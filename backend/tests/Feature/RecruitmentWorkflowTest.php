<?php

namespace Tests\Feature;

use App\Models\Candidate;
use App\Models\CandidateMessage;
use App\Models\Employer;
use App\Models\Job;
use App\Models\Resume;
use App\Models\User;
use Carbon\Carbon;
use Illuminate\Foundation\Testing\DatabaseTransactions;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Event;
use Illuminate\Support\Facades\Hash;
use Tests\TestCase;

class RecruitmentWorkflowTest extends TestCase
{
    use DatabaseTransactions;

    public function test_candidate_and_employer_can_register_and_candidate_can_login(): void
    {
        $suffix = uniqid();

        $this->postJson('/api/register', [
            'firstname' => 'An',
            'lastname' => 'Nguyen',
            'email' => "candidate_{$suffix}@example.test",
            'password' => 'Password1',
        ])->assertCreated();

        $this->postJson('/api/login', [
            'email' => "candidate_{$suffix}@example.test",
            'password' => 'Password1',
            'role' => 1,
        ])->assertOk()
            ->assertJsonPath('authorization.type', 'bearer');

        $this->postJson('/api/register-employer', [
            'email' => "employer_{$suffix}@example.test",
            'password' => 'secret123',
            'name' => 'Test Company',
            'address' => 'Ha Noi',
        ])->assertCreated();
    }

    public function test_candidate_can_save_and_apply_to_job_with_system_resume(): void
    {
        [$candidate, $candidateToken] = $this->createCandidateUser();
        [$job] = $this->createJobFixture();
        $resume = Resume::create([
            'candidate_id' => $candidate->id,
            'title' => 'Backend CV',
            'fullname' => 'Candidate Test',
        ]);

        $this->withToken($candidateToken)
            ->postJson("/api/candidates/{$job->id}/processJobSaving", ['status' => true])
            ->assertOk();

        $this->assertDatabaseHas('saved_jobs', [
            'candidate_id' => $candidate->id,
            'job_id' => $job->id,
        ]);

        $this->withToken($candidateToken)
            ->postJson("/api/jobs/{$job->id}/apply", [
                'id' => $job->id,
                'resume_id' => $resume->id,
            ])->assertOk();

        $this->assertDatabaseHas('job_applying', [
            'candidate_id' => $candidate->id,
            'job_id' => $job->id,
            'cv_type' => 'system',
            'resume_id' => $resume->id,
            'status' => 'pending',
        ]);
    }

    public function test_candidate_can_create_update_and_delete_resume(): void
    {
        [$candidate, $token] = $this->createCandidateUser();

        $this->withToken($token)
            ->postJson('/api/resumes', [
                'basicInfor' => [
                    'title' => 'Original CV',
                    'fullname' => 'Candidate Test',
                    'email' => $candidate->email,
                ],
                'educations' => [
                    ['school' => 'Test University', 'major' => 'IT'],
                ],
                'skills' => [
                    ['name' => 'PHP', 'proficiency' => 80],
                ],
            ])->assertCreated();

        $resume = Resume::where('candidate_id', $candidate->id)->firstOrFail();
        $education = DB::table('educations')->where('resume_id', $resume->id)->first();
        $skill = DB::table('skills')->where('resume_id', $resume->id)->first();

        $this->assertNotNull($education);
        $this->assertNotNull($skill);

        $this->withToken($token)
            ->patchJson("/api/resumes/{$resume->id}", [
                'basicInfor' => ['title' => 'Updated CV'],
                'educations' => [
                    ['id' => $education->id, 'school' => 'Updated University'],
                ],
                'skills' => [
                    ['id' => $skill->id, 'name' => 'Laravel', 'proficiency' => 90],
                ],
            ])->assertOk();

        $this->assertDatabaseHas('resumes', [
            'id' => $resume->id,
            'title' => 'Updated CV',
        ]);
        $this->assertDatabaseHas('educations', [
            'id' => $education->id,
            'school' => 'Updated University',
        ]);
        $this->assertDatabaseHas('skills', [
            'id' => $skill->id,
            'name' => 'Laravel',
        ]);

        $this->withToken($token)
            ->deleteJson("/api/resumes/{$resume->id}")
            ->assertOk();

        $this->assertDatabaseMissing('resumes', ['id' => $resume->id]);
        $this->assertDatabaseMissing('educations', ['id' => $education->id]);
        $this->assertDatabaseMissing('skills', ['id' => $skill->id]);
    }

