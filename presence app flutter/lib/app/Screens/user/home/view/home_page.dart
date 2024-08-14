import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kenface/app/utils/alert_notif.dart';
import '../../../../models/api.dart';
import '../../../../utils/colors/colors.dart';
import '../../../../utils/date.dart';
import '../../faceRecognition/views/Detec_face.dart';
import '../../profile/controller/controller_set_profile.dart';
import '../controller/controller_home.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SetProfileController profileController =
        Get.put(SetProfileController(context: context));
    ScreenUtil.init(context, designSize: const Size(393, 852));
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        return Obx(
          () => Scaffold(
            backgroundColor: AssetsColor.colorBackground,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(134.0),
              child: AppBar(
                leading: profileController.image!.value == ""
                    ? Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Icon(
                          Icons.account_circle,
                          size: 50.sp,
                          color: Colors.white,
                        ))
                    : Padding(
                        padding: EdgeInsets.only(left: 20.w),
                        child: CircleAvatar(
                          maxRadius: 60,
                          backgroundColor: Colors.white,
                          child: ClipOval(
                            child: Image.network(
                              "${Api.urlImage}${profileController.image?.value}",
                              width: 50.w,
                              height: 50.h,
                            ),
                          ),
                        ),
                      ),
                title: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Text(
                    ' ${controller.dashboardController.nameFace}',
                    style: GoogleFonts.encodeSansSemiExpanded(
                        fontSize: 18.sp, fontWeight: FontWeight.bold),
                  ),
                ),
                flexibleSpace: const Image(
                  image: AssetImage('assets/images/appbar1.png'),
                  fit: BoxFit.cover,
                ),
                elevation: 0,
                backgroundColor: AssetsColor.colorBackground,
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.only(left: 27.w, bottom: 27.h, top: 27.h),
                      width: 1.sw,
                      height: 125.h,
                      decoration: BoxDecoration(
                        color: AssetsColor.colorThrid.withOpacity(0.7),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(88.r),
                          topRight: Radius.circular(4.r),
                          bottomRight: Radius.circular(60.r),
                          bottomLeft: Radius.circular(4.r),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 65.h,
                            width: 65.w,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AssetsColor.colorBackground),
                            child: Center(
                              child: SvgPicture.asset(
                                'assets/images/office.svg',
                                width: 35.w,
                                height: 35.h,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${controller.dayName}, ${DateTime.now().day} ${months[DateTime.now().month - 1]} ${DateTime.now().year}',
                                style: GoogleFonts.encodeSansSemiExpanded(
                                    fontSize: 14,
                                    color: AssetsColor.colorBackground,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                width: 221.w,
                                child: Text(
                                  'NIP : ${controller.dashboardController.identityId}',
                                  style: GoogleFonts.encodeSansSemiExpanded(
                                      fontSize: 14,
                                      color: AssetsColor.colorBackground,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              SizedBox(
                                width: 229.w,
                                child: Text(
                                  'Instansi : ' +
                                      (profileController
                                                  .agencyName.value.length >=
                                              17
                                          ? profileController.agencyName.value
                                              .substring(0, 17)
                                          : profileController.agencyName.value),
                                  style: GoogleFonts.encodeSansSemiExpanded(
                                      fontSize: 14,
                                      color: AssetsColor.colorBackground,
                                      fontWeight: FontWeight.w400),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 26.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 100.w,
                          height: 40.h,
                          decoration: BoxDecoration(
                            color: AssetsColor.colorThrid.withOpacity(0.7),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25.r),
                              topRight: Radius.circular(0.r),
                              bottomRight: Radius.circular(30.r),
                              bottomLeft: Radius.circular(0.r),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Masuk',
                                style: GoogleFonts.encodeSansSemiExpanded(
                                    fontSize: 12,
                                    color: AssetsColor.colorBackground,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                profileController.opened.value.toString(),
                                style: GoogleFonts.encodeSansSemiExpanded(
                                    fontSize: 12,
                                    color: AssetsColor.colorBackground,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 100.w,
                          height: 40.h,
                          decoration: BoxDecoration(
                            color: AssetsColor.colorThrid.withOpacity(0.7),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25.r),
                              topRight: Radius.circular(0.r),
                              bottomRight: Radius.circular(30.r),
                              bottomLeft: Radius.circular(0.r),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Izin',
                                style: GoogleFonts.encodeSansSemiExpanded(
                                    fontSize: 12,
                                    color: AssetsColor.colorBackground,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                profileController.premited!.value.toString(),
                                style: GoogleFonts.encodeSansSemiExpanded(
                                    fontSize: 12,
                                    color: AssetsColor.colorBackground,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 100.w,
                          height: 40.h,
                          decoration: BoxDecoration(
                            color: AssetsColor.colorThrid.withOpacity(0.7),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25.r),
                              topRight: Radius.circular(0.r),
                              bottomRight: Radius.circular(30.r),
                              bottomLeft: Radius.circular(0.r),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Cuti',
                                style: GoogleFonts.encodeSansSemiExpanded(
                                    fontSize: 12,
                                    color: AssetsColor.colorBackground,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                profileController.leave.value.toString(),
                                style: GoogleFonts.encodeSansSemiExpanded(
                                    fontSize: 12,
                                    color: AssetsColor.colorBackground,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 26.h,
                    ),
                    Text(
                      'Menu',
                      style: GoogleFonts.encodeSansSemiExpanded(
                          fontSize: 16.sp, fontWeight: FontWeight.w800),
                    ),
                    SizedBox(
                      height: 26.h,
                    ),
                    profileController.isLoadingProfile.value
                        ? SizedBox(
                            width: 1.sw,
                            height: 95.h,
                            child: const Center(
                              child: RefreshProgressIndicator(),
                            ))
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  ElevatedButton(
                                      style: ButtonStyle(
                                        foregroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.white),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                AssetsColor.colorPrimary),
                                        shape: MaterialStateProperty.all(
                                            const CircleBorder()),
                                      ),
                                      onPressed: () {
                                        print(profileController.dateNow.value);
                                        print(profileController
                                                .dateNotAbsen.value);
                                        if (profileController.dateNow.value ==
                                            profileController
                                                .dateNotAbsen.value) {
                                          showNotificationRed(
                                              context, 'Silakan Absen Besok');
                                        } else {
                                          controller.getLocation(
                                              double.tryParse(profileController
                                                      .latitude.value) ??
                                                  0,
                                              double.tryParse(profileController
                                                      .longitude.value) ??
                                                  0);
                                        }
                                      },
                                      child: SizedBox(
                                        width: 65.w,
                                        height: 65.h,
                                        child: Center(
                                          child: SvgPicture.asset(
                                              'assets/images/absen.svg'),
                                        ),
                                      )),
                                  SizedBox(
                                    height: 8.w,
                                  ),
                                  Text(
                                    'Absen',
                                    style: GoogleFonts.encodeSansSemiExpanded(
                                        color: Colors.black,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  ElevatedButton(
                                      style: ButtonStyle(
                                        foregroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.white),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                AssetsColor.colorPrimary),
                                        shape: MaterialStateProperty.all(
                                            const CircleBorder()),
                                      ),
                                      onPressed: () {
                                        if (profileController.dateNow.value ==
                                            profileController
                                                .dateNotAbsen.value) {
                                          showNotificationRed(
                                              context, 'Silakan Absen Besok');
                                        } else {
                                          Get.to(DetecFace(isAbsen: 3));
                                        }
                                      },
                                      child: SizedBox(
                                        width: 65.w,
                                        height: 65.h,
                                        child: Center(
                                          child: SvgPicture.asset(
                                              'assets/images/sakit.svg'),
                                        ),
                                      )),
                                  SizedBox(
                                    height: 8.w,
                                  ),
                                  Text(
                                    'Sakit',
                                    style: GoogleFonts.encodeSansSemiExpanded(
                                        color: Colors.black,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  ElevatedButton(
                                      style: ButtonStyle(
                                        foregroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.white),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                AssetsColor.colorPrimary),
                                        shape: MaterialStateProperty.all(
                                            const CircleBorder()),
                                      ),
                                      onPressed: () {
                                        if (profileController.dateNow.value ==
                                            profileController
                                                .dateNotAbsen.value) {
                                          showNotificationRed(
                                              context, 'Silakan Absen Besok');
                                        } else {
                                          Get.to(DetecFace(isAbsen: 4));
                                        }
                                      },
                                      child: SizedBox(
                                        width: 65.w,
                                        height: 65.h,
                                        child: Center(
                                          child: SvgPicture.asset(
                                              'assets/images/cuti.svg'),
                                        ),
                                      )),
                                  SizedBox(
                                    height: 8.w,
                                  ),
                                  Text(
                                    'Cuti',
                                    style: GoogleFonts.encodeSansSemiExpanded(
                                        color: Colors.black,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ],
                          ),
                    SizedBox(
                      height: 26.h,
                    ),
                    // Text(
                    //   'Informasi',
                    //   style: GoogleFonts.encodeSansSemiExpanded(
                    //       fontSize: 16.sp, fontWeight: FontWeight.w800),
                    // ),
                    // SizedBox(
                    //   height: 13.h,
                    // ),
                    // ListView.builder(
                    //     padding: EdgeInsets.zero,
                    //     shrinkWrap: true,
                    //     physics: const NeverScrollableScrollPhysics(),
                    //     itemCount: 2,
                    //     itemBuilder: (context, index) {
                    //       return ListTile(
                    //         minLeadingWidth: 60.w,
                    //         contentPadding: EdgeInsets.zero,
                    //         leading: SvgPicture.asset(
                    //           'assets/images/clean.svg',
                    //         ),
                    //         title: Text(
                    //           'Jumat, 31 Maret 2023',
                    //           style: GoogleFonts.encodeSansSemiExpanded(
                    //               fontSize: 14.sp, fontWeight: FontWeight.w400),
                    //         ),
                    //         subtitle: Text(
                    //           'Kegiatas Kebersian Bulanan',
                    //           style: GoogleFonts.encodeSansSemiExpanded(
                    //               fontSize: 14.sp, fontWeight: FontWeight.w400),
                    //         ),
                    //       );
                    //     })
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
