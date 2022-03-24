import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

class detailPrajuruBanjarAdatAdmin extends StatefulWidget {
  static var prajuruBanjarAdatId;
  const detailPrajuruBanjarAdatAdmin({Key key}) : super(key: key);

  @override
  State<detailPrajuruBanjarAdatAdmin> createState() => _detailPrajuruBanjarAdatAdminState();
}

class _detailPrajuruBanjarAdatAdminState extends State<detailPrajuruBanjarAdatAdmin> {
  var jabatan;
  var namaBanjar;
  var statusPrajuruBanjarAdat;
  var tanggalMulaiMenjabat;
  var tanggalAkhirMenjabat;
  var agama;
  var nama;
  var namaAlias;
  var tempatLahir;
  var tanggalLahir;
  var jenisKelamin;
  var golonganDarah;
  var alamat;
  var profesi;

  var apiURLDetailPrajuruBanjarAdat = "http://192.168.18.10:8000/api/data/staff/prajuru_banjar_adat/detail/${detailPrajuruBanjarAdatAdmin.prajuruBanjarAdatId}";

  getPrajuruBanjarAdatInfo() async {
    http.get(Uri.parse(apiURLDetailPrajuruBanjarAdat),
      headers: {"Content-Type" : "application/json"}
    ).then((http.Response response) {
      var responseValue = response.statusCode;
      if(responseValue == 200) {
        var jsonData = response.body;
        var parsedJson = json.decode(jsonData);
        setState(() {
          jabatan = parsedJson['jabatan'];
          namaBanjar = parsedJson['nama_banjar_adat'];
          statusPrajuruBanjarAdat = parsedJson['status_prajuru_banjar_adat'];
          tanggalMulaiMenjabat = parsedJson['tanggal_mulai_menjabat'];
          tanggalAkhirMenjabat = parsedJson['tanggal_akhir_menjabat'];
          agama = parsedJson['agama'];
          nama = parsedJson['nama'];
          namaAlias = parsedJson['nama_alias'];
          tempatLahir = parsedJson['tempat_lahir'];
          tanggalLahir = parsedJson['tanggal_lahir'];
          golonganDarah = parsedJson['golongan_darah'];
          alamat = parsedJson['alamat'];
          profesi = parsedJson['profesi'];
          jenisKelamin = parsedJson['jenis_kelamin'];
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPrajuruBanjarAdatInfo();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Detail Prajuru", style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w700,
            color: HexColor("#025393")
          )),
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: HexColor("#025393"),
            onPressed: (){Navigator.of(context).pop();},
          )
        ),
        body: nama == null ? ProfilePageShimmer() : SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: Image.asset(
                  'images/person.png',
                  height: 100,
                  width: 100
                ),
                margin: EdgeInsets.only(top: 30)
              ),
              Container(
                child: Text(nama, style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: HexColor("#025393")
                ), textAlign: TextAlign.center),
                margin: EdgeInsets.only(top: 20)
              ),
              Container(
                child: Text(statusPrajuruBanjarAdat == "aktif" ? "AKTIF" : "TIDAK AKTIF", style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.white
                )),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: statusPrajuruBanjarAdat == 1 ? HexColor("019267") : HexColor("fab73d")
                ),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                margin: EdgeInsets.only(top: 10)
              ),
              Container(
                child: Text("Detail Prajuru", style: TextStyle(
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
                      child: Text("Nama Alias", style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14,
                        fontWeight: FontWeight.w700
                      )),
                      margin: EdgeInsets.only(top: 15)
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(namaAlias == null ? "Tidak Ada" : namaAlias, style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14
                      )),
                      margin: EdgeInsets.only(top: 5)
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text("Jabatan", style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14,
                        fontWeight: FontWeight.w700
                      )),
                      margin: EdgeInsets.only(top: 15)
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(jabatan, style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14
                      )),
                      margin: EdgeInsets.only(top: 5)
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text("Asal Banjar", style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14,
                        fontWeight: FontWeight.w700
                      )),
                      margin: EdgeInsets.only(top: 15)
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(namaBanjar, style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14
                      )),
                      margin: EdgeInsets.only(top: 5)
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text("Tanggal Mulai Menjabat", style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14,
                        fontWeight: FontWeight.w700
                      )),
                      margin: EdgeInsets.only(top: 15)
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(tanggalMulaiMenjabat, style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14
                      )),
                      margin: EdgeInsets.only(top: 5)
                    ),
                    Container(
                        alignment: Alignment.topLeft,
                        child: statusPrajuruBanjarAdat == 1 ? Container() : Container(
                            child: Column(
                                children: <Widget>[
                                  Container(
                                      alignment: Alignment.topLeft,
                                      child: Text("Tanggal Akhir Menjabat", style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700
                                      )),
                                      margin: EdgeInsets.only(top: 15)
                                  ),
                                  Container(
                                      alignment: Alignment.topLeft,
                                      child: Text(tanggalAkhirMenjabat, style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 14
                                      )),
                                      margin: EdgeInsets.only(top: 5)
                                  )
                                ]
                            )
                        )
                    ),
                    Container(
                        alignment: Alignment.topLeft,
                        child: Text("Agama", style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14,
                            fontWeight: FontWeight.w700
                        )),
                        margin: EdgeInsets.only(top: 15)
                    ),
                    Container(
                        alignment: Alignment.topLeft,
                        child: Text(agama, style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14
                        )),
                        margin: EdgeInsets.only(top: 5)
                    ),
                    Container(
                        alignment: Alignment.topLeft,
                        child: Text("Tempat Lahir", style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14,
                            fontWeight: FontWeight.w700
                        )),
                        margin: EdgeInsets.only(top: 15)
                    ),
                    Container(
                        alignment: Alignment.topLeft,
                        child: Text(tempatLahir, style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14
                        )),
                        margin: EdgeInsets.only(top: 5)
                    ),
                    Container(
                        alignment: Alignment.topLeft,
                        child: Text("Tanggal Lahir", style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14,
                            fontWeight: FontWeight.w700
                        )),
                        margin: EdgeInsets.only(top: 15)
                    ),
                    Container(
                        alignment: Alignment.topLeft,
                        child: Text(tanggalLahir, style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14
                        )),
                        margin: EdgeInsets.only(top: 5)
                    ),
                    Container(
                        alignment: Alignment.topLeft,
                        child: Text("Jenis Kelamin", style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14,
                            fontWeight: FontWeight.w700
                        )),
                        margin: EdgeInsets.only(top: 15)
                    ),
                    Container(
                        alignment: Alignment.topLeft,
                        child: Text(jenisKelamin, style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14
                        )),
                        margin: EdgeInsets.only(top: 5)
                    ),
                    Container(
                        alignment: Alignment.topLeft,
                        child: Text("Golongan Darah", style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14,
                            fontWeight: FontWeight.w700
                        )),
                        margin: EdgeInsets.only(top: 15)
                    ),
                    Container(
                        alignment: Alignment.topLeft,
                        child: Text(golonganDarah, style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14
                        )),
                        margin: EdgeInsets.only(top: 5)
                    ),
                    Container(
                        alignment: Alignment.topLeft,
                        child: Text("Alamat", style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14,
                            fontWeight: FontWeight.w700
                        )),
                        margin: EdgeInsets.only(top: 15)
                    ),
                    Container(
                        alignment: Alignment.topLeft,
                        child: Text(alamat, style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14
                        )),
                        margin: EdgeInsets.only(top: 5)
                    ),
                    Container(
                        alignment: Alignment.topLeft,
                        child: Text("Profesi", style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14,
                            fontWeight: FontWeight.w700
                        )),
                        margin: EdgeInsets.only(top: 15)
                    ),
                    Container(
                        alignment: Alignment.topLeft,
                        child: Text(profesi, style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14
                        )),
                        margin: EdgeInsets.only(top: 5)
                    )
                  ]
                ),
                decoration: BoxDecoration(
                  color: HexColor("EEEEEE"),
                  borderRadius: BorderRadius.circular(25)
                ),
                padding: EdgeInsets.only(top: 10, bottom: 10, left: 30, right: 30),
                margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20)
              )
            ]
          )
        )
      )
    );
  }
}