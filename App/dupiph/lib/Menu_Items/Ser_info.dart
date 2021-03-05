import 'package:flutter/material.dart';

class InfoPage_Ser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('서비스 소개'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('서비스 소개입니다.'),
      ),
    );
  }
}
