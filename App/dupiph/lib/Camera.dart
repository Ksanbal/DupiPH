import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';

import 'Result.dart';

import 'GetColor.dart';
import 'package:path/path.dart';

// import 'SQLite/Model.dart' as mo;
// import 'SQLite/Database.dart' as db;

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController controller;
  List cameras;
  int selectedCameraIdx;

  Future _initCameraController(CameraDescription cameraDescription) async {
    if (controller != null) {
      await controller.dispose();
    }

    controller = CameraController(cameraDescription, ResolutionPreset.veryHigh);

    controller.addListener(() {
      if (mounted) {
        setState(() {});
      }

      if (controller.value.hasError) {
        print('Camera error ${controller.value.errorDescription}');
      }
    });

    try {
      await controller.initialize();
    } on CameraException catch (e) {
      print(e);
    }

    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    // camera
    availableCameras().then((availableCameras) {
      cameras = availableCameras;
      if (cameras.length > 0) {
        setState(() {
          selectedCameraIdx = 0;
        });
        _initCameraController(cameras[selectedCameraIdx]).then((void v) {});
      } else {
        print('No Camera available');
      }
    }).catchError((err) {
      print('Error: $err.code\nError Message: $err.message');
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      extendBodyBehindAppBar: true,
      // body: _Camera(),
      body: CameraPreview(controller),
      floatingActionButton: _floatingActionButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  _appBar() {
    return AppBar(
      title: Text('DupiPH'),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      // actions: [
      //   _cameraSwitching(),
      // ],
    );
  }

  _Camera() {
    if (controller == null || !controller.value.isInitialized) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return Stack(
      alignment: FractionalOffset.center,
      children: [
        Positioned.fill(
          child: CameraPreview(controller),
        ),
        Positioned.fill(
          child: Opacity(
            opacity: 1,
            child: Image.asset(
              'images/Camera_overlay.png',
              fit: BoxFit.fitHeight,
            ),
          ),
        )
      ],
    );
  }

  _floatingActionButton(context) {
    return Row(
      children: [
        Expanded(child: _callGallery()),
        Expanded(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 110,
                width: 110,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xff89cadb).withOpacity(0.3),
                ),
              ),
              Container(
                height: 90,
                width: 90,
                child: FloatingActionButton(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.camera_alt,
                    color: Color(0xff43b0cc),
                    size: 60,
                  ),
                  onPressed: () async {
                    try {
                      final path = join(
                        (await getTemporaryDirectory()).path,
                        '${DateTime.now()}.png',
                      );

                      await controller.takePicture(path);

                      print(path);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ColorPickerWidget(
                            test_path: path,
                          ),
                        ),
                      );
                    } catch (e) {
                      print(e);
                    }
                  },
                ),
              )
            ],
          ),
        ),
        Expanded(child: _cameraSwitching()),
      ],
    );
  }

  _callGallery() {
    return IconButton(
        icon: Icon(
          Icons.insert_photo,
          color: Colors.white,
          size: 60,
        ),
        onPressed: () {});
  }

  _cameraSwitching() {
    if (cameras == null || cameras.isEmpty) {
      return Spacer();
    }

    CameraDescription selectedCamera = cameras[selectedCameraIdx];

    return IconButton(
        icon: Icon(
          Icons.flip_camera_ios,
          color: Colors.white,
          size: 60,
        ),
        onPressed: () {
          selectedCameraIdx = selectedCameraIdx < cameras.length - 1
              ? selectedCameraIdx + 1
              : 0;
          CameraDescription selectedCamera = cameras[selectedCameraIdx];
          _initCameraController(selectedCamera);
        });
  }
}
