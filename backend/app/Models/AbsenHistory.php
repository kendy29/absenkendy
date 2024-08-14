<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AbsenHistory extends Model
{
    use HasFactory;
    protected $table = 'historyabsen';
    protected $fillable = [
        'indentity_id_users',
        'opened',
        'date',
        'year',
        'month',
        'closed'
    ];
}
