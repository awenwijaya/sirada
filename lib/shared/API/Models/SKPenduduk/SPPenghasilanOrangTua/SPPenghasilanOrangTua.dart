// To parse this JSON data, do
//
//     final spPenghasilanOrangTua = spPenghasilanOrangTuaFromJson(jsonString);

import 'dart:convert';

SpPenghasilanOrangTua spPenghasilanOrangTuaFromJson(String str) => SpPenghasilanOrangTua.fromJson(json.decode(str));

String spPenghasilanOrangTuaToJson(SpPenghasilanOrangTua data) => json.encode(data.toJson());

class SpPenghasilanOrangTua {
  SpPenghasilanOrangTua({
    this.status,
    this.message,
    this.data,
  });

  String status;
  String message;
  List<Datum> data;

  factory SpPenghasilanOrangTua.fromJson(Map<String, dynamic> json) => SpPenghasilanOrangTua(
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
    this.idSpPenghasilan,
    this.orangTuaId,
    this.pendudukId,
    this.jumlahPenghasilan,
    this.suratMasyarakatId,
    this.status,
    this.keperluan,
    this.masterSuratId,
    this.tanggalPengajuan,
    this.tanggalPengesahan,
    this.desaId,
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
  });

  int idSpPenghasilan;
  int orangTuaId;
  int pendudukId;
  int jumlahPenghasilan;
  int suratMasyarakatId;
  String status;
  String keperluan;
  dynamic masterSuratId;
  DateTime tanggalPengajuan;
  dynamic tanggalPengesahan;
  int desaId;
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

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    idSpPenghasilan: json["id_sp_penghasilan"],
    orangTuaId: json["orang_tua_id"],
    pendudukId: json["penduduk_id"],
    jumlahPenghasilan: json["jumlah_penghasilan"],
    suratMasyarakatId: json["surat_masyarakat_id"],
    status: json["status"],
    keperluan: json["keperluan"],
    masterSuratId: json["master_surat_id"],
    tanggalPengajuan: DateTime.parse(json["tanggal_pengajuan"]),
    tanggalPengesahan: json["tanggal_pengesahan"],
    desaId: json["desa_id"],
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
  );

  Map<String, dynamic> toJson() => {
    "id_sp_penghasilan": idSpPenghasilan,
    "orang_tua_id": orangTuaId,
    "penduduk_id": pendudukId,
    "jumlah_penghasilan": jumlahPenghasilan,
    "surat_masyarakat_id": suratMasyarakatId,
    "status": status,
    "keperluan": keperluan,
    "master_surat_id": masterSuratId,
    "tanggal_pengajuan": "${tanggalPengajuan.year.toString().padLeft(4, '0')}-${tanggalPengajuan.month.toString().padLeft(2, '0')}-${tanggalPengajuan.day.toString().padLeft(2, '0')}",
    "tanggal_pengesahan": tanggalPengesahan,
    "desa_id": desaId,
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
  };
}
