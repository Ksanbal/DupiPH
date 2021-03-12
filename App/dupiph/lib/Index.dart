import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';

import 'Menu_Items/Cop_info.dart';
import 'Menu_Items/Ser_info.dart';
import 'Menu_Items/DB_info.dart';
import 'Camera.dart';

class IndexPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final Color barBackgroundColor = const Color(0xffdfdfdf).withOpacity(0.43);
  final Duration animDuration = const Duration(milliseconds: 250);

  int touchedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: _appBar(),
      drawer: _drawer(context),
      // body: Column(
      //   mainAxisAlignment: MainAxisAlignment.start,
      //   children: [
      //     // 최근 검사기록 차트
      //     Expanded(
      //       flex: 4,
      //       child: Container(
      //         color: Color(0xff34a1ae),
      //         child: Padding(
      //           padding:
      //               EdgeInsets.only(left: 30, right: 30, bottom: 5, top: 10),
      //           child: Column(
      //             children: [
      //               // Dupi Text
      //               _textDupi(),
      //               SizedBox(height: 5),
      //               // Chart
      //               _chart(),
      //             ],
      //           ),
      //         ),
      //       ),
      //     ),
      //     // 현재 날짜, 최신 or 선택 날짜 데이터
      //     Expanded(
      //       flex: 5,
      //       child: Padding(
      //         padding:
      //             EdgeInsets.only(left: 30, right: 30, bottom: 30, top: 20),
      //         child: Column(
      //           children: [
      //             // PH
      //             // Date
      //             _dateText(),
      //             SizedBox(height: 10),
      //             // Box
      // _alrtBox(),
      // SizedBox(height: 20),
      // _phIndi(),
      // SizedBox(height: 15),
      // _dmIndi(),
      //           ],
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
      body: Stack(
        children: [
          // Background Color
          _backGround(),
          // Widget Column
          Padding(
            padding: EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Dupi Text
                _textDupi(),
                SizedBox(height: 10),
                // Chart
                _chart(),
                SizedBox(height: 25),
                // Date Text
                _dateText(),
                SizedBox(height: 10),
                // PH
                _alrtBox(),
                SizedBox(height: 20),
                _phIndi(),
                SizedBox(height: 15),
                _dmIndi(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: _floatingActionButton(context),
    );
  }

  // AppBar
  _appBar() {
    return AppBar(
      title: Text('DupiPH'),
      centerTitle: true,
      backgroundColor: Color(0xff34a1ae),
      elevation: 0,
      leading: IconButton(
          icon: Icon(Icons.menu, size: 35),
          onPressed: () {
            _scaffoldKey.currentState.openDrawer();
          }),
    );
  }

  // Drawer
  _drawer(context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              '메뉴',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
            ),
            decoration: BoxDecoration(
              color: Color(0xff34a1ae),
            ),
          ),
          ListTile(
            title: Text(
              '회사소개',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InfoPage_Cop(),
                ),
              );
            },
          ),
          ListTile(
            title: Text(
              '서비스 소개',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InfoPage_Ser(),
                ),
              );
            },
          ),
          ListTile(
            title: Text(
              'DB list',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InfoPage_DB(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // Floating Action btn
  _floatingActionButton(context) {
    return FloatingActionButton.extended(
      backgroundColor: Color(0xff34a1ae),
      label: Text(
        '오늘의 두피는?',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      icon: Icon(
        Icons.touch_app,
        size: 30,
      ),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => CameraPage()));
      },
    );
  }

  // Background
  _backGround() {
    return Column(
      children: [
        Expanded(
          flex: 4,
          child: Container(
            color: Color(0xff34a1ae),
          ),
        ),
        Expanded(
          flex: 6,
          child: Container(
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  // Dupi Text
  _textDupi() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 20,
          width: 5,
          color: Colors.white,
        ),
        SizedBox(width: 10),
        Text(
          '최근 검사기록',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ],
    );
  }

  // Chart Section
  _chart() {
    return Container(
      height: 230,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0.5,
            blurRadius: 5,
            offset: Offset(0, 3),
          )
        ],
        color: Colors.white,
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(top: 20, bottom: 10),
          child: BarChart(
            mainBarData(),
            swapAnimationDuration: animDuration,
          ),
        ),
      ),
    );

    // return Expanded(
    //   child: Center(
    //     child: Padding(
    //       padding: EdgeInsets.only(top: 3),
    //       child: BarChart(
    //         mainBarData(),
    //         swapAnimationDuration: animDuration,
    //       ),
    //     ),
    //   ),
    // );
  }

  // Date Text
  _dateText() {
    List weekday = ['월', '화', '수', '목', '금', '토', '일'];

    return Row(
      children: [
        Container(
          height: 15,
          width: 5,
          color: Color(0xff34A1AE),
        ),
        SizedBox(width: 10),
        Text(
          '${DateFormat('M월 d일').format(DateTime.now())} (${weekday[DateTime.now().weekday - 1]})',
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }

  // 알림 박스
  _alrtBox() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 80,
      decoration: BoxDecoration(
        color: Color(0xffDC600E).withOpacity(0.27),
        // border: Border.all(
        //   width: 10,
        //   color: Color(0xffDC600E),
        // ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "주의",
            style: TextStyle(
              color: Color(0xffCB350E),
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "관리가 필요합니다.",
            style: TextStyle(
              color: Color(0xffCB350E),
              fontSize: 18,
            ),
          )
        ],
      ),
    );
  }

  // PH 지수
  _phIndi() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40,
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width - 50,
            height: 60,
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xff707070),
              ),
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          Container(
            width: (MediaQuery.of(context).size.width - 50) / 100 * 90,
            height: 60,
            decoration: BoxDecoration(
              color: Color(0xffFFF1CE),
              border: Border.all(
                color: Color(0xffE5AA1B),
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "PH6.5",
                    style: TextStyle(
                      color: Color(0xffECB020),
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(width: 15),
                ],
              ),
            ),
          ),
          Container(
            width: (MediaQuery.of(context).size.width - 50) / 100 * 30,
            height: 60,
            decoration: BoxDecoration(
              color: Color(0xffECB020),
              // border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Center(
              child: Text(
                'PH지수',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 손상도
  _dmIndi() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40,
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width - 50,
            height: 60,
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xff707070),
              ),
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          Container(
            width: (MediaQuery.of(context).size.width - 50) / 100 * 80,
            height: 60,
            decoration: BoxDecoration(
              color: Color(0xffE0EFF1),
              border: Border.all(
                color: Color(0xff34A1AE),
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "60%",
                    style: TextStyle(
                      color: Color(0xff34A1AE),
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(width: 15),
                ],
              ),
            ),
          ),
          Container(
            width: (MediaQuery.of(context).size.width - 50) / 100 * 30,
            height: 60,
            decoration: BoxDecoration(
              color: Color(0xff34A1AE),
              // border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Center(
              child: Text(
                '손상도',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Chart---------------------------------------
  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color barColor = const Color(0xffBED4D6),
    double width = 26,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: isTouched ? y + 3 : y,
          colors: isTouched ? [Color(0xfff3d386)] : [barColor],
          width: width,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            y: 14,
            // colors: [barBackgroundColor],
            colors: [Color(0xffffffff)],
          ),
          // borderRadius: BorderRadius.circular(10),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(7, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, 2, isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(1, 4, isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(2, 6, isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(3, 8, isTouched: i == touchedIndex);
          case 4:
            return makeGroupData(4, 10, isTouched: i == touchedIndex);
          case 5:
            return makeGroupData(5, 12, isTouched: i == touchedIndex);
          case 6:
            return makeGroupData(6, 14, isTouched: i == touchedIndex);

          default:
            return null;
        }
      });

  BarChartData mainBarData() {
    List weekday = ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'];

    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.blueGrey,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String weekDay;
              switch (group.x.toInt()) {
                case 0:
                  weekDay =
                      '${weekday[DateTime.now().subtract(Duration(days: 6)).weekday - 1]}';
                  break;
                case 1:
                  weekDay =
                      '${weekday[DateTime.now().subtract(Duration(days: 5)).weekday - 1]}';
                  break;
                case 2:
                  weekDay =
                      '${weekday[DateTime.now().subtract(Duration(days: 4)).weekday - 1]}';
                  break;
                case 3:
                  weekDay =
                      '${weekday[DateTime.now().subtract(Duration(days: 3)).weekday - 1]}';
                  break;
                case 4:
                  weekDay =
                      '${weekday[DateTime.now().subtract(Duration(days: 2)).weekday - 1]}';
                  break;
                case 5:
                  weekDay =
                      '${weekday[DateTime.now().subtract(Duration(days: 1)).weekday - 1]}';
                  break;
                case 6:
                  weekDay = '${weekday[DateTime.now().weekday - 1]}';
                  break;
              }
              return BarTooltipItem(weekDay + '\n' + (rod.y - 1).toString(),
                  TextStyle(color: Colors.yellow));
            }),
        touchCallback: (barTouchResponse) {
          setState(() {
            if (barTouchResponse.spot != null &&
                barTouchResponse.touchInput is! FlPanEnd &&
                barTouchResponse.touchInput is! FlLongPressEnd) {
              touchedIndex = barTouchResponse.spot.touchedBarGroupIndex;
            } else {
              touchedIndex = -1;
            }
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
              color: Colors.black, fontWeight: FontWeight.normal, fontSize: 14),
          margin: 8,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 0:
                return '${DateFormat('M.d').format(DateTime.now().subtract(Duration(days: 6)))}';
              case 1:
                return '${DateFormat('M.d').format(DateTime.now().subtract(Duration(days: 5)))}';
              case 2:
                return '${DateFormat('M.d').format(DateTime.now().subtract(Duration(days: 4)))}';
              case 3:
                return '${DateFormat('M.d').format(DateTime.now().subtract(Duration(days: 3)))}';
              case 4:
                return '${DateFormat('M.d').format(DateTime.now().subtract(Duration(days: 2)))}';
              case 5:
                return '${DateFormat('M.d').format(DateTime.now().subtract(Duration(days: 1)))}';
              case 6:
                return '${DateFormat('M.d').format(DateTime.now())}';
              default:
                return '';
            }
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
    );
  }
}
