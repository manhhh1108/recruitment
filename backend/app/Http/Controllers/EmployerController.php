<?php

namespace App\Http\Controllers;

use App\Events\NotifyCandidateEvent;
use App\Models\CandidateMessage;
use App\Models\Employer;
use App\Models\Job;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

// use Illuminate\Support\Facades\Redis;

class EmployerController extends Controller
{
    public function index(Request $request)
    {
        $keyw = $request->query('keyword');
        $query = Employer::query();
        if ($keyw) {
            $query->whereRaw('LOWER(name) LIKE ?', ['%'.strtolower($keyw).'%']);
        }
        $res = $query->paginate(6);

        return response()->json($res);
    }

    public function show($id)
    {
        $employer = Employer::find($id);
        if ($employer) {
            return $employer;
        } else {
            return response()->json([
                'message' => 'resource not found',
            ], 404);
        }
    }

    public function destroy($id)
    {
        if (Employer::find($id)) {
            Employer::destroy($id);
        } else {
            return response()->json(['message' => 'resource not found']);
        }
    }

    public function getHotList()
    {
        $res = Employer::where('is_hot', 1)->take(5)->get();
        for ($i = 0; $i < count($res); $i++) {
            $job_num = Job::where('employer_id', $res[$i]['id'])->count();
            $res[$i]['job_num'] = $job_num;
        }

        return response()->json($res);
    }

    public function getComJobs($id)
    {

        $jobs = Employer::join('jobs', 'employers.id', '=', 'employer_id')
            ->where([
                ['employers.id', '=', $id],
                ['jobs.is_active', '=', 1],
            ])
            ->select('jobs.*', DB::raw(
                'DATE_FORMAT(jobs.created_at, "%d/%m/%Y") as postDate,
                 DATE_FORMAT(jobs.expire_at, "%d/%m/%Y") as deadline'
            ))
            ->get();
        for ($i = 0; $i < count($jobs); $i++) {
            $res = DB::table('job_location')
                ->join('locations', 'location_id', '=', 'locations.id')
                ->where('job_id', $jobs[$i]->id)
                ->pluck('locations.name');
            //convert $res from array to string to send back frontend
            $location = array2String($res);
            $jobs[$i]['location'] = $location;
        }

        return $jobs;
    }

