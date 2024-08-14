import 'package:get/get.dart';

class ButtonCirclerController extends GetxController {
  RxBool isPressed = false.obs;
  void setPressed(bool isPres) {
    isPressed.value = isPres;
  }
}
