import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kenface/app/utils/alert_notif.dart';
import 'package:latlong2/latlong.dart';

import '../../faceRecognition/views/Detec_face.dart';
import '../../profile/controller/controller_set_profile.dart';
import '../controller/controller_dialog_map.dart';
import '../widget/button_location.dart';

class AbsenLocation extends GetView<DialogControllerMap> {
  AbsenLocation({Key? key, required this.currentLocation}) : super(key: key);
  late LatLng currentLocation;
  @override
  Widget build(BuildContext context) {
    SetProfileController profileController =
        Get.put(SetProfileController(context: context));
    return GetBuilder<DialogControllerMap>(
      init: DialogControllerMap(currentLocation: currentLocation.obs),
      builder: (controller) {
        controller.getLocation();
        return Obx(
          () => Scaffold(
            appBar: AppBar(
              title: Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.w),
                child: Text(
                  profileController.latitude.value == "0" &&
                          profileController.longitude.value == "0"
                      ? 'Silakan Absen di lokasi Anda'
                      : 'Dalam Radius ' +
                          controller.distanceInMeters.value.toInt().toString() +
                          ' Meter Dari Lokasi',
                  style: GoogleFonts.encodeSansSemiExpanded(
                      fontSize: 14.sp, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              elevation: 0,
              backgroundColor: Colors.transparent.withOpacity(0),
            ),
            extendBodyBehindAppBar: true,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: ButtonLocation(
              currentLocation: currentLocation,
              onPressed: () {
                if (controller.distanceInMeters.value >= 15.0) {
                  showNotificationRed(
                      context, 'Anda Lebih dari 15 meter dari lokasi');
                } else {
                  Get.off(DetecFace(
                    isAbsen: 2,
                    latitude: controller.positionEnd!.value.latitude.toString(),
                    longitude:
                        controller.positionEnd!.value.longitude.toString(),
                  ));
                }
              },
              icon: Icons.travel_explore_outlined,
            ),
            body: Stack(
              children: [
                FlutterMap(
                  options: MapOptions(
                      initialCenter: controller.currentLocation.value,
                      initialZoom: 17.0,
                      onTap: (position, tappedLocation) {
                        // controller.onMapTapped(tappedLocation);
                      }),
                  children: [
                    TileLayer(
                      urlTemplate:
                          "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: const ['a', 'b', 'c'],
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          width: 80.0,
                          height: 80.0,
                          point: controller.currentLocation.value,
                          child: Icon(
                            Icons.location_pin,
                            color: Colors.red,
                            size: 26.sp,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                Positioned(
                    top: 0,
                    left: 0,
                    child: Image.asset('assets/images/appbar2.png')),
              ],
            ),
          ),
        );
      },
    );
  }
}
