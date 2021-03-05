import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import 'Index.dart';

class ResultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                // Background
                _backGround(),
                // 측정값 & 인디케이터
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // 측정결과 Text
                    _titleText(),
                    // DateText
                    SizedBox(height: 5),
                    _dateText(),
                    // indicator
                    SizedBox(height: 20),
                    _circleIndicator(),
                    SizedBox(height: 10),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 지성 - 건성 인디케이터
                  _barIndicator(),
                ],
              ),
            ),
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
      leading: IconButton(
          icon: Icon(
            Icons.refresh,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          }),
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

  _titleText() {
    return Text(
      '측정결과',
      style: TextStyle(
        fontSize: 17,
        color: Colors.white,
      ),
    );
  }

  _dateText() {
    List weekday = ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${DateFormat('yyyy.MM.dd').format(DateTime.now())}  ',
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '${weekday[DateTime.now().weekday - 1]}',
          style: TextStyle(
            fontSize: 23,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  _circleIndicator() {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: CircularStepProgressIndicator(
        totalSteps: 100,
        currentStep: 74,
        stepSize: 10,
        selectedColor: Color(0xff5ee0ef),
        unselectedColor: Colors.grey[200],
        padding: 0,
        width: 150,
        height: 150,
        selectedStepSize: 15,
        roundedCap: (_, __) => true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '적정',
              style: TextStyle(
                fontSize: 40,
                color: Color(0xff2f7078),
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '이대로 유지해주세요.',
              style: TextStyle(
                fontSize: 15,
                color: Color(0xff2f7078),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _barIndicator() {
    return Column(
      children: [
        StepProgressIndicator(
          totalSteps: 15,
          currentStep: 12,
          size: 20,
          selectedColor: Colors.amber,
          unselectedColor: Colors.black,
          roundedEdges: Radius.circular(10),
          gradientColor: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomRight,
              colors: [Color(0xffd86565), Color(0xff7464b7)]),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '지성',
              style: TextStyle(
                color: Color(0xffd86565),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '건성',
              style: TextStyle(
                color: Color(0xff7464b7),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        )
      ],
    );
  }
}
