<?php

namespace App\Http\Controllers\Api;

use Carbon\Carbon;
use App\Models\User;
use App\Models\Profile;
use Illuminate\Support\Str;
use App\Models\AbsenHistory;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;
use Illuminate\Database\Eloquent\ModelNotFoundException;

class AuthController extends Controller
{
    public function register(Request $request)
    {
        try {
            $validator = Validator::make(
                $request->all(),
                [
                    'name' => 'required|string',
                    'email' => 'required|string',
                    'indentity_id' => 'required',
                    'password' => 'required|string',
                    'confrim_password' => 'required|same:password|string'
                ]

            );
            if ($validator->fails()) {
                $dataString = $validator->errors();
                $data = json_decode($dataString, true);
                $nameError = implode(' ', $data['name']);
                return response()->json(
                    [
                        'succes' => false,
                        'message' => 'ada kesalahan',
                        'data' => [
                            'name' => $nameError,
                            'email' => implode(' ', $data['email']),
                            'password' => implode(' ', $data['password']),
                            'indentity_id' => implode(' ', $data['indentity_id'])
                        ]
                    ],
                    501
                );
            } else {
                $date = Carbon::now();
                $monthName = $date->format('F'); // output: April
                $year = $date->format('Y'); // output: 2023
                $profile = Profile::create([
                    'indentity_id_users' => $request->indentity_id,
                    'month' => $monthName,
                    'year' => $year,
                ]);
                $input = $request->all();
                $input['password'] = bcrypt($input['password']);
                $user = User::create($input);

                $succes['token'] = $user->createToken('auth_token')->plainTextToken;
                $succes['name'] = $user->name;
                $succes['indentity_id'] = $user->indentity_id;


                return response()->json(
                    [
                        'succes' => true,
                        'message' => 'Sukses Register',
                        'data' => $succes
                    ],
                    200
                );

            }
        } catch (\Exception $th) {
            return response()->json(
                [
                    'succes' => false,
                    'message' => $th->getMessage(),
                    'data' => null

                ],
                500
            );
        }

    }
    public function login(Request $request)
    {
        if (Auth::attempt(['email' => $request->email, 'password' => $request->password])) {
            $auth = Auth::user();
            $succes['token'] = $auth->createToken('auth_token')->plainTextToken;
            $succes['name'] = $auth->name;
            $succes['face_id'] = $auth->face_id;
            $succes['indentity_id'] = $auth->indentity_id;
            $succes['is_admin'] = $auth->is_admin;

            return response()->json(
                [
                    'succes' => true,
                    'message' => 'Sukses Login',
                    'data' => $succes

                ],
                200
            );
        } else {
            return response()->json(
                [
                    'succes' => false,
                    'message' => 'check email and password',
                    'data' => null

                ],
                500
            );
        }
    }
    public function show(Request $request)
    {
        $validatedData = Validator::make(
            $request->all(),
            [
                'indentity_id' => 'required'
            ]
        );

        if ($validatedData->fails()) {
            $dataString = $validatedData->errors();
            $data = json_decode($dataString, true);
            $indentity_id_Error = implode(' ', $data['indentity_id']);
            return response()->json(
                [
                    'succes' => false,
                    'message' => 'ada kesalahan',
                    'data' => [
                        'indentity_id' => $indentity_id_Error,
                    ]
                ],
                501
            );
        } else {
            $user = User::where('indentity_id', $request->indentity_id)->first();
            if ($user) {
                $data = [
                    'status' => true,
                    'message' => 'show data Succesfully',
                    'data' => $user
                ];
                return response()->json($data, 200);
            } else {


                $data = [
                    'status' => false,
                    'message' => 'error data',
                    'data' => null
                ];
                return response()->json($data, 500);
            }
        }
    }
    public function updated(Request $request)
    {
        $validatedData = Validator::make(
            $request->all(),
            [
                'face_id' => 'required|string',
                'indentity_id' => 'required|string'
            ]

        );

        if ($validatedData->fails()) {


            $dataString = $validatedData->errors();
            $data = json_decode($dataString, true);
            if ($request->indentity_id != null) {
                return response()->json(
                    [
                        'succes' => false,
                        'message' => $validatedData->errors()->getMessages()['face_id'][0],
                        'data' => null
                    ],
                );
            } else if ($request->face_id != null) {
                return response()->json(
                    [
                        'succes' => false,
                        'message' => $validatedData->errors()->getMessages()['indentity_id'][0],
                        'data' => null
                    ],
                );
            } else if ($request->face_id == null && $request->indentity_id == null) {
                return response()->json(
                    [
                        'succes' => false,
                        'message' => 'ada kesalahan',
                        'data' => [
                            'indentity_id' => $validatedData->errors()->getMessages()['indentity_id'][0],
                            'face_id' => $validatedData->errors()->getMessages()['face_id'][0]
                        ]
                    ],
                    501
                );
            }
        } else {
            $data['face_id'] = $request->face_id;
            try {
                // find the user record by ID
                User::where('indentity_id', $request->indentity_id)->firstOrFail();
            } catch (ModelNotFoundException $e) {
                // handle the case where the user record is not found
                return response()->json([
                    'succes' => false,
                    'message' => 'User not found',
                    'data' => null

                ]);
            }
            $user = User::where('indentity_id', $request->indentity_id)->first();

            if ($user) {
                $user->update(
                    $data
                );
                $data = [
                    'status' => true,
                    'message' => 'User update Succesfully',
                    'data' => null
                ];
                return response()->json($data, 200);
            } else {
                $data = [
                    'status' => false,
                    'message' => 'Somethoing went wrong',
                    'data' => null
                ];
                return response()->json($data);
            }
        }
    }
    public function getUser(Request $request)
    {
        try {

            $now = Carbon::now();
            $year = $now->format('Y');
            $month = $now->format('F');


            $profile = Profile::get();
            if (!empty($profile->where('year', $year)->first()) && !empty($profile->where('month', $month)->first())) {
                $user = DB::table('users')
                    ->join('profile', 'profile.indentity_id_users', '=', 'users.indentity_id')
                    ->leftJoin('historyabsen', 'historyabsen.indentity_id_users', '=', 'users.indentity_id')
                    ->select('users.name', 'users.email', 'users.indentity_id', 'profile.agency_name', 'profile.latitude', 'profile.longitude', 'users.face_id', 'profile.grade', 'profile.open', 'profile.permit', 'profile.leave', 'profile.image', DB::raw('COALESCE(COUNT(historyabsen.opened), 0) as absen_masuk_count'),  DB::raw('COALESCE(COUNT(historyabsen.opened), 0) as absen_keluar_count'))->groupBy('users.indentity_id')
                    ->get();
                return response()->json([
                    'succes' => true,
                    'message' => 'Sukses get data User',
                    'data' => $user
                ]);
            } else if (empty($profile->where('year', $year)->first())) {
                foreach ($profile as $profiles) {
                    $oneYearAfter = $now->addYear()->format('Y');
                    $profiles->leave = 0;
                    $profiles->permit = 0;
                    $profiles->year = $oneYearAfter;
                    $profiles->save();
                }
                $user = DB::table('users')
                    ->join('profile', 'profile.indentity_id_users', '=', 'users.indentity_id')
                    ->leftJoin('historyabsen', 'historyabsen.indentity_id_users', '=', 'users.indentity_id')
                    ->select('users.name', 'users.email', 'users.indentity_id', 'profile.agency_name', 'profile.latitude', 'profile.longitude', 'users.face_id', 'profile.grade', 'profile.open', 'profile.permit', 'profile.leave', 'profile.image', DB::raw('(SELECT COALESCE(COUNT(opened),0) FROM historyabsen WHERE historyabsen.indentity_id_users = users.indentity_id) as absen_masuk_count'), DB::raw('(SELECT COALESCE(COUNT(closed),0) FROM historyabsen WHERE historyabsen.indentity_id_users = users.indentity_id) as absen_keluar_count'))
                    ->get();
                return response()->json([
                    'succes' => true,
                    'message' => 'Sukses get data User 2',
                    'data' => $user

                ]);
            } else {
                $oneMonthAfter = $now->addMonth();
                $oneMonthAfterName = $oneMonthAfter->format('F');
                $oneYearAfter = $now->addYear();
                foreach ($profile as $profiles) {
                    $oneYearAfter = $now->addYear();
                    $profiles->open = 0;
                    $profiles->year = $oneYearAfter;
                    $profiles->month = $oneMonthAfterName;
                    $profiles->save();
                }

                $user = DB::table('users')
                    ->join('profile', 'profile.indentity_id_users', '=', 'users.indentity_id')
                    ->leftJoin('historyabsen', 'historyabsen.indentity_id_users', '=', 'users.indentity_id')
                    ->select('users.name', 'users.email', 'users.indentity_id', 'profile.agency_name', 'profile.latitude', 'profile.longitude', 'users.face_id', 'profile.grade', 'profile.open', 'profile.permit', 'profile.leave', 'profile.image', DB::raw('(SELECT COALESCE(COUNT(opened),0) FROM historyabsen WHERE historyabsen.indentity_id_users = users.indentity_id) as absen_masuk_count'), DB::raw('(SELECT COALESCE(COUNT(closed),0) FROM historyabsen WHERE historyabsen.indentity_id_users = users.indentity_id) as absen_keluar_count'))
                    ->get();
                return response()->json([
                    'succes' => true,
                    'message' => 'Sukses get data User 3',
                    'data' => $user

                ]);
            }

        } catch (\Throwable $th) {
            return response()->json([
                'succes' => false,
                'message' => 'Error ' . $th,
                'data' => null
            ]);
        }

    }
    public function setNullFaceLoc(Request $request)
    {
        $validatedData = Validator::make(
            $request->all(),
            [
                'indentity_id' => 'required|string',
                'method_' => 'required|string'
            ]
        );
        if ($validatedData->fails()) {
            $errorMessages = $validatedData->errors()->getMessages();
            $firstErrorMessage = '';
            if (!empty($errorMessages['indentity_id'])) {
                // Jika pesan kesalahan untuk data pertama ada, tampilkan pesan kesalahan itu saja
                $firstErrorMessage = $errorMessages['indentity_id'][0];
            } else if (!empty($errorMessages['method_'])) {
                // Jika pesan kesalahan untuk data pertama tidak ada, tampilkan pesan kesalahan untuk data kedua (jika ada)
                $firstErrorMessage = $errorMessages['method_'][0];
            } else {
                $firstErrorMessage = 'Error';
            }
            return response()->json(
                [
                    'succes' => false,
                    'message' => $firstErrorMessage,
                    'data' => null
                ],
            );
        } else {
            if (User::where('indentity_id', $request->indentity_id)->exists()) {
                if ($request->method_ == 'faceId') {

                    $user = User::where('indentity_id', $request->indentity_id)->firstOrFail();
                    if (!empty($user->face_id)) {
                        $user->update([
                            'face_id' => null,
                        ]);
                        return response()->json([
                            'succes' => true,
                            'message' => 'Data sukses di update',
                            'data' => null
                        ]);
                    } else {
                        return response()->json([
                            'succes' => false,
                            'message' => 'Data gagal di update',
                            'data' => null
                        ]);
                    }
                } else if ($request->method_ == 'location') {
                    $profile = Profile::where('indentity_id_users', $request->indentity_id)->firstOrFail();
                    if (!empty($profile->latitude) && !empty($profile->longitude)) {
                        $profile->update([
                            'latitude' => null,
                            'longitude' => null
                        ]);
                        return response()->json([
                            'succes' => true,
                            'message' => 'Data sukses di update',
                            'data' => null
                        ]);
                    } else {
                        return response()->json([
                            'succes' => false,
                            'message' => 'Data gagal di update',
                            'data' => null
                        ]);
                    }
                }
            } else {

                return response()->json([
                    'succes' => false,
                    'message' => 'Data tidak di temukan',
                    'data' => null
                ]);

            }

        }
    }
    public function createUser(Request $request)
    {
        $validatedData = Validator::make(
            $request->all(),
            [
                'indentity_id' => 'required|string|unique:users',
                'name' => 'required|string',
                'email' => 'required|string|email|unique:users',
                'password' => 'required|string',
                'confrim_password' => 'required|same:password|string',
                'agency_name' => 'required|string',
                'grade' => 'required|string',
                'is_admin' => ['required', 'in:0,1']
            ]
        );
        if ($validatedData->fails()) {
            $errorMessages = $validatedData->errors()->getMessages();
            $firstErrorMessage = '';
            if (!empty($errorMessages['indentity_id'])) {
                // Jika pesan kesalahan untuk data pertama ada, tampilkan pesan kesalahan itu saja
                $firstErrorMessage = $errorMessages['indentity_id'][0];
            } else if (!empty($errorMessages['name'])) {
                // Jika pesan kesalahan untuk data pertama tidak ada, tampilkan pesan kesalahan untuk data kedua (jika ada)
                $firstErrorMessage = $errorMessages['name'][0];
            } else if (!empty($errorMessages['email'])) {
                // Jika pesan kesalahan untuk data pertama tidak ada, tampilkan pesan kesalahan untuk data kedua (jika ada)
                $firstErrorMessage = $errorMessages['email'][0];
            } else if (!empty($errorMessages['password'])) {
                // Jika pesan kesalahan untuk data pertama tidak ada, tampilkan pesan kesalahan untuk data kedua (jika ada)
                $firstErrorMessage = $errorMessages['password'][0];
            } else if (!empty($errorMessages['confrim_password'])) {
                // Jika pesan kesalahan untuk data pertama tidak ada, tampilkan pesan kesalahan untuk data kedua (jika ada)
                $firstErrorMessage = $errorMessages['confrim_password'][0];
            } else if (!empty($errorMessages['agency_name'])) {
                // Jika pesan kesalahan untuk data pertama tidak ada, tampilkan pesan kesalahan untuk data kedua (jika ada)
                $firstErrorMessage = $errorMessages['agency_name'][0];
            } else if (!empty($errorMessages['grade'])) {
                // Jika pesan kesalahan untuk data pertama tidak ada, tampilkan pesan kesalahan untuk data kedua (jika ada)
                $firstErrorMessage = $errorMessages['grade'][0];
            } else if (!empty($errorMessages['is_admin'])) {
                // Jika pesan kesalahan untuk data pertama tidak ada, tampilkan pesan kesalahan untuk data kedua (jika ada)
                $firstErrorMessage = $errorMessages['is_admin'][0];
            } else {
                $firstErrorMessage = 'error';
            }
            return response()->json(
                [
                    'succes' => false,
                    'message' => $firstErrorMessage,
                    'data' => null
                ],
            );
        } else {
            try {
                $date = Carbon::now();

                $monthName = $date->format('F'); // output: April
                $year = $date->format('Y'); // output: 2023
                $dataProfile = [
                    'indentity_id_users' => $request->indentity_id,
                    'agency_name' => $request->agency_name,
                    'image' => null,
                    'open' => 0,
                    'permit' => 0,
                    'leave' => 0,
                    'grade' => $request->grade,
                    'month' => $monthName,
                    'year' => $year,
                    'date_not_absen' => null,
                    'latitude' => null,
                    'longitude' => null
                ];
                $profile = Profile::create($dataProfile);

                $dataUser = [
                    'indentity_id' => $request->indentity_id,
                    'name' => $request->name,
                    'email' => $request->email,
                    'is_admin' => $request->is_admin,
                    'password' => bcrypt($request->password)

                ];
                $user = User::create($dataUser);

                if ($user && $profile) {
                    return response()->json([
                        'succes' => true,
                        'message' => 'Create User Berhasil',
                        'data' => null
                    ]);
                } else {
                    return response()->json([
                        'succes' => false,
                        'message' => 'Create User gagal',
                        'data' => null
                    ]);
                }
            } catch (\Throwable $th) {
                return response()->json(
                    [
                        'succes' => false,
                        'message' => $th->getMessage(),
                        'data' => null

                    ],
                    500
                );
            }


        }
    }
    public function deleteAccount(Request $request)
    {
        $validatedData = Validator::make(
            $request->all(),
            [
                'indentity_id' => 'required|string'
            ]
        );
        if ($validatedData->fails()) {
            $errorMessages = $validatedData->errors()->getMessages();
            $firstErrorMessage = '';
            if (!empty($errorMessages['indentity_id'])) {
                // Jika pesan kesalahan untuk data pertama ada, tampilkan pesan kesalahan itu saja
                $firstErrorMessage = $errorMessages['indentity_id'][0];
            } else {
                $firstErrorMessage = 'Error';
            }
            return response()->json(
                [
                    'succes' => false,
                    'message' => $firstErrorMessage,
                    'data' => null
                ],
            );
        } else {
            $user = User::where('indentity_id', $request->indentity_id);
            if (!empty(User::where('indentity_id', $request->indentity_id)->first())) {
                $user->delete();
                $profile = Profile::where('indentity_id_users', $request->indentity_id);
                if (!empty($profile->first())) {
                    $profile->delete();
                }
                $absen = AbsenHistory::where('indentity_id_users', $request->indentity_id);
                if (!empty($absen->first())) {
                    $absen->delete();
                }
                return response()->json(
                    [
                        'succes' => true,
                        'message' => 'Data Sukses Dihapus',
                        'data' => null
                    ],
                );
            } else {
                return response()->json(
                    [
                        'succes' => false,
                        'message' => 'Data tidak ditemukan',
                        'data' => null
                    ],
                );
            }
        }
    }
}