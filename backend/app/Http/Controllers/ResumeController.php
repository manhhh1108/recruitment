<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\Activity;
use App\Models\Certificate;
use App\Models\Education;
use App\Models\Experience;
use App\Models\Other;
use App\Models\Prize;
use App\Models\Project;
use App\Models\Resume;
use App\Models\Skill;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class ResumeController extends Controller
{
    public function getByCurrentCandidate()
    {
        $res = Resume::where('candidate_id', Auth::user()->id)
            ->select(['id', 'title', 'is_default', 'created_at', 'updated_at'])
            ->orderByDesc('is_default')
            ->orderByDesc('updated_at')
            ->get();

        return response()->json($res);
    }
    public function getById($id)
    {
        $resume = Resume::where('id', $id)
            ->with(['educations', 'experiences', 'projects', 'skills', 'certificates', 'prizes', 'activities', 'others'])
            ->firstOrFail();
        $basicInfor = Resume::findOrFail($id);
        $resume['basicInfor'] = $basicInfor;

        return response()->json($resume);
    }
    public function getOwnedById($id)
    {
        $resume = Resume::where('id', $id)
            ->where('candidate_id', Auth::id())
            ->with(['educations', 'experiences', 'projects', 'skills', 'certificates', 'prizes', 'activities', 'others'])
            ->firstOrFail();
        $basicInfor = Resume::where('id', $id)
            ->where('candidate_id', Auth::id())
            ->firstOrFail();
        $resume['basicInfor'] = $basicInfor;

        return response()->json($resume);
    }
    public function create(Request $req)
    {
        $candidate_id = Auth::user()->id;
        DB::transaction(function () use ($req, $candidate_id) {
            $resume_fields = (array) $req->basicInfor;
            $resume_fields['candidate_id'] = $candidate_id;

            $resume = Resume::create($resume_fields);

            $this->createResumeItems(Education::class, $req->educations, $candidate_id, $resume->id);
            $this->createResumeItems(Experience::class, $req->experiences, $candidate_id, $resume->id);
            $this->createResumeItems(Project::class, $req->projects, $candidate_id, $resume->id);
            $this->createResumeItems(Skill::class, $req->skills, $candidate_id, $resume->id);
            $this->createResumeItems(Certificate::class, $req->certificates, $candidate_id, $resume->id);
            $this->createResumeItems(Prize::class, $req->prizes, $candidate_id, $resume->id);
            $this->createResumeItems(Activity::class, $req->activities, $candidate_id, $resume->id);
            $this->createResumeItems(Other::class, $req->others, $candidate_id, $resume->id);
        });

        return response()->json("created successfully", 201);
    }
    public function update(Request $req, $id = null)
    {
        $candidate_id = Auth::id();
        $resume_id = $id ?? $req->resume_id;

        DB::transaction(function () use ($req, $candidate_id, $resume_id) {
            $resume_fields = (array) $req->basicInfor;

            Resume::where('id', $resume_id)
                ->where('candidate_id', $candidate_id)
                ->firstOrFail()
                ->update($resume_fields);

            $this->updateResumeItems(Education::class, $req->educations, $candidate_id, $resume_id);
            $this->updateResumeItems(Experience::class, $req->experiences, $candidate_id, $resume_id);
            $this->updateResumeItems(Project::class, $req->projects, $candidate_id, $resume_id);
            $this->updateResumeItems(Skill::class, $req->skills, $candidate_id, $resume_id);
            $this->updateResumeItems(Certificate::class, $req->certificates, $candidate_id, $resume_id);
            $this->updateResumeItems(Prize::class, $req->prizes, $candidate_id, $resume_id);
            $this->updateResumeItems(Activity::class, $req->activities, $candidate_id, $resume_id);
            $this->updateResumeItems(Other::class, $req->others, $candidate_id, $resume_id);
        });

        return response()->json("updated successfully");
    }
    public function destroy($id)
    {
        $candidate_id = Auth::id();

        DB::transaction(function () use ($id, $candidate_id) {
            Resume::where('id', $id)
                ->where('candidate_id', $candidate_id)
                ->firstOrFail()
                ->delete();

            Education::where('resume_id', $id)->where('candidate_id', $candidate_id)->delete();
            Experience::where('resume_id', $id)->where('candidate_id', $candidate_id)->delete();
            Project::where('resume_id', $id)->where('candidate_id', $candidate_id)->delete();
            Skill::where('resume_id', $id)->where('candidate_id', $candidate_id)->delete();
            Certificate::where('resume_id', $id)->where('candidate_id', $candidate_id)->delete();
            Prize::where('resume_id', $id)->where('candidate_id', $candidate_id)->delete();
            Activity::where('resume_id', $id)->where('candidate_id', $candidate_id)->delete();
            Other::where('resume_id', $id)->where('candidate_id', $candidate_id)->delete();
        });

        return response()->json("deleted successfully");
    }

    public function setDefault($id)
    {
        $candidate_id = Auth::id();

        DB::transaction(function () use ($id, $candidate_id) {
            Resume::where('candidate_id', $candidate_id)->update(['is_default' => false]);
            Resume::where('id', $id)
                ->where('candidate_id', $candidate_id)
                ->firstOrFail()
                ->update(['is_default' => true]);
        });

        return response()->json("updated successfully");
    }

    private function createResumeItems(string $modelClass, $items, int $candidate_id, int $resume_id): void
    {
        if (! $items) {
            return;
        }

        foreach ($items as $item) {
            $fields = (array) $item;
            unset($fields['id']);
            $fields['candidate_id'] = $candidate_id;
            $fields['resume_id'] = $resume_id;
            $modelClass::create($fields);
        }
    }

    private function updateResumeItems(string $modelClass, $items, int $candidate_id, int $resume_id): void
    {
        if (! $items) {
            return;
        }

        foreach ($items as $item) {
            $fields = (array) $item;
            unset($fields['candidate_id'], $fields['resume_id']);

            $modelClass::where('id', $item['id'])
                ->where('candidate_id', $candidate_id)
                ->where('resume_id', $resume_id)
                ->update($fields);
        }
    }
}