    public function test_employer_can_process_application(): void
    {
        Event::fake();

        [$candidate] = $this->createCandidateUser();
        [$job, $employerToken] = $this->createJobFixture();

        DB::table('job_applying')->insert([
            'candidate_id' => $candidate->id,
            'job_id' => $job->id,
            'cv_link' => 'http://localhost/cv.pdf',
            'cv_type' => 'upload',
            'status' => 'pending',
            'created_at' => now(),
            'updated_at' => now(),
        ]);

        $this->withToken($employerToken)
            ->postJson('/api/companies/processApplying', [
                'job_id' => $job->id,
                'candidate_id' => $candidate->id,
                'jname' => $job->jname,
                'actType' => 'ACCEPT',
                'step' => 'step1',
                'title' => 'Interview',
                'content' => 'Please join the interview.',
            ])->assertOk();

        $this->assertDatabaseHas('job_applying', [
            'candidate_id' => $candidate->id,
            'job_id' => $job->id,
            'status' => 'interview',
        ]);
        $this->assertSame(1, CandidateMessage::where('candidate_id', $candidate->id)->count());
    }

    public function test_admin_can_toggle_user_and_job(): void
    {
        [, $adminToken] = $this->createUserWithToken(0);
        [$targetUser] = $this->createCandidateUser();
        [$job] = $this->createJobFixture();

        $this->withToken($adminToken)
            ->postJson("/api/admin/users/{$targetUser->id}/toggle", ['is_active' => 0])
            ->assertOk();

        $this->assertDatabaseHas('users', [
            'id' => $targetUser->id,
            'is_active' => 0,
        ]);

        $this->withToken($adminToken)
            ->postJson("/api/admin/jobs/{$job->id}/toggle", ['is_active' => 0])
            ->assertOk();

        $this->assertDatabaseHas('jobs', [
            'id' => $job->id,
            'is_active' => 0,
        ]);
    }

    private function createCandidateUser(): array
    {
        [$user, $token] = $this->createUserWithToken(1);

        Candidate::create([
            'id' => $user->id,
            'user_id' => $user->id,
            'firstname' => 'Candidate',
            'lastname' => 'Test',
            'email' => $user->email,
        ]);

        return [$user, $token];
    }

    private function createEmployerUser(): array
    {
        [$user, $token] = $this->createUserWithToken(2);

        Employer::create([
            'id' => $user->id,
            'user_id' => $user->id,
            'name' => 'Employer Test',
            'address' => 'Ha Noi',
            'logo' => '',
            'is_hot' => 0,
            'is_active' => 1,
        ]);

        return [$user, $token];
    }

    private function createUserWithToken(int $role): array
    {
        $password = 'secret123';
        $user = User::create([
            'email' => 'test_' . uniqid() . '@example.test',
            'password' => Hash::make($password),
            'role' => $role,
            'is_active' => 1,
        ]);

        $token = $this->postJson('/api/login', [
            'email' => $user->email,
            'password' => $password,
            'role' => $role,
        ])->assertOk()->json('authorization.token');

        return [$user, $token];
    }

    private function createJobFixture(): array
    {
        [$employer, $token] = $this->createEmployerUser();
        $jtypeId = DB::table('jtypes')->insertGetId(['name' => 'Full time ' . uniqid()]);
        $jlevelId = DB::table('jlevels')->insertGetId(['name' => 'Junior ' . uniqid()]);
        $industryId = DB::table('industries')->insertGetId(['name' => 'Software ' . uniqid()]);
        $locationId = DB::table('locations')->insertGetId(['name' => 'HN ' . substr(uniqid(), -6)]);

        $job = Job::create([
            'employer_id' => $employer->id,
            'jtype_id' => $jtypeId,
            'jlevel_id' => $jlevelId,
            'jname' => 'Backend Developer',
            'address' => 'Ha Noi',
            'amount' => 1,
            'min_salary' => 1000,
            'max_salary' => 2000,
            'description' => 'Build APIs',
            'expire_at' => Carbon::now()->addMonth()->toDateString(),
            'is_hot' => 0,
            'is_active' => 1,
        ]);

        DB::table('job_industry')->insert([
            'job_id' => $job->id,
            'industry_id' => $industryId,
        ]);
        DB::table('job_location')->insert([
            'job_id' => $job->id,
            'location_id' => $locationId,
        ]);

        return [$job, $token];
    }
}
