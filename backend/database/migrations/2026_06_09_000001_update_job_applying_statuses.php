<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    public function up(): void
    {
        DB::statement("ALTER TABLE job_applying MODIFY status VARCHAR(30) NOT NULL DEFAULT 'pending'");
        DB::table('job_applying')->where('status', 'WAITING')->update(['status' => 'pending']);
        DB::table('job_applying')->where('status', 'BROWSING_RESUME')->update(['status' => 'viewed']);
        DB::table('job_applying')->where('status', 'BROWSING_INTERVIEW')->update(['status' => 'interview']);
        DB::table('job_applying')->where('status', 'PASSED')->update(['status' => 'suitable']);
        DB::table('job_applying')->whereIn('status', ['RESUME_FAILED', 'INTERVIEW_FAILED'])->update(['status' => 'rejected']);
        DB::statement("ALTER TABLE job_applying MODIFY status ENUM('pending','viewed','suitable','rejected','interview','cancelled') NOT NULL DEFAULT 'pending'");
    }

    public function down(): void
    {
        DB::statement("ALTER TABLE job_applying MODIFY status VARCHAR(30) NOT NULL DEFAULT 'WAITING'");
        DB::table('job_applying')->where('status', 'pending')->update(['status' => 'WAITING']);
        DB::table('job_applying')->where('status', 'viewed')->update(['status' => 'BROWSING_RESUME']);
        DB::table('job_applying')->where('status', 'interview')->update(['status' => 'BROWSING_INTERVIEW']);
        DB::table('job_applying')->where('status', 'suitable')->update(['status' => 'PASSED']);
        DB::table('job_applying')->whereIn('status', ['rejected', 'cancelled'])->update(['status' => 'RESUME_FAILED']);

        DB::statement("ALTER TABLE job_applying MODIFY status ENUM('WAITING','BROWSING_RESUME','RESUME_FAILED','BROWSING_INTERVIEW','INTERVIEW_FAILED','PASSED') NOT NULL DEFAULT 'WAITING'");
    }
};
