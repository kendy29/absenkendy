import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kenface/app/utils/alert_notif.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_image_cropper/simple_image_cropper.dart';
import '../../auth_screen/views/login_page.dart';
import '../../../dashboard/controller/controller_dashboard.dart';
import '../provider/provider_profile.dart';
import 'dart:ui' as ui;
import '../widget/crop_image.dart';

class SetProfileController extends GetxController {
  Rx<TextEditingController> institudeController = TextEditingController().obs;
  Rx<TextEditingController> gradeController = TextEditingController().obs;
  Rx<TextEditingController> oldPassController = TextEditingController().obs;
  Rx<TextEditingController> newPassController = TextEditingController().obs;
  SetProfileController({required this.context});
  BuildContext context;
  DashboardController dashboardController = Get.put(DashboardController());
  ProfileProvider provider = ProfileProvider();

  final GlobalKey<SimpleImageCropperState> cropKey = GlobalKey();
  dynamic data = {}.obs;
  File? jsonFile;
  Directory? tempDir;
  RxBool isLoadingUpdate = false.obs;
  RxBool isLoadingProfile = false.obs;
  RxString selectedImagePathLast = ''.obs;
  RxString agencyName = "".obs;
  RxString dateNotAbsen = "".obs;
  RxString dateNow =
      "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}"
          .obs;
  // 0 = settings profile , 1 = edit profile , 2 = edit Password
  RxInt widgetProfile = 0.obs;
  RxInt opened = 0.obs;
  RxInt? premited = 0.obs;
  RxInt leave = 0.obs;
  RxString latitude = "".obs;
  RxString longitude = "".obs;
  RxString? image = "".obs;
  RxString name = "".obs;
  RxString grade = "".obs;
  Future getProfile() async {
    isLoadingProfile.value = true;
    widgetProfile.value = 0;
    await dashboardController.getData();
    final profileModel = await provider.getProfile(context,
        indentityId: dashboardController.identityId.value,
        bearer: dashboardController.brear.value);
    image!.value = profileModel!.data!.image ?? "";
    agencyName.value = profileModel.data!.agencyName ?? "";
    institudeController.value.text = profileModel.data!.agencyName ?? "";
    opened.value = profileModel.data!.open ?? 0;
    premited!.value = profileModel.data!.permit ?? 0;
    leave.value = profileModel.data!.leave ?? 0;
    latitude.value = profileModel.data!.latitude ?? "";
    longitude.value = profileModel.data!.longitude ?? "";
    grade.value = profileModel.data!.grade ?? "";
    gradeController.value.text = profileModel.data!.grade ?? "";
    dateNotAbsen.value = profileModel.data!.dateNotAbsen ?? "";
    isLoadingProfile.value = false;
  }

  RxBool isLoadingPassword = false.obs;
  Future changePassword() async {
    try {
      isLoadingPassword.value = true;
      final pass = await provider.changePassword(context,
          oldPass: oldPassController.value.text,
          newPass: newPassController.value.text,
          bearer: dashboardController.brear.value);
      if (pass!.succes) {
        showNotificationGreen(context, pass.message);
        newPassController.value.clear();
        oldPassController.value.clear();
        widgetProfile.value = 0;
        isLoadingPassword.value = false;
      } else {
        isLoadingPassword.value = false;
        showNotificationRed(context, pass.message);
      }
    } catch (e) {
      isLoadingPassword.value = false;
      showNotificationRed(context, 'error');
    }
  }

  @override
  void dispose() {
    Get.delete<SetProfileController>();
    SetProfileController(context: context).dispose();
    Get.delete<SetProfileController>();
    super.dispose();
  }

  getFromGallery() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    selectedImagePathLast.value = (image!.path.isEmpty) ? "" : image.path;
    Get.to(CropImageView());
  }

  Future updateProfile(BuildContext context) async {
    try {
      isLoadingUpdate.value = true;
      final updateProfile = await provider.updateProfile(context,
          indentityId: dashboardController.identityId.value,
          agencyName: institudeController.value.text,
          grade: gradeController.value.text,
          bearer: dashboardController.brear.value);

      gradeController.value.clear();
      institudeController.value.clear();
      showNotificationGreen(context, updateProfile!.message);
      isLoadingUpdate.value = false;
      getProfile();
    } catch (e) {
      showNotificationGreen(context, 'Error');
      isLoadingUpdate.value = false;
    }
  }

  RxBool isLoadingIUpload = false.obs;
  Future cropImage(File filePath, BuildContext context) async {
    isLoadingIUpload.value = true;
    final file = File(selectedImagePathLast.value);
    provider.pushProfilePhoto(context,
        indentityId: dashboardController.identityId.value,
        bearer: dashboardController.brear.value,
        photoPath: file.path);
    Get.back();
    isLoadingIUpload.value = false;
  }

  Future<Uint8List?> imageToUint8List(Image image) async {
    final completer = Completer<Uint8List>();

    image.image
        .resolve(ImageConfiguration())
        .addListener(ImageStreamListener((ImageInfo info, bool _) async {
      final byteData =
          await info.image.toByteData(format: ui.ImageByteFormat.png);
      completer.complete(byteData!.buffer.asUint8List());
    }));

    return completer.future;
  }

  Future getDirectoryJson() async {
    tempDir = await getApplicationDocumentsDirectory();
    String _embPath = tempDir!.path + '/emb.json';
    jsonFile = File(_embPath);
    if (jsonFile!.existsSync()) {
      data = json.decode(jsonFile!.readAsStringSync());
    }
  }

  Future logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    deleteJsonDirectory();
    await prefs.setInt('is_login', 0);
    Get.offAll(LoginPage());
  }

  void deleteJsonDirectory() async {
    if (await jsonFile!.exists()) {
      jsonFile?.deleteSync();
    }
  }

  @override
  void onInit() {
    super.onInit();
    isLoadingUpdate.value = false;
    dashboardController.getData();
    getDirectoryJson();
    getProfile();
    print(image?.value);
  }
}
