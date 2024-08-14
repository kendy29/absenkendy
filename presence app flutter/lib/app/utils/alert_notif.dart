import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

void showNotification(BuildContext context, String message) {
 Get.snackbar(
    'Success',
    message.toString(),
    backgroundColor:Colors.white,
    snackPosition: SnackPosition.BOTTOM,
    colorText: Colors.white,
  );
}

void showNotificationGreen(BuildContext context, String message) {
  Get.snackbar(
    'Success',
    message.toString(),
    backgroundColor: HexColor('#05C270'),
    snackPosition: SnackPosition.BOTTOM,
    colorText: Colors.white,
  );
}

void showNotificationRed(BuildContext context, String message) {
  Get.snackbar(
    'Success',
    message.toString(),
    backgroundColor: HexColor('#F1416C'),
    snackPosition: SnackPosition.BOTTOM,
    colorText: Colors.white,
  );
}
