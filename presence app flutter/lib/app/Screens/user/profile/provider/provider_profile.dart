import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../models/api.dart';
import '../../../../models/password_model.dart';
import '../../../../models/profileModel/getProfile_model.dart';
import '../../../../models/profileModel/update_profile_model.dart';
import '../../../../utils/alert_notif.dart';
import '../controller/controller_set_profile.dart';

class ProfileProvider extends GetConnect {
  Map<String, String> bearerAuth({String? bearer}) => {
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $bearer'
      };
  Future<ProfileModel?> getProfile(BuildContext context,
      {required String? indentityId, required String? bearer}) async {
    Uri url = Uri.parse(Api.getProfile);

    final response = await http.post(url,
        body: {
          "indentity_id": "$indentityId",
        },
        headers: bearerAuth(bearer: bearer));
    var jsonString = response.body;
    print('DATA ' + jsonString);
    if (response.statusCode == 200) {
    } else if (response.statusCode == 500) {
      SetProfileController profileController =
          Get.put(SetProfileController(context: context));
      profileController.logout();
    }
    return profileModelFromJson(jsonString);
  }

  Future pushProfilePhoto(
    BuildContext context, {
    required String photoPath,
    required String? bearer,
    required String? indentityId,
  }) async {
    var url = Api.uploadImage;
    var request = http.MultipartRequest('POST', Uri.parse(url));

    request.files.add(await http.MultipartFile.fromPath('image', photoPath));

    request.fields['indentity_id'] = indentityId!;

    request.headers.assignAll(bearerAuth(bearer: bearer));

    http.StreamedResponse response = await request.send();
    print( await response.stream.bytesToString());
    if (response.statusCode == 200) {
      SetProfileController profileController =
          Get.put(SetProfileController(context: context));
      profileController.getProfile();
    } else {
      showNotificationRed(context, "Gagal diperbarui.");
      print(
          'gagal input profile ${await response.stream.bytesToString()} ${response.reasonPhrase}');
    }
  }

  Future<UpdateProfileModel?> updateProfile(BuildContext context,
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

  Future<ChangePasswordModel?> changePassword(BuildContext context,
      {required String? oldPass,
      required String? newPass,
      required String? bearer}) async {
    Uri url = Uri.parse(Api.changePassword);

    final response = await http.post(url,
        body: {"old_password": "$oldPass", "new_password": "$newPass"},
        headers: bearerAuth(bearer: bearer));
    var jsonString = response.body;

    print(jsonString);
    if (response.statusCode == 200) {
    } else {}
    return passwordModelFromJson(jsonString);
  }
}
