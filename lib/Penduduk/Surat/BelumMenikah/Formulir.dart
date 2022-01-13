import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:surat/LoginAndRegistration/LoginPage.dart';
import 'package:surat/Penduduk/Surat/PengajuanBerhasil.dart';
import 'package:surat/shared/LoadingAnimation/loading.dart';
import 'package:http/http.dart' as http;

class formSKBelumMenikah extends StatefulWidget {
  const formSKBelumMenikah({Key key}) : super(key: key);

  @override
  _formSKBelumMenikahState createState() => _formSKBelumMenikahState();
}

class _formSKBelumMenikahState extends State<formSKBelumMenikah> {
  final controllerKeperluan = TextEditingController();
  bool Loading = false;
  var apiURLCekNikah = "http://192.168.18.10:8000/api/sk/belumnikah/ceknikah";
  var apiURLSKBelumMenikah = "http://192.168.18.10:8000/api/sk/belumnikah/up";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Loading ? loading() : Scaffold(
        appBar: AppBar(
          title: Text("SK Belum Menikah", style: TextStyle(
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
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      child: Image.asset(
                        'images/person.png',
                        height: 100,
                        width: 100
                      ),
                      margin: EdgeInsets.only(top: 20),
                    ),
                    Container(
                      child: Text(
                        "Pengajuan SK Belum Menikah",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: HexColor("#025393")
                        ),
                        textAlign: TextAlign.center,
                      ),
                      margin: EdgeInsets.only(top: 10),
                    ),
                    Container(
                      alignment: Alignment.center,
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
                          controller: controllerKeperluan,
                          maxLines: 5,
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
                          if(controllerKeperluan.text == "") {
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
                                              'images/warning.png',
                                              height: 50,
                                              width: 50,
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                              "Data keperluan masih kosong",
                                              style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                  color: HexColor("#025393")
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                            margin: EdgeInsets.only(top: 10),
                                          ),
                                          Container(
                                            child: Text(
                                              "Data keperluan masih kosong. Silahkan isi data keperluan terlebih dahulu sebelum melanjutkan ke proses pengurusan SK Belum Menikah",
                                              style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontSize: 14
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                            margin: EdgeInsets.only(top: 10),
                                          ),
                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text("OK", style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: HexColor("#025393")
                                        )),
                                        onPressed: (){Navigator.of(context).pop();},
                                      )
                                    ],
                                  );
                                }
                            );
                          }else{
                            setState(() {
                              Loading = true;
                            });
                            var body = jsonEncode({
                              "penduduk_id" : loginPage.pendudukId
                            });
                            http.post(Uri.parse(apiURLCekNikah),
                              headers: {"Content-Type" : "application/json"},
                              body: body
                            ).then((http.Response response) {
                              var responseValue = response.statusCode;
                              if(responseValue == 200) {
                                var jsonData = response.body;
                                var parsedJson = json.decode(jsonData);
                                if(parsedJson['status_perkawinan'] == "Sudah Menikah") {
                                  setState(() {
                                    Loading = false;
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
                                                      'images/alert.png',
                                                      height: 50,
                                                      width: 50,
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Text(
                                                      "Tidak Dapat Melanjutkan",
                                                      style: TextStyle(
                                                        fontFamily: "Poppins",
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w700,
                                                        color: HexColor("#025393")
                                                      ),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                    margin: EdgeInsets.only(top: 10),
                                                  ),
                                                  Container(
                                                    child: Text(
                                                      "Maaf! Anda tidak dapat melakukan pengurusan SK Belum Menikah karena Anda terdaftar sudah menikah",
                                                      style: TextStyle(
                                                        fontFamily: "Poppins",
                                                        fontSize: 14
                                                      ),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                    margin: EdgeInsets.only(top: 10),
                                                  )
                                                ],
                                              ),
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                child: Text("OK", style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.w700,
                                                  color: HexColor("#025393")
                                                )),
                                                onPressed: (){Navigator.of(context).pop();},
                                              )
                                            ],
                                          );
                                      }
                                    );
                                  });
                                }else{
                                  var body = jsonEncode({
                                    'penduduk_id' : loginPage.pendudukId,
                                    'keperluan' : controllerKeperluan.text,
                                    'desa_id' : loginPage.desaId
                                  });
                                  http.post(Uri.parse(apiURLSKBelumMenikah),
                                    headers: {"Content-Type" : "application/json"},
                                    body: body
                                  ).then((http.Response response) {
                                    var responseValue = response.statusCode;
                                    if(responseValue == 200) {
                                      setState(() {
                                        Loading = false;
                                      });
                                      Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => pengajuanSKKelahiranBerhasil()));
                                    }
                                  });
                                }
                              }
                            });
                          }
                        },
                        child: Text(
                          "Ajukan SK Belum Menikah",
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
