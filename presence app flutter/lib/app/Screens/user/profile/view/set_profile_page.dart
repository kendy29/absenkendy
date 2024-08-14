import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:kenface/app/models/api.dart';

import '../../../../utils/colors/colors.dart';
import '../controller/controller_set_profile.dart';
import '../widget/edit_password.dart';
import '../widget/edit_profile.dart';
import '../widget/settings_profile.dart';

class SetProfilePage extends GetView<SetProfileController> {
  const SetProfilePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(393, 852));
    return GetBuilder<SetProfileController>(
      init: SetProfileController(context: context),
      builder: (controller) {
        return Obx(
          () => Scaffold(
            backgroundColor: AssetsColor.colorBackground,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(222.0),
              child: AppBar(
                leading: controller.widgetProfile.value != 0
                    ? IconButton(
                        onPressed: () {
                          controller.widgetProfile.value = 0;
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                        ))
                    : const SizedBox(),
                flexibleSpace: Stack(alignment: Alignment.center, children: [
                  const Image(
                    image: AssetImage('assets/images/appbar2.jpg'),
                    fit: BoxFit.cover,
                  ),
                  Positioned.fill(
                    left: 0.w,
                    top: 37.h,
                    right: 0.w,
                    child: Column(
                      children: [
                        controller.image?.value == ""
                            ? Stack(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      controller.getFromGallery();
                                    },
                                    child: Icon(
                                      Icons.account_circle,
                                      size: 120.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Positioned(
                                      bottom: 0.h,
                                      right: 0.w,
                                      child: Icon(
                                        Icons.edit_outlined,
                                        size: 35,
                                        color: AssetsColor.colorBackground,
                                      ))
                                ],
                              )
                            : Stack(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      controller.getFromGallery();
                                    },
                                    child: CircleAvatar(
                                      maxRadius: 65,
                                      backgroundColor: Colors.white,
                                      child: ClipOval(
                                        child: Image.network(
                                          "${Api.urlImage}${controller.image?.value}",
                                          width: 120.w,
                                          height: 120.h,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      bottom: 0.h,
                                      right: 0.w,
                                      child: Icon(
                                        Icons.edit_outlined,
                                        size: 35,
                                        color: AssetsColor.colorBackground,
                                      ))
                                ],
                              ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          '${controller.dashboardController.nameFace}',
                          style: GoogleFonts.encodeSansSemiExpanded(
                              fontSize: 20,
                              color: HexColor('FCF8E8'),
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${controller.grade}',
                          style: GoogleFonts.encodeSansSemiExpanded(
                              fontSize: 16,
                              color: HexColor('FCF8E8'),
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ]),
                elevation: 0,
                backgroundColor: AssetsColor.colorBackground,
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 26.h,
                  ),
                  controller.widgetProfile.value == 0
                          ? const SettingsProfile()
                          : controller.widgetProfile.value == 1
                              ? const EditProfile()
                              : controller.widgetProfile.value == 2
                                  ? const EditPassword()
                                  : const SizedBox()
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