    public function getCandidateList(Request $req)
    {
        $this->authorizeEmployer();
        $job_ids = Job::where('employer_id', '=', Auth::user()->id)->pluck('id');

        $keyword = $req->query('keyword'); //search by name, email, applied job of candidate

        if (! $req->status) {
            $status = ['pending', 'viewed', 'interview', 'suitable', 'rejected', 'cancelled'];
        } else {
            $status = [$req->status];
        }

        $query = DB::table('job_applying')
            ->join('jobs', 'job_id', '=', 'jobs.id')
            ->join('candidates', 'candidate_id', '=', 'candidates.id')
            ->leftJoin('job_industry', 'jobs.id', '=', 'job_industry.job_id')
            ->leftJoin('industries', 'job_industry.industry_id', '=', 'industries.id')
            ->whereIn('job_applying.status', $status)
            ->whereIn('job_applying.job_id', $job_ids)
            ->when($req->filled('job_id'), function ($query) use ($req) {
                return $query->where('job_applying.job_id', $req->job_id);
            })
            ->when($keyword != null, function ($query) use ($keyword) {
                return $query->where(function ($query2) use ($keyword) {
                    $query2->whereRaw('LOWER(jname) LIKE ?', ['%'.strtolower($keyword).'%'])
                        ->orWhereraw('LOWER(candidates.email) LIKE ?', ['%'.strtolower($keyword).'%'])
                        ->orWhereraw("LOWER(CONCAT(lastname, ' ', firstname)) LIKE ?", ['%'.strtolower($keyword).'%'])
                        ->orWhereraw('LOWER(industries.name) LIKE ?', ['%'.strtolower($keyword).'%']);
                });
            })
            ->selectRaw('job_applying.job_id,
                        job_applying.candidate_id,
                        job_applying.cv_link,
                        job_applying.cv_type,
                        job_applying.resume_id,
                        job_applying.status,
                        job_applying.created_at as applied_at,
                        job_applying.updated_at as application_updated_at,
                        candidates.id as candidate_table_id,
                        candidates.user_id,
                        candidates.firstname,
                        candidates.lastname,
                        candidates.gender,
                        candidates.dob,
                        candidates.phone,
                        candidates.email,
                        candidates.address,
                        candidates.link,
                        candidates.objective,
                        candidates.avatar,
                        jobs.id as id,
                        jobs.jname,
                        GROUP_CONCAT(DISTINCT industries.name ORDER BY industries.name SEPARATOR ", ") as industry_names,
                        DATE_FORMAT(job_applying.created_at, "%d/%m/%Y %H:%i") as appliedTime')
            ->groupBy(
                'job_applying.job_id',
                'job_applying.candidate_id',
                'job_applying.cv_link',
                'job_applying.cv_type',
                'job_applying.resume_id',
                'job_applying.status',
                'job_applying.created_at',
                'job_applying.updated_at',
                'candidates.id',
                'candidates.user_id',
                'candidates.firstname',
                'candidates.lastname',
                'candidates.gender',
                'candidates.dob',
                'candidates.phone',
                'candidates.email',
                'candidates.address',
                'candidates.link',
                'candidates.objective',
                'candidates.avatar',
                'candidates.created_at',
                'candidates.updated_at',
                'jobs.id',
                'jobs.jname'
            )
            ->orderByDesc('job_applying.created_at')
            ;

        $candidates = $req->filled('per_page')
            ? $query->paginate((int) $req->query('per_page', 10))
            : $query->get();

        return response()->json($candidates);
    }

    public function getCandidateDetail(Request $req)
    {
        $this->authorizeEmployer();

        $application = DB::table('job_applying')
            ->join('jobs', 'job_applying.job_id', '=', 'jobs.id')
            ->join('candidates', 'job_applying.candidate_id', '=', 'candidates.id')
            ->where('job_applying.job_id', $req->query('job_id'))
            ->where('job_applying.candidate_id', $req->query('candidate_id'))
            ->where('jobs.employer_id', Auth::id())
            ->selectRaw('job_applying.*, jobs.jname, jobs.description as job_description, candidates.*,
                        DATE_FORMAT(job_applying.created_at, "%d/%m/%Y %H:%i") as appliedTime,
                        DATE_FORMAT(job_applying.updated_at, "%d/%m/%Y %H:%i") as updatedTime')
            ->first();

        abort_unless($application, 404);

        $messages = CandidateMessage::where('candidate_id', $req->query('candidate_id'))
            ->where('job_id', $req->query('job_id'))
            ->orderByDesc('created_at')
            ->get();

        return response()->json([
            'application' => $application,
            'messages' => $messages,
        ]);
    }

    public function processApplying(Request $req)
    {
        $this->authorizeEmployer();
        $allowedStatuses = ['pending', 'viewed', 'suitable', 'rejected', 'interview', 'cancelled'];
        if ($req->status && ! in_array($req->status, $allowedStatuses, true)) {
            return response()->json(['message' => 'Invalid status'], 422);
        }

        $applicationExists = DB::table('job_applying')
            ->join('jobs', 'job_applying.job_id', '=', 'jobs.id')
            ->where('job_applying.job_id', $req->job_id)
            ->where('job_applying.candidate_id', $req->candidate_id)
            ->where('jobs.employer_id', Auth::id())
            ->exists();
        abort_unless($applicationExists, 404);

        $currentTime = Carbon::parse(Carbon::now())->format('H:i d/m/Y');
        $company = Employer::where('user_id', '=', Auth::user()->id)->value('name');

        if ($req->status) {
            $nextStatus = $req->status;
            $msgName = 'Trạng thái ứng tuyển được cập nhật, vị trí ';
        } elseif ($req->actType == 'VIEWED') {
            $nextStatus = 'viewed';
            $msgName = 'Nhà tuyển dụng đã xem hồ sơ, vị trí ';
        } elseif ($req->actType == 'ACCEPT') {
            if ($req->step == 'step1') {
                $nextStatus = 'interview';
                $msgName = 'Hồ sơ được chấp nhận, vị trí ';
            } elseif ($req->step == 'step2') {
                $nextStatus = 'suitable';
                $msgName = 'Chúc mừng bạn đã được nhận, vị trí ';
            }
        } elseif ($req->actType == 'REJECT') {
            $nextStatus = 'rejected';
            $msgName = $req->step == 'step2' ? 'Phỏng vấn bị loại, vị trí ' : 'Hồ sơ bị loại, vị trí ';
        }

        if (! isset($nextStatus)) {
            return response()->json(['message' => 'Invalid status action'], 422);
        }

        $msgName = $msgName.$req->jname.', '.$company.', lúc '.$currentTime;
        //update:
        DB::table('job_applying')
            ->where([
                ['job_id', '=', $req->job_id],
                ['candidate_id', '=', $req->candidate_id],
            ])
            ->update([
                'status' => $nextStatus,
                'updated_at' => Carbon::now(),
            ]);
        if ($req->actType != 'VIEWED' || $req->status) {
            CandidateMessage::create(
                [
                    'candidate_id' => $req->candidate_id,
                    'job_id' => $req->job_id,
                    'name' => $msgName,
                    'title' => $req->title,
                    'content' => $req->content,
                ]
            );
        }
        event(new NotifyCandidateEvent($msgName, $req->candidate_id));

        return response()->json('Updated successfully');
    }

    public function dashboard()
    {
        $this->authorizeEmployer();
        $employerId = Auth::user()->id;

        $jobIds = Job::where('employer_id', $employerId)->pluck('id');
        $totalJobs = $jobIds->count();
        $activeJobs = Job::where('employer_id', $employerId)
            ->where('is_active', 1)
            ->where('expire_at', '>=', Carbon::today())
            ->count();
        $expiredJobs = Job::where('employer_id', $employerId)
            ->where('expire_at', '<', Carbon::today())
            ->count();
        $inactiveJobs = Job::where('employer_id', $employerId)
            ->where('is_active', 0)
            ->count();
        $totalApplications = DB::table('job_applying')
            ->whereIn('job_id', $jobIds)
            ->where('status', '!=', 'cancelled')
            ->count();
        $newApplicationsThisWeek = DB::table('job_applying')
            ->whereIn('job_id', $jobIds)
            ->where('created_at', '>=', Carbon::now()->subDays(7))
            ->count();

        $recentApplications = DB::table('job_applying')
            ->join('jobs', 'job_applying.job_id', '=', 'jobs.id')
            ->join('candidates', 'job_applying.candidate_id', '=', 'candidates.id')
            ->whereIn('job_applying.job_id', $jobIds)
            ->selectRaw('job_applying.*, jobs.jname, candidates.firstname, candidates.lastname, candidates.email,
                        DATE_FORMAT(job_applying.created_at, "%d/%m/%Y %H:%i") as appliedTime')
            ->orderByDesc('job_applying.created_at')
            ->take(6)
            ->get();

        $applicationsByMonth = DB::table('job_applying')
            ->whereIn('job_id', $jobIds)
            ->where('status', '!=', 'cancelled')
            ->selectRaw('DATE_FORMAT(created_at, "%Y-%m") as month, COUNT(*) as total')
            ->groupBy('month')
            ->orderBy('month')
            ->take(12)
            ->get();

        $applicationsByStatus = DB::table('job_applying')
            ->whereIn('job_id', $jobIds)
            ->where('status', '!=', 'cancelled')
            ->selectRaw('status, COUNT(*) as total')
            ->groupBy('status')
            ->orderByDesc('total')
            ->get();

        return response()->json([
            'total_jobs' => $totalJobs,
            'active_jobs' => $activeJobs,
            'expired_jobs' => $expiredJobs,
            'inactive_jobs' => $inactiveJobs,
            'total_applications' => $totalApplications,
            'new_applications_this_week' => $newApplicationsThisWeek,
            'recent_applications' => $recentApplications,
            'applications_by_month' => $applicationsByMonth,
            'applications_by_status' => $applicationsByStatus,
        ]);
    }

    public function getJobList(Request $req)
    {
        $keyword = $req->query('keyword');
        $jobs = Job::with(['industries', 'locations'])
            ->join('jtypes', 'jtype_id', '=', 'jtypes.id')
            ->join('jlevels', 'jlevel_id', '=', 'jlevels.id')
            ->where('employer_id', '=', $req->id)
            ->when($keyword != null, function ($query) use ($keyword) {
                return $query->where(function ($query2) use ($keyword) {
                    $query2->whereRaw('LOWER(jname) LIKE ?', ['%'.strtolower($keyword).'%'])
                        ->orWhereraw('LOWER(jtypes.name) LIKE ?', ['%'.strtolower($keyword).'%'])
                        ->orWhereraw('LOWER(jlevels.name) LIKE ?', ['%'.strtolower($keyword).'%']);
                });
            })
            ->selectRaw('jobs.*, jtypes.name as jtype_name, jlevels.name as jlevel_name,
                        (SELECT COUNT(*) FROM job_applying WHERE job_applying.job_id = jobs.id AND job_applying.status != "cancelled") as application_count,
                        DATE_FORMAT(jobs.created_at ,"%d/%m/%Y %H:%i") as postTime,
                        DATE_FORMAT(expire_at ,"%d/%m/%Y") as deadline')
            ->orderByDesc('jobs.created_at')
            ->get();

        return response()->json($jobs);
    }

    public function changeJobStatus(Request $req, $job_id)
    {
        $this->authorizeEmployer();
        $req->validate(['status' => 'required|boolean']);

        Job::where('id', $job_id)
            ->where('employer_id', Auth::id())
            ->firstOrFail()
            ->update(['is_active' => $req->boolean('status')]);

        return response()->json('Updated successfully');
    }

    private function authorizeEmployer(): void
    {
        abort_unless((int) Auth::user()?->role === 2, 403);
    }
}
