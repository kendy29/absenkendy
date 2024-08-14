import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../models/auth_model.dart';
import '../../../../utils/alert_notif.dart';
import '../../../dashboard/controller/controller_dashboard.dart';
import '../../../dashboard/views/dashboard_view.dart';
import '../../faceRecognition/views/Detec_face.dart';
import '../provider/provider_auth.dart';

class AuthController extends GetxController {
  AuthProvider provider = AuthProvider();
  final keyRegister = GlobalKey<FormState>();
  // login
  Rx<TextEditingController> emailLoginController = TextEditingController().obs;
  Rx<TextEditingController> passLoginController = TextEditingController().obs;
  dynamic data = {}.obs;
  File? jsonFile;

  Directory? tempDir;
  RxBool isLoading = false.obs;
  RxBool isLoginPassAbsourt = true.obs;
  RxBool isRegisterPassAbsourt = true.obs;
  Future setLogin(BuildContext context) async {
    try {
      isLoading.value = true;
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      LoginModel model = await provider.authLogin(context,
          email: emailLoginController.value.text,
          password: passLoginController.value.text);
      await prefs.setInt('identity_id', model.data.indentityId!);
      await prefs.setString('brear', model.data.token!);
      await prefs.setString('nameFace', model.data.name!);

      DashboardController dashboardController = Get.put(DashboardController());
      dashboardController.getData();
      if (model.succes) {
        showNotificationGreen(context, model.message);
      }else{
          showNotificationRed(context, model.message);
      }
      if (model.data.isAdmin == '1') {
        await prefs.setInt('is_login', 3);

        Get.to(DashboardPage(isAdmin: true));
      } else {
        if (model.data.faceId == null) {
          await prefs.setInt('is_login', 1);
          Get.to(DetecFace(isAbsen: 1));
          emailLoginController.value.clear();
          passLoginController.value.clear();
        } else {
          await prefs.setInt('is_login', 2);
          data[model.data.name] = List.from(json.decode(model.data.faceId!));
          print(data);
          jsonFile!.writeAsStringSync(json.encode(data));
          Get.to(DashboardPage(isAdmin: false));
          emailLoginController.value.clear();
          passLoginController.value.clear();
        }
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      emailLoginController.value.clear();
      passLoginController.value.clear();
    }
    isLoading.value = false;
  }

  Future handle(String text, dynamic e1) async {
    data![text] = e1;
    jsonFile!.writeAsStringSync(json.encode(data));
  }

  @override
  void onInit() {
    super.onInit();
    initilize();
  }

  Future initilize() async {
    tempDir = await getApplicationDocumentsDirectory();
    String _embPath = tempDir!.path + '/emb.json';
    jsonFile = File(_embPath);
    if (jsonFile!.existsSync()) {
      data = json.decode(jsonFile!.readAsStringSync());
    }
  }
}
