<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

class PresentationDemoSeeder extends Seeder
{
    private const CANDIDATE_ID = 2001;

    private const PRIMARY_RESUME_ID = 2001;

    private const SECONDARY_RESUME_ID = 2002;

    public function run(): void
    {
        DB::transaction(function (): void {
            $this->seedCandidate();
            $this->seedCompaniesAndJobs();
            $this->seedResumes();
            $this->seedCandidateActivity();
        });
    }

    private function seedCandidate(): void
    {
        $now = now();

        DB::table('users')->updateOrInsert(
            ['id' => self::CANDIDATE_ID],
            [
                'email' => 'taianh.bui@example.com',
                'email_verified_at' => $now,
                'password' => Hash::make('TaiAnh@17112003'),
                'role' => 1,
                'is_active' => true,
                'created_at' => $now,
                'updated_at' => $now,
            ]
        );

        DB::table('candidates')->updateOrInsert(
            ['id' => self::CANDIDATE_ID],
            [
                'user_id' => self::CANDIDATE_ID,
                'firstname' => 'Tài Anh',
                'lastname' => 'Bùi Đức',
                'gender' => 0,
                'dob' => '2003-11-17',
                'phone' => '0987654321',
                'email' => 'taianh.bui@example.com',
                'address' => 'Cầu Giấy, Hà Nội',
                'link' => 'https://github.com/taianh-bui',
                'objective' => 'Lập trình viên trẻ định hướng Backend và Full-stack, yêu thích xây dựng REST API, tối ưu cơ sở dữ liệu và phát triển sản phẩm có trải nghiệm người dùng tốt.',
                'avatar' => 'https://ui-avatars.com/api/?name=Bui+Duc+Tai+Anh&size=512&background=0F4C81&color=ffffff&bold=true',
                'created_at' => $now,
                'updated_at' => $now,
            ]
        );
    }

