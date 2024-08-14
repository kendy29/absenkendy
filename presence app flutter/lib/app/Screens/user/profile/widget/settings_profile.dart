import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../utils/colors/colors.dart';
import '../controller/controller_set_profile.dart';

class SettingsProfile extends StatelessWidget {
  const SettingsProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SetProfileController controller =
        Get.put(SetProfileController(context: context));
    ScreenUtil.init(context, designSize: const Size(393, 852));
    return Obx(() => controller.isLoadingIUpload.value == true
        ? Center(
            child: RefreshProgressIndicator(),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pengaturan',
                style: GoogleFonts.encodeSansSemiExpanded(
                    fontSize: 16.sp, fontWeight: FontWeight.w800),
              ),
              SizedBox(
                height: 24.h,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  padding:
                      MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor: MaterialStateProperty.all<Color>(
                    AssetsColor.colorThrid,
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25.r),
                        topRight: Radius.circular(0.r),
                        bottomRight: Radius.circular(30.r),
                        bottomLeft: Radius.circular(0.r),
                      ),
                    ),
                  ),
                ),
                onPressed: () {
                  controller.widgetProfile.value = 1;
                },
                child: Container(
                  width: 1.sw,
                  height: 55.h,
                  padding: EdgeInsets.zero,
                  decoration: BoxDecoration(
                    color: AssetsColor.colorThrid,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.r),
                      topRight: Radius.circular(0.r),
                      bottomRight: Radius.circular(30.r),
                      bottomLeft: Radius.circular(0.r),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.supervised_user_circle_outlined,
                              color: Colors.white,
                              size: 35.sp,
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              'Edit Profile',
                              style: GoogleFonts.encodeSansSemiExpanded(
                                  color: AssetsColor.colorBackground,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SvgPicture.asset('assets/images/arrowright.svg'),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 18.h,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  padding:
                      MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor: MaterialStateProperty.all<Color>(
                    AssetsColor.colorThrid,
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25.r),
                        topRight: Radius.circular(0.r),
                        bottomRight: Radius.circular(30.r),
                        bottomLeft: Radius.circular(0.r),
                      ),
                    ),
                  ),
                ),
                onPressed: () {
                  controller.widgetProfile.value = 2;
                },
                child: Container(
                  width: 1.sw,
                  height: 55.h,
                  padding: EdgeInsets.zero,
                  decoration: BoxDecoration(
                    color: AssetsColor.colorThrid,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.r),
                      topRight: Radius.circular(0.r),
                      bottomRight: Radius.circular(30.r),
                      bottomLeft: Radius.circular(0.r),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset('assets/images/password.svg'),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              'Update Passowrd',
                              style: GoogleFonts.encodeSansSemiExpanded(
                                  color: AssetsColor.colorBackground,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SvgPicture.asset('assets/images/arrowright.svg'),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 18.h,
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.zero,
                      ),
                      foregroundColor: MaterialStateProperty.all<Color>(
                        AssetsColor.colorBackground,
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        AssetsColor.colorThrid,
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25.r),
                          topRight: Radius.circular(0.r),
                          bottomRight: Radius.circular(30.r),
                          bottomLeft: Radius.circular(0.r),
                        ),
                      ))),
                  onPressed: () {
                    controller.logout();
                  },
                  child: Container(
                    width: 1.sw,
                    height: 55.h,
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                      color: AssetsColor.colorThrid,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25.r),
                        topRight: Radius.circular(0.r),
                        bottomRight: Radius.circular(30.r),
                        bottomLeft: Radius.circular(0.r),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset('assets/images/logout.svg'),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                'Logout',
                                style: GoogleFonts.encodeSansSemiExpanded(
                                    color: AssetsColor.colorBackground,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SvgPicture.asset('assets/images/arrowright.svg'),
                        ],
                      ),
                    ),
                  )),
            ],
          ));
  }
}
