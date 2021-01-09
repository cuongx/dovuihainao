// To parse this JSON data, do

import 'dart:convert';

List<List<Question>> appsFromJson(String str) => List<List<Question>>.from(json
    .decode(str)
    .map((x) => List<Question>.from(x.map((x) => Question.fromJson(x)))));

String appsToJson(List<List<Question>> data) => json.encode(List<dynamic>.from(
    data.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))));

class Question {
  Question({
    this.id,
    this.cauHoi,
    this.a,
    this.b,
    this.c,
    this.d,
    this.giaiThich,
    this.isvisible,
    this.uid,
    this.qtime,
    this.level,
  });

  String id;
  String cauHoi;
  String a;
  String b;
  String c;
  String d;
  String giaiThich;
  String isvisible;
  Uid uid;
  DateTime qtime;
  String level;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        id: json["ID"],
        cauHoi: json["CauHoi"],
        a: json["A"],
        b: json["B"],
        c: json["C"],
        d: json["D"],
        giaiThich: json["GiaiThich"],
        isvisible: json["isvisible"],
        uid: uidValues.map[json["uid"]],
        qtime: DateTime.parse(json["qtime"]),
        level: json["level"],
      );

  static List<Question> listFromJson(List<dynamic> listJson) =>
    listJson != null
        ? List<Question>.from(listJson.map((x) => Question.fromJson(x)))
        : [];

  Map<String, dynamic> toJson() => {
        "ID": id,
        "CauHoi": cauHoi,
        "A": a,
        "B": b,
        "C": c,
        "D": d,
        "GiaiThich": giaiThich,
        "isvisible": isvisible,
        "uid": uidValues.reverse[uid],
        "qtime":
            "${qtime.year.toString().padLeft(4, '0')}-${qtime.month.toString().padLeft(2, '0')}-${qtime.day.toString().padLeft(2, '0')}",
        "level": level,
      };
}

enum Uid { DEFAULT }

final uidValues = EnumValues({"default": Uid.DEFAULT});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
