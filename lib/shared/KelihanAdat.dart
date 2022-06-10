// To parse this JSON data, do
//
//     final kelihanAdat = kelihanAdatFromJson(jsonString);

import 'dart:convert';

List<KelihanAdat> kelihanAdatFromJson(String str) => List<KelihanAdat>.from(json.decode(str).map((x) => KelihanAdat.fromJson(x)));

String kelihanAdatToJson(List<KelihanAdat> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class KelihanAdat {
  KelihanAdat({
    this.namaBanjarAdat,
    this.prajuruBanjarAdatId,
    this.nama,
  });

  String namaBanjarAdat;
  String prajuruBanjarAdatId;
  String nama;

  factory KelihanAdat.fromJson(Map<String, dynamic> json) => KelihanAdat(
    namaBanjarAdat: json["nama_banjar_adat"],
    prajuruBanjarAdatId: json["prajuru_banjar_adat_id"].toString(),
    nama: json["nama"],
  );

  Map<String, dynamic> toJson() => {
    "nama_banjar_adat": namaBanjarAdat,
    "prajuru_banjar_adat_id": prajuruBanjarAdatId,
    "nama": nama,
  };
}
