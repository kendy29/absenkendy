import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

import '../../../../utils/colors/colors.dart';
import '../controller/controller_dialog_map.dart';

class ButtonLocation extends StatelessWidget {
  ButtonLocation(
      {Key? key,
      required this.icon,
      required this.onPressed,
      required this.currentLocation})
      : super(key: key);
  final IconData icon;
  final VoidCallback onPressed;
  late LatLng currentLocation;
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(393, 852));
    return GetBuilder<DialogControllerMap>(
        init: DialogControllerMap(currentLocation: currentLocation.obs),
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
                        colors: (controller.isPressed.value
                            ? [
                                AssetsColor.colorPrimary.withOpacity(1),
                                AssetsColor.colorPrimary.withOpacity(0.6),
                              ]
                            : [
                                AssetsColor.colorPrimary.withOpacity(0.6),
                                AssetsColor.colorPrimary.withOpacity(1),
                              ])),
                    boxShadow: controller.isPressed.value
                        ? [
                            const BoxShadow(
                              color: Colors.black38,
                              blurRadius: 18,
                              offset: Offset(2, 2),
                            ),
                            const BoxShadow(
                              color: Colors.white60,
                              blurRadius: 18,
                              blurStyle: BlurStyle.inner,
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
