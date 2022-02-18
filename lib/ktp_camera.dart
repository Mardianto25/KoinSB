import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/splashscreen.dart';
import 'package:image_picker/image_picker.dart';

List<CameraDescription> cameras;

class KTPCamera extends StatefulWidget {
  @override
  KTPCameraState createState() => KTPCameraState();
}

class KTPCameraState extends State<KTPCamera> {
  CameraController controller;
  Future<void> main() async {
    cameras = await availableCameras();
  }

  // File _image;

  // Future getImage() async {
  //   var image = await ImagePicker.pickImage(source: ImageSource.camera);
  //   Navigator.pop(context);
  //   setState(() {
  //     _image = image;
  //   });
  // }

  @override
  void initState() {
    super.initState();
    main();
    if (controller == null || !controller.value.isInitialized) {
      return;
    }else{
      controller = CameraController(cameras[0], ResolutionPreset.medium);

    }
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }

      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller.value.isInitialized) {
      return Container();
    }
    return AspectRatio(
        aspectRatio:
        controller.value.aspectRatio,
        child: CameraPreview(controller));
  }

  // @override
  // Widget build(BuildContext context) {
  //   if (controller == null || !controller.value.isInitialized) {
  //     return Container();
  //   }
  //   final size = MediaQuery.of(context).size;
  //   final deviceRatio = size.width / size.height;
  //   return Scaffold(
  //       body: Transform.scale(
  //         scale: controller.value.aspectRatio / deviceRatio,
  //         child: Center(
  //           child: AspectRatio(
  //             aspectRatio: controller.value.aspectRatio,
  //             child: CameraPreview(controller),
  //           ),
  //         ),
  //       ),
  //       floatingActionButton: FloatingActionButton(
  //         backgroundColor: Colors.black,
  //         onPressed: () {

  //         },
  //         child: Icon(Icons.camera),
  //       ),
  //       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat
  //   );
  // }
}
