import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../models/absen/absen_all_model.dart';
import '../../../../models/absen/get_absen_user.dart';
import '../../../../models/api.dart';

class HistoryAdminProvider extends GetConnect {
  Map<String, String> bearerAuth({String? bearer}) => {
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $bearer'
      };
  Future<AbsenAllModel?> getAbsenAll({required String brear}) async {
    Uri url = Uri.parse(Api.apiAbsenAll);

    final response = await http.get(url, headers: bearerAuth(bearer: brear));

    var jsonString = response.body;
    print(jsonString);
    if (response.statusCode == 200) {
      // ignore: use_build_context_synchronously
    } else {
      // ignore: use_build_context_synchronously
    }
    return absenAllFromJson(jsonString);
  }
}
