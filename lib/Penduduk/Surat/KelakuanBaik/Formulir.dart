import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:surat/Penduduk/Surat/KelakuanBaik/BerkasPersyaratan.dart';
import 'package:surat/Penduduk/Surat/PengajuanBerhasil.dart';
import 'package:surat/shared/LoadingAnimation/loading.dart';
import 'package:http/http.dart' as http;
import 'package:surat/LoginAndRegistration/LoginPage.dart';

class formSKKelakuanBaik extends StatefulWidget {
  const formSKKelakuanBaik({Key key}) : super(key: key);

  @override
  _formSKKelakuanBaikState createState() => _formSKKelakuanBaikState();
}

class _formSKKelakuanBaikState extends State<formSKKelakuanBaik> {
  final controllerKeperluan = TextEditingController();
  bool Loading = false;
  var apiURLSKKelakuanBaik = "http://192.168.18.10:8000/api/sk/kelakuanbaik/up";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Loading ? loading() : Scaffold(
        appBar: AppBar(
          title: Text("Pengajuan SK", style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w700,
            color: HexColor("#025393")
          )),
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: HexColor("#025393"),
            onPressed: (){Navigator.of(context).pop();},
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: Image.asset(
                  'images/thumb.png',
                  height: 100,
                  width: 100,
                ),
                margin: EdgeInsets.only(top: 20),
              ),
              Container(
                child: Text(
                  "Silahkan masukkan keperluan Anda dalam mengurus surat ini.\n\nKeperluan Anda nantinya akan otomatis dimasukkan ke dalam berkas surat ketika berkas surat sudah di verifikasi.",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14
                  ),
                  textAlign: TextAlign.center,
                ),
                padding: EdgeInsets.only(left: 30, right: 30),
                margin: EdgeInsets.only(top: 20),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                  child: TextField(
                    maxLines: 5,
                    controller: controllerKeperluan,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(color: HexColor("#025393"))
                      ),
                      hintText: "Keperluan Anda"
                    ),
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 14
                    ),
                  ),
                ),
                margin: EdgeInsets.only(top: 20),
              ),
              Container(
                child: FlatButton(
                  onPressed: (){
                    Navigator.push(context, CupertinoPageRoute(builder: (context) => berkasPersyaratanKelakuanBaik()));
                  },
                  child: Text(
                    "Simpan & Unggah Berkas Persyaratan",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 14,
                      color: HexColor("#025393"),
                      fontWeight: FontWeight.w700
                    ),
                  ),
                  color: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                    side: BorderSide(color: HexColor("#025393"), width: 2)
                  ),
                  padding: EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50),
                ),
                margin: EdgeInsets.only(top: 20),
              )
            ],
          ),
        ),
      ),
    );
  }
}