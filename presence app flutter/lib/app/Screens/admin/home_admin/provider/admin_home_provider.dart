import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../models/add_user_model.dart';
import '../../../../models/api.dart';
import '../../../../models/banner_model.dart';
import '../../../../models/delete_account_model.dart';
import '../../../../models/get_user_model.dart';
import '../../../../models/profileModel/update_profile_model.dart';
import '../../../../models/set_nulll_model.dart';
import '../../../user/auth_screen/views/login_page.dart';
import '../../../user/profile/controller/controller_set_profile.dart';

class AdminHomeProvider extends GetConnect {
  Map<String, String> bearerAuth({String? bearer}) => {
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $bearer'
      };
  Future<GetUserModel> getUser(BuildContext context,
      {required String bearer}) async {
    Uri url = Uri.parse(Api.getUser);

    final response = await http.get(url, headers: bearerAuth(bearer: bearer));
    var jsonString = response.body;
    print(jsonString);
    if (response.statusCode == 200) {
    }else if (response.statusCode == 500) {
     final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('is_login', 0);
    Get.offAll(LoginPage());
    } else {}
    return getUserModelFromJson(jsonString);
  }
  Future<BannerModel> getListCount(BuildContext context,
      {required String bearer}) async {
    Uri url = Uri.parse(Api.listCount);

    final response = await http.get(url, headers: bearerAuth(bearer: bearer));
    var jsonString = response.body;
    print(jsonString);
    if (response.statusCode == 200) {
    }else if (response.statusCode == 500) {
     
    } else {}
    return bannerFromJson(jsonString);
  }

  Future<AddUserModel> addUser(
    BuildContext context, {
    required String bearer,
    required String? name,
    required String? identityId,
    required String? password,
    required String? confrimPassword,
    required String? agencyName,
    required String? grade,
    required String? email,
    required int? isAdmin,
  }) async {
    Uri url = Uri.parse(Api.addUser);

    final response = await http.post(url,
        body: {
          "indentity_id": "$identityId",
          "name": "$name",
          "password": "$password",
          "confrim_password": "$confrimPassword",
          "agency_name": "$agencyName",
          "grade": "$grade",
          "email": "$email",
          "is_admin": "$isAdmin",
        },
        headers: bearerAuth(bearer: bearer));
    var jsonString = response.body;
    print(jsonString);
    if (response.statusCode == 200) {
    } else {}
    return addUserModelFromJson(jsonString);
  }
  Future<SetNullModel> setNull(
    BuildContext context, {
    required String bearer,
    required String? method_,
    required String? indentityId
  }) async {
    Uri url = Uri.parse(Api.setNullFaceLoc);

    final response = await http.post(url,
        body: {
          "indentity_id": "$indentityId",
          "method_": "$method_"
        },
        headers: bearerAuth(bearer: bearer));
    var jsonString = response.body;
    print(jsonString);
    if (response.statusCode == 200) {
    } else {}
    return setNullModelFromJson(jsonString);
  }
  Future<UpdateProfileModel?> updateProfileUser(BuildContext context,
      {required String? indentityId,
      required String? agencyName,
      required String? grade,
      required String? bearer}) async {
    Uri url = Uri.parse(Api.updateProfile);

    final response = await http.post(url,
        body: {
          "indentity_id": "$indentityId",
          "agency_name": "$agencyName",
          "grade": "$grade"
        },
        headers: bearerAuth(bearer: bearer));
    var jsonString = response.body;

    print(jsonString);
    if (response.statusCode == 200) {
    } else {}
    return updateProfileFromJson(jsonString);
  }
  Future<DeleteAcountModel?> deleteAccount(BuildContext context,
      {required String? indentityId,
      required String? bearer}) async {
    Uri url = Uri.parse(Api.deleteAccount);

    final response = await http.post(url,
        body: {
          "indentity_id": "$indentityId"
        },
        headers: bearerAuth(bearer: bearer));
    var jsonString = response.body;

    print(jsonString);
    if (response.statusCode == 200) {
    } else {}
    return deleteAccountFromJson(jsonString);
  }
}