    private function seedCompaniesAndJobs(): void
    {
        $companies = [
            [
                'name' => 'NovaTech Solutions',
                'slug' => 'novatech',
                'address' => 'Tòa Discovery Complex, 302 Cầu Giấy, Hà Nội',
                'location' => 'Hà Nội',
                'employees' => [150, 300],
                'industry' => 'CNTT-Phần mềm',
                'website' => 'https://novatech.example.com',
                'description' => 'Công ty công nghệ phát triển nền tảng quản trị doanh nghiệp, thương mại điện tử và giải pháp chuyển đổi số cho khách hàng trong khu vực Đông Nam Á.',
                'hot' => true,
                'roles' => ['Backend Developer (PHP/Laravel)', 'Frontend Developer (ReactJS)', 'Business Analyst', 'DevOps Engineer'],
            ],
            [
                'name' => 'VietData AI',
                'slug' => 'vietdata',
                'address' => 'Keangnam Landmark 72, Nam Từ Liêm, Hà Nội',
                'location' => 'Hà Nội',
                'employees' => [80, 180],
                'industry' => 'CNTT-Phần mềm',
                'website' => 'https://vietdata.example.com',
                'description' => 'Doanh nghiệp nghiên cứu dữ liệu lớn và trí tuệ nhân tạo, cung cấp nền tảng phân tích dữ liệu, OCR và trợ lý số cho doanh nghiệp.',
                'hot' => true,
                'roles' => ['Data Analyst', 'Machine Learning Engineer', 'Python Backend Developer', 'QA Automation Engineer'],
            ],
            [
                'name' => 'BlueWave Digital Bank',
                'slug' => 'bluewave',
                'address' => '194 Trần Quang Khải, Hoàn Kiếm, Hà Nội',
                'location' => 'Hà Nội',
                'employees' => [800, 1500],
                'industry' => 'Ngân hàng',
                'website' => 'https://bluewave.example.com',
                'description' => 'Ngân hàng số tập trung vào trải nghiệm khách hàng, thanh toán không tiền mặt, quản trị rủi ro và các sản phẩm tài chính cá nhân hiện đại.',
                'hot' => true,
                'roles' => ['Java Backend Developer', 'Chuyên viên Phân tích nghiệp vụ', 'Chuyên viên An toàn thông tin', 'Digital Marketing Executive'],
            ],
            [
                'name' => 'GreenLog Logistics',
                'slug' => 'greenlog',
                'address' => '15 Bạch Đằng, Hải Châu, Đà Nẵng',
                'location' => 'Đà Nẵng',
                'employees' => [300, 600],
                'industry' => 'Vận chuyển / Giao nhận / Kho vận',
                'website' => 'https://greenlog.example.com',
                'description' => 'Đơn vị logistics ứng dụng công nghệ trong quản lý kho, vận tải đa phương thức và tối ưu chuỗi cung ứng toàn quốc.',
                'hot' => false,
                'roles' => ['Supply Chain Analyst', 'Điều phối vận tải', 'Nhân viên Quản lý kho', 'Software Engineer - Logistics Platform'],
            ],
            [
                'name' => 'PixelCraft Studio',
                'slug' => 'pixelcraft',
                'address' => '28 Nguyễn Văn Linh, Hải Châu, Đà Nẵng',
                'location' => 'Đà Nẵng',
                'employees' => [40, 100],
                'industry' => 'Mỹ thuật / Nghệ thuật / Thiết kế',
                'website' => 'https://pixelcraft.example.com',
                'description' => 'Studio thiết kế sản phẩm số chuyên UI/UX, nhận diện thương hiệu, thiết kế web và ứng dụng di động cho startup quốc tế.',
                'hot' => true,
                'roles' => ['UI/UX Designer', 'Graphic Designer', 'Frontend Developer', 'Product Designer Intern'],
            ],
            [
                'name' => 'Sunrise Commerce',
                'slug' => 'sunrise',
                'address' => '36 Hoàng Cầu, Đống Đa, Hà Nội',
                'location' => 'Hà Nội',
                'employees' => [200, 450],
                'industry' => 'Bán hàng / Kinh doanh',
                'website' => 'https://sunrise-commerce.example.com',
                'description' => 'Hệ sinh thái bán lẻ đa kênh vận hành các thương hiệu tiêu dùng, sàn thương mại điện tử và mạng lưới phân phối trên toàn quốc.',
                'hot' => false,
                'roles' => ['E-commerce Executive', 'Key Account Executive', 'Performance Marketing', 'Customer Experience Specialist'],
            ],
            [
                'name' => 'MediCare Pharma',
                'slug' => 'medicare',
                'address' => 'Khu Công nghệ cao, Thủ Đức, Hồ Chí Minh',
                'location' => 'Hồ Chí Minh',
                'employees' => [500, 900],
                'industry' => 'Dược phẩm',
                'website' => 'https://medicare-pharma.example.com',
                'description' => 'Công ty dược phẩm và chăm sóc sức khỏe phát triển hệ thống phân phối, quản lý nhà thuốc và nền tảng tư vấn sức khỏe trực tuyến.',
                'hot' => true,
                'roles' => ['Dược sĩ Tư vấn', 'Medical Representative', 'Product Marketing Executive', 'Full-stack Developer - HealthTech'],
            ],
            [
                'name' => 'CloudNine Technology',
                'slug' => 'cloudnine',
                'address' => 'Etown Central, Quận 4, Hồ Chí Minh',
                'location' => 'Hồ Chí Minh',
                'employees' => [120, 250],
                'industry' => 'CNTT-Phần cứng / Mạng',
                'website' => 'https://cloudnine.example.com',
                'description' => 'Nhà cung cấp hạ tầng cloud, dịch vụ managed service, an toàn thông tin và giải pháp vận hành hệ thống cho doanh nghiệp.',
                'hot' => true,
                'roles' => ['Cloud Engineer', 'System Administrator', 'Security Engineer', 'Technical Support Engineer'],
            ],
            [
                'name' => 'BrightPath Education',
                'slug' => 'brightpath',
                'address' => '82 Duy Tân, Cầu Giấy, Hà Nội',
                'location' => 'Hà Nội',
                'employees' => [100, 220],
                'industry' => 'Tư vấn',
                'website' => 'https://brightpath.example.com',
                'description' => 'Doanh nghiệp EdTech phát triển nền tảng học trực tuyến, hệ thống quản lý đào tạo và nội dung số cho sinh viên và người đi làm.',
                'hot' => false,
                'roles' => ['Academic Advisor', 'Content Creator', 'React Native Developer', 'Customer Success Executive'],
            ],
            [
                'name' => 'Orbit Media Vietnam',
                'slug' => 'orbitmedia',
                'address' => '18A Cộng Hòa, Tân Bình, Hồ Chí Minh',
                'location' => 'Hồ Chí Minh',
                'employees' => [70, 160],
                'industry' => 'Tiếp thị / Marketing',
                'website' => 'https://orbitmedia.example.com',
                'description' => 'Digital agency cung cấp chiến lược thương hiệu, quảng cáo đa nền tảng, social media và sản xuất nội dung sáng tạo.',
                'hot' => true,
                'roles' => ['Social Media Executive', 'SEO Specialist', 'Account Executive', 'Video Editor'],
            ],
            [
                'name' => 'FutureTel Communications',
                'slug' => 'futuretel',
                'address' => 'Lê Hồng Phong, Ngô Quyền, Hải Phòng',
                'location' => 'Hải Phòng',
                'employees' => [1000, 2500],
                'industry' => 'Bưu chính viễn thông',
                'website' => 'https://futuretel.example.com',
                'description' => 'Doanh nghiệp viễn thông phát triển hạ tầng mạng, dịch vụ số, IoT và giải pháp kết nối cho khách hàng cá nhân và doanh nghiệp.',
                'hot' => false,
                'roles' => ['Network Engineer', 'IoT Developer', 'Nhân viên Kinh doanh B2B', 'Chuyên viên Chăm sóc khách hàng'],
            ],
            [
                'name' => 'PeopleFirst HR',
                'slug' => 'peoplefirst',
                'address' => 'Becamex Tower, Thủ Dầu Một, Bình Dương',
                'location' => 'Bình Dương',
                'employees' => [50, 120],
                'industry' => 'Nhân sự',
                'website' => 'https://peoplefirst.example.com',
                'description' => 'Công ty tư vấn nhân sự cung cấp dịch vụ tuyển dụng, đào tạo, xây dựng thương hiệu tuyển dụng và phần mềm quản trị nguồn nhân lực.',
                'hot' => false,
                'roles' => ['Recruitment Consultant', 'HR Executive', 'Employer Branding Specialist', 'PHP Developer - HRM Platform'],
            ],
        ];

        $jobId = 3001;

        foreach ($companies as $companyIndex => $company) {
            $employerId = 2101 + $companyIndex;
            $this->seedEmployer($employerId, $company);

            foreach ($company['roles'] as $roleIndex => $role) {
                $this->seedJob(
                    $jobId++,
                    $employerId,
                    $company,
                    $role,
                    $roleIndex
                );
            }
        }
    }

