import 'dart:convert';

Result resultFromJson(String str) {
  final jsonData = json.decode(str);
  return Result.fromMap(jsonData);
}

String resultToJson(Result data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Result {
  int id;
  String date;
  String colorCode;
  String grade;

  Result({this.id, this.date, this.colorCode, this.grade});

  factory Result.fromMap(Map<String, dynamic> json) => new Result(
        id: json["id"],
        date: json['date'],
        colorCode: json['colorCode'],
        grade: json['grade'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'date': date,
        'colorCode': colorCode,
        'grade': grade,
      };
}
