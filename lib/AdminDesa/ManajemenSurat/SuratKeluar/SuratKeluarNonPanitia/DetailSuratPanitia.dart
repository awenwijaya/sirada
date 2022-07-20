import 'dart:convert';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:surat/shared/LoadingAnimation/loading.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:surat/AdminDesa/ManajemenSurat/SuratKeluar/ViewLampiran.dart';
import 'package:surat/LoginAndRegistration/LoginPage.dart';

class detailSuratKeluarPanitiaAdmin extends StatefulWidget {
  static var suratKeluarId;
  static bool isTetujon = false;
  const detailSuratKeluarPanitiaAdmin({Key key}) : super(key: key);

  @override
  State<detailSuratKeluarPanitiaAdmin> createState() => _detailSuratKeluarPanitiaAdminState();
}

class _detailSuratKeluarPanitiaAdminState extends State<detailSuratKeluarPanitiaAdmin> {
  var tanggalSurat;
  var nomorSurat;
  var lepihan;
  var parindikan;
  var pemahbah;
  var daging;
  var pamuput;
  var namaDesa;
  var namaKecamatan;
  var namaKabupaten;
  var alamat;
  var kontakWa1;
  var kontakWa2;
  var logoDesa;
  var aksaraDesa;
  var namaKetua;
  var namaSekretaris;
  var namaBendesa;
  var kecamatanId;
  var timKegiatan;
  var status;
  var validasiStatus;
  var pihakKrama;
  var validasiStatusKetua;
  var validasiStatusSekretaris;
  FToast ftoast;

  var qrCodeBendesa;
  var qrCodeSekretaris;
  var qrCodeKetua;

  List tetujonPrajuruDesaList = [];
  List tetujonPrajuruBanjarList = [];
  List tetujonPihakLainList = [];
  List tumusanPrajuruBanjarList = [];
  List tumusanPrajuruDesaList = [];
  List tumusanPihakLainList = [];
  List tetujonPanitiaList = [];
  List<String> tetujon = [];
  List<String> tumusan = [];
  List<String> tetujonTerlampir = [];
  List lampiran = [];
  List historiSurat = [];
  bool canValidate = false;
  bool LoadData = true;
  var apiURLShowDetailSuratKeluar = "https://siradaskripsi.my.id/api/data/surat/keluar/view/${detailSuratKeluarPanitiaAdmin.suratKeluarId}";
  var apiURLShowPrajuru = "https://siradaskripsi.my.id/api/data/admin/surat/keluar/prajuru/${detailSuratKeluarPanitiaAdmin.suratKeluarId}";
  var apiURLGetLampiran = "https://siradaskripsi.my.id/api/data/admin/surat/keluar/lampiran/${detailSuratKeluarPanitiaAdmin.suratKeluarId}";
  //get tetujon
  var apiURLGetTetujonPrajuruDesa = "https://siradaskripsi.my.id/api/data/surat/keluar/tetujon/prajuru/desa/${detailSuratKeluarPanitiaAdmin.suratKeluarId}";
  var apiURLGetTetujonPrajuruBanjar = "https://siradaskripsi.my.id/api/data/surat/keluar/tetujon/prajuru/banjar/${detailSuratKeluarPanitiaAdmin.suratKeluarId}";
  var apiURLGetTetujonPihakLain = "https://siradaskripsi.my.id/api/data/surat/keluar/tetujon/pihak-lain/${detailSuratKeluarPanitiaAdmin.suratKeluarId}";
  var apiURLGetTumusanPrajuruDesa = "https://siradaskripsi.my.id/api/data/surat/keluar/tumusan/prajuru/desa/${detailSuratKeluarPanitiaAdmin.suratKeluarId}";
  var apiURLGetTumusanPrajuruBanjar = "https://siradaskripsi.my.id/api/data/surat/keluar/tumusan/prajuru/banjar/${detailSuratKeluarPanitiaAdmin.suratKeluarId}";
  var apiURLGetTumusanPihakLain = "https://siradaskripsi.my.id/api/data/surat/keluar/tumusan/pihak-lain/${detailSuratKeluarPanitiaAdmin.suratKeluarId}";
  var apiURLShowPanitia = "https://siradaskripsi.my.id/api/data/admin/surat/keluar/panitia/${detailSuratKeluarPanitiaAdmin.suratKeluarId}";
  var apiURLGetHistori = "https://siradaskripsi.my.id/api/data/admin/surat/keluar/histori/${detailSuratKeluarPanitiaAdmin.suratKeluarId}";
  var apiURLShowTetujonPanitia = "https://siradaskripsi.my.id/api/data/surat/keluar/tetujon/panitia/${detailSuratKeluarPanitiaAdmin.suratKeluarId}";

  //validasi
  var apiURLSetSedangDiproses = "https://siradaskripsi.my.id/api/admin/surat/keluar/set/sedang-diproses";
  var apiURLShowValidasiStatus = "https://siradaskripsi.my.id/api/admin/surat/keluar/prajuru/validasi/show/${loginPage.prajuruId}";
  var apiURLValidasiSurat = "https://siradaskripsi.my.id/api/admin/surat/keluar/panitia/validasi/prajuru/accept";
  var apiURLGetQRCode = "https://siradaskripsi.my.id/api/data/admin/surat/keluar/panitia/validasi/qrcode/${detailSuratKeluarPanitiaAdmin.suratKeluarId}";
  var apiURLBatalTolak = "https://siradaskripsi.my.id/api/admin/surat/keluar/validasi/tolak/batal";

  getQRCode() async {
    http.get(Uri.parse(apiURLGetQRCode),
        headers: {"Content-Type" : "application/json"}
    ).then((http.Response response) {
      var responseValue = response.statusCode;
      if(responseValue == 200) {
        var jsonData = json.decode(response.body);
        setState(() {
          qrCodeKetua = jsonData['validasi_ketua'];
          qrCodeSekretaris = jsonData['validasi_sekretaris'];
          qrCodeBendesa = jsonData['validasi_bendesa'];
        });
      }
    });
  }

