import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

import '../../../wiget_dialog.dart/views/button_cricler.dart';
import '../controller/controller_detec_face.dart';


class DetecFace extends GetView<DetecFaceController> {
  DetecFace({Key? key, required this.isAbsen, this.latitude, this.longitude})
      : super(key: key);
  // if 1 = update face , 2 = absen , 3 = absen izin , 4 absen cuti
  int isAbsen;
  String? latitude;
  String? longitude;
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(393, 852));
    return GetBuilder<DetecFaceController>(
        init: DetecFaceController(context),
        builder: (controller) {
          return Obx(() => Scaffold(
                appBar: AppBar(
                  actions: <Widget>[
                    PopupMenuButton<Choice>(
                      onSelected: (Choice result) {
                        if (result == Choice.delete) {
                          controller.resetFile();
                        } else {
                          controller.viewLabels();
                        }
                      },
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<Choice>>[
                        const PopupMenuItem<Choice>(
                          child: Text('View Saved Faces'),
                          value: Choice.view,
                        ),
                        const PopupMenuItem<Choice>(
                          child: Text('Remove all faces'),
                          value: Choice.delete,
                        )
                      ],
                    ),
                  ],
                  title: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Text(
                      controller.predRes.value,
                      style: GoogleFonts.encodeSansSemiExpanded(
                          fontSize: 18.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                  elevation: 0,
                  backgroundColor: Colors.transparent.withOpacity(0),
                ),
                extendBodyBehindAppBar: true,
                body: controller.buildImage(),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerFloat,
                floatingActionButton: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      controller.isLoading.value
                          ? const RefreshProgressIndicator()
                          : controller.faceFound.value &&
                                  controller.isDetecting.value &&
                                  isAbsen == 1
                              // update face
                              ? ButtonDetec(
                                  isAbsen: false,
                                  icon: Icons.sensor_occupied_outlined,
                                  onPressed: () {
                                    controller.updateFace();
                                  },
                                )
                              : controller.faceFound.value &&
                                      controller.isDetecting.value &&
                                      controller.predRes.value !=
                                          "NOT RECOGNIZED" &&
                                      isAbsen == 2
                                  // absen
                                  ? ButtonDetec(
                                      isAbsen: true,
                                      icon: Icons.add_a_photo_outlined,
                                      onPressed: () {
                                        controller.addAbsen(
                                            latitude!, longitude!);
                                      },
                                    )
                                  : controller.faceFound.value &&
                                          controller.isDetecting.value &&
                                          controller.predRes.value !=
                                              "NOT RECOGNIZED" &&
                                          isAbsen == 3
                                      // absen izin
                                      ? ButtonDetec(
                                          isAbsen: true,
                                          icon: Icons.sick,
                                          onPressed: () {
                                            controller.absenPermit('izin');
                                          },
                                        )
                                      : controller.faceFound.value &&
                                          controller.isDetecting.value &&
                                          controller.predRes.value !=
                                              "NOT RECOGNIZED" &&
                                          isAbsen == 4
                                      // absen cuti
                                      ? ButtonDetec(
                                          isAbsen: true,
                                          icon: Icons.free_cancellation_outlined,
                                          onPressed: () {
                                            controller.absenPermit('cuti');
                                          },
                                        )
                                      : const SizedBox(),
                      // FloatingActionButton(
                      //   backgroundColor: (controller.faceFound.value &&
                      //     controller.isDetecting.value &&
                      //     controller.data!.isNotEmpty &&
                      //     controller.predRes.value != "NOT RECOGNIZED")
                      //       ? Colors.blue
                      //       : Colors.blueGrey,
                      //   child: const Icon(Icons.add),
                      //   onPressed: () {
                      //     if (controller.faceFound.value) controller.addLabel();
                      //   },
                      //   heroTag: null,
                      // ),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      // FloatingActionButton(
                      //   onPressed: controller.toggleCameraDirection,
                      //   heroTag: null,
                      //   child:
                      //       controller.direction.value == CameraLensDirection.back
                      //           ? const Icon(Icons.camera_front)
                      //           : const Icon(Icons.camera_rear),
                      // ),
                    ]),
              ));
        });
  }
  
}
