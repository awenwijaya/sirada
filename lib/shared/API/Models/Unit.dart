// To parse this JSON data, do
//
//     final unit = unitFromJson(jsonString);

import 'dart:convert';

Unit unitFromJson(String str) => Unit.fromJson(json.decode(str));

String unitToJson(Unit data) => json.encode(data.toJson());

class Unit {
  Unit({
    this.status,
    this.message,
    this.data,
  });

  String status;
  String message;
  List<Datum> data;

  factory Unit.fromJson(Map<String, dynamic> json) => Unit(
    status: json["status"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.unitId,
    this.namaUnit,
  });

  int unitId;
  String namaUnit;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    unitId: json["unit_id"],
    namaUnit: json["nama_unit"],
  );

  Map<String, dynamic> toJson() => {
    "unit_id": unitId,
    "nama_unit": namaUnit,
  };
}
