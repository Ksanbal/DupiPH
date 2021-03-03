import 'package:flutter/material.dart';

class IndexPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Chart
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.red,
              ),
            ),
            // List
            Expanded(
              flex: 3,
              child: Container(
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera),
        onPressed: () {},
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                '메뉴',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
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
                print('회사소개');
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
                print("서비스 소개");
              },
            ),
          ],
        ),
      ),
    );
  }

  // AppBar
  _appBar() {
    return AppBar(
      title: Text('DupiPH'),
    );
  }

  // Chart Section
  _Chart() {}

  // List Section
  _ListBuilder() {}
}
