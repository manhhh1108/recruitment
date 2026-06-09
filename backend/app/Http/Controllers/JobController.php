<?php

namespace App\Http\Controllers;

use App\Models\Industry;
use App\Models\Job;
use App\Models\Resume;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class JobController extends Controller
{
    public function index(Request $req)
    {
        $jobs = Job::with(['employer', 'locations'])
            ->where('jobs.is_active', 1)
            ->when($req->filled('keyword'), function ($query) use ($req) {
                return $query->join('employers', 'employer_id', '=', 'employers.id')
                    ->where(function ($query2) use ($req) {
                        $keyword = '%'.strtolower($req->keyword).'%';
                        $query2->whereRaw('LOWER(jobs.jname) LIKE ?', [$keyword])
                            ->orWhereRaw('LOWER(employers.name) LIKE ?', [$keyword]);
                    });
            })
            ->when($req->filled('industry_id'), function ($query) use ($req) {
                return $query->join('job_industry', 'jobs.id', '=', 'job_industry.job_id')
                    ->whereIn('industry_id', $req->industry_id);
            })
            ->when($req->filled('location_id'), function ($query) use ($req) {
                return $query->join('job_location', 'jobs.id', '=', 'job_location.job_id')
                    ->whereIn('location_id', $req->location_id);
            })
            ->when($req->filled('salary'), function ($query) use ($req) {
                return $query->where('min_salary', '>=', $req->salary);
            })
            ->when($req->filled('jtype_id'), function ($query) use ($req) {
                return $query->where('jtype_id', '=', $req->jtype_id);
            })
            ->when($req->filled('jlevel_id'), function ($query) use ($req) {
                return $query->where('jlevel_id', '=', $req->jlevel_id);
            })
            ->when($req->filled('posting_period'), function ($query) use ($req) {
                return $query->where('jobs.created_at', '>=', Carbon::now()->subDays((int) $req->posting_period));
            })
            ->when($req->filled('work_mode'), function ($query) use ($req) {
                $workMode = strtolower($req->work_mode);

                return $query->join('jtypes as work_mode_jtypes', 'jobs.jtype_id', '=', 'work_mode_jtypes.id')
                    ->whereRaw('LOWER(work_mode_jtypes.name) LIKE ?', ['%'.$workMode.'%']);
            });

        if ($req->sort_by === 'salary_high') {
            $jobs->orderByDesc(DB::raw('COALESCE(jobs.max_salary, jobs.min_salary, 0)'));
        } elseif ($req->sort_by === 'deadline') {
            $jobs->orderBy('jobs.expire_at');
        } else {
            $jobs->orderByDesc('jobs.created_at');
        }

        $jobs = $jobs->select('jobs.*')
            ->distinct()
            ->paginate(9);

        return response()->json($jobs);
    }

    public function show($id)
    {
        $job = Job::with(['employer', 'jtype', 'jlevel', 'industries', 'locations'])
            ->where('id', $id)
            ->select('jobs.*', DB::raw('DATE_FORMAT(created_at, "%d/%m/%Y") as postDate'))
            ->first();
        if (! $job) {
            return response()->json('resource not found');
        }
        $this->addLocationInf($job);
        $job['is_expired'] = Carbon::parse($job->expire_at)->endOfDay()->isPast();
        $job['similar_jobs'] = $this->getSimilarJobs($job);

        return response()->json($job);
    }

    public function getHotList()
    {
        $res = Job::with(['employer', 'locations'])
            ->where('is_hot', 1)
            ->orderByDesc('created_at')
            ->paginate(6);

        return response()->json($res);
    }

    public function create(Request $req)
    {
        $this->authorizeRole(2);
        $new_record = $req->all();

        $industries = $this->resolveIndustryIds($new_record['industries']);
        unset($new_record['industries']);
        $locations = $new_record['locations'];
        unset($new_record['locations']);

        $new_record['employer_id'] = Auth::user()->id;

        $job = Job::create($new_record);
        $job_industries = [];
        for ($i = 0; $i < count($industries); $i++) {
            $job_industries[$i] = collect(['job_id' => $job->id, 'industry_id' => $industries[$i]])->toArray();
        }
        if (count($job_industries) > 0) {
            DB::table('job_industry')->insert($job_industries);
        }

        $job_locations = [];
        for ($i = 0; $i < count($locations); $i++) {
            $job_locations[$i] = collect(['job_id' => $job->id, 'location_id' => $locations[$i]])->toArray();
        }
        if (count($job_locations) > 0) {
            DB::table('job_location')->insert($job_locations);
        }

        return response()->json('Updated successfully');
    }

    public function update(Request $req, $id)
    {
        $this->authorizeRole(2);
        $job = Job::where('id', $id)
            ->where('employer_id', Auth::id())
            ->firstOrFail();
        $update_fields = $req->all();
        unset($update_fields['id'], $update_fields['employer_id']);
        if (isset($update_fields['industries'])) {
            $industries = $this->resolveIndustryIds($update_fields['industries']);
            unset($update_fields['industries']);

            //update job_industry
            DB::table('job_industry')->where('job_id', $job->id)->delete();
            $job_industries = [];
            for ($i = 0; $i < count($industries); $i++) {
                $job_industries[$i] = collect(['job_id' => $job->id, 'industry_id' => $industries[$i]])->toArray();
            }
            if (count($job_industries) > 0) {
                DB::table('job_industry')->insert($job_industries);
            }
        }
        if (isset($update_fields['locations'])) {
            $locations = $update_fields['locations'];
            unset($update_fields['locations']);

            //update job_location
            DB::table('job_location')->where('job_id', $job->id)->delete();
            $job_locations = [];
            for ($i = 0; $i < count($locations); $i++) {
                $job_locations[$i] = collect(['job_id' => $job->id, 'location_id' => $locations[$i]])->toArray();
            }
            if (count($job_locations) > 0) {
                DB::table('job_location')->insert($job_locations);
            }
        }
        if (count($update_fields) > 0) {
            $job->update($update_fields);
        }
        $msg = 'Update successfully';

        return response()->json($msg);
    }

    public function duplicate($id)
    {
        $this->authorizeRole(2);

        $job = Job::with(['industries', 'locations'])
            ->where('id', $id)
            ->where('employer_id', Auth::id())
            ->firstOrFail();

        $newJob = $job->replicate();
        $newJob->jname = $job->jname.' (Copy)';
        $newJob->is_active = 0;
        $newJob->is_hot = 0;
        $newJob->created_at = Carbon::now();
        $newJob->updated_at = Carbon::now();
        $newJob->save();

        $newJob->industries()->sync($job->industries->pluck('id')->all());
        $newJob->locations()->sync($job->locations->pluck('id')->all());

        return response()->json($newJob, 201);
    }

    public function getJobIndustries($id)
    {
        $res = Job::find($id)->industries;

        return response()->json($res);
    }

    private function resolveIndustryIds($industries)
    {
        if (is_string($industries)) {
            $industries = explode(',', $industries);
        }

        return collect($industries)
            ->map(fn ($industry) => trim((string) $industry))
            ->filter()
            ->map(function ($industry) {
                if (is_numeric($industry)) {
                    return (int) $industry;
                }

                return Industry::firstOrCreate(['name' => $industry])->id;
            })
            ->unique()
            ->values()
            ->all();
    }

    public function addLocationInf($job)
    {
        $res = DB::table('job_location')
            ->join('locations', 'location_id', '=', 'locations.id')
            ->where('job_id', $job->id)
            ->pluck('locations.name');
        //convert $res from array to string to send back frontend
        $location = array2String($res);
        $job['location'] = $location;
        //format date to display:
        // $job['expire_at'] = Carbon::parse($job['expire_at'])->format('d/m/Y');
        // $job['updated_at'] = Carbon::parse($job['updated_at'])->toDateTimeString();
    }

    public function apply(Request $req)
    {
        $this->authorizeRole(1);
        $user = Auth::user();
        $job = Job::findOrFail($req->id);
        if (! $job->is_active || Carbon::parse($job->expire_at)->endOfDay()->isPast()) {
            return response()->json(['message' => 'Job expired'], 422);
        }

        if ($req->resume_id) {
            $resume = Resume::where('id', $req->resume_id)
                ->where('candidate_id', $user->id)
                ->firstOrFail();
            $frontendUrl = rtrim(env('FRONTEND_URL', 'http://localhost:3000'), '/');
            $path = $resume->cv_link ?: $frontendUrl.'/candidate/resumes/'.$resume->id;
            $cvType = 'system';
            $resumeId = $resume->id;
        } else {
            $req->validate(['cv' => 'required|file']);
            $fname = 'cand'.$user->id.'_'.$req->fname;
            $path = env('APP_URL').'/storage/'.$req->file('cv')->storeAs(
                'cv_images',
                $fname,
                'public'
            );
            $cvType = 'upload';
            $resumeId = null;
        }

        $existingApplication = DB::table('job_applying')
            ->where('job_id', $req->id)
            ->where('candidate_id', $user->id)
            ->first();

        if ($existingApplication && $existingApplication->status !== 'cancelled') {
            return response()->json(['message' => 'Already applied'], 409);
        }

        $applicationData = [
            'job_id' => $req->id,
            'candidate_id' => $user->id,
            'cv_link' => $path,
            'cv_type' => $cvType,
            'resume_id' => $resumeId,
            'status' => 'pending',
            'updated_at' => Carbon::now(),
        ];

        if ($existingApplication) {
            DB::table('job_applying')
                ->where('job_id', $req->id)
                ->where('candidate_id', $user->id)
                ->update($applicationData);
        } else {
            DB::table('job_applying')->insert([
                ...$applicationData,
                'created_at' => Carbon::now(),
            ]);
        }

        return response()->json($path);
    }

    public function checkApplying($job_id)
    {
        $this->authorizeRole(1);
        $user = Auth::user();
        $res = DB::table('job_applying')
            ->where([
                ['job_id', '=', $job_id],
                ['candidate_id', '=', $user->id],
            ])->first();

        if ($res != null && $res->status !== 'cancelled') {
            return response()->json(['value' => true, 'status' => $res->status]);
        } else {
            return response()->json(['value' => false]);
        }
    }

    public function cancelApplying($job_id)
    {
        $this->authorizeRole(1);
        $user = Auth::user();
        $deleted = DB::table('job_applying')
            ->where([
                ['job_id', '=', $job_id],
                ['candidate_id', '=', $user->id],
                ['status', '=', 'pending'],
            ])
            ->update([
                'status' => 'cancelled',
                'updated_at' => Carbon::now(),
            ]);

        if (! $deleted) {
            return response()->json(['message' => 'Application cannot be canceled'], 422);
        }

        return response()->json('Canceled successfully');
    }

    private function getSimilarJobs($job)
    {
        $industryIds = $job->industries->pluck('id')->all();

        return Job::with(['employer', 'locations'])
            ->where('jobs.id', '!=', $job->id)
            ->where('jobs.is_active', 1)
            ->where('jobs.expire_at', '>=', Carbon::today())
            ->when(count($industryIds) > 0, function ($query) use ($industryIds) {
                return $query->join('job_industry as similar_job_industry', 'jobs.id', '=', 'similar_job_industry.job_id')
                    ->whereIn('similar_job_industry.industry_id', $industryIds);
            })
            ->select('jobs.*')
            ->distinct()
            ->orderByDesc('jobs.created_at')
            ->take(4)
            ->get();
    }

    private function authorizeRole(int $role): void
    {
        abort_unless((int) Auth::user()?->role === $role, 403);
    }
}
