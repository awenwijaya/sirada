// To parse this JSON data, do
//
//     final tempatUsaha = tempatUsahaFromJson(jsonString);

import 'dart:convert';

TempatUsaha tempatUsahaFromJson(String str) => TempatUsaha.fromJson(json.decode(str));

String tempatUsahaToJson(TempatUsaha data) => json.encode(data.toJson());

class TempatUsaha {
  TempatUsaha({
    this.status,
    this.message,
    this.data,
  });

  String status;
  String message;
  List<Datum> data;

  factory TempatUsaha.fromJson(Map<String, dynamic> json) => TempatUsaha(
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
    this.idTempatUsaha,
    this.namaUsaha,
    this.jenisUsaha,
    this.alamatUsaha,
    this.dusunId,
    this.pendudukId,
    this.foto,
  });

  int idTempatUsaha;
  String namaUsaha;
  String jenisUsaha;
  String alamatUsaha;
  int dusunId;
  int pendudukId;
  String foto;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    idTempatUsaha: json["id_tempat_usaha"],
    namaUsaha: json["nama_usaha"],
    jenisUsaha: json["jenis_usaha"],
    alamatUsaha: json["alamat_usaha"],
    dusunId: json["dusun_id"],
    pendudukId: json["penduduk_id"],
    foto: json["foto"],
  );

  Map<String, dynamic> toJson() => {
    "id_tempat_usaha": idTempatUsaha,
    "nama_usaha": namaUsaha,
    "jenis_usaha": jenisUsaha,
    "alamat_usaha": alamatUsaha,
    "dusun_id": dusunId,
    "penduduk_id": pendudukId,
    "foto": foto,
  };
}
