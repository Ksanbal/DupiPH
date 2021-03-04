import 'package:flutter/material.dart';
import 'Index.dart';

class IntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.centerStart,
        children: [
          // 이미지 배경
          Container(
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              'images/Intro_background.jpeg',
              fit: BoxFit.fitHeight,
            ),
          ),
          // 그라데이션 컬러
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xff259f9b).withOpacity(0.65),
                  Color(0xff50f1b41).withOpacity(0.65),
                ],
              ),
            ),
          ),
          // Text
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '당신의 두피',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 31,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'DupiPH',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 47,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 40,
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => IndexPage()),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