    private function seedEmployer(int $employerId, array $company): void
    {
        $now = now();
        $email = $company['slug'].'@company.demo';

        DB::table('users')->updateOrInsert(
            ['id' => $employerId],
            [
                'email' => $email,
                'email_verified_at' => $now,
                'password' => Hash::make('Company@123'),
                'role' => 2,
                'is_active' => true,
                'created_at' => $now,
                'updated_at' => $now,
            ]
        );

        DB::table('employers')->updateOrInsert(
            ['id' => $employerId],
            [
                'user_id' => $employerId,
                'name' => $company['name'],
                'address' => $company['address'],
                'min_employees' => $company['employees'][0],
                'max_employees' => $company['employees'][1],
                'contact_name' => 'Phòng Tuyển dụng',
                'phone' => '024'.str_pad((string) $employerId, 7, '0', STR_PAD_LEFT),
                'website' => $company['website'],
                'description' => $company['description']."\n\nMôi trường làm việc chuyên nghiệp, chú trọng đào tạo, minh bạch trong đánh giá và tạo cơ hội phát triển nghề nghiệp lâu dài.",
                'logo' => 'https://ui-avatars.com/api/?name='.urlencode($company['name']).'&size=256&background=0F4C81&color=ffffff&bold=true',
                'image' => 'https://images.unsplash.com/photo-1497366754035-f200968a6e72?auto=format&fit=crop&w=1600&q=80',
                'is_hot' => $company['hot'],
                'is_active' => true,
                'created_at' => $now,
                'updated_at' => $now,
            ]
        );

        $locationId = $this->findOrCreate('locations', $company['location']);
        DB::table('employer_location')->updateOrInsert([
            'employer_id' => $employerId,
            'location_id' => $locationId,
        ]);
    }

