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
        Schema::create('historyabsen', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('indentity_id_users')->nullable();
            $table->string('opened')->nullable();
            $table->string('closed')->nullable();
            $table->string('month')->nullable();
            $table->string('year')->nullable();
            $table->string('date')->nullable();
            $table->timestamps();
        });
       
    }

    /**az
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('historyabsen');
    }
}; 
