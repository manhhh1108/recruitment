<?php

use App\Http\Controllers\ActivityController;
use App\Http\Controllers\AdminController;
use App\Http\Controllers\API\AuthController;
use App\Http\Controllers\CandidateController;
use App\Http\Controllers\CandidateMessageController;
use App\Http\Controllers\CertificateController;
use App\Http\Controllers\EducationController;
use App\Http\Controllers\EmployerController;
use App\Http\Controllers\ExperienceController;
use App\Http\Controllers\IndustryController;
use App\Http\Controllers\JlevelController;
use App\Http\Controllers\JobController;
use App\Http\Controllers\JtypeController;
use App\Http\Controllers\LocationController;
use App\Http\Controllers\OtherController;
use App\Http\Controllers\PrizeController;
use App\Http\Controllers\ProjectController;
use App\Http\Controllers\ResumeController;
use App\Http\Controllers\SkillController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/
/*
Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});
*/

Route::controller(AuthController::class)->group(function () {
    Route::post('login', 'login');
    Route::post('register', 'register');
    Route::get('logout', 'logout');
    Route::get('refresh', 'refresh');
    Route::get('getMe', 'me');
});

Route::controller(EmployerController::class)->prefix('companies')->group(function () {
    Route::get('', 'index');
    Route::get('dashboard', 'dashboard')->middleware('jwt');
    Route::get('{id}/getByID', 'show');
    Route::get('getHotList', 'getHotList');
    Route::delete('{id}', 'destroy');
    Route::get('{id}/getComJobs', 'getComJobs');
    Route::get('{id}/getJobList', 'getJobList');
    Route::get('getCandidateList', 'getCandidateList')->middleware('jwt');
    Route::get('candidateDetail', 'getCandidateDetail')->middleware('jwt');
    Route::post('processApplying', 'processApplying')->middleware('jwt');
    Route::post('{job_id}/changeJobStatus', 'changeJobStatus')->middleware('jwt');
});

Route::controller(JobController::class)->prefix('jobs')->group(function () {
    Route::get('', 'index');
    Route::get('{id}/getByID', 'show');
    Route::get('getHotList', 'getHotList');
    Route::post('', 'create')->middleware('jwt');
    Route::post('{id}/update', 'update')->middleware('jwt');
    Route::post('{id}/duplicate', 'duplicate')->middleware('jwt');
    Route::get('{id}/getJobIndustries', 'getJobIndustries');
    Route::post('{id}/apply', 'apply')->middleware('jwt');
    Route::get('{id}/checkApplying', 'checkApplying')->middleware('jwt');
    Route::delete('{id}/cancelApplying', 'cancelApplying')->middleware('jwt');
});

Route::controller(CandidateController::class)->prefix('candidates')->group(function () {
    // Route::get('', 'index');
    // Route::get('{id}', 'show')->middleware('jwt');
    Route::get('dashboard', 'dashboard')->middleware('jwt');
    Route::get('getCurrent', 'getCurrent')->middleware('jwt');
    Route::post('update', 'update')->middleware('jwt');
    Route::get('{id}/getAppliedJobs', 'getAppliedJobs')->middleware('jwt');
    Route::get('{id}/getSavedJobs', 'getSavedJobs')->middleware('jwt');
    Route::post('{job_id}/processJobSaving', 'processJobSaving')->middleware('jwt');
    Route::get('{job_id}/checkJobSaved', 'checkJobSaved')->middleware('jwt');
});

Route::controller(IndustryController::class)->prefix('industries')->group(function () {
    Route::get('', 'index');
});

Route::controller(LocationController::class)->prefix('locations')->group(function () {
    Route::get('', 'index');
});

Route::controller(JtypeController::class)->prefix('jtypes')->group(function () {
    Route::get('', 'index');
});

Route::controller(JlevelController::class)->prefix('jlevels')->group(function () {
    Route::get('', 'index');
});

Route::controller(CandidateMessageController::class)->prefix('cand-msgs')->group(function () {
    Route::get('{id}/getByCandidateID', 'getByCandidateID')->middleware('jwt');
    Route::get('{id}/updateReadMsg', 'updateReadMsg');
    Route::get('{id}/updateUnreadMsg', 'updateUnreadMsg')->middleware('jwt');
});