    private function seedJob(
        int $jobId,
        int $employerId,
        array $company,
        string $role,
        int $roleIndex
    ): void {
        $profile = $this->jobProfile($role);
        $jobTypeId = $this->findOrCreate('jtypes', $profile['type']);
        $jobLevelId = $this->findOrCreate('jlevels', $profile['level']);
        $industryId = $this->findOrCreate('industries', $company['industry']);
        $locationId = $this->findOrCreate('locations', $company['location']);
        $createdAt = now()->subDays(($jobId - 3000) % 24);

        DB::table('jobs')->updateOrInsert(
            ['id' => $jobId],
            [
                'employer_id' => $employerId,
                'jtype_id' => $jobTypeId,
                'jlevel_id' => $jobLevelId,
                'jname' => $role,
                'address' => $company['address'],
                'amount' => 1 + (($jobId + $roleIndex) % 5),
                'min_salary' => $profile['salary'][0],
                'max_salary' => $profile['salary'][1],
                'yoe' => $profile['experience'],
                'gender' => null,
                'description' => $this->jobDescription($role, $company['name'], $profile),
                'expire_at' => now()->addDays(35 + (($jobId * 7) % 55))->toDateString(),
                'is_hot' => ($jobId % 4) === 0,
                'is_active' => true,
                'created_at' => $createdAt,
                'updated_at' => now(),
            ]
        );

        DB::table('job_industry')->updateOrInsert([
            'job_id' => $jobId,
            'industry_id' => $industryId,
        ]);
        DB::table('job_location')->updateOrInsert([
            'job_id' => $jobId,
            'location_id' => $locationId,
        ]);

        foreach ($profile['skills'] as $skill) {
            $skillId = $this->findOrCreate('jskills', $skill);
            DB::table('job_skill')->updateOrInsert([
                'job_id' => $jobId,
                'skill_id' => $skillId,
            ]);
        }

        foreach ($profile['tags'] as $tag) {
            $tagId = $this->findOrCreate('jtags', $tag);
            DB::table('job_tag')->updateOrInsert([
                'job_id' => $jobId,
                'tag_id' => $tagId,
            ]);
        }
    }

    private function jobProfile(string $role): array
    {
        $roleLower = mb_strtolower($role);

        if (str_contains($roleLower, 'intern')) {
            return [
                'type' => 'Thực tập',
                'level' => 'Thực tập sinh',
                'salary' => [4, 8],
                'experience' => 0,
                'skills' => ['Giao tiếp', 'Làm việc nhóm', 'Tư duy học hỏi'],
                'tags' => ['Internship', 'On-site'],
            ];
        }

        if ($this->containsAny($roleLower, ['developer', 'engineer', 'administrator'])) {
            return [
                'type' => 'Nhân viên chính thức',
                'level' => 'Nhân viên',
                'salary' => [16, 32],
                'experience' => 2,
                'skills' => $this->technicalSkills($roleLower),
                'tags' => ['Technology', 'Hybrid'],
            ];
        }

        if ($this->containsAny($roleLower, ['designer', 'editor', 'content'])) {
            return [
                'type' => 'Nhân viên chính thức',
                'level' => 'Nhân viên',
                'salary' => [11, 22],
                'experience' => 1,
                'skills' => ['Figma', 'Sáng tạo nội dung', 'Làm việc nhóm'],
                'tags' => ['Creative', 'Portfolio'],
            ];
        }

        return [
            'type' => 'Nhân viên chính thức',
            'level' => 'Nhân viên',
            'salary' => [10, 24],
            'experience' => 1,
            'skills' => ['Giao tiếp', 'Phân tích', 'Microsoft Office'],
            'tags' => ['Full-time', 'Professional'],
        ];
    }

