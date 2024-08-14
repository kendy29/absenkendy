import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

import '../../../dashboard/controller/controller_dashboard.dart';

class DialogControllerMap extends GetxController {
  DialogControllerMap({required this.currentLocation});
  DashboardController dashboardController = Get.put(DashboardController());
  late Rx<LatLng> currentLocation;
  Rx<LatLng>? positionEnd = LatLng(0, 0).obs;
  RxDouble distanceInMeters = 100.0.obs;

  RxBool isPressed = false.obs;
  void setPressed(bool isPres) {
    isPressed.value = isPres;
  }

  Future getLocation() async {
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
    positionEnd!.value = LatLng(position.latitude, position.longitude);
    print('latlng : ' + positionEnd!.value.toString());
    distanceInMeters.value = Geolocator.distanceBetween(
        currentLocation.value.latitude,
        currentLocation.value.longitude,
        position.latitude,
        position.longitude);
  }

  void onMapTapped(LatLng tappedLocation) {
    currentLocation.value = tappedLocation;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    DialogControllerMap(currentLocation: currentLocation).dispose();
    Get.deleteAll();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getLocation();
  }
}
