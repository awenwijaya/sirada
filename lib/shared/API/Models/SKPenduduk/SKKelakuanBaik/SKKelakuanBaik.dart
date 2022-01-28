// To parse this JSON data, do
//
//     final skKelakuanBaik = skKelakuanBaikFromJson(jsonString);

import 'dart:convert';

SkKelakuanBaik skKelakuanBaikFromJson(String str) => SkKelakuanBaik.fromJson(json.decode(str));

String skKelakuanBaikToJson(SkKelakuanBaik data) => json.encode(data.toJson());

class SkKelakuanBaik {
  SkKelakuanBaik({
    this.status,
    this.message,
    this.data,
  });

  String status;
  String message;
  List<Datum> data;

  factory SkKelakuanBaik.fromJson(Map<String, dynamic> json) => SkKelakuanBaik(
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
    this.idSkKelakuanBaik,
    this.pendudukId,
    this.suratMasyarakatId,
    this.status,
    this.keperluan,
    this.masterSuratId,
    this.tanggalPengajuan,
    this.tanggalPengesahan,
    this.desaId,
  });

  int idSkKelakuanBaik;
  int pendudukId;
  int suratMasyarakatId;
  String status;
  String keperluan;
  dynamic masterSuratId;
  DateTime tanggalPengajuan;
  dynamic tanggalPengesahan;
  int desaId;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    idSkKelakuanBaik: json["id_sk_kelakuan_baik"],
    pendudukId: json["penduduk_id"],
    suratMasyarakatId: json["surat_masyarakat_id"],
    status: json["status"],
    keperluan: json["keperluan"],
    masterSuratId: json["master_surat_id"],
    tanggalPengajuan: DateTime.parse(json["tanggal_pengajuan"]),
    tanggalPengesahan: json["tanggal_pengesahan"],
    desaId: json["desa_id"],
  );

  Map<String, dynamic> toJson() => {
    "id_sk_kelakuan_baik": idSkKelakuanBaik,
    "penduduk_id": pendudukId,
    "surat_masyarakat_id": suratMasyarakatId,
    "status": status,
    "keperluan": keperluan,
    "master_surat_id": masterSuratId,
    "tanggal_pengajuan": "${tanggalPengajuan.year.toString().padLeft(4, '0')}-${tanggalPengajuan.month.toString().padLeft(2, '0')}-${tanggalPengajuan.day.toString().padLeft(2, '0')}",
    "tanggal_pengesahan": tanggalPengesahan,
    "desa_id": desaId,
  };
}
