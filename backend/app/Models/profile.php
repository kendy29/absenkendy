<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Profile extends Model
{
    use HasFactory;
    protected $table = 'profile';
    protected $fillable = [
        'indentity_id_users',
        'agency_name',
        'image',
        'log_type',
        'open',
        'permit',
        'leave',
        'grade',
        'date_not_absen',
        'year',
        'month',
        'latitude',
        'longitude'
    ];
    protected $casts = [
        'open' => 'integer',
        'permit' => 'integer',
        'leave' => 'integer',
    ];
}
