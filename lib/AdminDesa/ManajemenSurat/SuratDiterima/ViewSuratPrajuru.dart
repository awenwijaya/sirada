import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:surat/AdminDesa/ManajemenSurat/SuratKeluar/ViewLampiran.dart';
import 'package:surat/shared/LoadingAnimation/loading.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/flutter_svg.dart';

class viewSuratKeluarTetujonPrajuruAdmin extends StatefulWidget {
  static var suratKeluarId;
  const viewSuratKeluarTetujonPrajuruAdmin({Key key}) : super(key: key);

  @override
  State<viewSuratKeluarTetujonPrajuruAdmin> createState() => _viewSuratKeluarTetujonPrajuruAdminState();
}

class _viewSuratKeluarTetujonPrajuruAdminState extends State<viewSuratKeluarTetujonPrajuruAdmin> {
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
  var namaPenyarikan;
  var namaBendesa;
  var kecamatanId;
  var status;
  var qrCodeBendesa;
  var qrCodePenyarikan;

  List tetujonPrajuruDesaList = [];
  List tetujonPrajuruBanjarList = [];
  List tetujonPihakLainList = [];
  List tumusanPrajuruBanjarList = [];
  List tumusanPrajuruDesaList = [];
  List tumusanPihakLainList = [];
  List<String> tetujon = [];
  List<String> tumusan = [];
  List<String> tetujonTerlampir = [];
  List lampiran = [];

  bool LoadData = true;
  var apiURLShowDetailSuratKeluar = "https://siradaskripsi.my.id/api/data/surat/keluar/view/${viewSuratKeluarTetujonPrajuruAdmin.suratKeluarId}";
  var apiURLShowPrajuru = "https://siradaskripsi.my.id/api/data/admin/surat/keluar/prajuru/${viewSuratKeluarTetujonPrajuruAdmin.suratKeluarId}";
  var apiURLGetLampiran = "https://siradaskripsi.my.id/api/data/admin/surat/keluar/lampiran/${viewSuratKeluarTetujonPrajuruAdmin.suratKeluarId}";

  //get tetujon
  var apiURLGetTetujonPrajuruDesa = "https://siradaskripsi.my.id/api/data/surat/keluar/tetujon/prajuru/desa/${viewSuratKeluarTetujonPrajuruAdmin.suratKeluarId}";
  var apiURLGetTetujonPrajuruBanjar = "https://siradaskripsi.my.id/api/data/surat/keluar/tetujon/prajuru/banjar/${viewSuratKeluarTetujonPrajuruAdmin.suratKeluarId}";
  var apiURLGetTetujonPihakLain = "https://siradaskripsi.my.id/api/data/surat/keluar/tetujon/pihak-lain/${viewSuratKeluarTetujonPrajuruAdmin.suratKeluarId}";
  var apiURLGetTumusanPrajuruDesa = "https://siradaskripsi.my.id/api/data/surat/keluar/tumusan/prajuru/desa/${viewSuratKeluarTetujonPrajuruAdmin.suratKeluarId}";
  var apiURLGetTumusanPrajuruBanjar = "https://siradaskripsi.my.id/api/data/surat/keluar/tumusan/prajuru/banjar/${viewSuratKeluarTetujonPrajuruAdmin.suratKeluarId}";
  var apiURLGetTumusanPihakLain = "https://siradaskripsi.my.id/api/data/surat/keluar/tumusan/pihak-lain/${viewSuratKeluarTetujonPrajuruAdmin.suratKeluarId}";

  var apiURLGetQrCode = "https://siradaskripsi.my.id/api/data/admin/surat/keluar/validasi/qrcode/${viewSuratKeluarTetujonPrajuruAdmin.suratKeluarId}";

