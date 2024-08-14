<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\ProfileController;
use App\Http\Controllers\Api\AbsenHistoryController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

Route::post('register', [AuthController::class, 'register']);

Route::post('login', [AuthController::class, 'login']);
Route::group(['middleware' => ['auth:sanctum']], function () {
    Route::post('show', [AuthController::class, 'show']);
    Route::post('updatedFace', [AuthController::class, 'updated']);
    Route::post('uploadImage', [ProfileController::class, 'uploadImage']);
    Route::post('updateProfile', [ProfileController::class, 'updateProfile']);
    Route::post('getProfile', [ProfileController::class, 'getData']);
    Route::get('listCount', [ProfileController::class, 'listCount']);
    Route::post('absen', [AbsenHistoryController::class, 'absen']);
    Route::post('getAbsen', [AbsenHistoryController::class, 'getAbsenUser']);
    Route::get('getAbsenAll', [AbsenHistoryController::class, 'getAbsenAll']);
    Route::post('countAbsen', [AbsenHistoryController::class, 'countAbsenCount']);
    Route::get('getUser', [AuthController::class, 'getUser']);
    Route::post('setNullFaceLoc', [AuthController::class, 'setNullFaceLoc']);
    Route::post('deleteAccount', [AuthController::class, 'deleteAccount']);
    Route::post('createUser', [AuthController::class, 'createUser']);
    Route::post('changePassword', [ProfileController::class, 'changePassword']);
    Route::post('absenPermit', [AbsenHistoryController::class, 'absenPermit']);
});