  getPanitiaValidasiStatus() async {
    http.get(Uri.parse("https://siradaskripsi.my.id/api/admin/surat/keluar/panitia/get/validasi/${detailSuratKeluarPanitiaAdmin.suratKeluarId}"),
      headers: {"Content-Type" : "application/json"},
    ).then((http.Response response) {
      var responseValue = response.statusCode;
      if(responseValue == 200) {
        var jsonData = json.decode(response.body);
        setState(() {
          validasiStatusKetua = jsonData['validasi_ketua'];
          validasiStatusSekretaris = jsonData['validasi_sekretaris'];
          if(validasiStatusKetua == null || validasiStatusKetua == "Belum Divalidasi" || validasiStatusKetua == "Ditolak" || validasiStatusSekretaris == null || validasiStatusSekretaris == "Belum Divalidasi" || validasiStatusSekretaris == "Ditolak") {
            canValidate = false;
          }else if(validasiStatusKetua == "Tervalidasi" && validasiStatusSekretaris == "Tervalidasi") {
            canValidate = true;
          }
        });
      }
    });
  }

  getTetujonAnggota() async {
    this.tetujonPanitiaList = [];
    http.get(Uri.parse(apiURLShowTetujonPanitia),
        headers: {"Content-Type" : "application/json"}
    ).then((http.Response response) {
      var responseValue = response.statusCode;
      if(responseValue == 200) {
        var jsonData = json.decode(response.body);
        setState(() {
          tetujonPanitiaList = jsonData;
        });
      }
    });
  }

  getValidasiStatus() async {
    var body = jsonEncode({
      "surat_keluar_id" : detailSuratKeluarPanitiaAdmin.suratKeluarId
    });
    http.post(Uri.parse(apiURLShowValidasiStatus),
        headers: {"Content-Type" : "application/json"},
        body: body
    ).then((http.Response response) {
      var responseValue = response.statusCode;
      if(responseValue == 200) {
        var jsonData = json.decode(response.body);
        setState(() {
          validasiStatus = jsonData['status'];
        });
      }
    });
  }

  getLampiran() async {
    http.get(Uri.parse(apiURLGetLampiran),
        headers: {"Content-Type" : "application/json"}
    ).then((http.Response response) {
      var responseValue = response.statusCode;
      if(responseValue == 200) {
        var jsonData = json.decode(response.body);
        setState(() {
          lampiran = jsonData;
        });
      }
    });
  }

  getHistori() async {
    http.get(Uri.parse(apiURLGetHistori),
        headers: {"Content-Type" : "application/json"}
    ).then((http.Response response) {
      var responseValue = response.statusCode;
      print("get histori status code: ${response.statusCode.toString()}");
      if(responseValue == 200) {
        var jsonData = json.decode(response.body);
        setState(() {
          historiSurat = jsonData;
        });
      }
    });
  }

  getTetujon() async {
    this.tetujon = [];
    this.tetujonTerlampir = [];
    await http.get(Uri.parse(apiURLGetTetujonPrajuruDesa),
        headers: {"Content-Type" : "application/json"}
    ).then((http.Response response) {
      var responseValue = response.statusCode;
      if(responseValue == 200) {
        var jsonData = json.decode(response.body);
        setState(() {
          tetujonPrajuruDesaList = jsonData;
        });
        for(var i = 0; i < tetujonPrajuruDesaList.length; i++) {
          tetujonTerlampir.add("${tetujonPrajuruDesaList[i]['jabatan']} (${tetujonPrajuruDesaList[i]['nama']})");
        }
      }
    });
    await http.get(Uri.parse(apiURLGetTetujonPrajuruBanjar),
        headers: {"Content-Type" : "application/json"}
    ).then((http.Response response) {
      var responseValue = response.statusCode;
      print(responseValue.toString());
      if(responseValue == 200) {
        var jsonData = json.decode(response.body);
        setState(() {
          tetujonPrajuruBanjarList = jsonData;
        });
        for(var i = 0; i < tetujonPrajuruBanjarList.length; i++) {
          tetujonTerlampir.add("Banjar ${tetujonPrajuruBanjarList[i]['nama_banjar_adat']} (${tetujonPrajuruBanjarList[i]['nama']})");
        }
      }
    });
    await http.get(Uri.parse(apiURLGetTetujonPihakLain),
        headers: {"Content-Type" : "application/json"}
    ).then((http.Response response) {
      var responseValue = response.statusCode;
      if(responseValue == 200) {
        var jsonData = json.decode(response.body);
        setState(() {
          tetujonPihakLainList = jsonData;
        });
        for(var i = 0; i < tetujonPihakLainList.length; i++) {
          tetujonTerlampir.add("${tetujonPihakLainList[i]['pihak_lain']}");
        }
      }
    });
    await http.get(Uri.parse(apiURLShowTetujonPanitia),
        headers: {"Content-Type" : "application/json"}
    ).then((http.Response response) {
      var responseValue = response.statusCode;
      if(responseValue == 200) {
        var jsonData = json.decode(response.body);
        setState(() {
          tetujonPanitiaList = jsonData;
        });
        for(var i = 0; i < tetujonPihakLainList.length; i++) {
          tetujonTerlampir.add("${tetujonPanitiaList[i]['jabatan']}  (${tetujonPanitiaList[i]['nama']})");
        }
      }
    });
    if(tetujonTerlampir.length >= 2) {
      for(var i = 0; i < 2; i++) {
        setState(() {
          tetujon.add(tetujonTerlampir[i]);
          tetujonTerlampir.removeAt(i);
        });
      }
    }else {
      if(tetujonTerlampir.length == 1) {
        setState(() {
          tetujon.add(tetujonTerlampir[0]);
          tetujonTerlampir.removeAt(0);
        });
      }
    }
  }

  getTumusan() async {
    http.get(Uri.parse(apiURLGetTumusanPrajuruDesa),
        headers: {"Content-Type" : "application/json"}
    ).then((http.Response response) {
      var responseValue = response.statusCode;
      if(responseValue == 200) {
        var jsonData = json.decode(response.body);
        setState(() {
          tumusanPrajuruDesaList = jsonData;
        });
        for(var i = 0; i < tumusanPrajuruDesaList.length; i++) {
          tumusan.add("${tumusanPrajuruDesaList[i]['jabatan']} - ${tumusanPrajuruDesaList[i]['nama']}");
        }
      }
    });
  }

