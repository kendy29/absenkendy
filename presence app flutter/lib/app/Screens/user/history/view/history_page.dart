import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:kenface/app/utils/colors/colors.dart';

import '../controller/controller_history.dart';

class HistoryPage extends GetView<HistoryController> {
  const HistoryPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(393, 852));
    return GetBuilder<HistoryController>(
      init: HistoryController(),
      builder: (controller) {
        return Obx(
          () => Scaffold(
            backgroundColor: AssetsColor.colorPrimary,
            appBar: AppBar(
              backgroundColor: AssetsColor.colorPrimary,
              title: Text(
                "Recap Absen",
                style: GoogleFonts.encodeSansSemiExpanded(
                    color: HexColor('FCF8E8'),
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              elevation: 0,
            ),
            body: Container(
              color: AssetsColor.colorPrimary,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Expanded(
                      child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    width: 1.sw,
                    decoration: BoxDecoration(
                      color: AssetsColor.colorBackground,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(35.r),
                        topRight: Radius.circular(35.r),
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 22.h,
                        ),
                        controller.isLoading.value
                            ? const Center(child: RefreshProgressIndicator())
                            : Column(
                                children: controller.data == null
                                    ? []
                                    : controller.data!.map((element) {
                                        return Container(
                                          margin: EdgeInsets.only(bottom: 20.h),
                                          width: 1.sw,
                                          height: 120.h,
                                          decoration: BoxDecoration(
                                            color: AssetsColor.colorThrid,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(88.r),
                                              topRight: Radius.circular(10.r),
                                              bottomRight:
                                                  Radius.circular(60.r),
                                              bottomLeft: Radius.circular(4.r),
                                            ),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Column(
                                                children: [
                                                  SizedBox(
                                                    width: 229.w,
                                                    child: Text(
                                                      element.date ?? "",
                                                      style: GoogleFonts
                                                          .encodeSansSemiExpanded(
                                                              fontSize: 16,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 229.w,
                                                    child: Text(
                                                      'Masuk : ${element.opened}',
                                                      style: GoogleFonts
                                                          .encodeSansSemiExpanded(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 229.w,
                                                    child: Text(
                                                      'Keluar  : ${element.closed}',
                                                      style: GoogleFonts
                                                          .encodeSansSemiExpanded(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        );
                                      }).toList(),
                              )
                      ],
                    ),
                  ))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
