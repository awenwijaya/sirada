// To parse this JSON data, do
//
//     final staff = staffFromJson(jsonString);

import 'dart:convert';

Staff staffFromJson(String str) => Staff.fromJson(json.decode(str));

String staffToJson(Staff data) => json.encode(data.toJson());

class Staff {
  Staff({
    this.status,
    this.message,
    this.data,
  });

  String status;
  String message;
  List<Datum> data;

  factory Staff.fromJson(Map<String, dynamic> json) => Staff(
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
    this.staffId,
    this.jabatanId,
    this.unitId,
    this.status,
    this.pendudukId,
    this.masaBerakhir,
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
    this.namaUnit,
    this.namaJabatan,
    this.kecamatanId,
    this.namaDesa,
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
    this.statusDesa,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  int staffId;
  int jabatanId;
  int unitId;
  String status;
  int pendudukId;
  DateTime masaBerakhir;
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
  String namaUnit;
  String namaJabatan;
  int kecamatanId;
  String namaDesa;
  String kodePos;
  String nomorRegisterDesa;
  String statusRegisterDesa;
  String alamatKantorDesa;
  String teleponKantorDesa;
  String faxKantorDesa;
  String emailDesa;
  String webDesa;
  int luasDesa;
  String sejarahDesa;
  String fileStrukturPem;
  String logoDesa;
  String kontakWaDesa;
  String desaJenis;
  String statusDesa;
  DateTime createdAt;
  dynamic updatedAt;
  dynamic deletedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    staffId: json["staff_id"],
    jabatanId: json["jabatan_id"],
    unitId: json["unit_id"],
    status: json["status"],
    pendudukId: json["penduduk_id"],
    masaBerakhir: json["masa_berakhir"] == null ? null : DateTime.parse(json["masa_berakhir"]),
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
    namaUnit: json["nama_unit"],
    namaJabatan: json["nama_jabatan"],
    kecamatanId: json["kecamatan_id"],
    namaDesa: json["nama_desa"],
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
    statusDesa: json["status_desa"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"],
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "staff_id": staffId,
    "jabatan_id": jabatanId,
    "unit_id": unitId,
    "status": status,
    "penduduk_id": pendudukId,
    "masa_berakhir": masaBerakhir == null ? null : "${masaBerakhir.year.toString().padLeft(4, '0')}-${masaBerakhir.month.toString().padLeft(2, '0')}-${masaBerakhir.day.toString().padLeft(2, '0')}",
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
    "nama_unit": namaUnit,
    "nama_jabatan": namaJabatan,
    "kecamatan_id": kecamatanId,
    "nama_desa": namaDesa,
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
    "status_desa": statusDesa,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt,
    "deleted_at": deletedAt,
  };
}