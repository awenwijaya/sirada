// To parse this JSON data, do
//
//     final skTempatUsaha = skTempatUsahaFromJson(jsonString);

import 'dart:convert';

SkTempatUsaha skTempatUsahaFromJson(String str) => SkTempatUsaha.fromJson(json.decode(str));

String skTempatUsahaToJson(SkTempatUsaha data) => json.encode(data.toJson());

class SkTempatUsaha {
  SkTempatUsaha({
    this.status,
    this.message,
    this.data,
  });

  String status;
  String message;
  List<Datum> data;

  factory SkTempatUsaha.fromJson(Map<String, dynamic> json) => SkTempatUsaha(
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
    this.idSkTempatUsaha,
    this.pemohonId,
    this.idTempatUsaha,
    this.suratMasyarakatId,
    this.status,
    this.masterSuratId,
    this.tanggalPengajuan,
    this.tanggalPengesahan,
    this.desaId,
    this.namaUsaha,
    this.jenisUsaha,
    this.alamatUsaha,
    this.dusunId,
    this.foto,
    this.pendudukId,
    this.namaDesa,
    this.kodeWilayahDesa,
    this.kodePos,
    this.nomorRegisterDesa,
    this.statusRegisterDesa,
    this.alamatKantorDesa,
    this.teleponKantorDesa,
    this.faxKantorDesa,
    this.emailDesa,
    this.webDesa,
    this.luasDesa,
    this.sejarahDesa,
    this.fileStrukturPem,
    this.logoDesa,
    this.kontakWaDesa,
    this.desaJenis,
    this.kecamatanId,
    this.statusDesa,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.namaDusun,
    this.deleteAt,
  });

  int idSkTempatUsaha;
  int pemohonId;
  int idTempatUsaha;
  int suratMasyarakatId;
  String status;
  dynamic masterSuratId;
  DateTime tanggalPengajuan;
  dynamic tanggalPengesahan;
  int desaId;
  String namaUsaha;
  String jenisUsaha;
  String alamatUsaha;
  int dusunId;
  String foto;
  int pendudukId;
  String namaDesa;
  dynamic kodeWilayahDesa;
  dynamic kodePos;
  dynamic nomorRegisterDesa;
  dynamic statusRegisterDesa;
  dynamic alamatKantorDesa;
  dynamic teleponKantorDesa;
  dynamic faxKantorDesa;
  dynamic emailDesa;
  dynamic webDesa;
  dynamic luasDesa;
  dynamic sejarahDesa;
  dynamic fileStrukturPem;
  dynamic logoDesa;
  dynamic kontakWaDesa;
  String desaJenis;
  int kecamatanId;
  String statusDesa;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  String namaDusun;
  dynamic deleteAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    idSkTempatUsaha: json["id_sk_tempat_usaha"],
    pemohonId: json["pemohon_id"],
    idTempatUsaha: json["id_tempat_usaha"],
    suratMasyarakatId: json["surat_masyarakat_id"],
    status: json["status"],
    masterSuratId: json["master_surat_id"],
    tanggalPengajuan: DateTime.parse(json["tanggal_pengajuan"]),
    tanggalPengesahan: json["tanggal_pengesahan"],
    desaId: json["desa_id"],
    namaUsaha: json["nama_usaha"],
    jenisUsaha: json["jenis_usaha"],
    alamatUsaha: json["alamat_usaha"],
    dusunId: json["dusun_id"],
    foto: json["foto"] == null ? null : json["foto"],
    pendudukId: json["penduduk_id"],
    namaDesa: json["nama_desa"],
    kodeWilayahDesa: json["kode_wilayah_desa"],
    kodePos: json["kode_pos"],
    nomorRegisterDesa: json["nomor_register_desa"],
    statusRegisterDesa: json["status_register_desa"],
    alamatKantorDesa: json["alamat_kantor_desa"],
    teleponKantorDesa: json["telepon_kantor_desa"],
    faxKantorDesa: json["fax_kantor_desa"],
    emailDesa: json["email_desa"],
    webDesa: json["web_desa"],
    luasDesa: json["luas_desa"],
    sejarahDesa: json["sejarah_desa"],
    fileStrukturPem: json["file_struktur_pem"],
    logoDesa: json["logo_desa"],
    kontakWaDesa: json["kontak_wa_desa"],
    desaJenis: json["desa_jenis"],
    kecamatanId: json["kecamatan_id"],
    statusDesa: json["status_desa"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    namaDusun: json["nama_dusun"],
    deleteAt: json["delete_at"],
  );

  Map<String, dynamic> toJson() => {
    "id_sk_tempat_usaha": idSkTempatUsaha,
    "pemohon_id": pemohonId,
    "id_tempat_usaha": idTempatUsaha,
    "surat_masyarakat_id": suratMasyarakatId,
    "status": status,
    "master_surat_id": masterSuratId,
    "tanggal_pengajuan": "${tanggalPengajuan.year.toString().padLeft(4, '0')}-${tanggalPengajuan.month.toString().padLeft(2, '0')}-${tanggalPengajuan.day.toString().padLeft(2, '0')}",
    "tanggal_pengesahan": tanggalPengesahan,
    "desa_id": desaId,
    "nama_usaha": namaUsaha,
    "jenis_usaha": jenisUsaha,
    "alamat_usaha": alamatUsaha,
    "dusun_id": dusunId,
    "foto": foto == null ? null : foto,
    "penduduk_id": pendudukId,
    "nama_desa": namaDesa,
    "kode_wilayah_desa": kodeWilayahDesa,
    "kode_pos": kodePos,
    "nomor_register_desa": nomorRegisterDesa,
    "status_register_desa": statusRegisterDesa,
    "alamat_kantor_desa": alamatKantorDesa,
    "telepon_kantor_desa": teleponKantorDesa,
    "fax_kantor_desa": faxKantorDesa,
    "email_desa": emailDesa,
    "web_desa": webDesa,
    "luas_desa": luasDesa,
    "sejarah_desa": sejarahDesa,
    "file_struktur_pem": fileStrukturPem,
    "logo_desa": logoDesa,
    "kontak_wa_desa": kontakWaDesa,
    "desa_jenis": desaJenis,
    "kecamatan_id": kecamatanId,
    "status_desa": statusDesa,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
    "nama_dusun": namaDusun,
    "delete_at": deleteAt,
  };
}