import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import 'Result.dart';

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController _cameraController;
  List cameras;
  int selectedCameraIdx;

  // Future _initCameraController(CameraDescription, CameraDescription)

  @override
  void initState() {
    super.initState();
    // availableCameras().then((availableCameras) {
    //   cameras = availableCameras;
    //   if (cameras.length > 0) {
    //     setState(() {
    //       selectedCameraIdx = 0;
    //     });
    //     _initCameraController(cameras[selectedCameraIdx]).then((void v) {});
    //   } else {
    //     print('No Camera available');
    //   }
    // }).catchError((err) {
    //   print('Error: $err.code\nError Message: $err.message');
    // });
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 카메라
          _Camera(),
          // 뒤로가기 버튼
          _backBtn(),
        ],
      ),
      floatingActionButton: _NextBtn(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  _backBtn() {
    return Column(
      children: [
        SizedBox(height: 50),
        IconButton(
          icon: Icon(Icons.arrow_back),
          iconSize: 45,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  _Camera() {
    return FutureBuilder<void>(
      // future: _initCameraControllerFuture,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return CameraPreview(_cameraController);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  _NextBtn() {
    return Container(
      height: 130,
      width: 130,
      child: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Icon(
          Icons.camera_alt,
          color: Colors.blue,
          size: 45,
        ),
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ResultPage()),
          );
        },
      ),
    );
  }
}