    private function technicalSkills(string $role): array
    {
        return match (true) {
            str_contains($role, 'php'), str_contains($role, 'laravel') => ['PHP', 'Laravel', 'MySQL', 'REST API'],
            str_contains($role, 'frontend'), str_contains($role, 'react') => ['JavaScript', 'React', 'HTML/CSS', 'REST API'],
            str_contains($role, 'java') => ['Java', 'Spring Boot', 'MySQL', 'Microservices'],
            str_contains($role, 'python'), str_contains($role, 'machine learning') => ['Python', 'SQL', 'Machine Learning', 'Docker'],
            str_contains($role, 'data') => ['SQL', 'Power BI', 'Excel', 'Python'],
            str_contains($role, 'devops'), str_contains($role, 'cloud') => ['Docker', 'Linux', 'CI/CD', 'Cloud'],
            str_contains($role, 'security') => ['Network Security', 'Linux', 'SIEM', 'Incident Response'],
            str_contains($role, 'network'), str_contains($role, 'system') => ['Networking', 'Linux', 'Cloud', 'Monitoring'],
            str_contains($role, 'qa') => ['Postman', 'Selenium', 'SQL', 'Automation Test'],
            str_contains($role, 'mobile'), str_contains($role, 'react native') => ['React Native', 'JavaScript', 'REST API', 'Git'],
            default => ['Git', 'SQL', 'REST API', 'Agile'],
        };
    }

    private function jobDescription(string $role, string $company, array $profile): string
    {
        $skills = implode(', ', $profile['skills']);

        return "VỊ TRÍ: {$role}\n\n"
            ."MÔ TẢ CÔNG VIỆC\n"
            ."- Tham gia triển khai các mục tiêu chuyên môn của phòng ban và phối hợp cùng các thành viên trong dự án.\n"
            ."- Phân tích yêu cầu, đề xuất giải pháp, thực hiện công việc đúng tiến độ và tiêu chuẩn chất lượng của {$company}.\n"
            ."- Chủ động báo cáo, xử lý vấn đề và đóng góp sáng kiến cải tiến quy trình.\n"
            ."- Phối hợp với các bộ phận liên quan để mang lại kết quả tốt nhất cho khách hàng và sản phẩm.\n\n"
            ."YÊU CẦU\n"
            ."- Có từ {$profile['experience']} năm kinh nghiệm hoặc nền tảng phù hợp với vị trí.\n"
            ."- Kiến thức/kỹ năng ưu tiên: {$skills}.\n"
            ."- Có tư duy giải quyết vấn đề, tinh thần trách nhiệm và khả năng làm việc nhóm.\n"
            ."- Chủ động học hỏi, giao tiếp rõ ràng; đọc hiểu tài liệu tiếng Anh là lợi thế.\n\n"
            ."QUYỀN LỢI\n"
            ."- Thu nhập cạnh tranh theo năng lực, thưởng hiệu quả công việc và tháng lương thứ 13.\n"
            ."- Đầy đủ BHXH, BHYT, BHTN; khám sức khỏe và du lịch hằng năm.\n"
            ."- Được đào tạo chuyên môn, có lộ trình phát triển và đánh giá minh bạch.\n"
            .'- Môi trường chuyên nghiệp, đồng nghiệp hỗ trợ và trang thiết bị làm việc đầy đủ.';
    }