  getTumusanPrajuruBanjar() async {
    http.get(Uri.parse(apiURLGetTumusanPrajuruBanjar),
        headers: {"Content-Type" : "application/json"}
    ).then((http.Response response) {
      var responseValue = response.statusCode;
      print(responseValue.toString());
      if(responseValue == 200) {
        var jsonData = json.decode(response.body);
        setState(() {
          tumusanPrajuruBanjarList = jsonData;
        });
        for(var i = 0; i < tumusanPrajuruBanjarList.length; i++) {
          tumusan.add("Banjar ${tumusanPrajuruBanjarList[i]['nama_banjar_adat']} - ${tumusanPrajuruBanjarList[i]['nama']}");
        }
      }
    });
  }

  getTumusanPihakLain() async {
    http.get(Uri.parse(apiURLGetTumusanPihakLain),
        headers: {"Content-Type" : "application/json"}
    ).then((http.Response response) {
      var responseValue = response.statusCode;
      if(responseValue == 200) {
        var jsonData = json.decode(response.body);
        setState(() {
          tumusanPihakLainList = jsonData;
        });
        for(var i = 0; i < tumusanPihakLainList.length; i++) {
          tumusan.add("${tumusanPihakLainList[i]['pihak_lain']}");
        }
      }
    });
  }

  getKetuaPanitiaInfo() async {
    var body = jsonEncode({
      "jabatan" : "Ketua Panitia"
    });
    http.post(Uri.parse(apiURLShowPanitia),
        headers: {"Content-Type" : "application/json"},
        body: body
    ).then((http.Response response) {
      print("get ketua info status code : ${response.statusCode.toString()}");
      if(response.statusCode == 200) {
        var jsonData = response.body;
        var parsedJson = json.decode(jsonData);
        setState(() {
          namaKetua = parsedJson['nama'];
        });
      }
    });
  }

  getSekretarisPanitiaInfo() async {
    var body = jsonEncode({
      "jabatan" : "Sekretaris Panitia"
    });
    http.post(Uri.parse(apiURLShowPanitia),
        headers: {"Content-Type" : "application/json"},
        body: body
    ).then((http.Response response) {
      print("get sekretaris info status code : ${response.statusCode.toString()}");
      if(response.statusCode == 200) {
        var jsonData = response.body;
        var parsedJson = json.decode(jsonData);
        setState(() {
          namaSekretaris = parsedJson['nama'];
        });
      }
    });
  }

  getSuratKeluarInfo() async {
    http.get(Uri.parse(apiURLShowDetailSuratKeluar),
        headers: {"Content-Type" : "application/json"}
    ).then((http.Response response) {
      var responseValue = response.statusCode;
      if(responseValue == 200) {
        var jsonData = response.body;
        var parsedJson = json.decode(jsonData);
        setState(() {
          tanggalSurat = parsedJson['tanggal_keluar'];
          nomorSurat = parsedJson['nomor_surat'];
          lepihan = parsedJson['lepihan'];
          parindikan = parsedJson['parindikan'];
          pemahbah = parsedJson['pamahbah_surat'];
          daging = parsedJson['daging_surat'];
          pamuput = parsedJson['pamuput_surat'];
          namaDesa =  parsedJson['desadat_nama'];
          kecamatanId = parsedJson['kecamatan_id'];
          namaKabupaten = parsedJson['name'];
          alamat = parsedJson['desadat_alamat_kantor'];
          kontakWa1 = parsedJson['desadat_wa_kontak_1'];
          kontakWa2 = parsedJson['desadat_wa_kontak_2'];
          logoDesa = parsedJson['desadat_logo'];
          aksaraDesa = parsedJson['desadat_aksara_bali'];
          timKegiatan = parsedJson['tim_kegiatan'];
          status = parsedJson['status'];
          if(parsedJson['pihak_krama'] != null) {
            pihakKrama = "Krama ${parsedJson['pihak_krama']}";
          }else {
            pihakKrama = null;
          }
        });
        http.get(Uri.parse("https://siradaskripsi.my.id/api/data/kecamatan/${kecamatanId}"),
            headers: {"Content-Type" : "application/json"}
        ).then((http.Response response) {
          var responseValue = response.statusCode;
          if(responseValue == 200) {
            var jsonDataKecamatan = response.body;
            var parsedKecamatan = json.decode(jsonDataKecamatan);
            setState(() {
              namaKecamatan = parsedKecamatan['name'];
              LoadData = false;
            });
          }
        });
      }
    });
  }

  getBendesaInfo() async {
    var body = jsonEncode({
      "jabatan" : "Bendesa"
    });
    http.post(Uri.parse(apiURLShowPrajuru),
        headers: {"Content-Type" : "application/json"},
        body: body
    ).then((http.Response response) {
      if(response.statusCode == 200) {
        var jsonData = response.body;
        var parsedJson = json.decode(jsonData);
        setState(() {
          namaBendesa = parsedJson['nama'];
        });
      }
    });
  }

