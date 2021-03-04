import 'package:flutter/material.dart';

import 'Index.dart';

class ResultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                // Background
                _backGround(),
                // 측정값 & 인디케이터
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: Column(),
          ),
        ],
      ),
      floatingActionButton: _floatingActionButton(context),
    );
  }

  _appBar(context) {
    return AppBar(
      title: Text('DupiPH'),
      elevation: 0,
      backgroundColor: Color(0xff34a1ae),
      actions: [
        IconButton(
            icon: Icon(
              Icons.home,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => IndexPage()),
              );
            })
      ],
    );
  }

  _backGround() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xff34a1ae),
            Color(0xff007f8d),
          ],
        ),
      ),
    );
  }

  _floatingActionButton(context) {
    return FloatingActionButton.extended(
      backgroundColor: Color(0xff34a1ae),
      icon: Icon(
        Icons.shopping_cart,
        size: 30,
      ),
      label: Text(
        '제품 추천받기',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: () {
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => 상품페이지()));
      },
    );
  }
}
