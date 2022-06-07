// To parse this JSON data, do
//
//     final kelihanAdat = kelihanAdatFromJson(jsonString);

import 'dart:convert';

List<KelihanAdat> kelihanAdatFromJson(String str) => List<KelihanAdat>.from(json.decode(str).map((x) => KelihanAdat.fromJson(x)));

String kelihanAdatToJson(List<KelihanAdat> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class KelihanAdat {
  KelihanAdat({
    this.prajuruBanjarAdatId,
    this.nik,
    this.nama,
  });

  int prajuruBanjarAdatId;
  String nik;
  String nama;

  factory KelihanAdat.fromJson(Map<String, dynamic> json) => KelihanAdat(
    prajuruBanjarAdatId: json["prajuru_banjar_adat_id"],
    nik: json["nik"],
    nama: json["nama"],
  );

  Map<String, dynamic> toJson() => {
    "prajuru_banjar_adat_id": prajuruBanjarAdatId,
    "nik": nik,
    "nama": nama,
  };
}