    private function seedResumes(): void
    {
        $now = now();

        DB::table('resumes')->updateOrInsert(
            ['id' => self::PRIMARY_RESUME_ID],
            [
                'candidate_id' => self::CANDIDATE_ID,
                'title' => 'Backend Developer - Bùi Đức Tài Anh',
                'fullname' => 'Bùi Đức Tài Anh',
                'gender' => 0,
                'dob' => '2003-11-17',
                'phone' => '0987654321',
                'email' => 'taianh.bui@example.com',
                'address' => 'Cầu Giấy, Hà Nội',
                'link' => 'https://github.com/taianh-bui',
                'avatar' => 'https://ui-avatars.com/api/?name=Bui+Duc+Tai+Anh&size=512&background=0F4C81&color=ffffff&bold=true',
                'objective' => 'Mong muốn phát triển theo hướng Backend Developer chuyên sâu với PHP/Laravel và Node.js. Trong 2 năm tới, mục tiêu là làm chủ thiết kế REST API, tối ưu MySQL, kiểm thử tự động và quy trình CI/CD; đồng thời đóng góp vào các sản phẩm có giá trị thực tế.',
                'personalTitle' => 'THÔNG TIN CÁ NHÂN',
                'objectiveTitle' => 'MỤC TIÊU NGHỀ NGHIỆP',
                'educationTitle' => 'HỌC VẤN',
                'experienceTitle' => 'KINH NGHIỆM LÀM VIỆC',
                'projectTitle' => 'DỰ ÁN NỔI BẬT',
                'skillTitle' => 'KỸ NĂNG CHUYÊN MÔN',
                'certificateTitle' => 'CHỨNG CHỈ',
                'prizeTitle' => 'THÀNH TÍCH',
                'activityTitle' => 'HOẠT ĐỘNG',
                'cv_link' => null,
                'is_default' => true,
                'parts_order' => json_encode([
                    'personal',
                    'objective',
                    'skill',
                    'experience',
                    'project',
                    'education',
                    'certificate',
                    'prize',
                    'activity',
                    'other',
                ]),
                'created_at' => $now,
                'updated_at' => $now,
            ]
        );

        DB::table('resumes')->updateOrInsert(
            ['id' => self::SECONDARY_RESUME_ID],
            [
                'candidate_id' => self::CANDIDATE_ID,
                'title' => 'Full-stack Developer - Bùi Đức Tài Anh',
                'fullname' => 'Bùi Đức Tài Anh',
                'gender' => 0,
                'dob' => '2003-11-17',
                'phone' => '0987654321',
                'email' => 'taianh.bui@example.com',
                'address' => 'Cầu Giấy, Hà Nội',
                'link' => 'https://github.com/taianh-bui',
                'avatar' => 'https://ui-avatars.com/api/?name=Bui+Duc+Tai+Anh&size=512&background=0F4C81&color=ffffff&bold=true',
                'objective' => 'Tìm kiếm vị trí Full-stack Developer để vận dụng Laravel, ReactJS và kỹ năng thiết kế cơ sở dữ liệu, hướng tới xây dựng sản phẩm hoàn chỉnh từ giao diện đến backend.',
                'personalTitle' => 'GIỚI THIỆU',
                'objectiveTitle' => 'ĐỊNH HƯỚNG',
                'educationTitle' => 'HỌC VẤN',
                'experienceTitle' => 'KINH NGHIỆM',
                'projectTitle' => 'DỰ ÁN',
                'skillTitle' => 'CÔNG NGHỆ',
                'certificateTitle' => 'CHỨNG CHỈ',
                'prizeTitle' => 'THÀNH TÍCH',
                'activityTitle' => 'HOẠT ĐỘNG',
                'cv_link' => null,
                'is_default' => false,
                'parts_order' => json_encode([
                    'personal',
                    'objective',
                    'experience',
                    'project',
                    'skill',
                    'education',
                    'certificate',
                    'activity',
                ]),
                'created_at' => $now,
                'updated_at' => $now,
            ]
        );

        $this->replaceResumeItems();
    }

