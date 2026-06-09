<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('job_applying', function (Blueprint $table) {
            $table->string('cv_type', 20)->default('upload')->after('cv_link');
            $table->unsignedBigInteger('resume_id')->nullable()->after('cv_type');
        });
    }

    public function down(): void
    {
        Schema::table('job_applying', function (Blueprint $table) {
            $table->dropColumn(['cv_type', 'resume_id']);
        });
    }
};
