import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:get/get.dart';

import '../../../utils/colors/colors.dart';
import '../../user/home/view/home_page.dart';
import '../controller/controller_dashboard.dart';

class DashboardPage extends GetView<DashboardController> {
  DashboardPage({Key? key, required this.isAdmin}) : super(key: key);
  bool isAdmin;
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(393, 852));
    return GetBuilder<DashboardController>(
      init: DashboardController(),
      builder: (controller) {
        return Obx(
          () => Scaffold(
            extendBody: true,
            body: isAdmin
                ? controller
                    .adminDashboard[controller.selectedItemPosition.value]
                : controller
                    .userDashboard[controller.selectedItemPosition.value],
            bottomNavigationBar: Container(
              decoration:
                      controller.userDashboard[0] != const HomePage()
                  ? const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/navbar1.png'),
                          fit: BoxFit.fill),
                    )
                  : const BoxDecoration(),
              child: SnakeNavigationBar.color(
                // height: 80,
                height: 50,
                behaviour: controller.snakeBarStyle,
                snakeShape: controller.snakeShape.value,
                shape: controller.bottomBarShape,
                padding: controller.padding,
                backgroundColor: AssetsColor.colorThrid,

                ///configuration for SnakeNavigationBar.color
                snakeViewColor: controller.selectedColor,
                selectedItemColor:
                    controller.snakeShape.value == SnakeShape.indicator
                        ? controller.selectedColor
                        : null,
                unselectedItemColor:
                    controller.snakeShape.value != SnakeShape.indicator
                        ? controller.selectedColor
                        : controller.unselectedColor,

                showUnselectedLabels: controller.showUnselectedLabels.value,
                showSelectedLabels: controller.showSelectedLabels.value,

                selectedLabelStyle: const TextStyle(fontSize: 14),
                unselectedLabelStyle: const TextStyle(fontSize: 10),
                currentIndex: controller.selectedItemPosition.value,
                onTap: (index) => controller.setSelectedItemPosition(index),
                items: [
                  BottomNavigationBarItem(
                      activeIcon: Icon(Icons.house_outlined,
                          color: AssetsColor.colorThrid),
                      icon: Icon(Icons.house_outlined,
                          color: AssetsColor.colorBackground),
                      label: 'Home'),
                  BottomNavigationBarItem(
                      activeIcon: Icon(Icons.update_outlined,
                          color: AssetsColor.colorThrid),
                      icon: Icon(Icons.update_outlined,
                          color: AssetsColor.colorBackground),
                      label: 'History'),
                  BottomNavigationBarItem(
                      activeIcon: Icon(Icons.account_circle_outlined,
                          color: AssetsColor.colorThrid),
                      icon: Icon(Icons.account_circle_outlined,
                          color: AssetsColor.colorBackground),
                      label: 'Profile')
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
