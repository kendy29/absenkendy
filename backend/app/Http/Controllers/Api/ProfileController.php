<?php

namespace App\Http\Controllers\Api;

use Carbon\Carbon;
use App\Models\User;
use App\Models\Profile;
use Jenssegers\Date\Date;
use App\Models\AbsenHistory;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use Illuminate\Database\Eloquent\ModelNotFoundException;

class ProfileController extends Controller
{
    public function uploadImage(Request $request)
    {

        try {
            $validatedData = Validator::make(
                $request->all(),
                [
                    'image' => 'required|image|mimes:jpeg,png,jpg,svg',
                    'indentity_id' => 'required'
                ]
            );
            if ($validatedData->fails()) {
                $errorMessages = $validatedData->errors()->getMessages();
                $firstErrorMessage = '';
                if (!empty($errorMessages['indentity_id'])) {
                    // Jika pesan kesalahan untuk data pertama ada, tampilkan pesan kesalahan itu saja
                    $firstErrorMessage = $errorMessages['indentity_id'][0];
                } else if (!empty($errorMessages['image'])) {
                    // Jika pesan kesalahan untuk data pertama tidak ada, tampilkan pesan kesalahan untuk data kedua (jika ada)
                    $firstErrorMessage = $errorMessages['image'][0];
                } else {
                    $firstErrorMessage = 'Error';
                }
                return response()->json([
                    'succes' => false,
                    'message' => $firstErrorMessage,
                    'data' => null
                ]);

            } else {

                $date = date('Ymd_His');

                try {
                    // find the user record by ID
                    Profile::where('indentity_id_users', $request->indentity_id)->firstOrFail();
                } catch (ModelNotFoundException $e) {
                    // handle the case where the user record is not found
                    return response()->json([
                        'succes' => false,
                        'message' => 'User not found',
                        'data' => null

                    ]);
                }
                $photo = Profile::where('indentity_id_users', $request->indentity_id)->firstOrFail();
                if ($photo->image && file_exists(public_path('\images\\' . $photo->image))) {
                    unlink(public_path('\images\\' . $photo->image));
                }
                $image = $request->file('image');
                $imageName = $date . '.' . $image->getClientOriginalExtension();
                $image->move(public_path('images'), $imageName);
                $data['image'] = $imageName;
                if ($photo) {
                    $photo->update($data);

                    return response()->json([
                        'succes' => true,
                        'message' => 'Photo uploaded successfully',
                        'data' => null

                    ]);
                } else {
                    return response()->json([
                        'succes' => true,
                        'message' => 'Photo uploaded failled',
                        'data' => null

                    ]);
                }
            }


        } catch (\Illuminate\Auth\AuthenticationException $exception) {
            return response()->json([
                'succes' => false,
                'message' => 'error',
                'data' => null

            ]);
        }

    }
    public function updateProfile(Request $request)
    {
        $validatedData = Validator::make(
            $request->all(),
            [
                'indentity_id' => 'required|string',
                'agency_name' => 'required|string',
                'grade' => 'required|string'
            ]
        );
        if ($validatedData->fails()) {
            $errorMessages = $validatedData->errors()->getMessages();
            $firstErrorMessage = '';
            if (!empty($errorMessages['indentity_id'])) {
                // Jika pesan kesalahan untuk data pertama ada, tampilkan pesan kesalahan itu saja
                $firstErrorMessage = $errorMessages['indentity_id'][0];
            } else if (!empty($errorMessages['agency_name'])) {
                // Jika pesan kesalahan untuk data pertama tidak ada, tampilkan pesan kesalahan untuk data kedua (jika ada)
                $firstErrorMessage = $errorMessages['agency_name'][0];
            } else if (!empty($errorMessages['grade'])) {
                $firstErrorMessage = $errorMessages['grade'][0];
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
                // find the user record by ID
                Profile::where('indentity_id_users', $request->indentity_id)->firstOrFail();
            } catch (ModelNotFoundException $e) {
                // handle the case where the user record is not found
                return response()->json([
                    'succes' => false,
                    'message' => 'Data indentity tidak di temukan',
                    'data' => null

                ]);
            }
            $data['grade'] = $request->grade;
            $data['agency_name'] = $request->agency_name;
            $photo = Profile::where('indentity_id_users', $request->indentity_id);
            if ($photo) {
                $photo->update($data);

                return response()->json([
                    'succes' => true,
                    'message' => 'Data Sukses di ubah',
                    'data' => null

                ]);
            } else {
                return response()->json([
                    'succes' => true,
                    'message' => 'Data Gagal di ubah',
                    'data' => null

                ]);
            }
        }
    }
    public function getData(Request $request)
    {
        try {
            $now = Carbon::now();
            $year = $now->format('Y');
            $month = $now->format('F');
          

            if (!empty(Profile::where('indentity_id_users', $request->indentity_id)->where('year',$year)->first()) && !empty(Profile::where('indentity_id_users', $request->indentity_id)->where('month',$month)->first())) {
                $user = Profile::where('indentity_id_users', $request->indentity_id);
                return response()->json([
                    'succes' => true,
                    'message' => 'Sukses get data User',
                    'data' => $user->first()
                ]);
                 // jika Tahunya beda maka
            } else if (empty(Profile::where('indentity_id_users', $request->indentity_id)->where('year',$year)->first())) {
                $oneYearAfter = $now->addYear()->format('Y');
                $user = Profile::where('indentity_id_users', $request->indentity_id)->first();
                $user->update([
                    'leave' => 0,
                    'open' => 0,
                    'permit' => 0,
                    'year' => $oneYearAfter
                ]);
                return response()->json([
                    'succes' => true,
                    'message' => 'Sukses get data User 2',
                    'data' => $user

                ]);
            }
            // jika month nya beda dan tahunnya sama maka
            else if (empty(Profile::where('indentity_id_users', $request->indentity_id)->where('month',$month)->first())&&!empty(Profile::where('indentity_id_users', $request->indentity_id)->where('year',$year)->first())) {
               
                $oneMonthAfter = $now->addMonth()->format('F');
                $user = Profile::where('indentity_id_users', $request->indentity_id)->first();
                $user->update([
                
                    'open' => 0,
                    'month' => $oneMonthAfter
                ]);
                return response()->json([
                    'succes' => true,
                    'message' => 'Sukses get data User 3',
                    'data' => $user

                ]);
            }
            else {
                $oneMonthAfter = $now->addMonth()->format('F');
                $oneYearAfter = $now->addYear()->format('Y');
                $user = Profile::where('indentity_id_users', $request->indentity_id)->first();
                $user->update([
                    'open' => 0,
                    'leave' => 0,
                    'permit' => 0,
                    'month' => $oneMonthAfter,
                    'year' => $oneYearAfter
                ]);
                return response()->json([
                    'succes' => true,
                    'message' => 'Sukses get data User 4',
                    'data' => $user->first()

                ]);
            }

        } catch (ModelNotFoundException $e) {
            // handle the case where the user record is not found
            return response()->json([
                'succes' => false,
                'message' => 'User not found',
                'data' => null

            ]);
        }


    }
    public function changePassword(Request $request)
    {
        $user = auth()->user();
        $oldPassword = $request->old_password;
        $newPassword = $request->new_password;

        if (!Hash::check($oldPassword, $user->password)) {
            return response()->json([
                'succes' => false,
                'message' => 'Password Lama Salah',
                'data' => null
            ], 401);
        }

        $user->password = Hash::make($newPassword);
        $user->save();

        return response()->json([
            'succes' => true,
            'message' => 'Password berhasil diubah',
            'data' => null
        ]);
    }
    public function listCount()
    {
        $now = Carbon::now();
        $year = $now->format('Y');
        $month = $now->format('F');
        $data = [
            [
                'count' => User::count(),
                'name' => 'karyawan',
            ],
            [
                'count' => AbsenHistory::whereNotNull('opened')->where('month',$month)->where('year',$year)->count(),
                'name' => 'Absen Masuk',
            ],
            [
                'count' => AbsenHistory::whereNotNull('closed')->where('month',$month)->where('year',$year)->count(),
                'name' => 'Absen Keluar',
            ],
        ];
        return response()->json([
            'succes' => true,
            'message' => 'Data Berhasil Di Dapat',
            'data' => $data
        ]);
    }
}