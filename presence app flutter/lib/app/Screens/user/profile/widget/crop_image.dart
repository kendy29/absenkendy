import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_image_cropper/simple_image_cropper.dart';
import '../../../../utils/colors/colors.dart';
import '../controller/controller_set_profile.dart';

class CropImageView extends StatelessWidget {
  const CropImageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(393, 852));
    return GetBuilder<SetProfileController>(
        init: SetProfileController(context: context),
        builder: (controller2) {
          return Obx(() => Scaffold(
                  body: Stack(
                children: [
                  Column(
                    children: <Widget>[
                      Expanded(
                        child: Image.file(
                            File(controller2.selectedImagePathLast.value),
                          height: 500,
                          width: 500,
                       
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 1.sw,
                    height: 214.h,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/appbar1.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Crop Image',
                        style: GoogleFonts.encodeSansSemiExpanded(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0.h,
                    left: 0.w,
                    child: Container(
                      width: 1.sw,
                      height: 127.h,
                      child: Padding(
                        padding: EdgeInsets.only(top: 16.h),
                        child: Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: 160.w,
                            height: 65.h,
                            child: TextButton(
                              onPressed: () {
                                controller2.cropImage(
                                    File(controller2
                                        .selectedImagePathLast.value),
                                    context);
                              },
                              child: Container(
                                  padding: EdgeInsets.all(8.sp),
                                  decoration: BoxDecoration(
                                    color: AssetsColor.colorPrimary,
                                    border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  child: SvgPicture.asset(
                                    'assets/images/send.svg',
                                    width: 100.w,
                                    height: 60.h,
                                  )),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )));
        });
  }
}
