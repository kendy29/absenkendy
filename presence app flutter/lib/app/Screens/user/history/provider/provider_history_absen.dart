import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../models/absen/get_absen_user.dart';
import '../../../../models/api.dart';

class HistoryAbsenProvider extends GetConnect {
  Map<String, String> bearerAuth({String? bearer}) => {
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $bearer'
      };
      Future<GEtModelUser?> getAbsenUser(
      {required String? identityId,
      required String brear}) async {
    Uri url = Uri.parse(Api.apiAbsenUser);

    final response = await http.post(url,
        body: {
          "indentity_id": "$identityId",
        },
        headers: bearerAuth(bearer: brear));

    var jsonString = response.body;
    if (response.statusCode == 200) {
      // ignore: use_build_context_synchronously
    } else {
      // ignore: use_build_context_synchronously
    }
    return getModelUserFromJson(jsonString);
  }
}
