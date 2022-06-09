import 'dart:convert';
import 'package:surat/KramaPanitia/SuratKeluarPanitia/ViewLampiran.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;

class detailSuratKeluarPanitia extends StatefulWidget {
  static var suratKeluarId;
  const detailSuratKeluarPanitia({Key key}) : super(key: key);

  @override
  State<detailSuratKeluarPanitia> createState() => _detailSuratKeluarPanitiaState();
}

class _detailSuratKeluarPanitiaState extends State<detailSuratKeluarPanitia> {
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
  List tetujonPrajuruDesaList = [];
  List tetujonPrajuruBanjarList = [];
  List tetujonPihakLainList = [];
  List tumusanPrajuruBanjarList = [];
  List tumusanPrajuruDesaList = [];
  List tumusanPihakLainList = [];

  List<String> tetujon = [];
  List<String> tumusan = [];
  List lampiran = [];
  List historiSurat = [];

  bool LoadData = true;
  var apiURLShowDetailSuratKeluar = "https://siradaskripsi.my.id/api/data/surat/keluar/view/${detailSuratKeluarPanitia.suratKeluarId}";
  var apiURLShowPrajuru = "https://siradaskripsi.my.id/api/data/admin/surat/keluar/prajuru/${detailSuratKeluarPanitia.suratKeluarId}";
  var apiURLGetLampiran = "https://siradaskripsi.my.id/api/data/admin/surat/keluar/lampiran/${detailSuratKeluarPanitia.suratKeluarId}";
  //get tetujon
  var apiURLGetTetujonPrajuruDesa = "https://siradaskripsi.my.id/api/data/surat/keluar/tetujon/prajuru/desa/${detailSuratKeluarPanitia.suratKeluarId}";
  var apiURLGetTetujonPrajuruBanjar = "https://siradaskripsi.my.id/api/data/surat/keluar/tetujon/prajuru/banjar/${detailSuratKeluarPanitia.suratKeluarId}";
  var apiURLGetTetujonPihakLain = "https://siradaskripsi.my.id/api/data/surat/keluar/tetujon/pihak-lain/${detailSuratKeluarPanitia.suratKeluarId}";
  var apiURLGetTumusanPrajuruDesa = "https://siradaskripsi.my.id/api/data/surat/keluar/tumusan/prajuru/desa/${detailSuratKeluarPanitia.suratKeluarId}";
  var apiURLGetTumusanPrajuruBanjar = "https://siradaskripsi.my.id/api/data/surat/keluar/tumusan/prajuru/banjar/${detailSuratKeluarPanitia.suratKeluarId}";
  var apiURLGetTumusanPihakLain = "https://siradaskripsi.my.id/api/data/surat/keluar/tumusan/pihak-lain/${detailSuratKeluarPanitia.suratKeluarId}";
  var apiURLShowPanitia = "https://siradaskripsi.my.id/api/data/admin/surat/keluar/panitia/${detailSuratKeluarPanitia.suratKeluarId}";
  var apiURLGetHistori = "https://siradaskripsi.my.id/api/data/admin/surat/keluar/histori/${detailSuratKeluarPanitia.suratKeluarId}";

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
      if(responseValue == 200) {
        var jsonData = json.decode(response.body);
        setState(() {
          historiSurat = jsonData;
        });
      }
    });
  }

  getTetujon() async {
    http.get(Uri.parse(apiURLGetTetujonPrajuruDesa),
        headers: {"Content-Type" : "application/json"}
    ).then((http.Response response) {
      var responseValue = response.statusCode;
      if(responseValue == 200) {
        var jsonData = json.decode(response.body);
        setState(() {
          tetujonPrajuruDesaList = jsonData;
        });
        for(var i = 0; i < tetujonPrajuruDesaList.length; i++) {
          tetujon.add("Desa ${tetujonPrajuruDesaList[i]['desadat_nama']} - ${tetujonPrajuruDesaList[i]['nama']}");
        }
      }
    });
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
          tumusan.add("Desa ${tumusanPrajuruDesaList[i]['desadat_nama']} - ${tumusanPrajuruDesaList[i]['nama']}");
        }
      }
    });
  }

  getTetujonPrajuruBanjar() async {
    http.get(Uri.parse(apiURLGetTetujonPrajuruBanjar),
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
          tetujon.add("Banjar ${tetujonPrajuruBanjarList[i]['nama_banjar_adat']} - ${tetujonPrajuruBanjarList[i]['nama']}");
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

  getTetujonPihakLain() async {
    http.get(Uri.parse(apiURLGetTetujonPihakLain),
        headers: {"Content-Type" : "application/json"}
    ).then((http.Response response) {
      var responseValue = response.statusCode;
      if(responseValue == 200) {
        var jsonData = json.decode(response.body);
        setState(() {
          tetujonPihakLainList = jsonData;
        });
        for(var i = 0; i < tetujonPihakLainList.length; i++) {
          tetujon.add("${tetujonPihakLainList[i]['pihak_lain']}");
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSuratKeluarInfo();
    getBendesaInfo();
    getKetuaPanitiaInfo();
    getSekretarisPanitiaInfo();
    getTetujon();
    getTetujonPrajuruBanjar();
    getTetujonPihakLain();
    getTumusan();
    getTumusanPrajuruBanjar();
    getTumusanPihakLain();
    getHistori();
    getLampiran();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: HexColor("#025393"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: (){
              Navigator.of(context).pop();
            },
          ),
          title: Text(parindikan == null ? "" : parindikan, style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w700,
            color: Colors.white
          )),
          actions: <Widget>[
            IconButton(
              onPressed: (){},
              icon: Icon(Icons.edit),
              color: Colors.white,
            )
          ],
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
                            margin: EdgeInsets.only(left: 20),
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
                      child: tetujon.length == 0 ? Text("-", style: TextStyle(
                          fontFamily: "Times New Roman",
                          fontSize: 16
                      )) : Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          for(var i = 0; i < tetujon.length; i++) Text("${i+1}. ${tetujon[i].toString()}", textAlign: TextAlign.right, style: TextStyle(
                              fontFamily: "Times New Roman",
                              fontSize: 16
                          ))
                        ],
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
                                )) : Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    for(var i = 0; i < tumusan.length; i++) Text("${i+1}. ${tumusan[i].toString()}", style: TextStyle(
                                        fontFamily: "Times New Roman",
                                        fontSize: 16
                                    ))
                                  ],
                                ),
                                margin: EdgeInsets.only(left: 5),
                              )
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
                        child: Stack(
                            children: <Widget>[
                              Container(
                                  alignment: Alignment.topLeft,
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
                                          child: Text(namaKetua, style: TextStyle(
                                              fontFamily: "Times New Roman",
                                              fontSize: 16
                                          )),
                                          margin: EdgeInsets.only(top: 25)
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
                                          child: Text(namaSekretaris, style: TextStyle(
                                              fontFamily: "Times New Roman",
                                              fontSize: 16
                                          )),
                                          margin: EdgeInsets.only(top: 25)
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
                                child: Text(namaBendesa, style: TextStyle(
                                    fontFamily: "Times New Roman",
                                    fontSize: 16
                                )),
                                margin: EdgeInsets.only(top: 25)
                            )
                          ],
                        ),
                        margin: EdgeInsets.only(top: 20)
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
                                      viewLampiranSuratKeluarPanitia.namaFile = lampiran[i]['file'];
                                    });
                                    Navigator.push(context, CupertinoPageRoute(builder: (context) => viewLampiranSuratKeluarPanitia()));
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
                    Container(
                        child: Text("Status Surat", style: TextStyle(
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
                            indicatorStyle: IndicatorStyle(
                                color: HexColor("#025393"),
                                height: 30,
                                width: 30
                            ),
                            isFirst: i == 0 ? true : false,
                            endChild: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    child: Text(historiSurat[i]['created_at'], style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700
                                    )),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(right: 10),
                                    child: Text("${historiSurat[i]['histori']} oleh ${historiSurat[i]['nama']}", style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 14
                                    )),
                                  )
                                ],
                              ),
                              margin: EdgeInsets.only(left: 15),
                            ),
                          )
                        ],
                      ),
                      margin: EdgeInsets.only(top: 10, bottom: 10, left: 15),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
