// To parse this JSON data, do
//
//     final penduduk = pendudukFromJson(jsonString);

import 'dart:convert';

Penduduk pendudukFromJson(String str) => Penduduk.fromJson(json.decode(str));

String pendudukToJson(Penduduk data) => json.encode(data.toJson());

class Penduduk {
  Penduduk({
    this.status,
    this.message,
    this.data,
  });

  String status;
  String message;
  List<Datum> data;

  factory Penduduk.fromJson(Map<String, dynamic> json) => Penduduk(
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
    this.pendudukId,
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

  int pendudukId;
  String namaLengkap;
  TempatLahir tempatLahir;
  String tanggalLahir;
  String alamat;
  Agama agama;
  StatusPerkawinan statusPerkawinan;
  int pekerjaanId;
  Kewarganegaraan kewarganegaraan;
  GolonganDarah golonganDarah;
  JenisKelamin jenisKelamin;
  PendidikanTerakhir pendidikanTerakhir;
  StatusPenduduk statusPenduduk;
  int desaId;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    pendudukId: json["penduduk_id"],
    namaLengkap: json["nama_lengkap"],
    tempatLahir: tempatLahirValues.map[json["tempat_lahir"]],
    tanggalLahir: json["tanggal_lahir"],
    alamat: json["alamat"],
    agama: agamaValues.map[json["agama"]],
    statusPerkawinan: statusPerkawinanValues.map[json["status_perkawinan"]],
    pekerjaanId: json["pekerjaan_id"] == null ? null : json["pekerjaan_id"],
    kewarganegaraan: kewarganegaraanValues.map[json["kewarganegaraan"]],
    golonganDarah: golonganDarahValues.map[json["golongan_darah"]],
    jenisKelamin: jenisKelaminValues.map[json["jenis_kelamin"]],
    pendidikanTerakhir: pendidikanTerakhirValues.map[json["pendidikan_terakhir"]],
    statusPenduduk: statusPendudukValues.map[json["status_penduduk"]],
    desaId: json["desa_id"],
  );

  Map<String, dynamic> toJson() => {
    "penduduk_id": pendudukId,
    "nama_lengkap": namaLengkap,
    "tempat_lahir": tempatLahirValues.reverse[tempatLahir],
    "tanggal_lahir": tanggalLahir,
    "alamat": alamat,
    "agama": agamaValues.reverse[agama],
    "status_perkawinan": statusPerkawinanValues.reverse[statusPerkawinan],
    "pekerjaan_id": pekerjaanId == null ? null : pekerjaanId,
    "kewarganegaraan": kewarganegaraanValues.reverse[kewarganegaraan],
    "golongan_darah": golonganDarahValues.reverse[golonganDarah],
    "jenis_kelamin": jenisKelaminValues.reverse[jenisKelamin],
    "pendidikan_terakhir": pendidikanTerakhirValues.reverse[pendidikanTerakhir],
    "status_penduduk": statusPendudukValues.reverse[statusPenduduk],
    "desa_id": desaId,
  };
}

enum Agama { BUDDHA, HINDU }

final agamaValues = EnumValues({
  "Buddha": Agama.BUDDHA,
  "Hindu": Agama.HINDU
});

enum GolonganDarah { A, B, O }

final golonganDarahValues = EnumValues({
  "A": GolonganDarah.A,
  "B": GolonganDarah.B,
  "O": GolonganDarah.O
});

enum JenisKelamin { LAKI_LAKI, PEREMPUAN }

final jenisKelaminValues = EnumValues({
  "Laki-Laki": JenisKelamin.LAKI_LAKI,
  "Perempuan": JenisKelamin.PEREMPUAN
});

enum Kewarganegaraan { WNI }

final kewarganegaraanValues = EnumValues({
  "WNI": Kewarganegaraan.WNI
});

enum PendidikanTerakhir { D4_S1, S2, SMA }

final pendidikanTerakhirValues = EnumValues({
  "D4/S1": PendidikanTerakhir.D4_S1,
  "S2": PendidikanTerakhir.S2,
  "SMA": PendidikanTerakhir.SMA
});

enum StatusPenduduk { AKTIF }

final statusPendudukValues = EnumValues({
  "Aktif": StatusPenduduk.AKTIF
});

enum StatusPerkawinan { BELUM_MENIKAH, SUDAH_MENIKAH }

final statusPerkawinanValues = EnumValues({
  "Belum Menikah": StatusPerkawinan.BELUM_MENIKAH,
  "Sudah Menikah": StatusPerkawinan.SUDAH_MENIKAH
});

enum TempatLahir { DENPASAR }

final tempatLahirValues = EnumValues({
  "Denpasar": TempatLahir.DENPASAR
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
