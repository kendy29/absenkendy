<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('users', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('indentity_id')->unique();
            $table->foreign('indentity_id')->references('indentity_id_users')->on('historyabsen')->foreign('indentity_id')->references('indentity_id_users')->on('profile');
            $table->string('name');
            $table->json('face_id')->nullable();
            $table->string('email')->unique();
            $table->timestamp('email_verified_at')->nullable();
            $table->string('password');
            $table->enum('is_admin', array(0, 1))->default(0);
            $table->rememberToken();
            $table->timestamps();
        });
        DB::table('users')->insert([
            'indentity_id' => 1000,
            'name' => 'admin',
            'face_id' => null,
            'email' => 'admin@gmail.com',
            'email_verified_at' => null,
            'is_admin' => '1',
            'password' => bcrypt('admin123'),
        ]);
       
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('users');
        Schema::table('users', function (Blueprint $table) {
            $table->dropForeign(['indentity_id']);
        });
    }
};
