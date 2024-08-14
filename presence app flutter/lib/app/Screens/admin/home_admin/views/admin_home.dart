import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:kenface/app/Screens/admin/home_admin/views/add_user_page.dart';
import '../../../../models/api.dart';
import '../../../../utils/colors/colors.dart';
import '../../../user/profile/controller/controller_set_profile.dart';
import '../controller/admin_controller_home.dart';
import 'package:carousel_slider/carousel_slider.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SetProfileController profileController =
        Get.put(SetProfileController(context: context));
    ScreenUtil.init(context, designSize: const Size(393, 852));
    return GetBuilder<AdminHomeController>(
        init: AdminHomeController(context),
        builder: (controller) {
          return Obx(
            () => Scaffold(
              floatingActionButton: Padding(
                padding: EdgeInsets.only(bottom: 70.h),
                child: FloatingActionButton(
                  backgroundColor: AssetsColor.colorThrid,
                  child: const Icon(Icons.add, color: Colors.white),
                  onPressed: () {
                    Get.to(AddUserPage());
                  },
                ),
              ),
              body: SizedBox(
                width: 1.sw,
                height: 1.sh,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 165.h,
                            ),
                            controller.isLoadingBanner.value
                                ? SizedBox(
                                    width: 1.sw,
                                    height: 110.h,
                                    child: const Center(
                                      child: RefreshProgressIndicator(),
                                    ),
                                  )
                                : CarouselSlider(
                                    options: CarouselOptions(
                                      height: 120.h,
                                      autoPlay: true,
                                    ),
                                    items: controller.banner()),
                            SizedBox(
                              height: 30.h,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'User',
                                    style: GoogleFonts.encodeSansSemiExpanded(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  controller.isLoading.value
                                      ? const Center(
                                          child: RefreshProgressIndicator(),
                                        )
                                      : Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: controller.listUser!.value
                                              .map((element) => Padding(
                                                    padding: EdgeInsets.only(
                                                      bottom: 16.h,
                                                    ),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        ElevatedButton(
                                                          style: ButtonStyle(
                                                            shape: MaterialStateProperty
                                                                .all<
                                                                    RoundedRectangleBorder>(
                                                              RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0.r),
                                                              ),
                                                            ),
                                                            foregroundColor:
                                                                MaterialStateProperty
                                                                    .all<Color>(
                                                                        Colors
                                                                            .white),
                                                            backgroundColor:
                                                                MaterialStateProperty.all<
                                                                        Color>(
                                                                    AssetsColor
                                                                        .colorThrid),
                                                          ),
                                                          onPressed: () {
                                                            controller
                                                                .isLoadingSheetBottom
                                                                .value = false;
                                                            Get.bottomSheet(
                                                              Container(
                                                                height: 360.h,
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    border: Border.all(
                                                                        width: 10
                                                                            .w,
                                                                        color: AssetsColor
                                                                            .colorThrid),
                                                                    borderRadius: BorderRadius.only(
                                                                        topLeft:
                                                                            Radius.circular(10
                                                                                .r),
                                                                        topRight:
                                                                            Radius.circular(10.r))),
                                                                child: Padding(
                                                                    padding: EdgeInsets.only(
                                                                        top: 25
                                                                            .h,
                                                                        left: 20
                                                                            .w,
                                                                        right: 20
                                                                            .w),
                                                                    child: Obx(
                                                                      () => controller
                                                                              .isLoadingSheetBottom
                                                                              .value
                                                                          ? const Center(
                                                                              child: RefreshProgressIndicator(),
                                                                            )
                                                                          : Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Padding(
                                                                                  padding: EdgeInsets.only(left: 20.w),
                                                                                  child: Text(
                                                                                    element.name.toUpperCase(),
                                                                                    style: GoogleFonts.encodeSansSemiExpanded(
                                                                                      fontSize: 18.sp,
                                                                                      fontWeight: FontWeight.bold,
                                                                                      color: AssetsColor.colorThrid,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  height: 21.h,
                                                                                ),
                                                                                Row(
                                                                                  children: [
                                                                                    Expanded(
                                                                                        child: Container(
                                                                                      height: 57.h,
                                                                                      decoration: BoxDecoration(
                                                                                        borderRadius: BorderRadius.circular(10.r),
                                                                                        color: AssetsColor.colorThrid,
                                                                                      ),
                                                                                      child: Row(
                                                                                        children: [
                                                                                          SizedBox(
                                                                                            width: 8.w,
                                                                                          ),
                                                                                          Icon(
                                                                                            Icons.account_circle_outlined,
                                                                                            color: Colors.white,
                                                                                            size: 30.sp,
                                                                                          ),
                                                                                          SizedBox(
                                                                                            width: 8.w,
                                                                                          ),
                                                                                          Column(
                                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                                            children: [
                                                                                              Text('Absen Masuk',
                                                                                                  style: GoogleFonts.encodeSansSemiExpanded(
                                                                                                    fontSize: 16.sp,
                                                                                                    fontWeight: FontWeight.w500,
                                                                                                    color: Colors.white,
                                                                                                  )),
                                                                                              Text('${element.absenMasukCount}x Sebulan',
                                                                                                  style: GoogleFonts.encodeSansSemiExpanded(
                                                                                                    fontSize: 16.sp,
                                                                                                    fontWeight: FontWeight.w500,
                                                                                                    color: Colors.white,
                                                                                                  )),
                                                                                            ],
                                                                                          )
                                                                                        ],
                                                                                      ),
                                                                                    )),
                                                                                    SizedBox(
                                                                                      width: 16.w,
                                                                                    ),
                                                                                    Expanded(
                                                                                        child: Container(
                                                                                      height: 57.h,
                                                                                      decoration: BoxDecoration(
                                                                                        borderRadius: BorderRadius.circular(10.r),
                                                                                        color: AssetsColor.colorThrid,
                                                                                      ),
                                                                                      child: Row(
                                                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                                                        children: [
                                                                                          SizedBox(
                                                                                            width: 8.w,
                                                                                          ),
                                                                                          Icon(
                                                                                            Icons.account_circle_outlined,
                                                                                            color: Colors.white,
                                                                                            size: 30.sp,
                                                                                          ),
                                                                                          SizedBox(
                                                                                            width: 8.w,
                                                                                          ),
                                                                                          Column(
                                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                                            children: [
                                                                                              Text('Absen Keluar',
                                                                                                  style: GoogleFonts.encodeSansSemiExpanded(
                                                                                                    fontSize: 16.sp,
                                                                                                    fontWeight: FontWeight.w500,
                                                                                                    color: Colors.white,
                                                                                                  )),
                                                                                              Text('${element.absenKeluarCount}x Sebulan',
                                                                                                  style: GoogleFonts.encodeSansSemiExpanded(
                                                                                                    fontSize: 16.sp,
                                                                                                    fontWeight: FontWeight.w500,
                                                                                                    color: Colors.white,
                                                                                                  )),
                                                                                            ],
                                                                                          )
                                                                                        ],
                                                                                      ),
                                                                                    ))
                                                                                  ],
                                                                                ),
                                                                                SizedBox(
                                                                                  height: 14.h,
                                                                                ),
                                                                                Row(
                                                                                  children: [
                                                                                    Expanded(
                                                                                        child: Container(
                                                                                      height: 57.h,
                                                                                      decoration: BoxDecoration(
                                                                                        borderRadius: BorderRadius.circular(10.r),
                                                                                        color: AssetsColor.colorThrid,
                                                                                      ),
                                                                                      child: Row(
                                                                                        children: [
                                                                                          SizedBox(
                                                                                            width: 8.w,
                                                                                          ),
                                                                                          Icon(
                                                                                            Icons.account_circle_outlined,
                                                                                            color: Colors.white,
                                                                                            size: 30.sp,
                                                                                          ),
                                                                                          SizedBox(
                                                                                            width: 8.w,
                                                                                          ),
                                                                                          Column(
                                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                                            children: [
                                                                                              Text('Izin',
                                                                                                  style: GoogleFonts.encodeSansSemiExpanded(
                                                                                                    fontSize: 16.sp,
                                                                                                    fontWeight: FontWeight.w500,
                                                                                                    color: Colors.white,
                                                                                                  )),
                                                                                              Text('${element.permit}x Sebulan',
                                                                                                  style: GoogleFonts.encodeSansSemiExpanded(
                                                                                                    fontSize: 16.sp,
                                                                                                    fontWeight: FontWeight.w500,
                                                                                                    color: Colors.white,
                                                                                                  )),
                                                                                            ],
                                                                                          )
                                                                                        ],
                                                                                      ),
                                                                                    )),
                                                                                    SizedBox(
                                                                                      width: 16.w,
                                                                                    ),
                                                                                    Expanded(
                                                                                        child: Container(
                                                                                      height: 57.h,
                                                                                      decoration: BoxDecoration(
                                                                                        borderRadius: BorderRadius.circular(10.r),
                                                                                        color: AssetsColor.colorThrid,
                                                                                      ),
                                                                                      child: Row(
                                                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                                                        children: [
                                                                                          SizedBox(
                                                                                            width: 8.w,
                                                                                          ),
                                                                                          Icon(
                                                                                            Icons.account_circle_outlined,
                                                                                            color: Colors.white,
                                                                                            size: 30.sp,
                                                                                          ),
                                                                                          SizedBox(
                                                                                            width: 8.w,
                                                                                          ),
                                                                                          Column(
                                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                                            children: [
                                                                                              Text('Absen Cuti',
                                                                                                  style: GoogleFonts.encodeSansSemiExpanded(
                                                                                                    fontSize: 16.sp,
                                                                                                    fontWeight: FontWeight.w500,
                                                                                                    color: Colors.white,
                                                                                                  )),
                                                                                              Text('${element.leave}x Sebulan',
                                                                                                  style: GoogleFonts.encodeSansSemiExpanded(
                                                                                                    fontSize: 16.sp,
                                                                                                    fontWeight: FontWeight.w500,
                                                                                                    color: Colors.white,
                                                                                                  )),
                                                                                            ],
                                                                                          )
                                                                                        ],
                                                                                      ),
                                                                                    ))
                                                                                  ],
                                                                                ),
                                                                                SizedBox(
                                                                                  height: 14.h,
                                                                                ),
                                                                                Expanded(
                                                                                  child: Container(
                                                                                    height: 40.h,
                                                                                    decoration: BoxDecoration(
                                                                                      borderRadius: BorderRadius.circular(10.r),
                                                                                      color: AssetsColor.colorThrid,
                                                                                    ),
                                                                                    child: Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                      children: [
                                                                                        Row(
                                                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                                                          children: [
                                                                                            SizedBox(
                                                                                              width: 8.w,
                                                                                            ),
                                                                                            Icon(
                                                                                              Icons.share_location_sharp,
                                                                                              color: Colors.white,
                                                                                              size: 30.sp,
                                                                                            ),
                                                                                            SizedBox(
                                                                                              width: 8.w,
                                                                                            ),
                                                                                            Column(
                                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                                              children: [
                                                                                                Text('Latitude',
                                                                                                    style: GoogleFonts.encodeSansSemiExpanded(
                                                                                                      fontSize: 16.sp,
                                                                                                      fontWeight: FontWeight.w500,
                                                                                                      color: Colors.white,
                                                                                                    )),
                                                                                                Text('Longitude',
                                                                                                    style: GoogleFonts.encodeSansSemiExpanded(
                                                                                                      fontSize: 16.sp,
                                                                                                      fontWeight: FontWeight.w500,
                                                                                                      color: Colors.white,
                                                                                                    )),
                                                                                              ],
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                        Row(
                                                                                          children: [
                                                                                            element.longitude == null && element.latitude == null
                                                                                                ? Text('NULL',
                                                                                                    style: GoogleFonts.encodeSansSemiExpanded(
                                                                                                      fontSize: 16.sp,
                                                                                                      fontWeight: FontWeight.bold,
                                                                                                      color: Colors.white,
                                                                                                    ))
                                                                                                : ElevatedButton(
                                                                                                    style: ButtonStyle(
                                                                                                      foregroundColor: MaterialStateProperty.all<Color>(AssetsColor.colorThrid),
                                                                                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                                                                                    ),
                                                                                                    onPressed: () {
                                                                                                      controller.setNullFaceId('location', element.indentityId.toString());
                                                                                                    },
                                                                                                    child: Container(
                                                                                                      height: 30.h,
                                                                                                      decoration: BoxDecoration(
                                                                                                        color: Colors.white,
                                                                                                        borderRadius: BorderRadius.circular(
                                                                                                          10.r,
                                                                                                        ),
                                                                                                      ),
                                                                                                      child: Center(
                                                                                                        child: Text('Set NULL',
                                                                                                            style: GoogleFonts.encodeSansSemiExpanded(
                                                                                                              fontSize: 16.sp,
                                                                                                              fontWeight: FontWeight.bold,
                                                                                                              color: AssetsColor.colorThrid,
                                                                                                            )),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                            SizedBox(
                                                                                              width: 22.w,
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  height: 14.h,
                                                                                ),
                                                                                Expanded(
                                                                                  child: Container(
                                                                                    height: 40.h,
                                                                                    decoration: BoxDecoration(
                                                                                      borderRadius: BorderRadius.circular(10.r),
                                                                                      color: AssetsColor.colorThrid,
                                                                                    ),
                                                                                    child: Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                      children: [
                                                                                        Row(
                                                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                                                          children: [
                                                                                            SizedBox(
                                                                                              width: 8.w,
                                                                                            ),
                                                                                            Icon(
                                                                                              Icons.photo_camera_front_outlined,
                                                                                              color: Colors.white,
                                                                                              size: 30.sp,
                                                                                            ),
                                                                                            SizedBox(
                                                                                              width: 8.w,
                                                                                            ),
                                                                                            Column(
                                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                                              children: [
                                                                                                Text('Face ID',
                                                                                                    style: GoogleFonts.encodeSansSemiExpanded(
                                                                                                      fontSize: 16.sp,
                                                                                                      fontWeight: FontWeight.w500,
                                                                                                      color: Colors.white,
                                                                                                    )),
                                                                                              ],
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                        Row(
                                                                                          children: [
                                                                                            element.faceId == null
                                                                                                ? Text('NULL',
                                                                                                    style: GoogleFonts.encodeSansSemiExpanded(
                                                                                                      fontSize: 16.sp,
                                                                                                      fontWeight: FontWeight.bold,
                                                                                                      color: Colors.white,
                                                                                                    ))
                                                                                                : ElevatedButton(
                                                                                                    style: ButtonStyle(
                                                                                                      foregroundColor: MaterialStateProperty.all<Color>(AssetsColor.colorThrid),
                                                                                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                                                                                    ),
                                                                                                    onPressed: () {
                                                                                                      controller.setNullFaceId('faceId', element.indentityId.toString());
                                                                                                    },
                                                                                                    child: Container(
                                                                                                      height: 30.h,
                                                                                                      decoration: BoxDecoration(
                                                                                                        color: Colors.white,
                                                                                                        borderRadius: BorderRadius.circular(
                                                                                                          10.r,
                                                                                                        ),
                                                                                                      ),
                                                                                                      child: Center(
                                                                                                        child: Text('Set NULL',
                                                                                                            style: GoogleFonts.encodeSansSemiExpanded(
                                                                                                              fontSize: 16.sp,
                                                                                                              fontWeight: FontWeight.bold,
                                                                                                              color: AssetsColor.colorThrid,
                                                                                                            )),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                            SizedBox(
                                                                                              width: 22.w,
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  height: 14.h,
                                                                                ),
                                                                              ],
                                                                            ),
                                                                    )),
                                                              ),
                                                            );
                                                          },
                                                          child: Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 9.h,
                                                                    bottom:
                                                                        9.h),
                                                            width: 200.w,
                                                            height: 65.h,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: AssetsColor
                                                                  .colorThrid,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                3.r,
                                                              ),
                                                            ),
                                                            child: Row(
                                                              children: [
                                                                element.image ==
                                                                        null
                                                                    ? Icon(
                                                                        Icons
                                                                            .account_circle_outlined,
                                                                        size: 45
                                                                            .sp,
                                                                        color: Colors
                                                                            .white,
                                                                      )
                                                                    : CircleAvatar(
                                                                        maxRadius:
                                                                            20,
                                                                        backgroundColor:
                                                                            Colors.white,
                                                                        child:
                                                                            ClipOval(
                                                                          child:
                                                                              Image.network(
                                                                            "${Api.urlImage}${element.image}",
                                                                            width:
                                                                                45.w,
                                                                            height:
                                                                                45.h,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                SizedBox(
                                                                  width: 16.w,
                                                                ),
                                                                Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      element
                                                                          .name,
                                                                      style: GoogleFonts.encodeSansSemiExpanded(
                                                                          fontSize: 18
                                                                              .sp,
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          color:
                                                                              Colors.white),
                                                                    ),
                                                                    Text(
                                                                      element.email.length <=
                                                                              16
                                                                          ? element
                                                                              .email
                                                                          : element.email.substring(
                                                                              0,
                                                                              17),
                                                                      style: GoogleFonts.encodeSansSemiExpanded(
                                                                          fontSize: 14
                                                                              .sp,
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          color:
                                                                              Colors.white),
                                                                    ),
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            ElevatedButton(
                                                              style:
                                                                  ButtonStyle(tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                                minimumSize:
                                                                    MaterialStateProperty.all<
                                                                            Size>(
                                                                        Size.zero),
                                                                padding: MaterialStateProperty.all<
                                                                        EdgeInsets>(
                                                                    EdgeInsets
                                                                        .zero),
                                                                elevation:
                                                                    MaterialStateProperty
                                                                        .all<double>(
                                                                            0),
                                                                foregroundColor:
                                                                    MaterialStateProperty.all<
                                                                            Color>(
                                                                        Colors
                                                                            .white),
                                                                backgroundColor:
                                                                    MaterialStateProperty.all<
                                                                            Color>(
                                                                        Colors
                                                                            .transparent),
                                                              ),
                                                              onPressed: () {
                                                                controller
                                                                        .institudeController
                                                                        .value
                                                                        .text =
                                                                    element
                                                                        .agencyName;
                                                                controller
                                                                        .gradeController
                                                                        .value
                                                                        .text =
                                                                    element
                                                                        .grade;
                                                                Get.bottomSheet(
                                                                  Container(
                                                                    height:
                                                                        300.h,
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        border: Border.all(
                                                                            width: 10
                                                                                .w,
                                                                            color: AssetsColor
                                                                                .colorThrid),
                                                                        borderRadius: BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(10.r),
                                                                            topRight: Radius.circular(10.r))),
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsets.only(
                                                                          top: 25
                                                                              .h,
                                                                          left: 20
                                                                              .w,
                                                                          right:
                                                                              20.w),
                                                                      child:
                                                                          Obx(
                                                                        () => controller.isLoadingSheetBottom.value
                                                                            ? const Center(
                                                                                child: RefreshProgressIndicator(),
                                                                              )
                                                                            : Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Padding(
                                                                                    padding: EdgeInsets.only(left: 20.w),
                                                                                    child: Text(
                                                                                      'Edit',
                                                                                      style: GoogleFonts.encodeSansSemiExpanded(
                                                                                        fontSize: 18.sp,
                                                                                        fontWeight: FontWeight.bold,
                                                                                        color: AssetsColor.colorThrid,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: 17.h,
                                                                                  ),
                                                                                  TextFormField(
                                                                                    controller: controller.institudeController.value,
                                                                                    validator: (v) {
                                                                                      if (v!.isEmpty) {
                                                                                        return 'Instansi Harus Di isi';
                                                                                      }
                                                                                      return null;
                                                                                    },
                                                                                    decoration: InputDecoration(
                                                                                        prefixIcon: Icon(
                                                                                          Icons.apartment_outlined,
                                                                                          color: AssetsColor.colorThrid,
                                                                                          size: 35.sp,
                                                                                        ),
                                                                                        contentPadding: EdgeInsets.only(
                                                                                          top: 0.h,
                                                                                          bottom: 0.h,
                                                                                        ),
                                                                                        border: OutlineInputBorder(
                                                                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(25.r), bottomRight: Radius.circular(30.r), topRight: Radius.circular(0.r), bottomLeft: Radius.circular(0.r)),
                                                                                          borderSide: BorderSide(color: AssetsColor.colorThrid, width: 2.6.sp),
                                                                                        ),
                                                                                        enabledBorder: OutlineInputBorder(
                                                                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(25.r), bottomRight: Radius.circular(30.r), topRight: Radius.circular(0.r), bottomLeft: Radius.circular(0.r)),
                                                                                          borderSide: BorderSide(color: AssetsColor.colorThrid, width: 2.6.sp),
                                                                                        ),
                                                                                        focusedBorder: OutlineInputBorder(
                                                                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(25.r), bottomRight: Radius.circular(30.r), topRight: Radius.circular(0.r), bottomLeft: Radius.circular(0.r)),
                                                                                          borderSide: BorderSide(color: AssetsColor.colorThrid, width: 2.6.sp),
                                                                                        ),
                                                                                        hintText: "Edit Instansi",
                                                                                        hintStyle: GoogleFonts.encodeSansSemiExpanded(color: HexColor('1E1E1E').withOpacity(0.5))),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: 18.h,
                                                                                  ),
                                                                                  TextFormField(
                                                                                    controller: controller.gradeController.value,
                                                                                    validator: (v) {
                                                                                      if (v!.isEmpty) {
                                                                                        return 'Title Pekerjaan Harus Di isi';
                                                                                      }
                                                                                      return null;
                                                                                    },
                                                                                    decoration: InputDecoration(
                                                                                        prefixIcon: Icon(
                                                                                          Icons.badge_outlined,
                                                                                          color: AssetsColor.colorThrid,
                                                                                          size: 35.sp,
                                                                                        ),
                                                                                        contentPadding: EdgeInsets.only(top: 0.h, bottom: 0.h),
                                                                                        border: OutlineInputBorder(
                                                                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(25.r), bottomRight: Radius.circular(30.r), topRight: Radius.circular(0.r), bottomLeft: Radius.circular(0.r)),
                                                                                          borderSide: BorderSide(color: AssetsColor.colorThrid, width: 2.6.sp),
                                                                                        ),
                                                                                        enabledBorder: OutlineInputBorder(
                                                                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(25.r), bottomRight: Radius.circular(30.r), topRight: Radius.circular(0.r), bottomLeft: Radius.circular(0.r)),
                                                                                          borderSide: BorderSide(color: AssetsColor.colorThrid, width: 2.6.sp),
                                                                                        ),
                                                                                        focusedBorder: OutlineInputBorder(
                                                                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(25.r), bottomRight: Radius.circular(30.r), topRight: Radius.circular(0.r), bottomLeft: Radius.circular(0.r)),
                                                                                          borderSide: BorderSide(color: AssetsColor.colorThrid, width: 2.6.sp),
                                                                                        ),
                                                                                        hintText: "Edit Title Pekerjaan",
                                                                                        hintStyle: GoogleFonts.encodeSansSemiExpanded(color: HexColor('1E1E1E').withOpacity(0.5))),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: 18.h,
                                                                                  ),
                                                                                  ElevatedButton(
                                                                                    style: ButtonStyle(
                                                                                      padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
                                                                                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                                                                      backgroundColor: MaterialStateProperty.all<Color>(
                                                                                        AssetsColor.colorPrimary,
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
                                                                                      controller.updateProfile(context, element.indentityId.toString());
                                                                                    },
                                                                                    child: Container(
                                                                                      width: 1.sw,
                                                                                      height: 45.h,
                                                                                      padding: EdgeInsets.zero,
                                                                                      decoration: BoxDecoration(
                                                                                        color: AssetsColor.colorPrimary,
                                                                                        borderRadius: BorderRadius.only(
                                                                                          topLeft: Radius.circular(25.r),
                                                                                          topRight: Radius.circular(0.r),
                                                                                          bottomRight: Radius.circular(30.r),
                                                                                          bottomLeft: Radius.circular(0.r),
                                                                                        ),
                                                                                      ),
                                                                                      child: Padding(
                                                                                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                                                                                        child: Center(child: SvgPicture.asset('assets/images/send.svg')),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                              child: SvgPicture
                                                                  .asset(
                                                                      'assets/images/editadmin.svg'),
                                                            ),
                                                            ElevatedButton(
                                                              style:
                                                                  ButtonStyle(tapTargetSize:MaterialTapTargetSize.shrinkWrap ,
                                                                minimumSize:
                                                                    MaterialStateProperty.all<
                                                                            Size>(
                                                                        Size.zero),
                                                                padding: MaterialStateProperty.all<
                                                                        EdgeInsets>(
                                                                    EdgeInsets
                                                                        .zero),
                                                                elevation:
                                                                    MaterialStateProperty
                                                                        .all<double>(
                                                                            0),
                                                                foregroundColor:
                                                                    MaterialStateProperty.all<
                                                                            Color>(
                                                                        Colors
                                                                            .white),
                                                                backgroundColor:
                                                                    MaterialStateProperty.all<
                                                                            Color>(
                                                                        Colors
                                                                            .transparent),
                                                              ),
                                                              onPressed: () {
                                                                Get.bottomSheet(
                                                                  Container(
                                                                    height:
                                                                        200.h,
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        border: Border.all(
                                                                            width: 10
                                                                                .w,
                                                                            color: AssetsColor
                                                                                .colorThrid),
                                                                        borderRadius: BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(30.h),
                                                                            topRight: Radius.circular(30.h))),
                                                                    child: Obx(
                                                                      () => controller
                                                                              .isLoadingSheetBottom
                                                                              .value
                                                                          ? const Center(
                                                                              child: RefreshProgressIndicator(),
                                                                            )
                                                                          : Padding(
                                                                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                                                                              child: Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  ElevatedButton(
                                                                                    style: ButtonStyle(
                                                                                      minimumSize: MaterialStateProperty.all<Size>(Size.zero),
                                                                                      padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
                                                                                      elevation: MaterialStateProperty.all<double>(0),
                                                                                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                                                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
                                                                                    ),
                                                                                    onPressed: () {
                                                                                      Get.back();
                                                                                    },
                                                                                    child: Icon(
                                                                                      Icons.keyboard_return,
                                                                                      size: 35.sp,
                                                                                      color: AssetsColor.colorThrid,
                                                                                    ),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: 300.w,
                                                                                    child: Text(
                                                                                      'APAKAH KAMU YAKIN INGIN MENGHAPUS Akun ini?',
                                                                                      style: GoogleFonts.encodeSansSemiExpanded(fontSize: 18.sp, fontWeight: FontWeight.bold, color: AssetsColor.colorThrid),
                                                                                      textAlign: TextAlign.center,
                                                                                    ),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: 18.h,
                                                                                  ),
                                                                                  ElevatedButton(
                                                                                    style: ButtonStyle(
                                                                                      padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
                                                                                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                                                                      backgroundColor: MaterialStateProperty.all<Color>(
                                                                                        AssetsColor.colorPrimary,
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
                                                                                      controller.deleteAccount(element.indentityId.toString());
                                                                                    },
                                                                                    child: Container(
                                                                                      width: 1.sw,
                                                                                      height: 45.h,
                                                                                      padding: EdgeInsets.zero,
                                                                                      decoration: BoxDecoration(
                                                                                        color: AssetsColor.colorPrimary,
                                                                                        borderRadius: BorderRadius.only(
                                                                                          topLeft: Radius.circular(25.r),
                                                                                          topRight: Radius.circular(0.r),
                                                                                          bottomRight: Radius.circular(30.r),
                                                                                          bottomLeft: Radius.circular(0.r),
                                                                                        ),
                                                                                      ),
                                                                                      child: Padding(
                                                                                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                                                                                        child: Center(child: SvgPicture.asset('assets/images/deleteAccount.svg')),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                              child: SizedBox(
                                                                width: 30.w,
                                                                height: 30.h,
                                                                child:
                                                                    SvgPicture
                                                                        .asset(
                                                                  'assets/images/deleteadmin.svg',
                                                                  width: 30.w,
                                                                  height: 30.h,
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ))
                                              .toList(),
                                        )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 150.h,
                            )
                          ],
                        ),
                      ),
                    ),
                    Image.asset(
                      'assets/images/appbar1.png',
                      width: 1.sw,
                      height: 170.h,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      top: 42.h,
                      left: 20.w,
                      child: Row(
                        children: [
                          profileController.image?.value == ""
                              ? Icon(
                                  Icons.account_circle,
                                  size: 50.sp,
                                  color: Colors.white,
                                )
                              : CircleAvatar(
                                  maxRadius: 23,
                                  backgroundColor: Colors.white,
                                  child: ClipOval(
                                    child: Image.network(
                                      "${Api.urlImage}${profileController.image!.value}",
                                      width: 45.w,
                                      height: 45.h,
                                    ),
                                  ),
                                ),
                          SizedBox(
                            width: 18.w,
                          ),
                          Text(
                            ' ${controller.dashboardController.nameFace}',
                            style: GoogleFonts.encodeSansSemiExpanded(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
