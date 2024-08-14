import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:google_ml_vision/google_ml_vision.dart';
import 'package:kenface/main.dart';
import 'package:path_provider/path_provider.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as imglib;
import 'package:quiver/collection.dart';
import 'package:flutter/services.dart';

import '../../../../models/update_face_model.dart';
import '../../../../utils/alert_notif.dart';
import '../../../dashboard/controller/controller_dashboard.dart';
import '../../../dashboard/views/dashboard_view.dart';
import '../../profile/controller/controller_set_profile.dart';
import '../provider/provider_face_recognition.dart';
import '../views/Detec_face.dart';

class DetecFaceController extends GetxController {
  DetecFaceController(this.context);

  DashboardController dashboardController = Get.put(DashboardController());
  List<CameraDescription>? cameras;
  FaceRecogProvider provider = FaceRecogProvider();
  BuildContext context;
  dynamic data = {}.obs;
  File? jsonFile;
  Rx<dynamic>? _scanResults;
  CameraController? camera;
  var interpreter;
  Rx<bool> isDetecting = false.obs;
  Rx<CameraLensDirection> direction = CameraLensDirection.front.obs;
  double threshold = 1.0;
  Directory? tempDir;

  RxDouble? scaleX = 0.0.obs;
  RxDouble? scaleY = 0.0.obs;
  List? e1 = [];
  Rx<bool> faceFound = false.obs;
  final FaceDetector faceDetector2 = GoogleVision.instance
      .faceDetector(const FaceDetectorOptions(enableContours: true));
  Rx<TextEditingController> name = TextEditingController().obs;
  RxString predRes = "NOT RECOGNIZED".obs;
  RxBool isLoading = false.obs;
  RxString brear = "".obs;
  RxString nameFace = "".obs;
  RxInt? identityId = 0.obs;
  Future getData() async {}

