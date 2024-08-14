import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../../models/api.dart';
import '../../../../models/auth_model.dart';
import '../../../../utils/alert_notif.dart';

class AuthProvider extends GetConnect {
  Future<LoginModel> authLogin(BuildContext context,
      {required String? email, required String? password}) async {
    Uri url = Uri.parse(Api.apiLogin);

    final response = await http.post(url,
        body: json.encode({
          "email": "$email",
          "password": "$password",
        }),
        headers: {"Content-Type": "application/json"});
    var jsonString = response.body;
    print(jsonString);
    if (response.statusCode == 200) {
      showNotificationGreen(context, "Sukses Login.");
    } else {
      showNotificationRed(context, "Gagal Login.");
    }
    return loginFromJson(jsonString);
  }
}
