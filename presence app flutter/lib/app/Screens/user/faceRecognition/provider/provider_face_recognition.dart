import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../../models/absen/absen_permit_model.dart';
import '../../../../models/absen/add_absen_model.dart';
import '../../../../models/api.dart';
import '../../../../models/update_face_model.dart';
import '../../../../utils/alert_notif.dart';
import '../../../dashboard/views/dashboard_view.dart';
import '../../profile/controller/controller_set_profile.dart';

class FaceRecogProvider extends GetConnect {
  Map<String, String> bearerAuth({String? bearer}) => {
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $bearer'
      };
  Future<UpdateFaceModel> updateFace(BuildContext context,
      {required String? identityId,
      required dynamic faceId,
      required String brear}) async {
    Uri url = Uri.parse(Api.apiUpdateFace);

    final response = await http.post(url,
        body: {"indentity_id": "$identityId", "face_id": "$faceId"},
        headers: bearerAuth(bearer: brear));

    var jsonString = response.body;
    print(jsonString);
    if (response.statusCode == 200) {
      // ignore: use_build_context_synchronously
    } else if (response.statusCode == 500) {
      SetProfileController profileController =
          Get.put(SetProfileController(context:context));
      profileController.logout();
    } else {
      // ignore: use_build_context_synchronously
    }
    return faceFromJson(jsonString);
  }

  Future<AbsenPermitModel?> absenPermit(BuildContext context,
      {required String? identityId,
      required String? dateNotAbsen,
      required int count,
      required String? method_,
      required String brear}) async {
    Uri url = Uri.parse(Api.apiAbsenPermit);

    final response = await http.post(url,
        body: {
          "indentity_id": "$identityId",
          "date_not_absen": "$dateNotAbsen",
          "count": "$count",
          "method_": "$method_"
        },
        headers: bearerAuth(bearer: brear));

    var jsonString = response.body;
    print(jsonString);
    if (response.statusCode == 200) {
      // ignore: use_build_context_synchronously
    } else if (response.statusCode == 500) {
      SetProfileController profileController =
          Get.put(SetProfileController(context:context));
      profileController.logout();
    } else {
      // ignore: use_build_context_synchronously
    }
    return absenPermitFromJson(jsonString);
  }

  Future<AbsenModel?> addAbsen(BuildContext context,
      {required String? identityId,
      required String? latitude,
      required String? longitude,
      required String? date,
      required int? count,
      required String brear}) async {
    Uri url = Uri.parse(Api.apiAddAbsen);

    final response = await http.post(url,
        body: {
          "indentity_id": "$identityId",
          "latitude": "$latitude",
          "count": "$count",
          "date_not_absen": "$date",
          "longitude": "$longitude"
        },
        headers: bearerAuth(bearer: brear));

    var jsonString = response.body;
    print(jsonString);
   
    return absenFromJson(jsonString);
  }
}
