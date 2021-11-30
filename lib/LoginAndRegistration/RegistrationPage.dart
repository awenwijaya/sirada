import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:surat/LoginAndRegistration/EmailConfirmation.dart';
import 'package:http/http.dart' as http;
import 'package:surat/shared/LoadingAnimation/loading.dart';

class registrationPage extends StatefulWidget {
  static var nik;
  const registrationPage({Key key}) : super(key: key);

  @override
  _registrationPageState createState() => _registrationPageState();
}

class _registrationPageState extends State<registrationPage> {
  final controllerNIK = TextEditingController();
  bool Loading = false;
  var apiURLcekPenduduk = "http://192.168.18.10:8000/api/cek_penduduk";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: new ThemeData(scaffoldBackgroundColor: HexColor("#FFFFFF")),
      home: Loading ? loading() : Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: Icon(CupertinoIcons.back),
                  color: Colors.black,
                  onPressed: (){Navigator.of(context).pop();},
                ),
                margin: EdgeInsets.only(top: 60, left: 10),
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  "Daftar Akun",
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      color: HexColor("#025393")
                  ),
                ),
              ),
              Container(
                child: Image.asset(
                  'images/regisform.png',
                  height: 200,
                  width: 200,
                ),
                margin: EdgeInsets.only(top: 45),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Text(
                        "Silahkan masukkan NIK yang tertera pada KTP Anda untuk melanjutkan",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 17,
                            fontWeight: FontWeight.w700
                        ),
                        textAlign: TextAlign.center,
                      ),
                      padding: EdgeInsets.only(left: 20, right: 20),
                      margin: EdgeInsets.only(top: 30),
                    ),
                    Container(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                        child: TextField(
                          controller: controllerNIK,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50.0),
                                borderSide: BorderSide(color: HexColor("#025393"))
                            ),
                            hintText: "Contoh: 3313091704330001",
                            prefixIcon: Icon(Icons.person_rounded),
                          ),
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 15
                          ),
                        ),
                      ),
                      margin: EdgeInsets.only(top: 30),
                    )
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: TextButton(
                  child: Text(
                    "Lanjutkan",
                    style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: HexColor("#025393")
                    ),
                  ),
                  onPressed: (){
                    if(controllerNIK.text == "") {
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
                                        "Data NIK belum diinputkan",
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700,
                                          color: HexColor("#025393"),
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      margin: EdgeInsets.only(top: 10),
                                    ),
                                    Container(
                                      child: Text(
                                        "Isikanlah data NIK terlebih dahulu sebelum melanjutkan",
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 15
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      margin: EdgeInsets.only(top: 10),
                                    )
                                  ],
                                )
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: Text('OK', style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w700,
                                  color: HexColor("#025393"),
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
                        "nik" : controllerNIK.text
                      });
                      http.post(Uri.parse(apiURLcekPenduduk),
                        headers: {"Content-Type" : "application/json"},
                        body: body
                      ).then((http.Response response) {
                        var data = response.statusCode;
                        if(data == 500) {
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
                                                "Data NIK tidak ditemukan",
                                                style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w700,
                                                  color: HexColor("#025393"),
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              margin: EdgeInsets.only(top: 10),
                                            ),
                                            Container(
                                              child: Text(
                                                "Pastikan Anda telah menginputkan data NIK yang benar dan coba lagi",
                                                style: TextStyle(
                                                    fontFamily: "Poppins",
                                                    fontSize: 15
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              margin: EdgeInsets.only(top: 10),
                                            )
                                          ],
                                        )
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('OK', style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w700,
                                          color: HexColor("#025393"),
                                        )),
                                        onPressed: (){Navigator.of(context).pop();},
                                      )
                                    ],
                                  );
                                }
                            );
                          });
                        }else if(data == 200) {
                          setState(() {
                            Loading = false;
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context){
                                return konfirmasiData();
                              }
                            );
                          });
                        }else{
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
                                                'images/warning.png',
                                                height: 50,
                                                width: 50,
                                              ),
                                            ),
                                            Container(
                                              child: Text(
                                                "Tidak dapat menghubungi server",
                                                style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w700,
                                                  color: HexColor("#025393"),
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              margin: EdgeInsets.only(top: 10),
                                            ),
                                            Container(
                                              child: Text(
                                                "Mohon maaf sedang ada kendala saat kami berusaha menghubungi server. Silahkan coba lagi",
                                                style: TextStyle(
                                                    fontFamily: "Poppins",
                                                    fontSize: 15
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              margin: EdgeInsets.only(top: 10),
                                            )
                                          ],
                                        )
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('OK', style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w700,
                                          color: HexColor("#025393"),
                                        )),
                                        onPressed: (){Navigator.of(context).pop();},
                                      )
                                    ],
                                  );
                                }
                            );
                          });
                        }
                      });
                    }
                  },
                ),
                margin: EdgeInsets.only(top: 20),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: TextButton(
                    child: Text(
                      "Mengapa saya perlu memasukkan NIK saya?",
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 14,
                          color: Colors.black
                      ),
                      textAlign: TextAlign.center,
                    ),
                    onPressed: (){
                      showDialog(
                          context: context,
                          barrierDismissible: true,
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
                                        'images/ktp.png',
                                        height: 50,
                                        width: 50,
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        "NIK",
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700,
                                          color: HexColor("#025393"),
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      margin: EdgeInsets.only(top: 10),
                                    ),
                                    Container(
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            child: Text(
                                              "NIK dalam aplikasi ini digunakan untuk verifikasi data penduduk yang sudah terdaftar sebelumnya pada sistem."
                                                  "\n\nSelain itu, NIK juga dapat memudahkan pemerintah desa dalam melakukan verifikasi dan pengurusan surat Anda."
                                                  "\n\nTenang! Data kependudukan Anda akan aman dan kami tidak akan menyalahgunakan data kependudukan Anda 😉",
                                              style: TextStyle(
                                                fontFamily: "Poppins",
                                                fontSize: 15,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                            margin: EdgeInsets.only(top: 10),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('OK', style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w700,
                                    color: HexColor("#025393"),
                                  )),
                                  onPressed: (){Navigator.of(context).pop();},
                                )
                              ],
                            );
                          }
                      );
                    },
                  ),
                ),
                margin: EdgeInsets.only(top: 40),
              )
            ],
          ),
        )
      ),
    );
  }
}

