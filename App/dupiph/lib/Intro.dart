import 'package:flutter/material.dart';
import 'Index.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class IntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TypewriterAnimatedTextKit(
          text: [
            "당신의 두피관리",
            "DupiPH",
          ],
          textStyle: TextStyle(
            color: Colors.black,
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
          speed: Duration(milliseconds: 200),
          repeatForever: false,
          totalRepeatCount: 1,
          onTap: () {
            print('Tap Event');
          },
          onFinished: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => IndexPage()));
          },
        ),
      ),
    );
  }
}
