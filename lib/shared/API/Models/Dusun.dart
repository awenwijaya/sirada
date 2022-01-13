// To parse this JSON data, do
//
//     final dusun = dusunFromJson(jsonString);

import 'dart:convert';

Dusun dusunFromJson(String str) => Dusun.fromJson(json.decode(str));

String dusunToJson(Dusun data) => json.encode(data.toJson());

class Dusun {
  Dusun({
    this.status,
    this.message,
    this.data,
  });

  String status;
  String message;
  List<Datum> data;

  factory Dusun.fromJson(Map<String, dynamic> json) => Dusun(
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
    this.dusunId,
    this.namaDusun,
    this.desaId,
    this.createdAt,
    this.updatedAt,
    this.deleteAt,
  });

  int dusunId;
  String namaDusun;
  int desaId;
  DateTime createdAt;
  dynamic updatedAt;
  dynamic deleteAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    dusunId: json["dusun_id"],
    namaDusun: json["nama_dusun"],
    desaId: json["desa_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"],
    deleteAt: json["delete_at"],
  );

  Map<String, dynamic> toJson() => {
    "dusun_id": dusunId,
    "nama_dusun": namaDusun,
    "desa_id": desaId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt,
    "delete_at": deleteAt,
  };
}
