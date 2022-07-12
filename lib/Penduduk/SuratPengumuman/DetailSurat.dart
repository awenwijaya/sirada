import 'dart:convert';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:surat/Penduduk/SuratPengumuman/Lampiran.dart';
import 'package:surat/shared/LoadingAnimation/loading.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:surat/LoginAndRegistration/LoginPage.dart';

class detailSuratPrajuruKrama extends StatefulWidget {
  static var suratKeluarId;
  static var status;
  const detailSuratPrajuruKrama({Key key}) : super(key: key);

  @override
  State<detailSuratPrajuruKrama> createState() => _detailSuratPrajuruKramaState();
}

class _detailSuratPrajuruKramaState extends State<detailSuratPrajuruKrama> {
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
  var qrCodeBendesa;
  var qrCodePenyarikan;
  var status;
  var pihakKrama;
  var validasiStatus;
  FToast ftoast;
  List lampiran = [];
  List tumusanPrajuruBanjarList = [];
  List tumusanPrajuruDesaList = [];
  List tumusanPihakLainList = [];
  List<String> tumusan = [];
  bool LoadData = true;
  var apiURLGetLampiran = "https://siradaskripsi.my.id/api/data/admin/surat/keluar/lampiran/${detailSuratPrajuruKrama.suratKeluarId}";
  var apiURLShowDetailSuratKeluar = "https://siradaskripsi.my.id/api/data/surat/keluar/view/${detailSuratPrajuruKrama.suratKeluarId}";
  var apiURLShowPrajuru = "https://siradaskripsi.my.id/api/data/admin/surat/keluar/prajuru/${detailSuratPrajuruKrama.suratKeluarId}";
  var apiURLGetTumusanPrajuruDesa = "https://siradaskripsi.my.id/api/data/surat/keluar/tumusan/prajuru/desa/${detailSuratPrajuruKrama.suratKeluarId}";
  var apiURLGetTumusanPrajuruBanjar = "https://siradaskripsi.my.id/api/data/surat/keluar/tumusan/prajuru/banjar/${detailSuratPrajuruKrama.suratKeluarId}";
  var apiURLGetTumusanPihakLain = "https://siradaskripsi.my.id/api/data/surat/keluar/tumusan/pihak-lain/${detailSuratPrajuruKrama.suratKeluarId}";
  var apiURLGetQrCode = "https://siradaskripsi.my.id/api/data/admin/surat/keluar/validasi/qrcode/${detailSuratPrajuruKrama.suratKeluarId}";
  var apiURLSetRead = "https://siradaskripsi.my.id/api/krama/view/surat/set-read";

  setReadSurat() async {
    var body = jsonEncode({
      "surat_keluar_id" : detailSuratPrajuruKrama.suratKeluarId.toString(),
      "user_id" : loginPage.userId
    });
    http.post(Uri.parse(apiURLSetRead),
      headers: {"Content-Type" : "application/json"},
      body: body
    ).then((http.Response response) {
      var responseValue = response.statusCode;
      if(responseValue == 200) {
        print("set status read krama telah berhasil");
      }
    });
  }

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSuratKeluarInfo();
    getBendesaInfo();
    getPenyarikanInfo();
    getTumusan();
    getLampiran();
    getQRCode();
    if(detailSuratPrajuruKrama.status == "Belum Terbaca") {
      setReadSurat();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: HexColor("025393"),
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
                          child: Text(pihakKrama, style: TextStyle(
                              fontFamily: "Times New Roman",
                              fontSize: 16
                          )),
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
                                      margin: EdgeInsets.only(top: 10, left: 10)
                                  ),
                                  Container(
                                      alignment: Alignment.topRight,
                                      child: namaPenyarikan == null ? Container() : Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
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
                          child: Divider(
                              color: Colors.black38
                          ),
                          margin: EdgeInsets.symmetric(horizontal: 15),
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
                                          viewLampiranSuratKeluarKrama.namaFile = lampiran[i]['file'];
                                        });
                                        Navigator.push(context, CupertinoPageRoute(builder: (context) => viewLampiranSuratKeluarKrama()));
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
              )
            ],
          )
      ),
    );
  }
}
