<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('job_applying', function (Blueprint $table) {
            $table->text('internal_note')->nullable()->after('resume_id');
            $table->dateTime('interview_at')->nullable()->after('internal_note');
            $table->string('source', 60)->nullable()->after('interview_at');
        });
    }

    public function down(): void
    {
        Schema::table('job_applying', function (Blueprint $table) {
            $table->dropColumn(['internal_note', 'interview_at', 'source']);
        });
    }
};
