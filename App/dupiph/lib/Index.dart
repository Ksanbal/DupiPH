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
  final Color barBackgroundColor = const Color(0xffdfdfdf).withOpacity(0.43);
  final Duration animDuration = const Duration(milliseconds: 250);

  int touchedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      drawer: _drawer(context),
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
                SizedBox(height: 20),
                // Date Text
                _dateText(),
                // PH
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
          flex: 3,
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
      children: [
        Container(
          height: 20,
          width: 5,
          color: Colors.white,
        ),
        SizedBox(width: 20),
        Text(
          '나의 일주일간 ',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
        Text(
          '두피상태',
          style: TextStyle(
            color: Colors.yellow,
            fontSize: 25,
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
  }

  // Date Text
  _dateText() {
    List weekday = ['월', '화', '수', '목', '금', '토', '일'];

    return Row(
      children: [
        Text(
          '${DateFormat('MM월 dd일').format(DateTime.now())}',
          style: TextStyle(fontSize: 20),
        ),
        Text(
          '(${weekday[DateTime.now().weekday - 1]})',
          style: TextStyle(fontSize: 20),
        ),
      ],
    );
  }

  // Chart---------------------------------------
  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color barColor = const Color(0xffdfdfdf),
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: isTouched ? y + 1 : y,
          colors: isTouched ? [Color(0xfff3d386)] : [barColor],
          width: width,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            y: 20,
            colors: [barBackgroundColor],
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(7, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, 5, isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(1, 6.5, isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(2, 5, isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(3, 7.5, isTouched: i == touchedIndex);
          case 4:
            return makeGroupData(4, 9, isTouched: i == touchedIndex);
          case 5:
            return makeGroupData(5, 11.5, isTouched: i == touchedIndex);
          case 6:
            return makeGroupData(6, 6.5, isTouched: i == touchedIndex);
          default:
            return null;
        }
      });

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.blueGrey,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String weekDay;
              switch (group.x.toInt()) {
                case 0:
                  weekDay = '월요일';
                  break;
                case 1:
                  weekDay = '화요일';
                  break;
                case 2:
                  weekDay = '수요일';
                  break;
                case 3:
                  weekDay = '목요일';
                  break;
                case 4:
                  weekDay = '금요일';
                  break;
                case 5:
                  weekDay = '토요일';
                  break;
                case 6:
                  weekDay = '일요일';
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
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),
          margin: 16,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 0:
                return '월';
              case 1:
                return '화';
              case 2:
                return '수';
              case 3:
                return '목';
              case 4:
                return '금';
              case 5:
                return '토';
              case 6:
                return '일';
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
