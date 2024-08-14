
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/Screens/user/auth_screen/views/login_page.dart';
import 'app/Screens/dashboard/views/dashboard_view.dart';
import 'app/Screens/user/faceRecognition/views/Detec_face.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(GetMaterialApp(
    themeMode: ThemeMode.light,
    theme: ThemeData(brightness: Brightness.light),
    home: prefs.getInt('is_login') == 2
        ?  DashboardPage(isAdmin: false,)
        :prefs.getInt('is_login') == 3
        ?  DashboardPage(isAdmin: true)
        : prefs.getInt('is_login') == 1
            ?  DetecFace(isAbsen: 1)
            : LoginPage(),
    title: "HRIS",
    debugShowCheckedModeBanner: false,
  ));
}