  Future updateFace() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      isLoading.value = true;
      UpdateFaceModel faceModel = await provider.updateFace(context,
          identityId: prefs.getInt('identity_id').toString(),
          faceId: e1,
          brear: prefs.getString('brear') ?? "");
      if (faceModel.status) {
        await prefs.setInt('is_login', 2);
        Get.offAll(DashboardPage(
          isAdmin: false,
        ));
        _handle(prefs.getString('nameFace') ?? "");
        isLoading.value = false;
        dashboardController.getData();
        SetProfileController profileController =
            Get.put(SetProfileController(context: context));
        profileController.getProfile();
      } else {
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
    }
    isLoading.value = false;
  }

  Future absenPermit(String method_) async {
    try {
      isLoading.value = true;
      if (method_ == 'izin') {
        SetProfileController profiledController =
            Get.put(SetProfileController(context: context));
        final permit = await provider.absenPermit(context,
            identityId: dashboardController.identityId.value,
            brear: dashboardController.brear.value,
            method_: method_,
            count: (profiledController.premited!.value) + 1,
            dateNotAbsen: profiledController.dateNow.value);
        isLoading.value = false;
        Get.offAll(DashboardPage(
          isAdmin: false,
        ));
        profiledController.getProfile();
        showNotificationGreen(context, permit!.message);
      } else {
        SetProfileController profiledController =
            Get.put(SetProfileController(context: context));
        final cuti = await provider.absenPermit(context,
            identityId: dashboardController.identityId.value,
            brear: dashboardController.brear.value,
            method_: method_,
            count: profiledController.leave.value + 1,
            dateNotAbsen: profiledController.dateNow.value);
        isLoading.value = false;
        Get.offAll(DashboardPage(
          isAdmin: false,
        ));
        profiledController.getProfile();

        showNotificationGreen(context, cuti!.message);
      }
    } catch (e) {
      isLoading.value = false;
    }
  }

  @override
  void dispose() {
    super.dispose();
    try {
      
      Get.delete<DetecFaceController>();
      camera!.dispose();
      faceDetector2.close();

    } catch (e) {
//
    }
  }

  void _initializeCamera() async {
    cameras = await availableCameras();
    await loadModel();
    CameraDescription description = await getCamera(direction.value);

    camera =
        CameraController(description, ResolutionPreset.low, enableAudio: false);
    await camera?.initialize();
    tempDir = await getApplicationDocumentsDirectory();
    String _embPath = tempDir!.path + '/emb.json';
    jsonFile = File(_embPath);
    if (jsonFile!.existsSync()) {
      data = json.decode(jsonFile!.readAsStringSync());
    }

    camera!.startImageStream((CameraImage image) {
      if (camera?.value != null) {
        if (isDetecting.value) return;
        isDetecting.value = true;
        String res;
        dynamic finalResult = Multimap<String, Face>();
        detect(
                image: image,
                detectInImage: _getDetectionMethod(),
                imageRotation: description.sensorOrientation)
            .then(
          (dynamic result) async {
            if (result.length == 0) {
              faceFound.value = false;

              predRes.value = "NOT RECOGNIZED";
            } else {
              faceFound.value = true;
            }
            Face _face;
            imglib.Image convertedImage =
                _convertCameraImage(image, direction.value);
            for (_face in result) {
              double x, y, w, h;
              x = (_face.boundingBox.left - 10);
              y = (_face.boundingBox.top - 10);
              w = (_face.boundingBox.width + 10);
              h = (_face.boundingBox.height + 10);
              imglib.Image croppedImage = imglib.copyCrop(convertedImage,
                  x: x.round(),
                  y: y.round(),
                  width: w.round(),
                  height: h.round());
              croppedImage =
                  imglib.copyResizeCropSquare(croppedImage, size: 112);
              // int startTime =  DateTime.now().millisecondsSinceEpoch;
              res = _recog(croppedImage);

              scaleX!.value = camera!.value.previewSize!.width /
                  _face.boundingBox.left.toDouble();
              scaleY!.value = camera!.value.previewSize!.height +
                  _face.boundingBox.top.toDouble();

              // int endTime =  DateTime.now().millisecondsSinceEpoch;
              // print("Inference took ${endTime - startTime}ms");
              predRes.value = res;
              finalResult.add(res, _face);
            }
            _scanResults!.value = finalResult;
            isDetecting.value = false;
          },
        ).catchError(
          (_) {
            isDetecting.value = false;
          },
        );
      }
    });
  }

  Future<dynamic> Function(GoogleVisionImage visionImage)
      _getDetectionMethod() {
    final faceDetector = GoogleVision.instance.faceDetector(
      const FaceDetectorOptions(
        mode: FaceDetectorMode.accurate,
      ),
    );
    
    return faceDetector2.processImage;
  }

  RxBool isPressed = false.obs;
  void setPressed(bool isPres) {
    isPressed.value = isPres;
  }

  Widget buildImage() {
    if (camera == null || !camera!.value.isInitialized) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Container(
      constraints: const BoxConstraints.expand(),
      child: Obx(
        () => camera == null
            ? const Center(child: null)
            : Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  CameraPreview(camera!),
                  // _buildResults(),
                  Positioned(
                      top: 0,
                      left: 0,
                      child: Image.asset('assets/images/appbar2.png')),
                  (faceFound.value == false)
                      ? const SizedBox()
                      : Positioned(
                          left: scaleX!.value + 60,
                          top: scaleY!.value - 180,
                          child: Image.asset(
                            'assets/bingkai.png',
                            width: 250,
                            height: 450,
                            fit: BoxFit.fill,
                          ),
                        ),
                ],
              ),
      ),
    );
  }

  void toggleCameraDirection() async {
    if (direction.value == CameraLensDirection.back) {
      direction.value = CameraLensDirection.front;
    } else {
      direction.value = CameraLensDirection.back;
    }
    await camera?.stopImageStream();
    await camera?.dispose();

    camera = null;

    _initializeCamera();
  }

  Future loadModel() async {
    try {
      final gpuDelegateV2 = GpuDelegateV2(
          options: GpuDelegateOptionsV2(
        isPrecisionLossAllowed: false,
      ));

      var interpreterOptions = InterpreterOptions()..addDelegate(gpuDelegateV2);
      interpreter = await Interpreter.fromAsset('assets/mobilefacenet.tflite',
          options: interpreterOptions);
    } on Exception {
      //
    }
  }

  imglib.Image _convertCameraImage(
      CameraImage image, CameraLensDirection _dir) {
    int width = image.width;
    int height = image.height;
    // imglib -> Image package from https://pub.dartlang.org/packages/image
    var img = imglib.Image(width: width, height: height); // Create Image buffer
    const int hexFF = 0xFF000000;
    final int uvyButtonStride = image.planes[1].bytesPerRow;
    final int uvPixelStride = image.planes[1].bytesPerPixel!;
    for (int x = 0; x < width; x++) {
      for (int y = 0; y < height; y++) {
        final int uvIndex =
            uvPixelStride * (x / 2).floor() + uvyButtonStride * (y / 2).floor();
        final int index = y * width + x;
        final yp = image.planes[0].bytes[index];
        final up = image.planes[1].bytes[uvIndex];
        final vp = image.planes[2].bytes[uvIndex];
        // Calculate pixel color
        int r = (yp + vp * 1436 / 1024 - 179).round().clamp(0, 255);
        int g = (yp - up * 46549 / 131072 + 44 - vp * 93604 / 131072 + 91)
            .round()
            .clamp(0, 255);
        int b = (yp + up * 1814 / 1024 - 227).round().clamp(0, 255);
        // color: 0x FF  FF  FF  FF
        //           A   B   G   R
        // img.data?[index!] = hexFF | (b << 16) | (g << 8) | r;
      }
    }
    var img1 = (_dir == CameraLensDirection.front)
        ? imglib.copyRotate(img, angle: -90)
        : imglib.copyRotate(img, angle: 90);
    return img1;
  }

  String _recog(imglib.Image img) {
    List input = imageToByteListFloat32(img, 112, 128, 128);
    input = input.reshape([1, 112, 112, 3]);
    List output = List.filled(1 * 192, 0).reshape([1, 192]);
    interpreter.run(input, output);
    output = output.reshape([192]);
    e1 = List.from(output);
    return compare(e1!).toUpperCase();
  }

  String compare(List currEmb) {
    if (data!.isEmpty) return "No Face saved";
    double minDist = 999;
    double currDist = 0.0;
    predRes.value = "NOT RECOGNIZED";
    for (String label in data!.keys) {
      currDist = euclideanDistance(data![label], currEmb);
      if (currDist <= threshold && currDist < minDist) {
        minDist = currDist;
        predRes.value = label;
      }
    }
    return predRes.value;
  }

  void resetFile() {
    data?.value = {};
    jsonFile?.deleteSync();
  }

  void viewLabels() {
    camera = null;

    String name;
    var alert = AlertDialog(
      title: const Text("Saved Faces"),
      content: ListView.builder(
          padding: const EdgeInsets.all(2),
          itemCount: data!.length,
          itemBuilder: (BuildContext context, int index) {
            name = data!.keys.elementAt(index);
            return Column(
              children: <Widget>[
                ListTile(
                  title: Text(
                    name,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[400],
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(2),
                ),
                const Divider(),
              ],
            );
          }),
      actions: <Widget>[
        TextButton(
          child: const Text("OK"),
          onPressed: () {
            _initializeCamera();
            Navigator.pop(context);
          },
        )
      ],
    );
    showDialog(
        context: context,
        builder: (context) {
          return alert;
        });
  }

  void addLabel() {
    camera = null;

    var alert = AlertDialog(
      title: const Text("Add Face"),
      content: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: name.value,
              autofocus: true,
              decoration: const InputDecoration(
                  labelText: "Name", icon: Icon(Icons.face)),
            ),
          )
        ],
      ),
      actions: <Widget>[
        TextButton(
            child: const Text("Save"),
            onPressed: () {
              _handle(name.value.text.toUpperCase());
              name.value.clear();
              Navigator.pop(context);
            }),
        TextButton(
          child: const Text("Cancel"),
          onPressed: () {
            _initializeCamera();
            Navigator.pop(context);
          },
        )
      ],
    );
    showDialog(
        context: context,
        builder: (context) {
          return alert;
        });
  }

  void _handle(String text) {
    data![text] = e1;
    jsonFile!.writeAsStringSync(json.encode(data));
    _initializeCamera();
  }

  Future<CameraDescription> getCamera(CameraLensDirection dir) async {
    return cameras!.firstWhere(
      (CameraDescription camera) => camera.lensDirection == dir,
    );
  }

  GoogleVisionImageMetadata buildMetaData(
    CameraImage image,
    ImageRotation rotation,
  ) {
    return GoogleVisionImageMetadata(
      rawFormat: image.format.raw,
      size: Size(image.width.toDouble(), image.height.toDouble()),
      rotation: rotation,
      planeData: image.planes.map(
        (Plane plane) {
          return GoogleVisionImagePlaneMetadata(
            bytesPerRow: plane.bytesPerRow,
            height: plane.height,
            width: plane.width,
          );
        },
      ).toList(),
    );
  }

  Future<dynamic> detect({
    CameraImage? image,
    Future<dynamic>? Function(GoogleVisionImage image)? detectInImage,
    int? imageRotation,
  }) async {
    return detectInImage!(
      GoogleVisionImage.fromBytes(
        _concatenatePlanes(image!.planes),
        buildMetaData(image, _rotationIntToImageRotation(imageRotation!)),
      ),
    );
  }

  Uint8List _concatenatePlanes(List<Plane> planes) {
    final WriteBuffer allBytes = WriteBuffer();
    planes.forEach((Plane plane) => allBytes.putUint8List(plane.bytes));
    return allBytes.done().buffer.asUint8List();
  }

  ImageRotation _rotationIntToImageRotation(int rotation) {
    switch (rotation) {
      case 0:
        return ImageRotation.rotation0;
      case 90:
        return ImageRotation.rotation90;
      case 180:
        return ImageRotation.rotation180;
      default:
        assert(rotation == 270);
        return ImageRotation.rotation270;
    }
  }

  Float32List imageToByteListFloat32(
      imglib.Image image, int inputSize, double mean, double std) {
    var convertedBytes = Float32List(1 * inputSize * inputSize * 3);
    var buffer = Float32List.view(convertedBytes.buffer);
    int pixelIndex = 0;
    for (var i = 0; i < inputSize; i++) {
      for (var j = 0; j < inputSize; j++) {
        var pixel = image.getPixel(j, i);
        buffer[pixelIndex++] = (imglib.crand(Random(10)) - mean) / std;
        buffer[pixelIndex++] = (imglib.crand(Random(20)) - mean) / std;
        buffer[pixelIndex++] = (imglib.crand(Random(30)) - mean) / std;
      }
    }
    return convertedBytes.buffer.asFloat32List();
  }

  double euclideanDistance(List e1, List e2) {
    double sum = 0.0;
    for (int i = 0; i < e1.length; i++) {
      sum += pow((e1[i] - e2[i]), 2);
    }
    return sqrt(sum);
  }

  Future addAbsen(String latitude, String longitude) async {
    try {
      isLoading.value = true;
      SetProfileController profiledController =
          Get.put(SetProfileController(context: context));
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final absen = await provider.addAbsen(context,
          identityId: prefs.getInt('identity_id').toString(),
          latitude: latitude,
          longitude: longitude,
          date: profiledController.dateNow.value,
          count: profiledController.opened.value + 1,
          brear: prefs.getString('brear') ?? "");

      isLoading.value = false;
      if (absen!.message == 'Silakan absen besok') {
        showNotificationRed(context, absen.message);
        Get.offAll(DashboardPage(
          isAdmin: false,
        ),popGesture: false);

        profiledController.getProfile();
      } else if (absen.succes == true &&
          absen.message != 'Silakan absen besok') {
        showNotificationGreen(context, absen.message);
        Get.offAll(DashboardPage(
          isAdmin: false,
        ),popGesture: false);

        profiledController.getProfile();
      } else {
        showNotificationRed(context, absen.message);
        Get.offAll(DashboardPage(
          isAdmin: false,
        ),popGesture: false);

        profiledController.getProfile();
      }
    } catch (e) {
      isLoading.value = false;
      Get.offAll(DashboardPage(
        isAdmin: false,
      ),popGesture: false);
      SetProfileController profileController =
          Get.put(SetProfileController(context: context));
      profileController.getProfile();
    }
  }

  @override
  void onInit() {
    super.onInit();
    isLoading.value = false;
    _initializeCamera();
    getData();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    DetecFaceController(context).dispose();
    Get.delete<DetecFaceController>();
    
    Get.deleteAll();
  }
}

enum Choice { view, delete }
