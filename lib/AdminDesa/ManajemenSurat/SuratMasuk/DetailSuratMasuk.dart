import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:surat/AdminDesa/ManajemenSurat/SuratMasuk/ViewSuratMasuk.dart';
import 'package:url_launcher/url_launcher.dart';

class detailSuratMasukAdmin extends StatefulWidget {
  static var idSurat;
  const detailSuratMasukAdmin({Key key}) : super(key: key);

  @override
  State<detailSuratMasukAdmin> createState() => _detailSuratMasukAdminState();
}

class _detailSuratMasukAdminState extends State<detailSuratMasukAdmin> {
  var apiURLShowDetailSuratMasuk = "http://192.168.18.10:8000/api/data/admin/surat/keluar/view/${detailSuratMasukAdmin.idSurat}";
  var kodeSurat;
  var parindikan;
  var tanggalSurat;
  var mawitSaking;
  var tanggalMasuk;
  var namaPrajuru;
  var namaFile;
  bool LoadingData = true;

  Future getDetailSurat() {
    http.get(Uri.parse(apiURLShowDetailSuratMasuk),
        headers: {"Content-Type" : "application/json"}
    ).then((http.Response response) {
      var responseValue = response.statusCode;
      if(responseValue == 200) {
        var jsonData = response.body;
        var parsedJson = json.decode(jsonData);
        setState(() {
          LoadingData = false;
          kodeSurat = parsedJson['kode_nomor_surat'];
          parindikan = parsedJson['perihal'];
          tanggalSurat = parsedJson['tanggal_surat'];
          mawitSaking = parsedJson['asal_surat'];
          tanggalMasuk = parsedJson['tanggal_surat'];
          namaPrajuru = parsedJson['nama'];
          namaFile = parsedJson['file'];
        });
      }
    });
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
            color: HexColor("#025393"),
            onPressed: (){
              Navigator.of(context).pop();
            },
          ),
          title: Text("Detail Surat", style: TextStyle(
              fontFamily: "Poppins",
              fontWeight: FontWeight.w700,
              color: HexColor("#025393")
          )),
        ),
        body: LoadingData ? ProfilePageShimmer() : SingleChildScrollView(
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
                child: Text("Detail Surat", style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14,
                  fontWeight: FontWeight.w700
                )),
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(top: 15, left: 25)
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                        alignment: Alignment.topLeft,
                        child: Text("Kode Surat", style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14,
                            fontWeight: FontWeight.w700
                        )),
                        margin: EdgeInsets.only(top: 15)
                    ),
                    Container(
                        alignment: Alignment.topLeft,
                        child: Text(kodeSurat, style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14
                        )),
                        margin: EdgeInsets.only(top: 5)
                    ),
                    Container(
                        alignment: Alignment.topLeft,
                        child: Text("Parindikan", style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14,
                            fontWeight: FontWeight.w700
                        )),
                        margin: EdgeInsets.only(top: 15)
                    ),
                    Container(
                        alignment: Alignment.topLeft,
                        child: Text(parindikan, style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14
                        )),
                        margin: EdgeInsets.only(top: 5)
                    ),
                    Container(
                        alignment: Alignment.topLeft,
                        child: Text("Tanggal Surat", style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14,
                            fontWeight: FontWeight.w700
                        )),
                        margin: EdgeInsets.only(top: 15)
                    ),
                    Container(
                        alignment: Alignment.topLeft,
                        child: Text(tanggalSurat, style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14
                        )),
                        margin: EdgeInsets.only(top: 5)
                    ),
                    Container(
                        alignment: Alignment.topLeft,
                        child: Text("Mawit Saking", style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14,
                            fontWeight: FontWeight.w700
                        )),
                        margin: EdgeInsets.only(top: 15)
                    ),
                    Container(
                        alignment: Alignment.topLeft,
                        child: Text(mawitSaking, style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14
                        )),
                        margin: EdgeInsets.only(top: 5)
                    ),
                    Container(
                        alignment: Alignment.topLeft,
                        child: Text("Tanggal Masuk", style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14,
                            fontWeight: FontWeight.w700
                        )),
                        margin: EdgeInsets.only(top: 15)
                    ),
                    Container(
                        alignment: Alignment.topLeft,
                        child: Text(tanggalMasuk, style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14
                        )),
                        margin: EdgeInsets.only(top: 5)
                    ),
                    Container(
                        alignment: Alignment.topLeft,
                        child: Text("Nama Prajuru", style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14,
                            fontWeight: FontWeight.w700
                        )),
                        margin: EdgeInsets.only(top: 15)
                    ),
                    Container(
                        alignment: Alignment.topLeft,
                        child: Text(namaPrajuru, style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14
                        )),
                        margin: EdgeInsets.only(top: 5, bottom: 15)
                    ),
                  ],
                ),
                  decoration: BoxDecoration(
                      color: HexColor("EEEEEE"),
                      borderRadius: BorderRadius.circular(25)
                  ),
                  padding: EdgeInsets.only(top: 10, bottom: 10, left: 30, right: 30),
                  margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20)
              ),
              Container(
                child: FlatButton(
                  onPressed: () async {
                    setState(() {
                      viewSuratMasukAdmin.namaFile = namaFile;
                    });
                    Navigator.push(context, CupertinoPageRoute(builder: (context) => viewSuratMasukAdmin()));
                  },
                    child: Text("Lihat Surat", style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: HexColor("#025393")
                    )),
                    color: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                        side: BorderSide(color: HexColor("#025393"), width: 2)
                    ),
                    padding: EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50)
                )
              )
            ]
          )
        )
      ),
    );
  }
}
