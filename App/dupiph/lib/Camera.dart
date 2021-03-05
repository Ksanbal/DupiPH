import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import 'Result.dart';

import 'SQLite/Model.dart' as mo;
import 'SQLite/Database.dart' as db;

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
      body: Stack(
        children: [
          // 카메라
          _Camera(),
        ],
      ),
      floatingActionButton: _floatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  _appBar() {
    return AppBar(
      title: Text('DupiPH'),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: [
        _cameraSwitching(),
      ],
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

  _cameraSwitching() {
    if (cameras == null || cameras.isEmpty) {
      return Spacer();
    }

    CameraDescription selectedCamera = cameras[selectedCameraIdx];

    return IconButton(
        icon: Icon(
          Icons.flip_camera_ios,
          color: Colors.white,
        ),
        onPressed: () {
          selectedCameraIdx = selectedCameraIdx < cameras.length - 1
              ? selectedCameraIdx + 1
              : 0;
          CameraDescription selectedCamera = cameras[selectedCameraIdx];
          _initCameraController(selectedCamera);
        });
  }

  _floatingActionButton() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 120,
          width: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xff89cadb).withOpacity(0.3),
          ),
        ),
        Container(
          height: 100,
          width: 100,
          child: FloatingActionButton(
            backgroundColor: Colors.white,
            child: Icon(
              Icons.camera_alt,
              color: Color(0xff43b0cc),
              size: 60,
            ),
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ResultPage()),
              );
            },
          ),
        )
      ],
    );
  }
}