  getQRCode() async {
    http.get(Uri.parse(apiURLGetQrCode),
        headers: {"Content-Type" : "application/json"}
    ).then((http.Response response) {
      var responseValue = response.statusCode;
      if(responseValue == 200) {
        var jsonData = json.decode(response.body);
        setState(() {
          qrCodeBendesa = jsonData['validasi_ketua'];
          qrCodePenyarikan = jsonData['validasi_penyarikan'];
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
      }
    });
    for(var i = 0; i < tetujonPihakLainList.length; i++) {
      tetujonTerlampir.add("${tetujonPihakLainList[i]['pihak_lain']}");
    }
    for(var i = 0; i < tetujonPrajuruBanjarList.length; i++) {
      tetujonTerlampir.add("Banjar ${tetujonPrajuruBanjarList[i]['nama_banjar_adat']} (${tetujonPrajuruBanjarList[i]['nama']})");
    }
    for(var i = 0; i < tetujonPrajuruDesaList.length; i++) {
      tetujonTerlampir.add("${tetujonPrajuruDesaList[i]['jabatan']} (${tetujonPrajuruDesaList[i]['nama']})");
    }
    if(tetujonTerlampir.length > 2) {
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
      }else {
        setState(() {
          tetujon.add(tetujonTerlampir[0]);
          tetujon.add(tetujonTerlampir[1]);
          tetujonTerlampir.removeAt(0);
          tetujonTerlampir.removeAt(1);
        });
      }
    }
  }

  getTumusan() async {
    this.tumusan = [];
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
          tumusan.add("${tumusanPrajuruDesaList[i]['jabatan']} (${tumusanPrajuruDesaList[i]['nama']})");
        }
      }
    });
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
          tumusan.add("Banjar ${tumusanPrajuruBanjarList[i]['nama_banjar_adat']} (${tumusanPrajuruBanjarList[i]['nama']})");
        }
      }
    });
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

  getSuratKeluarInfo() async {
    http.get(Uri.parse(apiURLShowDetailSuratKeluar),
        headers: {"Content-Type" : "application/json"}
    ).then((http.Response response) {
      var responseValue = response.statusCode;
      print("status get surat: ${response.statusCode.toString()}");
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
          status = parsedJson['status'];
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

  getPenyarikanInfo() async {
    var body = jsonEncode({
      "jabatan" : "penyarikan"
    });
    http.post(Uri.parse(apiURLShowPrajuru),
        headers: {"Content-Type" : "application/json"},
        body: body
    ).then((http.Response response) {
      if(response.statusCode == 200) {
        var jsonData = response.body;
        var parsedJson = json.decode(jsonData);
        setState(() {
          namaPenyarikan = parsedJson['nama'];
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

  getDetailSurat() async {
    await getSuratKeluarInfo();
    await getBendesaInfo();
    await getPenyarikanInfo();
    await getTetujon();
    await getTumusan();
    await getLampiran();
    await getQRCode();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDetailSurat();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: HexColor("025393"),
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
            LoadData ? ProfilePageShimmer() : SingleChildScrollView(
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
                                      image: NetworkImage('https://storage.siradaskripsi.my.id/img/logo-desa/${logoDesa}'),
                                      fit: BoxFit.fill
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
                        ]
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
                      margin: EdgeInsets.only(right: 15, top: 15)
                  ),
                  Container(
                      alignment: Alignment.topRight,
                      child: Text("Katur Majeng Ring :", style: TextStyle(
                          fontFamily: "Times New Roman",
                          fontSize: 16
                      ), textAlign: TextAlign.center),
                      margin: EdgeInsets.only(top: 10, right: 15)
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    child: Container(
                      child: Column(
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
                            child: tetujonTerlampir.isNotEmpty ? Text("(Terlampir)", style: TextStyle(
                                fontFamily: "Times New Roman",
                                fontSize: 16
                            )) : Container(),
                          )
                        ],
                      ),
                    ),
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
                      margin: EdgeInsets.only(left: 15, top: 10)
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
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                                alignment: Alignment.topLeft,
                                child: namaBendesa == null ? Container() : Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      child: Text("Bendesa", style: TextStyle(
                                          fontFamily: "Times New Roman",
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700
                                      ), textAlign: TextAlign.center),
                                    ),
                                    Container(
                                      child: qrCodeBendesa == "Belum tervalidasi" ? Container() : qrCodeBendesa == null ? Container() : Container(
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
                                margin: EdgeInsets.only(left: 10, top: 10)
                            ),
                            Container(
                                alignment: Alignment.topRight,
                                child: namaPenyarikan == null ? Container() : Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                        child: Text("Penyarikan", style: TextStyle(
                                            fontFamily: "Times New Roman",
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700
                                        ))
                                    ),
                                    Container(
                                      child: qrCodePenyarikan == null ? Container() : qrCodePenyarikan == "Belum tervalidasi" ? Container() : Container(
                                          child: SvgPicture.network(
                                            "https://storage.siradaskripsi.my.id/file/validasi/${qrCodePenyarikan}",
                                            height: 50,
                                            placeholderBuilder: (context) => CircularProgressIndicator(),
                                          ),
                                          margin: EdgeInsets.only(top: 10)
                                      ),
                                    ),
                                    Container(
                                        child: Text(namaPenyarikan, style: TextStyle(
                                            fontFamily: "Times New Roman",
                                            fontSize: 16
                                        )),
                                        margin: EdgeInsets.only(top: 10)
                                    )
                                  ],
                                ),
                                margin: EdgeInsets.only(top: 10, right: 10)
                            ),
                          ]
                      )
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
                                fontSize: 16
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
                      margin: EdgeInsets.only(left: 15, top: 10)
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
                                onTap: (){
                                  setState(() {
                                    viewLampiranSuratKeluarAdmin.namaFile = lampiran[i]['file'];
                                  });
                                  Navigator.push(context, CupertinoPageRoute(builder: (context) => viewLampiranSuratKeluarAdmin()));
                                },
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
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