class konfirmasiData extends StatefulWidget {
  const konfirmasiData({Key key}) : super(key: key);

  @override
  _konfirmasiDataState createState() => _konfirmasiDataState();
}

class _konfirmasiDataState extends State<konfirmasiData> {
  var apiURLDataPenduduk = "http://192.168.18.10:8000/api/getdatabynik";



  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(40.0))
      ),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            child: Image.asset(
              'images/person.png',
              height: 50,
              width: 50,
            ),
          ),
          Container(
            child: Text(
              "Konfirmasi Data Anda",
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: HexColor("#025393")
              ),
              textAlign: TextAlign.center,
            ),
            margin: EdgeInsets.only(top: 10),
          ),
          Container(
            child: Text(
              "Silahkan konfirmasi data di bawah ini apakah data ini benar milik Anda",
              style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 15
              ),
              textAlign: TextAlign.center,
            ),
            margin: EdgeInsets.only(top: 10),
          )
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Benar', style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w700,
            color: HexColor("#025393")
          )),
          onPressed: (){Navigator.push(context, CupertinoPageRoute(builder: (context) => enterEmail()));},
        ),
        TextButton(
          child: Text('Tidak', style: TextStyle(
              fontFamily: "Poppins",
              fontWeight: FontWeight.w700,
              color: HexColor("#025393")
          )),
          onPressed: (){Navigator.of(context).pop();},
        )
      ],
    );
  }
}

class enterEmail extends StatefulWidget {
  const enterEmail({Key key}) : super(key: key);

  @override
  _enterEmailState createState() => _enterEmailState();
}

class _enterEmailState extends State<enterEmail> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: new ThemeData(scaffoldBackgroundColor: HexColor("#FFFFFF")),
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: Text(
                  "Registrasi Akun",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    color: HexColor("#025393")
                  ),
                ),
                margin: EdgeInsets.only(top: 70),
              ),
              Container(
                child: Image.asset(
                  'images/security.png',
                  height: 150,
                  width: 150,
                ),
                margin: EdgeInsets.only(top: 50),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Text(
                        "Silahkan masukkan email dan password dari akun Anda",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 17,
                          fontWeight: FontWeight.w700
                        ),
                        textAlign: TextAlign.center,
                      ),
                      padding: EdgeInsets.only(left: 20, right: 20),
                      margin: EdgeInsets.only(top: 50),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                              child: TextField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                    borderSide: BorderSide(color: HexColor("#025393")),
                                  ),
                                  hintText: "Email",
                                  prefixIcon: Icon(Icons.email_rounded)
                                ),
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 15
                                ),
                              ),
                            ),
                          ),
                          Container(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                              child: TextField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                    borderSide: BorderSide(color: HexColor("#025393"))
                                  ),
                                  prefixIcon: Icon(Icons.lock_rounded),
                                  hintText: "Password"
                                ),
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 15
                                ),
                                obscureText: true,
                              ),
                            ),
                          ),
                          Container(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                              child: TextField(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(50.0),
                                        borderSide: BorderSide(color: HexColor("#025393"))
                                    ),
                                    prefixIcon: Icon(Icons.lock_rounded),
                                    hintText: "Konfirmasi Password"
                                ),
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 15
                                ),
                                obscureText: true,
                              ),
                            ),
                          ),
                          Container(
                            child: FlatButton(
                              onPressed: (){
                                Navigator.push(context, CupertinoPageRoute(builder: (context) => emailConfirmation()));
                              },
                              child: Text('Daftar Akun', style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Poppins',
                                color: Colors.white,
                                fontWeight: FontWeight.w700
                              )),
                              color: HexColor("#025393"),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)
                              ),
                              padding: EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50),
                            ),
                            margin: EdgeInsets.only(top: 20),
                          )
                        ],
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