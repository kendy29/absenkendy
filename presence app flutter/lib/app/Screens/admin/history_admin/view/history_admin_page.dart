import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:kenface/app/utils/colors/colors.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';
import '../../../../models/absen/absen_all_model.dart';
import '../controller/controller_history_admin.dart';

class HistoryAdminPage extends GetView<HistoryAdminController> {
  const HistoryAdminPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(393, 852));
    return GetBuilder<HistoryAdminController>(
      init: HistoryAdminController(),
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
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 22.h,
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 100.h),
                            child: StickyGroupedListView<AllAbsenModel, String>(physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                order: StickyGroupedListOrder.ASC,
                                elements: controller.data!.value,floatingHeader: false,stickyHeaderBackgroundColor: Colors.white,
                                groupBy: (element) => element.date,
                                itemComparator: (AllAbsenModel element1,
                                        AllAbsenModel element2) =>
                                    element1.date.compareTo(element2.date),
                                groupSeparatorBuilder: (AllAbsenModel element) =>
                                    Container(
                                     margin: EdgeInsets.only(left: 60.w,right: 60.w,bottom: 20.h),
                                      height: 45.h,
                                      decoration: BoxDecoration(
                                        color: AssetsColor.colorSecondary,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(88.r),
                                          topRight: Radius.circular(10.r),
                                          bottomRight: Radius.circular(60.r),
                                          bottomLeft: Radius.circular(4.r),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          element.date,
                                          textAlign: TextAlign.center,
                                          style:
                                              GoogleFonts.encodeSansSemiExpanded(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white),
                                        ),
                                      ),
                                    ),
                                itemBuilder: (context, element) {
                                  return Container(
                                    margin: EdgeInsets.only(bottom: 20.h),
                                    width: 1.sw,
                                    height: 120.h,
                                    decoration: BoxDecoration(
                                      color: AssetsColor.colorThrid,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(88.r),
                                        topRight: Radius.circular(10.r),
                                        bottomRight: Radius.circular(60.r),
                                        bottomLeft: Radius.circular(4.r),
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          children: [
                                             SizedBox(
                                              width: 229.w,
                                              child: Text(
                                                element.name,
                                                style: GoogleFonts
                                                    .encodeSansSemiExpanded(
                                                        fontSize: 18,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 229.w,
                                              child: Text(
                                                element.date,
                                                style: GoogleFonts
                                                    .encodeSansSemiExpanded(
                                                        fontSize: 16,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 229.w,
                                              child: Text(
                                                'Masuk : ${element.opened}',
                                                style: GoogleFonts
                                                    .encodeSansSemiExpanded(
                                                        fontSize: 14,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w500),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 229.w,
                                              child: Text(
                                                'Keluar  : ${element.closed}',
                                                style: GoogleFonts
                                                    .encodeSansSemiExpanded(
                                                        fontSize: 14,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w500),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
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
