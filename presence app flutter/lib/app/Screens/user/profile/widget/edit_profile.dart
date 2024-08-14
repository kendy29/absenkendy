import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../utils/colors/colors.dart';
import '../controller/controller_set_profile.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SetProfileController controller = Get.put(SetProfileController(context:context));
    ScreenUtil.init(context, designSize: const Size(393, 852));
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Edit Profile',
            style: GoogleFonts.encodeSansSemiExpanded(
                fontSize: 16.sp, fontWeight: FontWeight.w800),
          ),
          SizedBox(
            height: 24.h,
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
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.r),
                      bottomRight: Radius.circular(30.r),
                      topRight: Radius.circular(0.r),
                      bottomLeft: Radius.circular(0.r)),
                  borderSide:
                      BorderSide(color: AssetsColor.colorThrid, width: 2.6.sp),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.r),
                      bottomRight: Radius.circular(30.r),
                      topRight: Radius.circular(0.r),
                      bottomLeft: Radius.circular(0.r)),
                  borderSide:
                      BorderSide(color: AssetsColor.colorThrid, width: 2.6.sp),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.r),
                      bottomRight: Radius.circular(30.r),
                      topRight: Radius.circular(0.r),
                      bottomLeft: Radius.circular(0.r)),
                  borderSide:
                      BorderSide(color: AssetsColor.colorThrid, width: 2.6.sp),
                ),
                hintText: "Edit Instansi",
                hintStyle: GoogleFonts.encodeSansSemiExpanded(
                    color: HexColor('1E1E1E').withOpacity(0.5))),
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
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.r),
                      bottomRight: Radius.circular(30.r),
                      topRight: Radius.circular(0.r),
                      bottomLeft: Radius.circular(0.r)),
                  borderSide:
                      BorderSide(color: AssetsColor.colorThrid, width: 2.6.sp),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.r),
                      bottomRight: Radius.circular(30.r),
                      topRight: Radius.circular(0.r),
                      bottomLeft: Radius.circular(0.r)),
                  borderSide:
                      BorderSide(color: AssetsColor.colorThrid, width: 2.6.sp),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.r),
                      bottomRight: Radius.circular(30.r),
                      topRight: Radius.circular(0.r),
                      bottomLeft: Radius.circular(0.r)),
                  borderSide:
                      BorderSide(color: AssetsColor.colorThrid, width: 2.6.sp),
                ),
                hintText: "Edit Title Pekerjaan",
                hintStyle: GoogleFonts.encodeSansSemiExpanded(
                    color: HexColor('1E1E1E').withOpacity(0.5))),
          ),
          SizedBox(
            height: 18.h,
          ),
          controller.isLoadingUpdate.value
              ? const Center(child: RefreshProgressIndicator())
              : ElevatedButton(
                  style: ButtonStyle(
                    padding:
                        MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
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
                    controller.updateProfile(context);
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
                        bottomRight: Radius.circular(30.r),
                        bottomLeft: Radius.circular(0.r),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Center(
                          child: SvgPicture.asset('assets/images/send.svg')),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
