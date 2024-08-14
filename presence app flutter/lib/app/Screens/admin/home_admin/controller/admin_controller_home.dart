import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kenface/app/Screens/dashboard/views/dashboard_view.dart';
import 'package:kenface/app/utils/alert_notif.dart';
import 'package:kenface/app/utils/colors/colors.dart';

import '../../../../models/banner_model.dart';
import '../../../../models/get_user_model.dart';
import '../../../dashboard/controller/controller_dashboard.dart';
import '../../../user/profile/controller/controller_set_profile.dart';
import '../provider/admin_home_provider.dart';

class AdminHomeController extends GetxController {
  AdminHomeController(this.context);
  BuildContext context;
  AdminHomeProvider provider = AdminHomeProvider();
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;
  Rx<TextEditingController> passConfrimController = TextEditingController().obs;
  Rx<TextEditingController> identityController = TextEditingController().obs;
  Rx<TextEditingController> instansiController = TextEditingController().obs;
  Rx<TextEditingController> titleController = TextEditingController().obs;
  Rx<TextEditingController> institudeController = TextEditingController().obs;
  Rx<TextEditingController> gradeController = TextEditingController().obs;
  DashboardController dashboardController = Get.put(DashboardController());
  RxBool isLoading = false.obs;
  RxBool isLoadingAddUser = false.obs;
  RxBool isLoadingSheetBottom = false.obs;
  RxBool switchValue = false.obs;
  RxBool isPassSame = false.obs;
  RxBool isAdmin = false.obs;
  RxBool isVisiblePas = true.obs;
  RxBool isVisiblePas2 = true.obs;
  RxBool isLoadingUpdate = false.obs;
  RxBool isLoadingBanner = false.obs;
  RxString changePas1 = ''.obs;
  RxString changePas2 = ''.obs;
  RxList<ModelUser>? listUser = <ModelUser>[].obs;
  RxList<ListBanner> listBanner = <ListBanner>[].obs;
  List<Widget> banner() {
    final List<Widget> imageSliders = listBanner
        .map(
          (item) => Container(
              height: 102.h,
              decoration: BoxDecoration(
                  color: AssetsColor.colorThrid,
                  borderRadius: BorderRadius.circular(10.r)),
              padding: EdgeInsets.only(
                  top: 28.h, bottom: 28.h, left: 14.w, right: 14.w),
              margin: EdgeInsets.only(left: 16.w, right: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.account_circle_outlined,
                    color: Colors.white,
                    size: 45.sp,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style: GoogleFonts.encodeSansSemiExpanded(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                      Text(
                        item.count.toString()+' Orang',
                        style: GoogleFonts.encodeSansSemiExpanded(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      )
                    ],
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: Color.fromARGB(255, 197, 141, 141),
                    size: 30.sp,
                  ),
                ],
              )),
        )
        .toList();
    return imageSliders;
  }

  Future updateProfile(BuildContext context, String? indentityId) async {
    try {
      isLoadingSheetBottom.value = true;
      final updateProfile = await provider.updateProfileUser(context,
          indentityId: indentityId,
          agencyName: institudeController.value.text,
          grade: gradeController.value.text,
          bearer: dashboardController.brear.value);

      gradeController.value.clear();
      institudeController.value.clear();
      if (updateProfile!.succes) {
        showNotificationGreen(context, updateProfile.message);
        isLoadingSheetBottom.value = false;
        Get.back();
      } else {
        showNotificationRed(context, updateProfile.message);
        isLoadingSheetBottom.value = false;
        Get.back();
      }
      getUser();
      getListCount();
    } catch (e) {
      showNotificationGreen(context, 'Error');
      isLoadingSheetBottom.value = false;
      Get.back();
    }
  }

  Future deleteAccount(String indentityId) async {
    try {
      isLoadingSheetBottom.value = true;
      final deleteAccount = await provider.deleteAccount(context,
          indentityId: indentityId, bearer: dashboardController.brear.value);
      if (deleteAccount!.succes) {
        isLoadingSheetBottom.value = false;
        showNotificationGreen(context, deleteAccount.message);
        getUser();
        getListCount();
        Get.back();
      } else {
        isLoadingSheetBottom.value = false;
        showNotificationRed(context, deleteAccount.message);
        Get.back();
      }
    } catch (e) {
      isLoadingSheetBottom.value = false;
      showNotificationRed(context, 'error');
      Get.back();
    }
  }

  Future setNullFaceId(String? method_, String? indentityId) async {
    try {
      isLoadingSheetBottom.value = true;
      final setNUll = await provider.setNull(context,
          bearer: dashboardController.brear.value,
          method_: method_,
          indentityId: indentityId);
      if (setNUll.succes) {
        isLoadingSheetBottom.value = false;
        Get.back();
        showNotificationGreen(context, setNUll.message);
      } else {
        isLoadingSheetBottom.value = false;
        Get.back();
        showNotificationRed(context, setNUll.message);
      }
    } catch (e) {
      isLoadingSheetBottom.value = false;
      Get.back();
      showNotificationRed(context, 'error');
    }
  }

  Future setNullLocation(String? method_, String? indentityId) async {
    try {
      isLoadingSheetBottom.value = true;
      final setNUll = await provider.setNull(context,
          bearer: dashboardController.brear.value,
          method_: method_,
          indentityId: indentityId);
      if (setNUll.succes) {
        isLoadingSheetBottom.value = false;
        Get.back();
        showNotificationGreen(context, setNUll.message);
      } else {
        isLoadingSheetBottom.value = false;
        Get.back();
        showNotificationRed(context, setNUll.message);
      }
    } catch (e) {
      isLoadingSheetBottom.value = false;
      Get.back();
      showNotificationRed(context, 'error');
    }
  }

  Future getUser() async {
    try {
      isLoading.value = true;
      final user = await provider.getUser(context,
          bearer: dashboardController.brear.value);
      listUser?.value = user.data!;
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
    }
  }

  Future getListCount() async {
    try {
      isLoadingBanner.value = true;
      final data = await provider.getListCount(context,
          bearer: dashboardController.brear.value);
      listBanner.value = data.data;
      isLoadingBanner.value = false;
    } catch (e) {
      isLoadingBanner.value = false;
    }
  }

  Future addUser() async {
    try {
      isLoadingAddUser.value = true;
      if (passwordController.value.text != passConfrimController.value.text) {
        showNotificationRed(context, "Password Tidak sama");
      } else {
        final addUser = await provider.addUser(context,
            bearer: dashboardController.brear.value,
            name: nameController.value.text,
            identityId: identityController.value.text,
            password: passwordController.value.text,
            confrimPassword: passConfrimController.value.text,
            agencyName: instansiController.value.text,
            grade: titleController.value.text,
            email: emailController.value.text,
            isAdmin: isAdmin.value ? 1 : 0);
        if (addUser.succes) {
          showNotificationGreen(context, addUser.message);
          Get.offAll(DashboardPage(isAdmin: true));
        } else {
          showNotificationRed(context, addUser.message);
        }
      }

      isLoadingAddUser.value = false;
      getUser();
      getListCount();
    } catch (e) {
      isLoadingAddUser.value = false;
    }
  }

  @override
  void onInit() {
    isLoading.value = false;
    isLoadingSheetBottom.value = false;
    isLoadingAddUser.value = false;
    getUser();
    getListCount();
    super.onInit();
  }
}