  getDetailSurat() async {
    await getSuratKeluarInfo();
    await getBendesaInfo();
    await getKetuaPanitiaInfo();
    await getSekretarisPanitiaInfo();
    await getTetujon();
    await getTumusan();
    await getTumusanPrajuruBanjar();
    await getTumusanPihakLain();
    await getHistori();
    await getLampiran();
    await getValidasiStatus();
    await getPanitiaValidasiStatus();
    await getQRCode();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDetailSurat();
    // getTetujonAnggota();
    ftoast = FToast();
    ftoast.init(this.context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: HexColor("#025393"),
            onPressed: (){
              Navigator.of(context).pop();
            },
          ),
          title: Text(parindikan == null ? "" : parindikan, style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w700,
            color: HexColor("#025393")
          )),
        ),
        body: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.white
              ),
            ),
            Container(
              child: LoadData ? ProfilePageShimmer() : SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage('https://storage.siradaskripsi.my.id/img/logo-desa/${logoDesa}')
                              )
                            ),
                            margin: EdgeInsets.only(left: 20)
                          ),
                          Container(
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.82,
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      height: 65,
                                      child: Image.network('https://storage.siradaskripsi.my.id/img/aksara-bali/${aksaraDesa}'),
                                      margin: EdgeInsets.only(top: 10, left: 10),
                                    ),
                                    Container(
                                        child: Text("DESA ADAT ${namaDesa}".toUpperCase(), style: TextStyle(
                                            fontFamily: "Times New Roman",
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700
                                        ))
                                    ),
                                    Container(
                                        child: Text("KECAMATAN ${namaKecamatan} ${namaKabupaten}".toUpperCase(), style: TextStyle(
                                            fontFamily: "Times New Roman",
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700
                                        ), textAlign: TextAlign.center),
                                        margin: EdgeInsets.only(top: 5),
                                        padding: EdgeInsets.symmetric(horizontal: 10)
                                    ),
                                    Container(
                                      child: timKegiatan == null ? Container() : Text("$timKegiatan".toUpperCase(), style: TextStyle(
                                          fontFamily: "Times New Roman",
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700
                                      ), textAlign: TextAlign.center),
                                      margin: EdgeInsets.only(top: 5),
                                      padding: EdgeInsets.symmetric(horizontal: 10),
                                    ),
                                    Container(
                                        child: Text("${alamat}${kontakWa1 == null ? "" : ", $kontakWa1"}${kontakWa2 == null ? "" : ",$kontakWa2"}", style: TextStyle(
                                            fontFamily: "Times New Roman",
                                            fontSize: 16
                                        ), textAlign: TextAlign.center),
                                        margin: EdgeInsets.only(top: 5),
                                        padding: EdgeInsets.symmetric(horizontal: 10)
                                    )
                                  ],
                                ),
                              )
                          )
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(width: 2.0, color: Colors.black)
                        )
                      ),
                      margin: EdgeInsets.only(top: 10, left: 15, right: 15),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      child: Text("${namaDesa}, ${tanggalSurat}", style: TextStyle(
                        fontFamily: "Times New Roman",
                        fontSize: 16
                      )),
                      margin: EdgeInsets.only(right: 15, top: 15),
                    ),
                    Container(
                        alignment: Alignment.topRight,
                        child: Text("Katur Majeng Ring :", style: TextStyle(
                            fontFamily: "Times New Roman",
                            fontSize: 16
                        ), textAlign: TextAlign.center),
                        margin: EdgeInsets.only(top: 5, right: 15)
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      child: pihakKrama == null ? tetujon.length == 0 ? tetujonPanitiaList.isNotEmpty ? Container() : Text("-", style: TextStyle(
                          fontFamily: "Times New Roman",
                          fontSize: 16
                      )) : Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          for(var i = 0; i < tetujon.length; i++) Container(
                            child: Text("${i+1}. ${tetujon[i].toString()}", textAlign: TextAlign.right, style: TextStyle(
                                fontFamily: "Times New Roman",
                                fontSize: 16
                            )),
                            margin: EdgeInsets.only(bottom: 5),
                          ),
                          Container(
                            child: tetujonPanitiaList.isNotEmpty ? Text("(Terlampir)", style: TextStyle(
                                fontFamily: "Times New Roman",
                                fontSize: 16
                            )) : tetujonTerlampir.isNotEmpty ? Text("(Terlampir)", style: TextStyle(
                                fontFamily: "Times New Roman",
                                fontSize: 16
                            )) : Container(),
                          )
                        ],
                      ) : Text(pihakKrama, style: TextStyle(
                          fontFamily: "Times New Roman",
                          fontSize: 16
                      )),
                      margin: EdgeInsets.only(right: 15, top: 5),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      child: tetujonTerlampir.isEmpty ? tetujonPanitiaList.isNotEmpty ? Text("(Terlampir)", style: TextStyle(
                          fontFamily: "Times New Roman",
                          fontSize: 16
                      )) : Container() : Container(),
                      margin: EdgeInsets.only(right: 15, top: 5),
                    ),
                    Container(
                        child: Column(
                            children: <Widget>[
                              Container(
                                  alignment: Alignment.topLeft,
                                  child: Text("Nomor: ${nomorSurat}", style: TextStyle(
                                      fontFamily: "Times New Roman",
                                      fontSize: 16
                                  )),
                                  margin: EdgeInsets.only(top: 5)
                              ),
                              Container(
                                  alignment: Alignment.topLeft,
                                  child: Text(lepihan == "0" ? "Lepihan: -" : "Lepihan: ${lepihan} lepih", style: TextStyle(
                                      fontFamily: "Times New Roman",
                                      fontSize: 16
                                  )),
                                  margin: EdgeInsets.only(top: 5)
                              ),
                              Container(
                                  alignment: Alignment.topLeft,
                                  child: Text("Parindikan: ${parindikan}", style: TextStyle(
                                      fontFamily: "Times New Roman",
                                      fontSize: 16
                                  )),
                                  margin: EdgeInsets.only(top: 5)
                              ),
                            ]
                        ),
                        margin: EdgeInsets.only(left: 15, top: 20)
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            alignment: Alignment.topLeft,
                            height: 50,
                            child: Image.network('https://storage.siradaskripsi.my.id/img/aksara-bali/om-swastyastu.png'),
                            margin: EdgeInsets.only(top: 10, left: 10),
                          ),
                          Container(
                              alignment: Alignment.topLeft,
                              child: Text("Om Swastiyastu", style: TextStyle(
                                  fontFamily: "Times New Roman",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700
                              )),
                              margin: EdgeInsets.only(top: 10, left: 15)
                          ),
                        ],
                      ),
                    ),
                    Container(
                        alignment: Alignment.topLeft,
                        child: Text(pemahbah == null ? "" : "\t\t\t${pemahbah}", style: TextStyle(
                            fontFamily: "Times New Roman",
                            fontSize: 16
                        ), textAlign: TextAlign.justify),
                        padding: EdgeInsets.only(left: 15, right: 15)
                    ),
                    Container(
                        alignment: Alignment.topLeft,
                        child: Text(daging == null ? "" : "\t\t\t${daging}", style: TextStyle(
                            fontFamily: "Times New Roman",
                            fontSize: 16
                        ), textAlign: TextAlign.justify),
                        padding: EdgeInsets.only(left: 15, right: 15)
                    ),
                    Container(
                        alignment: Alignment.topLeft,
                        child: Text(pamuput == null ? "" : "\t\t\t${pamuput}", style: TextStyle(
                            fontFamily: "Times New Roman",
                            fontSize: 16
                        ), textAlign: TextAlign.justify),
                        padding: EdgeInsets.only(left: 15, right: 15)
                    ),
                    Container(
                        alignment: Alignment.topLeft,
                        child: Text("Om Santih, Santih, Santih Om", style: TextStyle(
                            fontFamily: "Times New Roman",
                            fontSize: 16,
                            fontWeight: FontWeight.w700
                        )),
                        margin: EdgeInsets.only(top: 5, left: 15)
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      height: 50,
                      child: Image.network('https://storage.siradaskripsi.my.id/img/aksara-bali/om-santih,santih,santih-om.png'),
                      margin: EdgeInsets.only(top: 10, left: 10),
                    ),
                    Container(
                        alignment: Alignment.topLeft,
                        child: timKegiatan == null ? Container() : Text(timKegiatan, style: TextStyle(
                            fontFamily: "Times New Roman",
                            fontSize: 16,
                            fontWeight: FontWeight.w700
                        )),
                        margin: EdgeInsets.only(top: 10, bottom: 10, left: 15),
                        padding: EdgeInsets.only(right: 15)
                    ),
                    Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                  child: namaKetua == null ? Container() : Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                          child: Text("Ketua", style: TextStyle(
                                              fontFamily: "Times New Roman",
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700
                                          ))
                                      ),
                                      Container(
                                        child: qrCodeKetua == "Belum tervalidasi" ? Container() : Container(
                                          child: SvgPicture.network(
                                            "https://storage.siradaskripsi.my.id/file/validasi/${qrCodeKetua}",
                                            height: 50,
                                            placeholderBuilder: (context) => CircularProgressIndicator(),
                                          ),
                                          margin: EdgeInsets.only(top: 10),
                                        ),
                                      ),
                                      Container(
                                          child: Text(namaKetua, style: TextStyle(
                                              fontFamily: "Times New Roman",
                                              fontSize: 16
                                          )),
                                          margin: EdgeInsets.only(top: 10)
                                      )
                                    ],
                                  ),
                                  margin: EdgeInsets.only(left: 10, top: 10)
                              ),
                              Container(
                                  alignment: Alignment.topRight,
                                  child: namaSekretaris == null ? Container() : Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                          child: Text("Sekretaris", style: TextStyle(
                                              fontFamily: "Times New Roman",
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700
                                          ))
                                      ),
                                      Container(
                                        child: qrCodeSekretaris == "Belum tervalidasi" ? Container() : Container(
                                          child: SvgPicture.network(
                                            "https://storage.siradaskripsi.my.id/file/validasi/${qrCodeSekretaris}",
                                            height: 50,
                                            placeholderBuilder: (context) => CircularProgressIndicator(),
                                          ),
                                          margin: EdgeInsets.only(top: 10),
                                        ),
                                      ),
                                      Container(
                                          child: Text(namaSekretaris, style: TextStyle(
                                              fontFamily: "Times New Roman",
                                              fontSize: 16
                                          )),
                                          margin: EdgeInsets.only(top: 10)
                                      )
                                    ],
                                  ),
                                  margin: EdgeInsets.only(right: 10, top: 10)
                              )
                            ]
                        )
                    ),
                    Container(
                        alignment: Alignment.center,
                        child: namaBendesa == null ? Container() : Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                                child: Text("Bendesa", style: TextStyle(
                                    fontFamily: "Times New Roman",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700
                                ))
                            ),
                            Container(
                              child: qrCodeBendesa == "Belum tervalidasi" ? Container() : Container(
                                child: SvgPicture.network(
                                  "https://storage.siradaskripsi.my.id/file/validasi/${qrCodeBendesa}",
                                  height: 50,
                                  placeholderBuilder: (context) => CircularProgressIndicator(),
                                ),
                                margin: EdgeInsets.only(top: 10),
                              ),
                            ),
                            Container(
                                child: Text(namaBendesa, style: TextStyle(
                                    fontFamily: "Times New Roman",
                                    fontSize: 16
                                )),
                                margin: EdgeInsets.only(top: 10)
                            )
                          ],
                        ),
                        margin: EdgeInsets.only(top: 20)
                    ),
                    Container(
                      child: tumusan.length == 0 ? Container() : Column(
                        children: <Widget>[
                          Container(
                              alignment: Alignment.topLeft,
                              child: Text("Tumusan :", style: TextStyle(
                                  fontFamily: "Times New Roman",
                                  fontSize: 16
                              )),
                              margin: EdgeInsets.only(top: 5)
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: tumusan.length == 0 ? Text("-", style: TextStyle(
                              fontFamily: "Times New Roman",
                              fontSize: 16,
                            )) : Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  for(var i = 0; i < tumusan.length; i++) Container(
                                    child: Text("${i+1}. ${tumusan[i].toString()}", style: TextStyle(
                                        fontFamily: "Times New Roman",
                                        fontSize: 16
                                    )),
                                    margin: EdgeInsets.only(bottom: 5),
                                  )
                                ],
                              ),
                              margin: EdgeInsets.only(top: 5),
                            ),
                            margin: EdgeInsets.only(left: 5),
                          )
                        ],
                      ),
                      margin: EdgeInsets.only(left: 15, top: 10),
                    ),
                    Container(
                      child: tetujonTerlampir.length == 0 ? Container() : Divider(
                          color: Colors.black38
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 15),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: tetujonTerlampir.length == 0 ? Container() : Column(
                        children: <Widget>[
                          Container(
                              alignment: Alignment.topLeft,
                              child: Text("Tetujon Surat (Terlampir) :", style: TextStyle(
                                  fontFamily: "Times New Roman",
                                  fontSize: 16
                              ))
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                for(var i = 0; i < tetujonTerlampir.length; i++) Container(
                                  child: Text("${i+1}. ${tetujonTerlampir[i].toString()}", style: TextStyle(
                                      fontFamily: "Times New Roman",
                                      fontSize: 16
                                  )),
                                  margin: EdgeInsets.only(bottom: 5),
                                )
                              ],
                            ),
                            margin: EdgeInsets.only(top: 5),
                          ),
                        ],
                      ),
                      margin: EdgeInsets.only(left: 15),
                    ),
                    // Container(
                    //   alignment: Alignment.topLeft,
                    //   child: tetujonPanitiaList.length == 0 ? Container() : Column(
                    //     children: <Widget>[
                    //       Container(
                    //         alignment: Alignment.topLeft,
                    //         child: Text("Katur Majeng Ring :", style: TextStyle(
                    //             fontFamily: "Times New Roman",
                    //             fontSize: 16
                    //         )),
                    //       ),
                    //       Container(
                    //         alignment: Alignment.topLeft,
                    //         child: Column(
                    //           mainAxisAlignment: MainAxisAlignment.start,
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: <Widget>[
                    //             for(var i = 0; i < tetujonPanitiaList.length; i++) Container(
                    //               child: Text("${i+1}. ${tetujonPanitiaList[i]['jabatan']}  (${tetujonPanitiaList[i]['nama']})", style: TextStyle(
                    //                   fontFamily: "Times New Roman",
                    //                   fontSize: 16
                    //               )),
                    //               margin: EdgeInsets.only(bottom: 5),
                    //             )
                    //           ],
                    //         ),
                    //         margin: EdgeInsets.only(top: 5),
                    //       )
                    //     ],
                    //   ),
                    //   margin: EdgeInsets.only(left: 15),
                    // ),
                    Container(
                      child: lampiran.length == 0 ? Container() : Column(
                        children: <Widget>[
                          Container(
                              alignment: Alignment.topLeft,
                              margin: EdgeInsets.only(top: 15, left: 25),
                              child: Text("Lampiran", style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700
                              ))
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              for(var i = 0; i < lampiran.length; i++) Container(
                                child: GestureDetector(
                                  onTap: (){},
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                          child: Image.asset('images/paper.png', height: 40, width: 40,)
                                      ),
                                      Container(
                                        child: SizedBox(
                                          width: MediaQuery.of(context).size.width * 0.60,
                                          child: Text(lampiran[i]['file'], style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700
                                          ), maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: false
                                          ),
                                        ),
                                        margin: EdgeInsets.only(left: 20),
                                      )
                                    ],
                                  ),
                                ),
                                margin: EdgeInsets.only(top: 15, left: 20, right: 20),
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                height: 70,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0,3)
                                      )
                                    ]
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: detailSuratKeluarPanitiaAdmin.isTetujon == true ? Container() : status == "Menunggu Respon" ? Container() : status == "Telah Dikonfirmasi" ? Container() : validasiStatus  == "Ditolak" ? Container(
                          child: Column(
                            children: <Widget>[
                              Container(
                                child: Text("Aksi", style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700
                                )),
                                alignment: Alignment.topLeft,
                                margin: EdgeInsets.only(top: 20, left: 25),
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: FlatButton(
                                  onPressed: (){
                                    showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(Radius.circular(40.0))
                                            ),
                                            content: Container(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  Container(
                                                    child: Image.asset(
                                                      'images/question.png',
                                                      height: 50,
                                                      width: 50,
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Text("Batalkan Penolakan Surat", style: TextStyle(
                                                        fontFamily: "Poppins",
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w700,
                                                        color: HexColor("025393")
                                                    ), textAlign: TextAlign.center),
                                                    margin: EdgeInsets.only(top: 10),
                                                  ),
                                                  Container(
                                                    child: Text("Apakah Anda yakin ingin membatalkan penolakan surat ini?", style: TextStyle(
                                                        fontFamily: "Poppins",
                                                        fontSize: 14
                                                    ), textAlign: TextAlign.center),
                                                    margin: EdgeInsets.only(top: 10),
                                                  )
                                                ],
                                              ),
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                child: Text("Ya", style: TextStyle(
                                                    fontFamily: "Poppins",
                                                    fontWeight: FontWeight.w700,
                                                    color: HexColor("025393")
                                                )),
                                                onPressed: (){
                                                  var body = jsonEncode({
                                                    "user_id" : loginPage.userId,
                                                    "surat_keluar_id" : detailSuratKeluarPanitiaAdmin.suratKeluarId,
                                                    "prajuru_desa_adat_id" : loginPage.prajuruId,
                                                  });
                                                  http.post(Uri.parse(apiURLBatalTolak),
                                                      headers: {"Content-Type" : "application/json"},
                                                      body: body
                                                  ).then((http.Response response) {
                                                    var responseValue = response.statusCode;
                                                    print("status tolak surat: ${responseValue.toString()}");
                                                    if(responseValue == 200) {
                                                      ftoast.showToast(
                                                          child: Container(
                                                            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                                            decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(25),
                                                                color: Colors.green
                                                            ),
                                                            child: Row(
                                                              children: <Widget>[
                                                                Icon(Icons.done),
                                                                Container(
                                                                  margin: EdgeInsets.only(left: 15),
                                                                  child: SizedBox(
                                                                    width: MediaQuery.of(context).size.width * 0.65,
                                                                    child: Text("Surat telah dibatalkan status penolakannya", style: TextStyle(
                                                                        fontFamily: "Poppins",
                                                                        fontSize: 14,
                                                                        fontWeight: FontWeight.w700,
                                                                        color: Colors.white
                                                                    )),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          )
                                                      );
                                                      getDetailSurat();
                                                      Navigator.of(context).pop(true);
                                                    }
                                                  });
                                                },
                                              ),
                                              TextButton(
                                                child: Text("Tidak", style: TextStyle(
                                                    fontFamily: "Poppins",
                                                    fontWeight: FontWeight.w700,
                                                    color: HexColor("025393")
                                                )),
                                                onPressed: (){Navigator.of(context).pop();},
                                              )
                                            ],
                                          );
                                        }
                                    );
                                  },
                                  child: Text("Batalkan Penolakan Surat", style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: HexColor("990000")
                                  )),
                                  color: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                      side: BorderSide(color: HexColor("990000"), width: 2)
                                  ),
                                  padding: EdgeInsets.only(top: 10, bottom: 10, left: 30, right: 30),
                                ),
                              )
                            ],
                          )
                      ) : canValidate == false ? Container(
                          child: Container(
                            child: Row(
                              children: <Widget>[
                                Container(
                                  child: Icon(
                                      Icons.info_rounded,
                                      color: Colors.black
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                          child: SizedBox(
                                            width: MediaQuery.of(context).size.width * 0.7,
                                            child: Text("Tidak dapat melanjutkan verifikasi surat", style: TextStyle(
                                                fontFamily: "Poppins",
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black
                                            )),
                                          )
                                      ),
                                      Container(
                                        child: SizedBox(
                                          width: MediaQuery.of(context).size.width * 0.7,
                                          child: Text("Anda sementara tidak dapat melakukan verifikasi surat karena panitia kegiatan belum atau menolak verifikasi surat ini.", style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 14,
                                              color: Colors.black
                                          )),
                                        ),
                                      )
                                    ],
                                  ),
                                  margin: EdgeInsets.only(left: 15),
                                )
                              ],
                            ),
                            decoration: BoxDecoration(
                                color: HexColor("B2C8DF"),
                                borderRadius: BorderRadius.circular(25)
                            ),
                            padding: EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
                            margin: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 5),
                          )
                      ) : validasiStatus == "Belum Divalidasi" ? Column(
                        children: <Widget>[
                          Container(
                            child: Text("Aksi", style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14,
                                fontWeight: FontWeight.w700
                            )),
                            alignment: Alignment.topLeft,
                            margin: EdgeInsets.only(top: 20, left: 25),
                          ),
                          Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    child: FlatButton(
                                      onPressed: (){
                                        showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(Radius.circular(40.0))
                                              ),
                                              content: Container(
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: <Widget>[
                                                    Container(
                                                      child: Image.asset(
                                                        'images/question.png',
                                                        height: 50,
                                                        width: 50,
                                                      ),
                                                    ),
                                                    Container(
                                                      child: Text("Verifikasi Surat", style: TextStyle(
                                                        fontFamily: "Poppins",
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w700,
                                                        color: HexColor("#025393")
                                                      ), textAlign: TextAlign.center),
                                                      margin: EdgeInsets.only(top: 10),
                                                    ),
                                                    Container(
                                                      child: Text("Apakah Anda yakin ingin melakukan verifikasi terhadap surat ini?", style: TextStyle(
                                                        fontFamily: "Poppins",
                                                        fontSize: 14
                                                      ), textAlign: TextAlign.center),
                                                      margin: EdgeInsets.only(top: 10),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: Text("Ya", style: TextStyle(
                                                    fontFamily: "Poppins",
                                                    fontWeight: FontWeight.w700,
                                                    color: HexColor('#025393')
                                                  )),
                                                  onPressed: (){
                                                    var body = jsonEncode({
                                                      "user_id" : loginPage.userId,
                                                      "prajuru_desa_adat_id" : loginPage.prajuruId,
                                                      "surat_keluar_id" : detailSuratKeluarPanitiaAdmin.suratKeluarId
                                                    });
                                                    http.post(Uri.parse(apiURLValidasiSurat),
                                                      headers: {"Content-Type" : "application/json"},
                                                      body: body
                                                    ).then((http.Response response) {
                                                      var responseValue = response.statusCode;
                                                      print("validasi status: ${responseValue.toString()}");
                                                      if(responseValue == 200) {
                                                        ftoast.showToast(
                                                          child: Container(
                                                            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(25),
                                                              color: Colors.green
                                                            ),
                                                            child: Row(
                                                              children: <Widget>[
                                                                Icon(Icons.done),
                                                                Container(
                                                                  margin: EdgeInsets.only(left: 15),
                                                                  child: SizedBox(
                                                                    width: MediaQuery.of(this.context).size.width * 0.65,
                                                                    child: Text("Verifikasi surat telah berhasil", style: TextStyle(
                                                                        fontFamily: "Poppins",
                                                                        fontSize: 14,
                                                                        fontWeight: FontWeight.w700,
                                                                        color: Colors.white
                                                                    )),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          )
                                                        );
                                                        getDetailSurat();
                                                        Navigator.of(context).pop();
                                                      }
                                                    });
                                                  },
                                                ),
                                                TextButton(
                                                  child: Text("Tidak", style: TextStyle(
                                                    fontFamily: "Poppins",
                                                    fontWeight: FontWeight.w700,
                                                    color: HexColor("#025393")
                                                  )),
                                                  onPressed: (){
                                                    Navigator.of(context).pop();
                                                  },
                                                )
                                              ],
                                            );
                                          }
                                        );
                                      },
                                      child: Text("Verifikasi Surat", style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: HexColor("446A46")
                                      )),
                                      color: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(25),
                                          side: BorderSide(color: HexColor("446A46"), width: 2)
                                      ),
                                      padding: EdgeInsets.only(top: 10, bottom: 10, left: 30, right: 30),
                                    ),
                                  ),
                                  Container(
                                    child: FlatButton(
                                      onPressed: (){
                                        Navigator.push(context, CupertinoPageRoute(builder: (context) => tolakValidasiSuratPanitiaAdmin())).then((value) {
                                          getDetailSurat();
                                        });
                                      },
                                      child: Text("Tolak Surat", style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: HexColor("990000")
                                      )),
                                      color: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(25),
                                          side: BorderSide(color: HexColor("990000"), width: 2)
                                      ),
                                      padding: EdgeInsets.only(top: 10, bottom: 10, left: 30, right: 30),
                                    ),
                                    margin: EdgeInsets.only(left: 10),
                                  )
                                ],
                              ),
                              margin: EdgeInsets.only(top: 10)
                          )
                        ],
                      ) : Container(),
                    ),
                    Container(
                      child: detailSuratKeluarPanitiaAdmin.isTetujon == true ? Container() : Column(
                        children: <Widget>[
                          Container(
                              child: Text("Histori Surat", style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              )),
                              alignment: Alignment.topLeft,
                              margin: EdgeInsets.only(top: 15, left: 25)
                          ),
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                for(var i = 0; i < historiSurat.length; i++) TimelineTile(
                                    indicatorStyle: i+1 < historiSurat.length ? IndicatorStyle(
                                        color: Colors.black,
                                        height: 30,
                                        width: 30
                                    ) : IndicatorStyle(
                                      color: HexColor("#377D71"),
                                      height: 30,
                                      width: 30,
                                    ),
                                    isFirst: i == 0 ? true : false,
                                    isLast: i+1 == historiSurat.length ? true : false,
                                    endChild: Row(
                                      children: <Widget>[
                                        Container(
                                          child: Icon(
                                              historiSurat[i]['histori'].contains('ditambahkan')
                                                  ? Icons.add
                                                  : historiSurat[i]['histori'] == "Surat telah diubah"
                                                  ? Icons.edit
                                                  : historiSurat[i]['histori'].contains('Sedang Diproses')
                                                  ? Icons.add_task_rounded
                                                  : historiSurat[i]['histori'].contains('telah ditandatangani')
                                                  ? Icons.done
                                                  : historiSurat[i]['histori'].contains('ditolak')
                                                  ? Icons.cancel
                                                  : historiSurat[i]['histori'].contains('dibatalkan status tolak validasi')
                                                  ? Icons.cancel : Icons.cancel,
                                              color: i+1 < historiSurat.length ? Colors.black54 : HexColor("377D71")
                                          ),
                                          margin: EdgeInsets.only(left: 15),
                                        ),
                                        Container(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                child: Text(DateFormat("dd-MMM-yyyy, hh:mm").format(DateTime.parse(historiSurat[i]['created_at'])).toString(), style: TextStyle(
                                                    fontFamily: "Poppins",
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w700,
                                                    color: i+1 < historiSurat.length ? Colors.black54 : Colors.black
                                                )),
                                              ),
                                              Container(
                                                  padding: EdgeInsets.only(right: 10),
                                                  child: SizedBox(
                                                    width: MediaQuery.of(context).size.width * 0.69 ,
                                                    child: Text("${historiSurat[i]['histori']} oleh ${historiSurat[i]['jabatan']} ${historiSurat[i]['nama']}", style: TextStyle(
                                                        fontFamily: "Poppins",
                                                        fontSize: 14,
                                                        color: i+1 < historiSurat.length ? Colors.black54 : Colors.black
                                                    ), maxLines: 2, softWrap: false, overflow: TextOverflow.ellipsis),
                                                  )
                                              )
                                            ],
                                          ),
                                          margin: EdgeInsets.only(left: 15, top: 15),
                                        ),
                                      ],
                                    )
                                )
                              ],
                            ),
                            margin: EdgeInsets.only(top: 10, bottom: 10, left: 15),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}

