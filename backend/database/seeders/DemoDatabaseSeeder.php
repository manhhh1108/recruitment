<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

class DemoDatabaseSeeder extends Seeder
{
    private const CANDIDATE_ID = 1001;

    private const EMPLOYER_ID = 1101;

    private const ADMIN_ID = 1201;

    private const RESUME_ID = 1001;

    public function run(): void
    {
        DB::transaction(function (): void {
            $now = now();

            DB::table('users')->updateOrInsert(
                ['id' => self::CANDIDATE_ID],
                [
                    'email' => 'candidate.demo@example.com',
                    'email_verified_at' => $now,
                    'password' => Hash::make('password'),
                    'role' => 1,
                    'is_active' => true,
                    'created_at' => $now,
                    'updated_at' => $now,
                ]
            );

            DB::table('users')->updateOrInsert(
                ['id' => self::EMPLOYER_ID],
                [
                    'email' => 'employer.demo@example.com',
                    'email_verified_at' => $now,
                    'password' => Hash::make('password'),
                    'role' => 2,
                    'is_active' => true,
                    'created_at' => $now,
                    'updated_at' => $now,
                ]
            );

            DB::table('users')->updateOrInsert(
                ['id' => self::ADMIN_ID],
                [
                    'email' => 'admin.demo@example.com',
                    'email_verified_at' => $now,
                    'password' => Hash::make('password'),
                    'role' => 0,
                    'is_active' => true,
                    'created_at' => $now,
                    'updated_at' => $now,
                ]
            );

            DB::table('candidates')->updateOrInsert(
                ['id' => self::CANDIDATE_ID],
                [
                    'user_id' => self::CANDIDATE_ID,
                    'firstname' => 'Minh Anh',
                    'lastname' => 'Nguyen',
                    'gender' => 1,
                    'dob' => '2001-08-15',
                    'phone' => '0912345678',
                    'email' => 'candidate.demo@example.com',
                    'address' => 'Cau Giay, Ha Noi',
                    'link' => 'https://github.com/demo-candidate',
                    'objective' => 'Phat trien thanh full-stack developer, tao ra san pham on dinh va de su dung.',
                    'avatar' => 'avatar.jpg',
                    'created_at' => $now,
                    'updated_at' => $now,
                ]
            );

            DB::table('employers')->updateOrInsert(
                ['id' => self::EMPLOYER_ID],
                [
                    'user_id' => self::EMPLOYER_ID,
                    'name' => 'TechWorks Viet Nam',
                    'address' => '123 Duy Tan, Cau Giay, Ha Noi',
                    'min_employees' => 100,
                    'max_employees' => 300,
                    'contact_name' => 'Nguyen Thu Ha',
                    'phone' => '02473001234',
                    'website' => 'https://example.com',
                    'description' => 'Cong ty phat trien san pham web va nen tang du lieu cho thi truong Viet Nam.',
                    'logo' => 'logo.png',
                    'image' => 'company-banner.jpg',
                    'is_hot' => true,
                    'is_active' => true,
                    'created_at' => $now,
                    'updated_at' => $now,
                ]
            );

            $locationId = $this->findOrCreate('locations', 'Hà Nội');
            $industryId = $this->findOrCreate('industries', 'CNTT-Phần mềm');
            $jobTypeId = $this->findOrCreate('jtypes', 'Nhân viên chính thức');
            $jobLevelId = $this->findOrCreate('jlevels', 'Nhân viên');

            DB::table('employer_location')->updateOrInsert([
                'employer_id' => self::EMPLOYER_ID,
                'location_id' => $locationId,
            ]);

            $jobs = [
                [
                    'id' => 1001,
                    'jname' => 'Laravel Backend Developer',
                    'amount' => 3,
                    'min_salary' => 18,
                    'max_salary' => 30,
                    'yoe' => 2,
                    'is_hot' => true,
                    'description' => 'Phat trien REST API bang Laravel, toi uu truy van MySQL va viet automated test.',
                    'skills' => ['PHP', 'Laravel', 'MySQL'],
                    'tags' => ['Backend', 'API'],
                ],
                [
                    'id' => 1002,
                    'jname' => 'React Frontend Developer',
                    'amount' => 2,
                    'min_salary' => 16,
                    'max_salary' => 28,
                    'yoe' => 2,
                    'is_hot' => true,
                    'description' => 'Xay dung giao dien tuyen dung responsive, tich hop API va toi uu trai nghiem nguoi dung.',
                    'skills' => ['JavaScript', 'React', 'CSS'],
                    'tags' => ['Frontend', 'Web'],
                ],
                [
                    'id' => 1003,
                    'jname' => 'QA Engineer',
                    'amount' => 2,
                    'min_salary' => 14,
                    'max_salary' => 24,
                    'yoe' => 1,
                    'is_hot' => false,
                    'description' => 'Thiet ke test case, kiem thu API va phoi hop cung doi phat trien de dam bao chat luong.',
                    'skills' => ['Postman', 'SQL', 'Selenium'],
                    'tags' => ['QA', 'Automation'],
                ],
                [
                    'id' => 1004,
                    'jname' => 'UI UX Intern',
                    'amount' => 2,
                    'min_salary' => 5,
                    'max_salary' => 8,
                    'yoe' => 0,
                    'is_hot' => false,
                    'description' => 'Ho tro nghien cuu nguoi dung, thiet ke wireframe va prototype cho san pham web.',
                    'skills' => ['Figma', 'UI Design'],
                    'tags' => ['Internship', 'Design'],
                ],
                [
                    'id' => 1005,
                    'jname' => 'Data Analyst',
                    'amount' => 2,
                    'min_salary' => 15,
                    'max_salary' => 25,
                    'yoe' => 1,
                    'is_hot' => false,
                    'description' => 'Phan tich du lieu tuyen dung, xay dung dashboard va bao cao ho tro quyet dinh.',
                    'skills' => ['SQL', 'Power BI', 'Excel'],
                    'tags' => ['Data', 'Reporting'],
                ],
                [
                    'id' => 1006,
                    'jname' => 'DevOps Engineer',
                    'amount' => 1,
                    'min_salary' => 22,
                    'max_salary' => 35,
                    'yoe' => 3,
                    'is_hot' => false,
                    'description' => 'Van hanh CI/CD, container va he thong giam sat cho cac dich vu web.',
                    'skills' => ['Docker', 'Linux', 'CI/CD'],
                    'tags' => ['DevOps', 'Infrastructure'],
                ],
            ];

            foreach ($jobs as $index => $job) {
                DB::table('jobs')->updateOrInsert(
                    ['id' => $job['id']],
                    [
                        'employer_id' => self::EMPLOYER_ID,
                        'jtype_id' => $jobTypeId,
                        'jlevel_id' => $jobLevelId,
                        'jname' => $job['jname'],
                        'address' => '123 Duy Tan, Cau Giay, Ha Noi',
                        'amount' => $job['amount'],
                        'min_salary' => $job['min_salary'],
                        'max_salary' => $job['max_salary'],
                        'yoe' => $job['yoe'],
                        'gender' => null,
                        'description' => $job['description'],
                        'expire_at' => now()->addDays(30 + ($index * 10))->toDateString(),
                        'is_hot' => $job['is_hot'],
                        'is_active' => true,
                        'created_at' => $now,
                        'updated_at' => $now,
                    ]
                );

                DB::table('job_industry')->updateOrInsert([
                    'job_id' => $job['id'],
                    'industry_id' => $industryId,
                ]);

                DB::table('job_location')->updateOrInsert([
                    'job_id' => $job['id'],
                    'location_id' => $locationId,
                ]);

                foreach ($job['skills'] as $skill) {
                    $skillId = $this->findOrCreate('jskills', $skill);
                    DB::table('job_skill')->updateOrInsert([
                        'job_id' => $job['id'],
                        'skill_id' => $skillId,
                    ]);
                }

                foreach ($job['tags'] as $tag) {
                    $tagId = $this->findOrCreate('jtags', $tag);
                    DB::table('job_tag')->updateOrInsert([
                        'job_id' => $job['id'],
                        'tag_id' => $tagId,
                    ]);
                }
            }

            DB::table('resumes')->updateOrInsert(
                ['id' => self::RESUME_ID],
                [
                    'candidate_id' => self::CANDIDATE_ID,
                    'title' => 'Full-stack Developer CV',
                    'fullname' => 'Nguyen Minh Anh',
                    'gender' => 1,
                    'dob' => '2001-08-15',
                    'phone' => '0912345678',
                    'email' => 'candidate.demo@example.com',
                    'address' => 'Cau Giay, Ha Noi',
                    'link' => 'https://github.com/demo-candidate',
                    'avatar' => 'avatar.jpg',
                    'objective' => 'Ung dung kinh nghiem Laravel va React de xay dung san pham co chat luong.',
                    'personalTitle' => 'Thong tin ca nhan',
                    'objectiveTitle' => 'Muc tieu nghe nghiep',
                    'educationTitle' => 'Hoc van',
                    'experienceTitle' => 'Kinh nghiem',
                    'projectTitle' => 'Du an',
                    'skillTitle' => 'Ky nang',
                    'certificateTitle' => 'Chung chi',
                    'prizeTitle' => 'Giai thuong',
                    'activityTitle' => 'Hoat dong',
                    'cv_link' => null,
                    'parts_order' => json_encode([
                        'personal',
                        'objective',
                        'education',
                        'experience',
                        'project',
                        'skill',
                    ]),
                    'created_at' => $now,
                    'updated_at' => $now,
                ]
            );

            $applications = [
                1001 => 'pending',
                1002 => 'viewed',
                1003 => 'interview',
                1004 => 'suitable',
                1005 => 'rejected',
                1006 => 'cancelled',
            ];

            foreach ($applications as $jobId => $status) {
                DB::table('job_applying')->updateOrInsert(
                    [
                        'job_id' => $jobId,
                        'candidate_id' => self::CANDIDATE_ID,
                    ],
                    [
                        'cv_link' => 'http://localhost:3000/candidate/resumes/'.self::RESUME_ID,
                        'cv_type' => 'system',
                        'resume_id' => self::RESUME_ID,
                        'status' => $status,
                        'created_at' => $now,
                        'updated_at' => $now,
                    ]
                );
            }

            DB::table('saved_jobs')->updateOrInsert([
                'candidate_id' => self::CANDIDATE_ID,
                'job_id' => 1001,
            ]);
        });
    }

    private function findOrCreate(string $table, string $name): int
    {
        $id = DB::table($table)->where('name', $name)->value('id');

        return $id ?: DB::table($table)->insertGetId(['name' => $name]);
    }
}
