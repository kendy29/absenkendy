import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../utils/colors/colors.dart';
import '../controller/auth_controller.dart';

class LoginPage extends GetView<AuthController> {
  final keyLogin = GlobalKey<FormState>();

  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(393, 852));
    final width = 1.sw;
    return GetBuilder<AuthController>(
        init: AuthController(),
        builder: (controller) {
          return Obx(
            () => Scaffold(
              resizeToAvoidBottomInset: true,
              backgroundColor: Colors.white,
             
              body: SizedBox(
                height: 1.sh + 100,
                width: 1.sw,
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    SizedBox(
                      height: 340.h,
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            top: -40.h,
                            height: 340.h,
                            width: width,
                            child: Container(
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image:  AssetImage('assets/images/appbar2.jpg'),
                                      fit: BoxFit.cover)),
                            ),
                          ),
                          Positioned(
                            left: 35.w,
                            bottom: 94.h,
                            child: TextButton(
                              onPressed: () async {},
                              child: Text("Login",
                                  style: GoogleFonts.encodeSansSemiExpanded(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30.sp)),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40.w),
                      child: Form(
                        key: keyLogin,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                color: Colors.white,
                              ),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(10.sp),
                                    child: TextFormField(
                                      controller:
                                          controller.emailLoginController.value,
                                      validator: (v) {
                                        if (v!.isEmpty) {
                                          return 'Email Harus Di isi';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                          border: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color:
                                                    AssetsColor.colorPrimary),
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color:
                                                    AssetsColor.colorPrimary),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color:
                                                    AssetsColor.colorPrimary),
                                          ),
                                          hintText: "Email",
                                          hintStyle: GoogleFonts
                                              .encodeSansSemiExpanded(
                                                  color: Colors.grey)),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10.sp),
                                    child: TextFormField(
                                      obscureText:
                                          controller.isLoginPassAbsourt.value,
                                      controller:
                                          controller.passLoginController.value,
                                      validator: (v) {
                                        if (v!.isEmpty) {
                                          return 'Password Harus Di isi';
                                        } else if (v.length < 6) {
                                          return 'Password Harus Lebih Dari 6 Karakter';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                          suffix: GestureDetector(
                                            onTap: () {
                                              if (controller
                                                  .isLoginPassAbsourt.value) {
                                                controller.isLoginPassAbsourt
                                                    .value = false;
                                              } else {
                                                controller.isLoginPassAbsourt
                                                    .value = true;
                                              }
                                            },
                                            child: Icon(
                                              controller.isLoginPassAbsourt.value
                                                  ? Icons
                                                      .visibility_off_outlined
                                                  : Icons.visibility_outlined,
                                              color: AssetsColor.colorPrimary,
                                            ),
                                          ),
                                          border: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color:
                                                    AssetsColor.colorPrimary),
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color:
                                                    AssetsColor.colorPrimary),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color:
                                                    AssetsColor.colorPrimary),
                                          ),
                                          hintText: "Password",
                                          hintStyle: GoogleFonts
                                              .encodeSansSemiExpanded(
                                                  color: Colors.grey)),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            Center(
                                child: Text(
                              "Forgot Password?",
                              style: GoogleFonts.encodeSansSemiExpanded(
                                  color: Colors.black87),
                            )),
                            SizedBox(
                              height: 30.h,
                            ),
                            controller.isLoading.value
                                ? const Center(
                                    child: RefreshProgressIndicator(),
                                  )
                                : Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 60.w),
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                          foregroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.white),
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  AssetsColor.colorPrimary),
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50.r),
                                          ))),
                                      onPressed: () {
                                        if (keyLogin.currentState!.validate()) {
                                          controller.setLogin(context);
                                        }
                                        // showDialog(
                                        //   context: context,
                                        //   builder: (context) => DialogMap(),
                                        // );
                                      },
                                      child: Container(
                                        height: 50.h,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50.r),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Login",
                                            style: GoogleFonts
                                                .encodeSansSemiExpanded(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    )),
                            SizedBox(
                              height: 30.h,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              bottomNavigationBar: Container(
                height: 130.h,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/navbar1.png'),
                      fit: BoxFit.fill),
                ),
              ),
            ),
          );
        });
  }
}
