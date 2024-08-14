<?php

use Carbon\Carbon;
use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

return new class extends Migration {
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('profile', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('indentity_id_users')->unique()->nullable();
            $table->string('agency_name')->nullable();
            $table->string('month')->nullable();
            $table->string('year')->nullable();
            $table->text('image')->nullable();
            $table->enum('log_type', array(0, 1, 2))->default(0);
            $table->integer('open')->default(0);
            $table->integer('permit')->default(0);
            $table->integer('leave')->default(0);
            $table->string('grade')->nullable();
            $table->string('date_not_absen')->nullable();
            $table->string('latitude')->nullable();
            $table->string('longitude')->nullable();
            $table->timestamps();
        });
        $date = Carbon::now();

        $monthName = $date->format('F'); // output: April
        $year = $date->format('Y'); // output: 2023
        DB::table('profile')->insert([
            'indentity_id_users' => 1000,
            'agency_name' => null,
            'image' => null,
            'open' => 0,
            'permit' => 0,
            'leave' => 0,
            'month' => $monthName,
            'year' =>  $year,
            'grade' => null,
            'date_not_absen' => null,
            'latitude' => null,
            'longitude' => null
        ]);


    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('profile');
    }
};