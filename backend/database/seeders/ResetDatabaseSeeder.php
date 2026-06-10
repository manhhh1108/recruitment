<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

class ResetDatabaseSeeder extends Seeder
{
    /**
     * Reset application tables and seed the project with baseline plus demo data.
     *
     * Run with:
     * php artisan db:seed --class=ResetDatabaseSeeder
     */
    public function run(): void
    {
        Schema::disableForeignKeyConstraints();

        foreach ($this->tablesToTruncate() as $table) {
            DB::table($table)->truncate();
        }

        Schema::enableForeignKeyConstraints();

        $this->call([
            UserSeeder::class,
            CandidateSeeder::class,
            LocationSeeder::class,
            EmployerSeeder::class,
            EmployerLocationSeeder::class,
            JtypeSeeder::class,
            JlevelSeeder::class,
            IndustrySeeder::class,
            JobSeeder::class,
            JobIndustrySeeder::class,
            JobLocationSeeder::class,
            EducationSeeder::class,
            ExperienceSeeder::class,
            SkillSeeder::class,
            ProjectSeeder::class,
            CertificateSeeder::class,
            PrizeSeeder::class,
            ActivitySeeder::class,
            OtherSeeder::class,
            DemoDatabaseSeeder::class,
            PresentationDemoSeeder::class,
        ]);
    }

    private function tablesToTruncate(): array
    {
        return [
            'candidate_messages',
            'saved_jobs',
            'job_applying',
            'job_skill',
            'job_tag',
            'job_location',
            'job_industry',
            'employer_location',
            'others',
            'activities',
            'prizes',
            'certificates',
            'skills',
            'projects',
            'experiences',
            'educations',
            'resumes',
            'jobs',
            'jskills',
            'jtags',
            'industries',
            'jlevels',
            'jtypes',
            'locations',
            'employers',
            'candidates',
            'users',
            'personal_access_tokens',
            'password_reset_tokens',
            'failed_jobs',
            'admin_audit_logs',
        ];
    }
}
