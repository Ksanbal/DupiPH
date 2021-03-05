import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'Model.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    // db가 없으면 새로 생성
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "dupiphDB.db");

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute("CREATE TABLE result ("
            "id INTEGER PRIMARY KEY,"
            "date TEXT,"
            "colorCode TEXT,"
            "grade TEXT"
            ")");
      },
    );
  }

  // Create
  newResult(Result newResult) async {
    // 일반생성
    final db = await database;
    var res = await db.insert("result", newResult.toMap());
    return res;

    // 조건생성
    // get해서 Null? 일반 생성 : update
    // final db = await database;
    // var r_res = await db.rawQuery("");

    // if (r_res.isNotEmpty) {
    //   // update
    //   print(r_res);
    // } else {
    //   // create
    //   var c_res = await db.insert("result", newResult.toMap());
    //   return c_res;
    // }
  }

  // Read
  // 단독으로 가져올때
  getResult(int id) async {
    final db = await database;
    var res = await db.query('result', where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Result.fromMap(res.first) : Null;
  }

  // 일주일치 가져올때
  getWeekResult() async {
    final db = await database;
    var res = await db.rawQuery("");
    List<Result> list =
        res.isNotEmpty ? res.toList().map((c) => Result.fromMap(c)) : null;
    return list;
  }

  // 전부 가져올때
  getAllClients() async {
    final db = await database;
    var res = await db.query('result');
    List<Result> list =
        res.isNotEmpty ? res.map((c) => Result.fromMap(c)).toList() : [];

    return list;
  }
}
