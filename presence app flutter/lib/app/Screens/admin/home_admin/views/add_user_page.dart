import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:kenface/app/utils/colors/colors.dart';

import '../controller/admin_controller_home.dart';

class AddUserPage extends StatelessWidget {
  AddUserPage({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(393, 852));
    return GetBuilder<AdminHomeController>(
        init: AdminHomeController(context),
        builder: (controller) {
          return Obx(() => Scaffold(
                backgroundColor: AssetsColor.colorPrimary,
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(100.0.h),
                  child: Container(
                    height: 100.h,
                    color: AssetsColor.colorPrimary,
                    child: Padding(
                      padding: EdgeInsets.only(top: 42.h, left: 20.w),
                      child: Text(
                        'Tambahkan Akun',
                        style: GoogleFonts.encodeSansSemiExpanded(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                body: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Expanded(
                          child: Container(
                        width: 1.sw,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(35.r),
                                topRight: Radius.circular(35.r))),
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 20.h,
                                left: 20.w,
                                right: 20.w,
                                bottom: 120.h),
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: controller.emailController.value,
                                  validator: (v) {
                                    if (v!.isEmpty) {
                                      return 'Email Harus Di isi';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.mark_email_unread_outlined,
                                        color: AssetsColor.colorThrid,
                                        size: 35.sp,
                                      ),
                                      contentPadding: EdgeInsets.only(
                                        top: 0.h,
                                        bottom: 0.h,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(25.r),
                                            bottomRight: Radius.circular(30.r),
                                            topRight: Radius.circular(0.r),
                                            bottomLeft: Radius.circular(0.r)),
                                        borderSide: BorderSide(
                                            color: AssetsColor.colorThrid,
                                            width: 2.6.sp),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(25.r),
                                            bottomRight: Radius.circular(30.r),
                                            topRight: Radius.circular(0.r),
                                            bottomLeft: Radius.circular(0.r)),
                                        borderSide: BorderSide(
                                            color: AssetsColor.colorThrid,
                                            width: 2.6.sp),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(25.r),
                                            bottomRight: Radius.circular(30.r),
                                            topRight: Radius.circular(0.r),
                                            bottomLeft: Radius.circular(0.r)),
                                        borderSide: BorderSide(
                                            color: AssetsColor.colorThrid,
                                            width: 2.6.sp),
                                      ),
                                      hintText: "Email",
                                      hintStyle:
                                          GoogleFonts.encodeSansSemiExpanded(
                                              color: HexColor('1E1E1E')
                                                  .withOpacity(0.5))),
                                ),
                                SizedBox(
                                  height: 18.h,
                                ),
                                TextFormField(
                                  controller: controller.nameController.value,
                                  validator: (v) {
                                    if (v!.isEmpty) {
                                      return 'Name Harus Di isi';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.assignment_ind_outlined,
                                        color: AssetsColor.colorThrid,
                                        size: 35.sp,
                                      ),
                                      contentPadding: EdgeInsets.only(
                                          top: 0.h, bottom: 0.h),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(25.r),
                                            bottomRight: Radius.circular(30.r),
                                            topRight: Radius.circular(0.r),
                                            bottomLeft: Radius.circular(0.r)),
                                        borderSide: BorderSide(
                                            color: AssetsColor.colorThrid,
                                            width: 2.6.sp),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(25.r),
                                            bottomRight: Radius.circular(30.r),
                                            topRight: Radius.circular(0.r),
                                            bottomLeft: Radius.circular(0.r)),
                                        borderSide: BorderSide(
                                            color: AssetsColor.colorThrid,
                                            width: 2.6.sp),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(25.r),
                                            bottomRight: Radius.circular(30.r),
                                            topRight: Radius.circular(0.r),
                                            bottomLeft: Radius.circular(0.r)),
                                        borderSide: BorderSide(
                                            color: AssetsColor.colorThrid,
                                            width: 2.6.sp),
                                      ),
                                      hintText: "Name",
                                      hintStyle:
                                          GoogleFonts.encodeSansSemiExpanded(
                                              color: HexColor('1E1E1E')
                                                  .withOpacity(0.5))),
                                ),
                                SizedBox(
                                  height: 18.h,
                                ),
                                TextFormField(
                                  onChanged: (e) {
                                    controller.changePas1.value = e;
                                    print(controller.changePas1.value);
                                  },
                                  controller:
                                      controller.passwordController.value,
                                  validator: (v) {
                                    if (v!.isEmpty) {
                                      return 'Password Harus Di isi';
                                    }
                                    return null;
                                  },
                                  obscureText: controller.isVisiblePas.value,
                                  decoration: InputDecoration(
                                      suffix: SizedBox(
                                          width: 24.w,
                                          height: 24.h,
                                          child: IconButton(
                                            onPressed: () {
                                              if (controller
                                                      .isVisiblePas.value ==
                                                  true) {
                                                controller.isVisiblePas.value =
                                                    false;
                                              } else {
                                                controller.isVisiblePas.value =
                                                    true;
                                              }
                                            },
                                            padding: EdgeInsets.zero,
                                            constraints: BoxConstraints(),
                                            iconSize: 24.sp,
                                            icon: controller
                                                        .isVisiblePas.value ==
                                                    false
                                                ? Padding(
                                                  padding: EdgeInsets.only(right: 10.w),
                                                  child: Icon(
                                                      Icons.visibility,
                                                      size: 24.sp,
                                                      color: AssetsColor.colorThrid,
                                                    ),
                                                )
                                                : Padding(
                                                  padding: EdgeInsets.only(right: 10.w),
                                                  child: Icon(
                                                      Icons.visibility_off,
                                                      size: 24.sp,
                                                      color: AssetsColor.colorThrid,
                                                    ),
                                                ),
                                          )),
                                      prefixIcon: Icon(
                                        Icons.lock_clock_outlined,
                                        color: AssetsColor.colorThrid,
                                        size: 35.sp,
                                      ),
                                      contentPadding: EdgeInsets.only(
                                          top: 0.h, bottom: 0.h,right: 20.w),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(25.r),
                                            bottomRight: Radius.circular(30.r),
                                            topRight: Radius.circular(0.r),
                                            bottomLeft: Radius.circular(0.r)),
                                        borderSide: BorderSide(
                                            color: AssetsColor.colorThrid,
                                            width: 2.6.sp),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(25.r),
                                            bottomRight: Radius.circular(30.r),
                                            topRight: Radius.circular(0.r),
                                            bottomLeft: Radius.circular(0.r)),
                                        borderSide: BorderSide(
                                            color: AssetsColor.colorThrid,
                                            width: 2.6.sp),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(25.r),
                                            bottomRight: Radius.circular(30.r),
                                            topRight: Radius.circular(0.r),
                                            bottomLeft: Radius.circular(0.r)),
                                        borderSide: BorderSide(
                                            color: AssetsColor.colorThrid,
                                            width: 2.6.sp),
                                      ),
                                      hintText: "Password",
                                      hintStyle:
                                          GoogleFonts.encodeSansSemiExpanded(
                                              color: HexColor('1E1E1E')
                                                  .withOpacity(0.5))),
                                ),
                                SizedBox(
                                  height: 18.h,
                                ),
                                TextFormField(
                                  onChanged: (e) {
                                    controller.changePas2.value = e;
                                    if (controller.changePas1.value != e) {
                                      controller.isPassSame.value = true;
                                    } else {
                                      controller.isPassSame.value = false;
                                    }
                                    print(controller.changePas2.value);
                                  },
                                  controller:
                                      controller.passConfrimController.value,
                                  validator: (v) {
                                    if (v!.isEmpty) {
                                      return 'Confrim Password Harus Di isi';
                                    }
                                    return null;
                                  },
                                  obscureText: controller.isVisiblePas2.value,
                                  decoration: InputDecoration(
                                      suffix: SizedBox(
                                          width: 24.w,
                                          height: 24.h,
                                          child: IconButton(
                                            onPressed: () {
                                              if (controller
                                                      .isVisiblePas2.value ==
                                                  true) {
                                                controller.isVisiblePas2.value =
                                                    false;
                                              } else {
                                                controller.isVisiblePas2.value =
                                                    true;
                                              }
                                            },
                                            padding: EdgeInsets.zero,
                                            constraints: BoxConstraints(),
                                            iconSize: 24.sp,
                                            icon: controller
                                                        .isVisiblePas2.value ==
                                                    false
                                                ? Padding(
                                                  padding: EdgeInsets.only(right: 10.w),
                                                  child: Icon(Icons.visibility,
                                                      size: 24.sp,
                                                      color:
                                                          AssetsColor.colorThrid),
                                                )
                                                : Padding(
                                                  padding: EdgeInsets.only(right: 10.w),
                                                  child: Icon(Icons.visibility_off,
                                                      size: 24.sp,
                                                      color:
                                                          AssetsColor.colorThrid),
                                                ),
                                          )),
                                      prefixIcon: Icon(
                                        Icons.lock_open_outlined,
                                        color: AssetsColor.colorThrid,
                                        size: 35.sp,
                                      ),
                                      contentPadding: EdgeInsets.only(
                                          top: 0.h, bottom: 0.h,right: 20.w),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(25.r),
                                            bottomRight: Radius.circular(30.r),
                                            topRight: Radius.circular(0.r),
                                            bottomLeft: Radius.circular(0.r)),
                                        borderSide: BorderSide(
                                            color: AssetsColor.colorThrid,
                                            width: 2.6.sp),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(25.r),
                                            bottomRight: Radius.circular(30.r),
                                            topRight: Radius.circular(0.r),
                                            bottomLeft: Radius.circular(0.r)),
                                        borderSide: BorderSide(
                                            color: AssetsColor.colorThrid,
                                            width: 2.6.sp),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(25.r),
                                            bottomRight: Radius.circular(30.r),
                                            topRight: Radius.circular(0.r),
                                            bottomLeft: Radius.circular(0.r)),
                                        borderSide: BorderSide(
                                            color: AssetsColor.colorThrid,
                                            width: 2.6.sp),
                                      ),
                                      hintText: "Confrim Password",
                                      hintStyle:
                                          GoogleFonts.encodeSansSemiExpanded(
                                              color: HexColor('1E1E1E')
                                                  .withOpacity(0.5))),
                                ),
                                controller.isPassSame.value
                                    ? Padding(
                                        padding: EdgeInsets.only(
                                            left: 0.w, right: 0.w, top: 9.h),
                                        child: Container(
                                          width: 1.sw,
                                          decoration: BoxDecoration(
                                              color: HexColor('#F1416C'),
                                              borderRadius:
                                                  BorderRadius.circular(5.r)),
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0.sp),
                                            child: Text(
                                              "Password tidak sama",
                                              style: GoogleFonts
                                                  .encodeSansSemiExpanded(
                                                      fontSize: 12.sp,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w400),
                                            ),
                                          ),
                                        ),
                                      )
                                    : SizedBox(),
                                SizedBox(
                                  height: 18.h,
                                ),
                                TextFormField(
                                  controller:
                                      controller.identityController.value,
                                  validator: (v) {
                                    if (v!.isEmpty) {
                                      return 'Identity Id Harus Di isi';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.apps_sharp,
                                        color: AssetsColor.colorThrid,
                                        size: 35.sp,
                                      ),
                                      contentPadding: EdgeInsets.only(
                                          top: 0.h, bottom: 0.h),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(25.r),
                                            bottomRight: Radius.circular(30.r),
                                            topRight: Radius.circular(0.r),
                                            bottomLeft: Radius.circular(0.r)),
                                        borderSide: BorderSide(
                                            color: AssetsColor.colorThrid,
                                            width: 2.6.sp),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(25.r),
                                            bottomRight: Radius.circular(30.r),
                                            topRight: Radius.circular(0.r),
                                            bottomLeft: Radius.circular(0.r)),
                                        borderSide: BorderSide(
                                            color: AssetsColor.colorThrid,
                                            width: 2.6.sp),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(25.r),
                                            bottomRight: Radius.circular(30.r),
                                            topRight: Radius.circular(0.r),
                                            bottomLeft: Radius.circular(0.r)),
                                        borderSide: BorderSide(
                                            color: AssetsColor.colorThrid,
                                            width: 2.6.sp),
                                      ),
                                      hintText: "Identity Id",
                                      hintStyle:
                                          GoogleFonts.encodeSansSemiExpanded(
                                              color: HexColor('1E1E1E')
                                                  .withOpacity(0.5))),
                                ),
                                SizedBox(
                                  height: 18.h,
                                ),
                                TextFormField(
                                  controller:
                                      controller.instansiController.value,
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
                                          top: 0.h, bottom: 0.h),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(25.r),
                                            bottomRight: Radius.circular(30.r),
                                            topRight: Radius.circular(0.r),
                                            bottomLeft: Radius.circular(0.r)),
                                        borderSide: BorderSide(
                                            color: AssetsColor.colorThrid,
                                            width: 2.6.sp),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(25.r),
                                            bottomRight: Radius.circular(30.r),
                                            topRight: Radius.circular(0.r),
                                            bottomLeft: Radius.circular(0.r)),
                                        borderSide: BorderSide(
                                            color: AssetsColor.colorThrid,
                                            width: 2.6.sp),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(25.r),
                                            bottomRight: Radius.circular(30.r),
                                            topRight: Radius.circular(0.r),
                                            bottomLeft: Radius.circular(0.r)),
                                        borderSide: BorderSide(
                                            color: AssetsColor.colorThrid,
                                            width: 2.6.sp),
                                      ),
                                      hintText: "Instansi",
                                      hintStyle:
                                          GoogleFonts.encodeSansSemiExpanded(
                                              color: HexColor('1E1E1E')
                                                  .withOpacity(0.5))),
                                ),
                                SizedBox(
                                  height: 18.h,
                                ),
                                TextFormField(
                                  controller: controller.titleController.value,
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
                                      contentPadding: EdgeInsets.only(
                                          top: 0.h, bottom: 0.h),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(25.r),
                                            bottomRight: Radius.circular(30.r),
                                            topRight: Radius.circular(0.r),
                                            bottomLeft: Radius.circular(0.r)),
                                        borderSide: BorderSide(
                                            color: AssetsColor.colorThrid,
                                            width: 2.6.sp),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(25.r),
                                            bottomRight: Radius.circular(30.r),
                                            topRight: Radius.circular(0.r),
                                            bottomLeft: Radius.circular(0.r)),
                                        borderSide: BorderSide(
                                            color: AssetsColor.colorThrid,
                                            width: 2.6.sp),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(25.r),
                                            bottomRight: Radius.circular(30.r),
                                            topRight: Radius.circular(0.r),
                                            bottomLeft: Radius.circular(0.r)),
                                        borderSide: BorderSide(
                                            color: AssetsColor.colorThrid,
                                            width: 2.6.sp),
                                      ),
                                      hintText: "Title Pekerjaan",
                                      hintStyle:
                                          GoogleFonts.encodeSansSemiExpanded(
                                              color: HexColor('1E1E1E')
                                                  .withOpacity(0.5))),
                                ),
                                SizedBox(
                                  height: 18.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      controller.isAdmin.value
                                          ? 'Ini Akun Untuk Admin'
                                          : 'ini Akun Bukan Untuk Admin',
                                      style: GoogleFonts.encodeSansSemiExpanded(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Switch(
                                      value: controller.isAdmin.value,
                                      onChanged: (value) {
                                        controller.isAdmin.value = value;
                                      },
                                      activeTrackColor: AssetsColor.colorThrid,
                                      activeColor: AssetsColor.colorPrimary,
                                      inactiveTrackColor: Colors.grey[300],
                                      inactiveThumbColor: Colors.grey,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 18.h,
                                ),
                                controller.isLoadingAddUser.value
                                    ? const Center(
                                        child: RefreshProgressIndicator(),
                                      )
                                    : ElevatedButton(
                                        style: ButtonStyle(
                                          padding: MaterialStateProperty.all<
                                              EdgeInsets>(EdgeInsets.zero),
                                          foregroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.white),
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                            AssetsColor.colorPrimary,
                                          ),
                                          shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(25.r),
                                                topRight: Radius.circular(0.r),
                                                bottomRight:
                                                    Radius.circular(30.r),
                                                bottomLeft:
                                                    Radius.circular(0.r),
                                              ),
                                            ),
                                          ),
                                        ),
                                        onPressed: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            controller.addUser();
                                          }
                                        },
                                        child: Container(
                                          width: 1.sw,
                                          height: 55.h,
                                          padding: EdgeInsets.zero,
                                          decoration: BoxDecoration(
                                            color: AssetsColor.colorPrimary,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(25.r),
                                              topRight: Radius.circular(0.r),
                                              bottomRight:
                                                  Radius.circular(30.r),
                                              bottomLeft: Radius.circular(0.r),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20.w),
                                            child: Center(
                                                child: SvgPicture.asset(
                                                    'assets/images/send.svg')),
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ),
                      )),
                    ],
                  ),
                ),
              ));
        });
  }
}
