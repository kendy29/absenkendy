import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/colors/colors.dart';
import '../../admin/history_admin/view/history_admin_page.dart';
import '../../admin/home_admin/views/add_user_page.dart';
import '../../admin/home_admin/views/admin_home.dart';
import '../../user/history/view/history_page.dart';
import '../../user/home/view/home_page.dart';
import '../../user/profile/controller/controller_set_profile.dart';
import '../../user/profile/view/set_profile_page.dart';

class DashboardController extends GetxController {
  List<Widget> userDashboard = [
    const Center(
      child: HomePage(),
    ),
    const Center(
      child: HistoryPage(),
    ),
    const Center(
      child: SetProfilePage(),
    )
  ];
  List<Widget> adminDashboard = [
     const Center(
      child: AdminHomePage(),
    ),
    const Center(
      child: HistoryAdminPage(),
    ),
    const Center(
      child: SetProfilePage(),
    )
  ];
  RxInt selectedItemPosition = 0.obs;
  RxString brear = "".obs;
  RxString identityId = "".obs;
  RxString nameFace = "".obs;
  ShapeBorder? bottomBarShape = const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(25)),
  );
  SnakeBarBehaviour snakeBarStyle = SnakeBarBehaviour.floating;
  EdgeInsets padding = const EdgeInsets.all(20);

  Rx<SnakeShape> snakeShape = SnakeShape.circle.obs;

  RxBool showSelectedLabels = false.obs;
  RxBool showUnselectedLabels = false.obs;

  Color selectedColor = AssetsColor.colorBackground;
  Color unselectedColor = AssetsColor.colorBackground;

  Gradient selectedGradient =
      const LinearGradient(colors: [Colors.red, Colors.amber]);
  Gradient unselectedGradient =
      const LinearGradient(colors: [Colors.red, Colors.blueGrey]);

  setSelectedItemPosition(int value) {
    selectedItemPosition.value = value;
  }

  @override
  void dispose() {
    DashboardController().dispose();
    Get.delete<DashboardController>();
    super.dispose();
  }

  Future getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    brear.value = prefs.getString('brear') ?? "";
    identityId.value = prefs.getInt('identity_id').toString();
    nameFace.value = prefs.getString('nameFace') ?? "";
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getData();
  }
}
