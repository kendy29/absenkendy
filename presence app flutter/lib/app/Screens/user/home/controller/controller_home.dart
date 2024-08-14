import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

import '../../../../utils/date.dart';
import '../../absenLocation/controller/controller_dialog_map.dart';
import '../../absenLocation/views/absen_location_page.dart';
import '../../../dashboard/controller/controller_dashboard.dart';
import '../../profile/controller/controller_set_profile.dart';

class HomeController extends GetxController {
  Rx<LatLng>? position;
  DashboardController dashboardController = Get.put(DashboardController());
  String dayName = weekdays[DateTime.now().weekday - 1];
  getLocation(double lat, double long) async {
    bool? serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    LocationPermission? permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    Get.to(() => AbsenLocation(
        currentLocation: LatLng(lat == 0 ? position.latitude : lat,
            long == 0 ? position.longitude : long)));

    DialogControllerMap mapController = Get.put(DialogControllerMap(
        currentLocation: LatLng(lat == 0 ? position.latitude : lat,
                long == 0 ? position.longitude : long)
            .obs));
    mapController.getLocation();
  }

  @override
  void dispose() {
    Get.delete<HomeController>();
    super.dispose();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // getLocation();
  }
}
