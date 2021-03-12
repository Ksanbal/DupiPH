import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import 'Index.dart';

class ResultPage extends StatefulWidget {
  ResultPage({Key key, this.color_code}) : super(key: key);
  final Color color_code;

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    print(widget.color_code);

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 4000,
      ),
    );

    _animation = Tween<double>(
      begin: 0,
      end: 85,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn))
      ..addListener(() {
        setState(() {});
      });

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      // body: Column(
      //   children: [
      //     Expanded(
      //       flex: 5,
      //       child: Container(
      //         width: MediaQuery.of(context).size.width,
      //         color: Color(0xff34A1AE),
      //         child: Column(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: [
      //             // 측정결과 Text
      //             _titleText(),
      //             // DateText
      //             // SizedBox(height: 5),
      //             _dateText(),
      //             // indicator
      //             SizedBox(height: 20),
      //             Stack(
      //               alignment: Alignment.center,
      //               children: [
      //                 // 원형 인디케이터
      //                 _circleIndicator(),
      //                 // 인디케이터 안쪽을 자르기위한 컨테이너
      //                 Container(
      //                   height: 220,
      //                   width: 220,
      //                   decoration: BoxDecoration(
      //                     color: Color(0xff34A1AE),
      //                     shape: BoxShape.circle,
      //                   ),
      //                 ),
      //                 // 인디케이터 내부 텍스트
      //                 _circleText(),
      //               ],
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //     Expanded(
      //       flex: 3,
      //       child: Padding(
      //         padding: EdgeInsets.all(20),
      //         child: Column(
      //           mainAxisAlignment: MainAxisAlignment.start,
      //           children: [
      //             Row(
      //               children: [
      //                 Container(
      //                   height: 18,
      //                   width: 5,
      //                   color: Colors.black,
      //                 ),
      //                 SizedBox(width: 20),
      //                 Text(
      //                   '두피상태',
      //                   style: TextStyle(
      //                     color: Colors.black,
      //                     fontSize: 18,
      //                   ),
      //                 ),
      //               ],
      //             ),
      //             SizedBox(
      //               height: 20,
      //             ),
      //             // 지성 - 건성 인디케이터
      //             _barIndicator(),
      //           ],
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
      body: Stack(
        children: [
          // background
          Column(
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: Color(0xff34A1AE),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  color: Colors.white,
                ),
              ),
            ],
          ),
          // 본문
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              // 측정결과 Text
              _titleText(),
              // DateText
              // SizedBox(height: 5),
              _dateText(),
              // indicator
              SizedBox(height: 20),
              Stack(
                alignment: Alignment.center,
                children: [
                  // 원형 인디케이터
                  _circleIndicator(),
                  // 인디케이터 안쪽을 자르기위한 컨테이너
                  Container(
                    height: 220,
                    width: 220,
                    decoration: BoxDecoration(
                      color: Color(0xff34A1AE),
                      shape: BoxShape.circle,
                    ),
                  ),
                  // 인디케이터 내부 텍스트
                  _circleText(),
                ],
              ),
              SizedBox(height: 15),
              // 두피상태
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    elevation: 0,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 125,
                        right: 125,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '두피상태',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // PH 그래프
              Expanded(
                flex: 4,
                child: Padding(
                  padding: EdgeInsets.only(left: 25, right: 25),
                  // 지성 - 건성 인디케이터
                  child: _barIndicator(),
                ),
              ),
              Spacer(flex: 3),
            ],
          ),
        ],
      ),
      floatingActionButton: _floatingActionButton(context),
    );
  }

  _appBar(context) {
    return AppBar(
      title: Text('DupiPH'),
      centerTitle: true,
      elevation: 0,
      backgroundColor: Color(0xff34a1ae),
      // leading: IconButton(
      //     icon: Icon(
      //       Icons.refresh,
      //       color: Colors.white,
      //     ),
      //     onPressed: () {
      //       Navigator.pop(context);
      //     }),
      actions: [
        IconButton(
            icon: Icon(
              Icons.home,
              size: 35,
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
        // color: Colors.white,
        color: Color(0xff7DEFFC),
      ),
    );
  }

  _dateText() {
    List weekday = ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'];
    return Text(
      '${DateFormat('yyyy.MM.dd').format(DateTime.now())}  ${weekday[DateTime.now().weekday - 1]}',
      style: TextStyle(
        fontSize: 25,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  _circleIndicator() {
    return Container(
      width: 250,
      height: 250,
      // decoration: BoxDecoration(
      //   shape: BoxShape.circle,
      // ),
      child: CircularStepProgressIndicator(
          totalSteps: 100,
          currentStep: _animation.value.toInt(),
          selectedColor: Color(0xff7DEFFC),
          unselectedColor: Color(0xff146A74),
          padding: 0,
          width: 250,
          height: 250,
          stepSize: 10,
          selectedStepSize: 20,
          child: Center(
            child: Container(
              height: 190,
              width: 190,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 10,
                  color: Colors.transparent,
                ),
                color: Colors.white,
              ),
              // child: Column(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Text(
              //       '모발 손상도',
              //       style: TextStyle(
              //         fontSize: 15,
              //         color: Color(0xff325054),
              //         fontWeight: FontWeight.bold,
              //       ),
              //     ),
              //     Text(
              //       '15%',
              //       style: TextStyle(
              //         fontSize: 60,
              //         color: Color(0xff325054),
              //         fontWeight: FontWeight.bold,
              //       ),
              //     ),
              //     Text(
              //       '이대로 유지해주세요.',
              //       style: TextStyle(
              //         fontSize: 15,
              //         color: Color(0xff0099A3),
              //         fontWeight: FontWeight.w100,
              //         // letterSpacing: 5,
              //       ),
              //     ),
              //   ],
              // ),
            ),
          )),
    );
  }

  _circleText() {
    return Container(
      child: Container(
        height: 200,
        width: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '모발 손상도',
              style: TextStyle(
                fontSize: 17,
                color: Color(0xff325054),
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '15%',
              style: TextStyle(
                fontSize: 60,
                color: Color(0xff325054),
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '이대로 유지해주세요.',
              style: TextStyle(
                fontSize: 15,
                color: Color(0xff0099A3),
                fontWeight: FontWeight.w100,
                // letterSpacing: 5,
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
        // 표시기
        Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 100 * 19.5,
            ),
            Container(
              height: 60,
              width: 90,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Column(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          width: 120,
                          decoration: BoxDecoration(
                            color: Color(0xffce9014),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          child: Center(
                            child: Text(
                              "PH 5.0",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Spacer(
                        flex: 2,
                      ),
                    ],
                  ),
                  Container(
                    height: 30,
                    width: 3,
                    decoration: BoxDecoration(
                      color: Color(0xffce9014),
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    ),
                  ),
                  Container(
                    height: 8,
                    width: 8,
                    decoration: BoxDecoration(
                      color: Color(0xffce9014),
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 5),
        // 인디케이터
        StepProgressIndicator(
          totalSteps: 10,
          currentStep: 10,
          size: 25,
          padding: 2.0,
          roundedEdges: Radius.circular(10),
          selectedGradientColor: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color(0xffd86565),
              Color(0xffE6B05D),
              Color(0xffECB915),
              Color(0xffCFC628),
              Color(0xff77C9A3),
              Color(0xff6AA0C9),
              Color(0xff7464b7),
            ],
          ),
          unselectedGradientColor: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xff77C9A3)],
          ),
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
