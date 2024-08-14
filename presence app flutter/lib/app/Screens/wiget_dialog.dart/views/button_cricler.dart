import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utils/colors/colors.dart';
import '../../user/faceRecognition/controller/controller_detec_face.dart';

class ButtonDetec extends GetView<DetecFaceController> {
  final IconData icon;
  final VoidCallback onPressed;
  bool isAbsen;
   ButtonDetec({Key? key,required this.isAbsen, required this.icon, required this.onPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(393, 852));
    return GetBuilder<DetecFaceController>(
        init: DetecFaceController(context),
        builder: (controller) {
          return Obx(() => GestureDetector(
                onTapDown: (_) => controller.setPressed(true),
                onTapUp: (_) => controller.setPressed(false),
                onTapCancel: () => controller.setPressed(false),
                onTap: onPressed,
                child: Container(
                  height: 80.h,
                  width: 80.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: controller.faceFound.value &&
                              controller.isDetecting.value &&
                              controller.data.length != 0 &&
                              controller.predRes.value != "NOT RECOGNIZED"&&isAbsen==true
                          ? (controller.isPressed.value
                              ? [
                                  AssetsColor.colorPrimary.withOpacity(1),
                                  AssetsColor.colorPrimary.withOpacity(0.6),
                                ]
                              : [
                                  AssetsColor.colorPrimary.withOpacity(0.6),
                                  AssetsColor.colorPrimary.withOpacity(1),
                                ])
                          : (controller.isPressed.value
                              ? [
                                  Colors.red[300]!.withOpacity(1),
                                  Colors.red[300]!.withOpacity(0.6),
                                ]
                              : [
                                  Colors.red[300]!.withOpacity(0.6),
                                  Colors.red[300]!.withOpacity(1),
                                ]),
                    ),
                    boxShadow: controller.isPressed.value
                        ? [
                            const BoxShadow(
                              color: Colors.black38,
                              blurRadius: 18,
                              offset: Offset(2, 2),
                            ),
                          ]
                        : [
                            const BoxShadow(
                              color: Colors.black54,
                              blurRadius: 18,
                              offset: Offset(0, 0),
                            ),
                          ],
                  ),
                  child: Icon(
                    icon,
                    size: 40.sp,
                    color: AssetsColor.colorBackground,
                  ),
                ),
              ));
        });
  }
}