Route::controller(EducationController::class)->prefix('educations')->group(function () {
    Route::get('', 'index');
    Route::get('getByCurrentCandidateProfile', 'getByCurrentCandidateProfile');
    Route::get('{resume_id}/getByCurCandResumeId', 'getByCurCandResumeId');
    Route::post('', 'create');
    Route::delete('{id}', 'destroy');
    Route::post('update/{id}', 'update');
});
Route::controller(ExperienceController::class)->prefix('experiences')->group(function () {
    Route::get('', 'index');
    Route::get('getByCurrentCandidateProfile', 'getByCurrentCandidateProfile');
    Route::get('{resume_id}/getByCurCandResumeId', 'getByCurCandResumeId');
    Route::post('', 'create');
    Route::delete('{id}', 'destroy');
    Route::patch('{id}', 'update');
});
Route::controller(SkillController::class)->prefix('skills')->group(function () {
    Route::get('', 'index');
    Route::get('getByCurrentCandidateProfile', 'getByCurrentCandidateProfile');
    Route::get('{resume_id}/getByCurCandResumeId', 'getByCurCandResumeId');
    Route::post('', 'create');
    Route::delete('{id}', 'destroy');
    Route::patch('{id}', 'update');
});
Route::controller(ProjectController::class)->prefix('projects')->group(function () {
    Route::get('', 'index');
    Route::get('getByCurrentCandidateProfile', 'getByCurrentCandidateProfile');
    Route::get('{resume_id}/getByCurCandResumeId', 'getByCurCandResumeId');
    Route::post('', 'create');
    Route::delete('{id}', 'destroy');
    Route::patch('{id}', 'update');
});
Route::controller(CertificateController::class)->prefix('certificates')->group(function () {
    Route::get('', 'index');
    Route::get('getByCurrentCandidateProfile', 'getByCurrentCandidateProfile');
    Route::get('{resume_id}/getByCurCandResumeId', 'getByCurCandResumeId');
    Route::post('', 'create');
    Route::delete('{id}', 'destroy');
    Route::post('/update/{id}', 'update');
});
Route::controller(PrizeController::class)->prefix('prizes')->group(function () {
    Route::get('', 'index');
    Route::get('getByCurrentCandidateProfile', 'getByCurrentCandidateProfile');
    Route::get('{resume_id}/getByCurCandResumeId', 'getByCurCandResumeId');
    Route::post('', 'create');
    Route::delete('{id}', 'destroy');
    Route::post('/update/{id}', 'update');
});
Route::controller(ActivityController::class)->prefix('activities')->group(function () {
    Route::get('', 'index');
    Route::get('getByCurrentCandidateProfile', 'getByCurrentCandidateProfile');
    Route::get('{resume_id}/getByCurCandResumeId', 'getByCurCandResumeId');
    Route::post('', 'create');
    Route::delete('{id}', 'destroy');
    Route::patch('{id}', 'update');
});
Route::controller(OtherController::class)->prefix('others')->group(function () {
    Route::get('', 'index');
    Route::get('getByCurrentCandidateProfile', 'getByCurrentCandidateProfile');
    Route::get('{resume_id}/getByCurCandResumeId', 'getByCurCandResumeId');
    Route::post('', 'create');
    Route::delete('{id}', 'destroy');
    Route::patch('{id}', 'update');
});
Route::controller(ResumeController::class)->prefix('resumes')->group(function () {
    Route::get('getByCurrentCandidate', 'getByCurrentCandidate');
    Route::get('{id}/getById', 'getById');
    Route::post('', 'create');
    Route::post('update', 'update');
    Route::delete('{id}', 'destroy');
});

Route::controller(AdminController::class)->prefix('admin')->middleware('jwt')->group(function () {
    Route::get('dashboard', 'dashboard');
    Route::get('users', 'users');
    Route::post('users/{id}/toggle', 'toggleUser');
    Route::get('jobs', 'jobs');
    Route::post('jobs/{id}/toggle', 'toggleJob');
    Route::get('categories/{type}', 'categories');
    Route::post('categories/{type}', 'storeCategory');
    Route::post('categories/{type}/{id}', 'updateCategory');
    Route::delete('categories/{type}/{id}', 'destroyCategory');
});