    private function replaceResumeItems(): void
    {
        $resumeIds = [self::PRIMARY_RESUME_ID, self::SECONDARY_RESUME_ID];

        foreach (['educations', 'experiences', 'projects', 'skills', 'certificates', 'prizes', 'activities', 'others'] as $table) {
            DB::table($table)
                ->where('candidate_id', self::CANDIDATE_ID)
                ->whereIn('resume_id', $resumeIds)
                ->delete();
        }

        foreach ($resumeIds as $resumeId) {
            DB::table('educations')->insert([
                [
                    'candidate_id' => self::CANDIDATE_ID,
                    'resume_id' => $resumeId,
                    'school' => 'Đại học Công nghệ - Đại học Quốc gia Hà Nội',
                    'major' => 'Công nghệ thông tin - Kỹ thuật phần mềm',
                    'start_date' => '2021-09-01',
                    'end_date' => '2025-06-30',
                    'description' => 'GPA: 3.35/4.0. Học phần nổi bật: Cấu trúc dữ liệu và giải thuật, Cơ sở dữ liệu, Phát triển ứng dụng Web, Công nghệ phần mềm, Mạng máy tính.',
                ],
            ]);

            DB::table('experiences')->insert([
                [
                    'candidate_id' => self::CANDIDATE_ID,
                    'resume_id' => $resumeId,
                    'name' => 'Backend Developer Intern',
                    'company' => 'NovaTech Solutions',
                    'start_date' => '2024-06-01',
                    'end_date' => '2024-09-30',
                    'description' => 'Phát triển REST API bằng Laravel; thiết kế migration và quan hệ Eloquent; tối ưu truy vấn MySQL; kiểm thử API bằng Postman; làm việc theo Git Flow và Scrum.',
                ],
                [
                    'candidate_id' => self::CANDIDATE_ID,
                    'resume_id' => $resumeId,
                    'name' => 'Freelance Web Developer',
                    'company' => 'Dự án cá nhân và nhóm',
                    'start_date' => '2023-10-01',
                    'end_date' => '2025-03-31',
                    'description' => 'Xây dựng website quản lý bán hàng và tuyển dụng; phân tích yêu cầu, thiết kế database, phát triển backend Laravel, tích hợp ReactJS và triển khai bản demo.',
                ],
            ]);

            DB::table('projects')->insert([
                [
                    'candidate_id' => self::CANDIDATE_ID,
                    'resume_id' => $resumeId,
                    'name' => 'Recruitment Web Platform',
                    'prj_type' => 'Đồ án tốt nghiệp',
                    'role' => 'Backend Developer / Database Designer',
                    'technologies' => 'Laravel 10, PHP 8.1, MySQL, JWT, Redis, Pusher, ReactJS',
                    'start_date' => '2025-01-01',
                    'end_date' => '2025-06-30',
                    'description' => 'Xây dựng hệ thống tuyển dụng với ba vai trò. Phát triển 112 API routes, xác thực JWT, quản lý nhiều CV, tìm kiếm việc làm, pipeline ứng tuyển, dashboard thống kê, thông báo và audit log.',
                    'link' => 'https://github.com/taianh-bui/recruitment-web',
                ],
                [
                    'candidate_id' => self::CANDIDATE_ID,
                    'resume_id' => $resumeId,
                    'name' => 'E-commerce Management API',
                    'prj_type' => 'Dự án cá nhân',
                    'role' => 'Full-stack Developer',
                    'technologies' => 'Laravel, ReactJS, MySQL, Docker',
                    'start_date' => '2024-02-01',
                    'end_date' => '2024-05-31',
                    'description' => 'Thiết kế API quản lý sản phẩm, tồn kho, đơn hàng và phân quyền; xây dựng dashboard quản trị; áp dụng validation, pagination và transaction.',
                    'link' => 'https://github.com/taianh-bui/ecommerce-management',
                ],
                [
                    'candidate_id' => self::CANDIDATE_ID,
                    'resume_id' => $resumeId,
                    'name' => 'Student Task Management',
                    'prj_type' => 'Dự án nhóm',
                    'role' => 'Team Leader / Backend Developer',
                    'technologies' => 'Node.js, Express, MongoDB, Socket.IO',
                    'start_date' => '2023-08-01',
                    'end_date' => '2023-12-15',
                    'description' => 'Ứng dụng quản lý công việc nhóm có bảng Kanban, thông báo thời gian thực và phân quyền thành viên. Điều phối nhóm 4 người và quản lý source code trên GitHub.',
                    'link' => 'https://github.com/taianh-bui/student-task-management',
                ],
            ]);

            $skills = [
                ['PHP', 88, 'Laravel, Eloquent ORM, REST API, Composer'],
                ['Laravel', 90, 'Routing, Middleware, JWT, Queue, Event, Feature Test'],
                ['MySQL', 85, 'Thiết kế quan hệ, index, transaction, tối ưu truy vấn'],
                ['JavaScript', 78, 'ES6+, async/await, Axios, DOM'],
                ['ReactJS', 75, 'Component, Hook, Router, quản lý state'],
                ['Git/GitHub', 85, 'Git Flow, pull request, xử lý conflict'],
                ['Docker', 68, 'Container hóa môi trường phát triển'],
                ['Tiếng Anh', 72, 'Đọc hiểu tài liệu kỹ thuật và giao tiếp cơ bản'],
            ];

            foreach ($skills as [$name, $proficiency, $description]) {
                DB::table('skills')->insert([
                    'candidate_id' => self::CANDIDATE_ID,
                    'resume_id' => $resumeId,
                    'name' => $name,
                    'proficiency' => $proficiency,
                    'description' => $description,
                ]);
            }

            DB::table('certificates')->insert([
                [
                    'candidate_id' => self::CANDIDATE_ID,
                    'resume_id' => $resumeId,
                    'name' => 'Laravel API Development',
                    'receive_date' => '2024-10-15',
                    'expire_date' => null,
                    'image' => null,
                ],
                [
                    'candidate_id' => self::CANDIDATE_ID,
                    'resume_id' => $resumeId,
                    'name' => 'TOEIC 720',
                    'receive_date' => '2024-03-20',
                    'expire_date' => '2026-03-20',
                    'image' => null,
                ],
            ]);

            DB::table('prizes')->insert([
                [
                    'candidate_id' => self::CANDIDATE_ID,
                    'resume_id' => $resumeId,
                    'name' => 'Top 10 cuộc thi Web Development cấp khoa',
                    'receive_date' => '2024-05-25',
                    'image' => null,
                ],
                [
                    'candidate_id' => self::CANDIDATE_ID,
                    'resume_id' => $resumeId,
                    'name' => 'Sinh viên giỏi năm học 2023-2024',
                    'receive_date' => '2024-09-05',
                    'image' => null,
                ],
            ]);

            DB::table('activities')->insert([
                [
                    'candidate_id' => self::CANDIDATE_ID,
                    'resume_id' => $resumeId,
                    'organization' => 'Câu lạc bộ Lập trình',
                    'role' => 'Thành viên Ban kỹ thuật',
                    'is_present' => false,
                    'start_date' => '2022-10-01',
                    'end_date' => '2024-06-30',
                    'description' => 'Hỗ trợ tổ chức workshop Git, REST API và nhập môn Laravel; hướng dẫn thành viên mới hoàn thiện dự án web đầu tiên.',
                    'link' => null,
                ],
                [
                    'candidate_id' => self::CANDIDATE_ID,
                    'resume_id' => $resumeId,
                    'organization' => 'Chương trình Tiếp sức mùa thi',
                    'role' => 'Tình nguyện viên',
                    'is_present' => false,
                    'start_date' => '2023-06-15',
                    'end_date' => '2023-07-15',
                    'description' => 'Hỗ trợ thí sinh và phụ huynh tại điểm thi, phối hợp điều phối đội tình nguyện.',
                    'link' => null,
                ],
            ]);

            DB::table('others')->insert([
                [
                    'candidate_id' => self::CANDIDATE_ID,
                    'resume_id' => $resumeId,
                    'name' => 'Điểm mạnh',
                    'description' => 'Tư duy logic, chủ động tìm hiểu công nghệ, có trách nhiệm với deadline, giao tiếp và phối hợp nhóm tốt.',
                ],
                [
                    'candidate_id' => self::CANDIDATE_ID,
                    'resume_id' => $resumeId,
                    'name' => 'Sở thích',
                    'description' => 'Đọc tài liệu công nghệ, xây dựng side project, chạy bộ và tham gia hoạt động cộng đồng.',
                ],
            ]);
        }
    }

