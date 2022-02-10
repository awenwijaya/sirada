// To parse this JSON data, do
//
//     final jabatan = jabatanFromJson(jsonString);

import 'dart:convert';

Jabatan jabatanFromJson(String str) => Jabatan.fromJson(json.decode(str));

String jabatanToJson(Jabatan data) => json.encode(data.toJson());

class Jabatan {
  Jabatan({
    this.status,
    this.message,
    this.data,
  });

  String status;
  String message;
  List<Datum> data;

  factory Jabatan.fromJson(Map<String, dynamic> json) => Jabatan(
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
    this.jabatanId,
    this.namaJabatan,
  });

  int jabatanId;
  String namaJabatan;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    jabatanId: json["jabatan_id"],
    namaJabatan: json["nama_jabatan"],
  );

  Map<String, dynamic> toJson() => {
    "jabatan_id": jabatanId,
    "nama_jabatan": namaJabatan,
  };
}