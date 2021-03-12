import 'package:flutter/material.dart';

import '../SQLite/Model.dart';
import '../SQLite/Database.dart';

class InfoPage_DB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DB List'),
      ),
      body: FutureBuilder<List<Result>>(
        future: DBProvider.db.getAllClients(),
        builder: (BuildContext context, AsyncSnapshot<List<Result>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                Result item = snapshot.data[index];
                return ListTile(
                  title: Text("${item.id}"),
                  leading: Text(item.colorCode),
                  subtitle: Text(item.date),
                  trailing: Text(item.grade),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