    private function seedCandidateActivity(): void
    {
        $savedJobIds = [3001, 3002, 3005, 3007, 3014, 3025, 3048];
        foreach ($savedJobIds as $jobId) {
            DB::table('saved_jobs')->updateOrInsert([
                'candidate_id' => self::CANDIDATE_ID,
                'job_id' => $jobId,
            ]);
        }

        $applications = [
            3001 => ['viewed', 'Website'],
            3003 => ['interview', 'Website'],
            3007 => ['pending', 'Job Fair'],
            3028 => ['suitable', 'Referral'],
            3048 => ['rejected', 'Website'],
        ];

        foreach ($applications as $jobId => [$status, $source]) {
            DB::table('job_applying')->updateOrInsert(
                [
                    'job_id' => $jobId,
                    'candidate_id' => self::CANDIDATE_ID,
                ],
                [
                    'cv_link' => 'http://localhost:3000/candidate/resumes/'.self::PRIMARY_RESUME_ID,
                    'cv_type' => 'system',
                    'resume_id' => self::PRIMARY_RESUME_ID,
                    'internal_note' => $status === 'interview' ? 'Ứng viên có nền tảng backend phù hợp, cần trao đổi thêm về kinh nghiệm thực tế.' : null,
                    'interview_at' => $status === 'interview' ? now()->addDays(3) : null,
                    'source' => $source,
                    'status' => $status,
                    'created_at' => now()->subDays(($jobId % 12) + 1),
                    'updated_at' => now(),
                ]
            );
        }
    }

    private function containsAny(string $value, array $needles): bool
    {
        foreach ($needles as $needle) {
            if (str_contains($value, $needle)) {
                return true;
            }
        }

        return false;
    }

    private function findOrCreate(string $table, string $name): int
    {
        $id = DB::table($table)->where('name', $name)->value('id');

        return $id ?: DB::table($table)->insertGetId(['name' => $name]);
    }
}