class tolakValidasiSuratPanitiaAdmin extends StatefulWidget {
  const tolakValidasiSuratPanitiaAdmin({Key key}) : super(key: key);

  @override
  State<tolakValidasiSuratPanitiaAdmin> createState() => _tolakValidasiSuratAdminPanitiaState();
}

class _tolakValidasiSuratAdminPanitiaState extends State<tolakValidasiSuratPanitiaAdmin> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  FToast ftoast;
  bool Loading = false;
  final controllerAlasanPenolakan = TextEditingController();
  var apiURLTolakValidasiSurat = "https://siradaskripsi.my.id/api/admin/surat/keluar/validasi/tolak";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ftoast = FToast();
    ftoast.init(this.context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Loading ? loading() :Scaffold(
        appBar: AppBar(
          title: Text("Tolak Verifikasi Surat", style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w700,
            color: HexColor("#025393")
          )),
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: HexColor("#025393"),
            onPressed: (){
              Navigator.of(context).pop();
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'images/email.png',
                      height: 100,
                      width: 100,
                    ),
                    margin: EdgeInsets.only(top: 30),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text("Sebelum Anda melakukan penolakan terhadap surat ini, silahkan masukkan alasan penolakan pada form dibawah.", style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 14,
                    ), textAlign: TextAlign.center),
                    margin: EdgeInsets.only(top: 15),
                    padding: EdgeInsets.symmetric(horizontal: 30),
                  ),
                  Container(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if(value.isEmpty) {
                            return "Data tidak boleh kosong";
                          }else {
                            return null;
                          }
                        },
                        controller: controllerAlasanPenolakan,
                        maxLines: 10,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(color: HexColor("#025393"))
                            ),
                            hintText: "Alasan penolakan surat"
                        ),
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14
                        ),
                      ),
                    ),
                    margin: EdgeInsets.only(top: 15),
                  ),
                  Container(
                    child: FlatButton(
                      onPressed: (){
                        if(formKey.currentState.validate()) {
                          setState(() {
                            Loading = true;
                          });
                          var body = jsonEncode({
                            "user_id" : loginPage.userId,
                            "surat_keluar_id" : detailSuratKeluarPanitiaAdmin.suratKeluarId,
                            "prajuru_desa_adat_id" : loginPage.prajuruId,
                            "alasan_ditolak" : controllerAlasanPenolakan.text
                          });
                          http.post(Uri.parse(apiURLTolakValidasiSurat),
                              headers: {"Content-Type" : "application/json"},
                              body: body
                          ).then((http.Response response) {
                            var responseValue = response.statusCode;
                            print("status tolak surat : ${responseValue.toString()}");
                            if(responseValue == 200) {
                              setState(() {
                                Loading = false;
                              });
                              ftoast.showToast(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color: Colors.green
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        Icon(Icons.done),
                                        Container(
                                          margin: EdgeInsets.only(left: 15),
                                          child: SizedBox(
                                            width: MediaQuery.of(context).size.width * 0.65,
                                            child: Text("Penolakan validasi surat telah berhasil", style: TextStyle(
                                                fontFamily: "Poppins",
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white
                                            )),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                              );
                              Navigator.of(context).pop(true);
                            }
                          });
                        }else {
                          ftoast.showToast(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: Colors.redAccent
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Icon(Icons.close),
                                    Container(
                                      margin: EdgeInsets.only(left: 15),
                                      child: SizedBox(
                                        width: MediaQuery.of(context).size.width * 0.65,
                                        child: SizedBox(
                                          width: MediaQuery.of(context).size.width * 0.65,
                                          child: Text("Silahkan masukkan alasan penolakan surat", style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white
                                          )),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                          );
                        }
                      },
                      child: Text("Tolak Verifikasi Surat", style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: HexColor("#990000")
                      )),
                      color: Colors.transparent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                          side: BorderSide(color: HexColor("#990000"), width: 2)
                      ),
                      padding: EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50),
                    ),
                    margin: EdgeInsets.only(top: 20, bottom: 20),
                  )
                ],
              )
          ),
        ),
      ),
    );
  }
}