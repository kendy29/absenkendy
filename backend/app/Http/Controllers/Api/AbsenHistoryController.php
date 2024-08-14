<?php

namespace App\Http\Controllers\Api;

use Carbon\Carbon;
use App\Models\Profile;
use Jenssegers\Date\Date;
use App\Models\AbsenHistory;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Validator;
use Illuminate\Database\Eloquent\ModelNotFoundException;

class AbsenHistoryController extends Controller
{
    public function absen(Request $request)
    {
        $validatedData = Validator::make(
            $request->all(),
            [
                'latitude' => 'required|string',
                'longitude' => 'required|string',
                'indentity_id' => 'required|string',
                'date_not_absen' => 'required|string',
                'count' => 'required|int'
            ]

        );

        if ($validatedData->fails()) {

            $errorMessages = $validatedData->errors()->getMessages();
            $firstErrorMessage = '';
            if (!empty($errorMessages['indentity_id'])) {
                // Jika pesan kesalahan untuk data pertama ada, tampilkan pesan kesalahan itu saja
                $firstErrorMessage = $errorMessages['indentity_id'][0];
            } else if (!empty($errorMessages['latitude'])) {
                // Jika pesan kesalahan untuk data pertama tidak ada, tampilkan pesan kesalahan untuk data kedua (jika ada)
                $firstErrorMessage = $errorMessages['latitude'][0];
            } else if (!empty($errorMessages['longitude'])) {
                $firstErrorMessage = $errorMessages['longitude'][0];
            } else if (!empty($errorMessages['date_not_absen'])) {
                $firstErrorMessage = $errorMessages['date_not_absen'][0];
            } else if (!empty($errorMessages['count'])) {
                $firstErrorMessage = $errorMessages['count'][0];
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
            $profile = Profile::where('indentity_id_users', $request->indentity_id)->first(); // Mengambil data profile berdasarkan identity
            $waktuSekarang = Carbon::now()->toTimeString();
            $now = Carbon::now();
            $year = $now->format('Y');
            $month = $now->format('F');

            Date::setLocale('id');
            $tanggal = Date::now()->format('l j F Y');
            if (Profile::where('indentity_id_users', $request->indentity_id)->whereNull('latitude')->whereNull('longitude')->exists()) {
                $profile->update([

                    'latitude' => $request->latitude,
                    'longitude' => $request->longitude
                ]);
                $data = [
                    'indentity_id_users' => $request->indentity_id,
                    'date' => $tanggal,
                    'opened' => $waktuSekarang,
                    'month' => $month,
                    'year' => $year
                    // tambahkan field dan nilai yang ingin disimpan
                ];


                AbsenHistory::create($data);
                $profileUpdate = Profile::where('indentity_id_users', $request->indentity_id)->first();

                $profileUpdate->update([
                    'log_type' => '1',
                    'open' => $request->count
                ]);
                return response()->json(
                    [
                        'succes' => true,
                        'message' => 'Sukses update lokasi dan absen',
                        'data' => null
                    ],
                    200
                );
            } else {
                // Data profile belum ada, lakukan insert data profile
                if ($profile['log_type'] == 0 && AbsenHistory::where('indentity_id_users', $request->indentity_id)->whereNull('date')->exists()) {
                    try {
                        // find the user record by ID
                        AbsenHistory::where('indentity_id_users', $request->indentity_id)->firstOrFail();
                    } catch (ModelNotFoundException $e) {
                        // handle the case where the user record is not found
                        $data = [
                            'indentity_id_users' => $request->indentity_id,
                            'date' => $tanggal,
                            'opened' => $waktuSekarang,
                            'month' => $month,
                            'year' => $year
                            // tambahkan field dan nilai yang ingin disimpan
                        ];


                        AbsenHistory::create($data);
                    }
                    $data = [
                        'date' => $tanggal,
                        'opened' => $waktuSekarang,
                        'open' => $request->count,
                        'month' => $month,
                        'year' => $year
                        // tambahkan field dan nilai yang ingin disimpan
                    ];

                    $absen = AbsenHistory::where('indentity_id_users', $request->indentity_id)->first();
                    $profileUpdate = Profile::where('indentity_id_users', $request->indentity_id)->first();
                    $absen->update($data);
                    $profileUpdate->update([
                        'log_type' => '1'
                    ]);
                    return response()->json(
                        [
                            'succes' => true,
                            'message' => 'Sukses absen masuk',
                            'data' => null
                        ],
                        200
                    );
                } else if (empty(AbsenHistory::where('indentity_id_users', $request->indentity_id)->first())) {
                    $data = [
                        'indentity_id_users' => $request->indentity_id,
                        'date' => $tanggal,
                        'opened' => $waktuSekarang,
                        'month' => $month,
                        'year' => $year
                        // tambahkan field dan nilai yang ingin disimpan
                    ];


                    AbsenHistory::create($data);
                    $profileUpdate = Profile::where('indentity_id_users', $request->indentity_id)->first();
                    $profileUpdate->update([
                        'log_type' => '1',
                        'open' => $request->count
                    ]);
                    return response()->json(
                        [
                            'succes' => true,
                            'message' => 'Sukses absen masuk',
                            'data' => null
                        ],
                        200
                    );

                } else if ($profile['log_type'] == 1 && !empty(AbsenHistory::where('indentity_id_users', $request->indentity_id)->where('date', $tanggal)->whereNotNull('opened')->whereNull('closed')->latest()->first())) {

                    $data = [
                        'closed' => $waktuSekarang
                        // tambahkan field dan nilai yang ingin disimpan
                    ];

                    $absen = AbsenHistory::where('indentity_id_users', $request->indentity_id)->where('date', $tanggal)->whereNotNull('opened')->latest()->first();


                    $absen->update($data);

                    $profileUpdate = Profile::where('indentity_id_users', $request->indentity_id)->first();
                    $profileUpdate->update([
                        'log_type' => '2',
                        'date_not_absen'=>$request->date_not_absen
                    ]);
                    return response()->json(
                        [
                            'succes' => true,
                            'message' => 'Sukses absen keluar',
                            'data' => null
                        ],
                        200

                    );
                } else if ($profile['log_type'] == 2 && empty(AbsenHistory::where('indentity_id_users', $request->indentity_id)->where('date', $tanggal)->latest()->first())) {
                    $data = [
                        'indentity_id_users' => $request->indentity_id,
                        'date' => $tanggal,
                        'opened' => $waktuSekarang,
                        'month' => $month,
                        'year' => $year
                        // tambahkan field dan nilai yang ingin disimpan
                    ];


                    AbsenHistory::create($data);
                    $profileUpdate = Profile::where('indentity_id_users', $request->indentity_id)->first();
                    $profileUpdate->update([
                        'log_type' => '1',
                        'open' => $request->count
                    ]);
                    return response()->json(
                        [
                            'succes' => true,
                            'message' => 'Sukses absen masuk',
                            'data' => null
                        ],
                        200
                    );
                } else {
                    $profileUpdate = Profile::where('indentity_id_users', $request->indentity_id)->first();
                    $profileUpdate->update([
                        'log_type' => '2',
                        'date_not_absen'=>$request->date_not_absen
                    ]);
                    return response()->json(
                        [
                            'succes' => false,
                            'message' => 'Silakan absen besok',
                            'data' => null
                        ]
                    );
                }
            }
        }
    }
    public function getAbsenUser(Request $request)
    {
        $validatedData = Validator::make(
            $request->all(),
            [
                'indentity_id' => 'required|string',
            ]
        );

        if ($validatedData->fails()) {


            $dataString = $validatedData->errors();
            $data = json_decode($dataString, true);

            return response()->json(
                [
                    'succes' => false,
                    'message' => $validatedData->errors()->getMessages()['indentity_id'][0],
                    'data' => null
                ],
            );

        } else {
            try {

                $absen = AbsenHistory::where('indentity_id_users', $request->indentity_id)->get();
                if ($absen->isNotEmpty()) {

                    return response()->json([
                        'succes' => true,
                        'message' => 'Get Data Sukses',
                        'data' => $absen

                    ], 200);
                } else {

                    return response()->json([
                        'succes' => false,
                        'message' => 'Get Data Failled',
                        'data' => null

                    ], 500);
                }

            } catch (ModelNotFoundException $e) {
                // handle the case where the user record is not found
                return response()->json([
                    'succes' => false,
                    'message' => 'Absen not found',
                    'data' => null

                ]);
            }
        }
    }
    public function getAbsenAll()
    {

        try {
            $absen = DB::table('historyabsen')
                ->join('profile', 'historyabsen.indentity_id_users', '=', 'profile.indentity_id_users')
                ->join('users', 'historyabsen.indentity_id_users', '=', 'users.indentity_id')
                ->whereNotNull('historyabsen.date')
                ->select('users.name', 'historyabsen.id', 'historyabsen.indentity_id_users', 'historyabsen.date', 'historyabsen.opened', 'historyabsen.closed', 'profile.image', 'historyabsen.created_at', 'historyabsen.updated_at')
                ->get();
            return response()->json([
                'succes' => true,
                'message' => 'Get Data Sukses',
                'data' => $absen

            ]);
        } catch (ModelNotFoundException $e) {
            // handle the case where the user record is not found
            return response()->json([
                'succes' => false,
                'message' => 'Absen not found',
                'data' => null

            ]);
        }
    }
    public function absenPermit(Request $request)
    {
        $validatedData = Validator::make(
            $request->all(),
            [
                'indentity_id' => 'required|string',
                'date_not_absen' => 'required|string',
                'count' => 'integer',
                'method_' => 'required|string'
            ]
        );
        if ($validatedData->fails()) {
            $errorMessages = $validatedData->errors()->getMessages();
            $firstErrorMessage = '';
            if (!empty($errorMessages['indentity_id'])) {
                // Jika pesan kesalahan untuk data pertama ada, tampilkan pesan kesalahan itu saja
                $firstErrorMessage = $errorMessages['indentity_id'][0];
            } else if (!empty($errorMessages['date_not_absen'])) {
                // Jika pesan kesalahan untuk data pertama tidak ada, tampilkan pesan kesalahan untuk data kedua (jika ada)
                $firstErrorMessage = $errorMessages['date_not_absen'][0];
            } else if (!empty($errorMessages['count'])) {
                $firstErrorMessage = $errorMessages['count'][0];
            } else if (!empty($errorMessages['method_'])) {
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
            try {
                $profile = Profile::where('indentity_id_users', $request->indentity_id)->firstOrFail();
                if ($request->method_ == 'izin') {
                    $profile->update([
                        'permit' => $request->count,
                        'log_type' => '2',
                        'date_not_absen' => $request->date_not_absen
                    ]);
                    return response()->json(
                        [
                            'succes' => true,
                            'message' => 'Sukses Permohonan izin',
                            'data' => null
                        ],
                    );
                } else if ($request->method_ == 'cuti') {
                    $profile->update([
                        'leave' => $request->count,
                        'log_type' => '2',
                        'date_not_absen' => $request->date_not_absen
                    ]);
                    return response()->json(
                        [
                            'succes' => true,
                            'message' => 'Sukses Permohonan Cuti',
                            'data' => null
                        ],
                    );
                } else {
                    return response()->json(
                        [
                            'succes' => false,
                            'message' => 'Request failled',
                            'data' => null
                        ],
                    );
                }

            } catch (\Throwable $th) {
                return response()->json(
                    [
                        'succes' => false,
                        'message' => 'User tidak di temukan',
                        'data' => null
                    ],
                );
            }
        }
    }
    public function countAbsenCount(Request $request)
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
            if ($request->method_ == 'opened') {

                $profile = AbsenHistory::where('indentity_id_users', $request->indentity_id)
                    ->whereNotNull('opened')->count();
                return response()->json(
                    [
                        'succes' => false,
                        'message' => 'count Absen Masuk',
                        'data' => $profile
                    ],
                );
            } else if ($request->method_ == 'closed') {
                $profile = AbsenHistory::where('indentity_id_users', $request->indentity_id)
                    ->whereNotNull('closed')->count();
                return response()->json(
                    [
                        'succes' => false,
                        'message' => 'count Absen Keluar',
                        'data' => $profile
                    ],
                );
            }
        }
    }

}