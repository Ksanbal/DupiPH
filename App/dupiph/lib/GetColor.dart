import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/services.dart' show rootBundle;

import 'Result.dart';

class ColorPickerWidget extends StatefulWidget {
  ColorPickerWidget({Key key, this.test_path}) : super(key: key);
  final String test_path;

  @override
  _ColorPickerWidgetState createState() => _ColorPickerWidgetState();
}

class _ColorPickerWidgetState extends State<ColorPickerWidget> {
  String imagePath = 'images/Intro_background.jpeg';
  GlobalKey imageKey = GlobalKey();
  GlobalKey paintKey = GlobalKey();

  // CHANGE THIS FLAG TO TEST BASIC IMAGE, AND SNAPSHOT.
  bool useSnapshot = true;

  // based on useSnapshot=true ? paintKey : imageKey ;
  // this key is used in this example to keep the code shorter.
  GlobalKey currentKey;

  final StreamController<Color> _stateController = StreamController<Color>();
  img.Image photo;

  Color selectedColor = Colors.black;

  double left_value = 0;
  double top_value = 0;

  @override
  void initState() {
    currentKey = useSnapshot ? paintKey : imageKey;
    print(widget.test_path);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DupiPH"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        alignment: Alignment.center,
        children: [
          StreamBuilder(
            initialData: Colors.green[500],
            stream: _stateController.stream,
            builder: (buildContext, snapshot) {
              selectedColor = snapshot.data ?? Colors.white;
              return RepaintBoundary(
                key: paintKey,
                child: GestureDetector(
                  onPanDown: (details) {
                    searchPixel(details.globalPosition);
                    setState(() {
                      left_value = details.globalPosition.dx - 55;
                      top_value = details.globalPosition.dy - 55;
                    });
                  },
                  onPanUpdate: (details) {
                    searchPixel(details.globalPosition);
                    setState(() {
                      left_value = details.globalPosition.dx - 55;
                      top_value = details.globalPosition.dy - 55;
                    });
                  },
                  child: Center(
                    child: Image.file(
                      // imagePath,
                      File(widget.test_path),
                      height: MediaQuery.of(context).size.height,
                      key: imageKey,
                      //color: Colors.red,
                      //colorBlendMode: BlendMode.hue,
                      //alignment: Alignment.bottomRight,
                      // fit: BoxFit.none,
                      fit: BoxFit.fill,
                      // scale: .8,
                    ),
                  ),
                ),
              );
            },
          ),
          Positioned(
            left: left_value,
            top: top_value,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
                border: Border.all(
                  width: 3,
                  color: (top_value == 0 && left_value == 0)
                      ? Colors.transparent
                      : selectedColor,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(40),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (top_value == 0 && left_value == 0)
                        ? Colors.transparent
                        : Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 200,
            child: Text(
              "리트머스를 클릭해주세요",
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    color: Colors.black,
                    offset: Offset(0.0, 0.0),
                  ),
                ],
                // fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
      floatingActionButton: _floatingActionButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  _floatingActionButton(context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 120,
          width: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: selectedColor.withOpacity(0.3),
          ),
        ),
        Container(
          height: 100,
          width: 100,
          child: FloatingActionButton(
            backgroundColor: selectedColor,
            child: Text(
              "확인",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
            ),
            onPressed: () {
              print(selectedColor);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResultPage(
                    color_code: selectedColor,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void searchPixel(Offset globalPosition) async {
    if (photo == null) {
      await (useSnapshot ? loadSnapshotBytes() : loadImageBundleBytes());
    }
    _calculatePixel(globalPosition);
  }

  void _calculatePixel(Offset globalPosition) {
    RenderBox box = currentKey.currentContext.findRenderObject();
    Offset localPosition = box.globalToLocal(globalPosition);

    double px = localPosition.dx;
    double py = localPosition.dy;

    if (!useSnapshot) {
      double widgetScale = box.size.width / photo.width;
      print(py);
      px = (px / widgetScale);
      py = (py / widgetScale);
    }

    int pixel32 = photo.getPixelSafe(px.toInt(), py.toInt());
    int hex = abgrToArgb(pixel32);

    _stateController.add(Color(hex));
  }

  Future<void> loadImageBundleBytes() async {
    // ByteData imageBytes = await rootBundle.load(imagePath);
    ByteData imageBytes = await rootBundle.load(widget.test_path);
    setImageBytes(imageBytes);
  }

  Future<void> loadSnapshotBytes() async {
    RenderRepaintBoundary boxPaint = paintKey.currentContext.findRenderObject();
    ui.Image capture = await boxPaint.toImage();
    ByteData imageBytes =
        await capture.toByteData(format: ui.ImageByteFormat.png);
    setImageBytes(imageBytes);
    capture.dispose();
  }

  void setImageBytes(ByteData imageBytes) {
    List<int> values = imageBytes.buffer.asUint8List();
    photo = null;
    photo = img.decodeImage(values);
  }
}

// image lib uses uses KML color format, convert #AABBGGRR to regular #AARRGGBB
int abgrToArgb(int argbColor) {
  int r = (argbColor >> 16) & 0xFF;
  int b = argbColor & 0xFF;
  return (argbColor & 0xFF00FF00) | (b << 16) | r;
}
