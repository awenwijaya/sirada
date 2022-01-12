// To parse this JSON data, do
//
//     final orangTua = orangTuaFromJson(jsonString);

import 'dart:convert';

OrangTua orangTuaFromJson(String str) => OrangTua.fromJson(json.decode(str));

String orangTuaToJson(OrangTua data) => json.encode(data.toJson());

class OrangTua {
  OrangTua({
    this.status,
    this.message,
    this.data,
  });

  String status;
  String message;
  List<Datum> data;

  factory OrangTua.fromJson(Map<String, dynamic> json) => OrangTua(
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
    this.detailPendudukId,
    this.pendudukId,
    this.statusKeluarga,
    this.kartuKeluargaId,
    this.nik,
    this.namaLengkap,
    this.tempatLahir,
    this.tanggalLahir,
    this.alamat,
    this.agama,
    this.statusPerkawinan,
    this.pekerjaanId,
    this.kewarganegaraan,
    this.golonganDarah,
    this.jenisKelamin,
    this.pendidikanTerakhir,
    this.statusPenduduk,
    this.desaId,
  });

  int detailPendudukId;
  int pendudukId;
  String statusKeluarga;
  int kartuKeluargaId;
  String nik;
  String namaLengkap;
  String tempatLahir;
  DateTime tanggalLahir;
  String alamat;
  String agama;
  String statusPerkawinan;
  dynamic pekerjaanId;
  String kewarganegaraan;
  String golonganDarah;
  String jenisKelamin;
  String pendidikanTerakhir;
  String statusPenduduk;
  int desaId;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    detailPendudukId: json["detail_penduduk_id"],
    pendudukId: json["penduduk_id"],
    statusKeluarga: json["status_keluarga"],
    kartuKeluargaId: json["kartu_keluarga_id"],
    nik: json["nik"],
    namaLengkap: json["nama_lengkap"],
    tempatLahir: json["tempat_lahir"],
    tanggalLahir: DateTime.parse(json["tanggal_lahir"]),
    alamat: json["alamat"],
    agama: json["agama"],
    statusPerkawinan: json["status_perkawinan"],
    pekerjaanId: json["pekerjaan_id"],
    kewarganegaraan: json["kewarganegaraan"],
    golonganDarah: json["golongan_darah"],
    jenisKelamin: json["jenis_kelamin"],
    pendidikanTerakhir: json["pendidikan_terakhir"],
    statusPenduduk: json["status_penduduk"],
    desaId: json["desa_id"],
  );

  Map<String, dynamic> toJson() => {
    "detail_penduduk_id": detailPendudukId,
    "penduduk_id": pendudukId,
    "status_keluarga": statusKeluarga,
    "kartu_keluarga_id": kartuKeluargaId,
    "nik": nik,
    "nama_lengkap": namaLengkap,
    "tempat_lahir": tempatLahir,
    "tanggal_lahir": "${tanggalLahir.year.toString().padLeft(4, '0')}-${tanggalLahir.month.toString().padLeft(2, '0')}-${tanggalLahir.day.toString().padLeft(2, '0')}",
    "alamat": alamat,
    "agama": agama,
    "status_perkawinan": statusPerkawinan,
    "pekerjaan_id": pekerjaanId,
    "kewarganegaraan": kewarganegaraan,
    "golongan_darah": golonganDarah,
    "jenis_kelamin": jenisKelamin,
    "pendidikan_terakhir": pendidikanTerakhir,
    "status_penduduk": statusPenduduk,
    "desa_id": desaId,
  };
}
