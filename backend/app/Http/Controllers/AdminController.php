<?php

namespace App\Http\Controllers;

use App\Models\Industry;
use App\Models\Jlevel;
use App\Models\Job;
use App\Models\Jtype;
use App\Models\Location;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class AdminController extends Controller
{
    private function authorizeAdmin()
    {
        abort_unless(Auth::user()?->role === 0, 403, 'Admin only');
    }

    public function dashboard()
    {
        $this->authorizeAdmin();

        return response()->json([
            'users' => User::count(),
            'candidates' => User::where('role', 1)->count(),
            'employers' => User::where('role', 2)->count(),
            'companies' => DB::table('employers')->count(),
            'jobs' => Job::count(),
            'active_jobs' => Job::where('is_active', 1)->count(),
            'applications' => DB::table('job_applying')->where('status', '!=', 'cancelled')->count(),
            'applications_by_month' => DB::table('job_applying')
                ->selectRaw('DATE_FORMAT(created_at, "%Y-%m") as month, COUNT(*) as total')
                ->groupBy('month')
                ->orderBy('month')
                ->take(12)
                ->get(),
        ]);
    }

    public function users(Request $request)
    {
        $this->authorizeAdmin();

        $users = User::query()
            ->when($request->filled('role'), fn ($query) => $query->where('role', $request->role))
            ->when($request->filled('keyword'), function ($query) use ($request) {
                return $query->whereRaw('LOWER(email) LIKE ?', ['%' . strtolower($request->keyword) . '%']);
            })
            ->select('id', 'email', 'role', 'is_active', 'created_at')
            ->orderByDesc('id')
            ->paginate(10);

        return response()->json($users);
    }

    public function toggleUser(Request $request, $id)
    {
        $this->authorizeAdmin();

        User::where('id', $id)->update(['is_active' => (int) $request->is_active]);

        return response()->json('Updated successfully');
    }

    public function jobs(Request $request)
    {
        $this->authorizeAdmin();

        $jobs = Job::with('employer')
            ->when($request->filled('keyword'), function ($query) use ($request) {
                return $query->whereRaw('LOWER(jname) LIKE ?', ['%' . strtolower($request->keyword) . '%']);
            })
            ->select('jobs.*')
            ->orderByDesc('jobs.created_at')
            ->paginate(10);

        return response()->json($jobs);
    }

    public function toggleJob(Request $request, $id)
    {
        $this->authorizeAdmin();

        Job::where('id', $id)->update(['is_active' => (int) $request->is_active]);

        return response()->json('Updated successfully');
    }

    public function categories($type)
    {
        $this->authorizeAdmin();

        return response()->json($this->categoryModel($type)::orderBy('name')->get());
    }

    public function storeCategory(Request $request, $type)
    {
        $this->authorizeAdmin();
        $request->validate(['name' => 'required|string|max:255']);

        $item = $this->categoryModel($type)::create(['name' => $request->name]);

        return response()->json($item, 201);
    }

    public function updateCategory(Request $request, $type, $id)
    {
        $this->authorizeAdmin();
        $request->validate(['name' => 'required|string|max:255']);

        $this->categoryModel($type)::where('id', $id)->update(['name' => $request->name]);

        return response()->json('Updated successfully');
    }

    private function categoryModel($type)
    {
        return match ($type) {
            'industries' => Industry::class,
            'locations' => Location::class,
            'jtypes' => Jtype::class,
            'jlevels' => Jlevel::class,
            default => abort(404, 'Invalid category'),
        };
    }
}
