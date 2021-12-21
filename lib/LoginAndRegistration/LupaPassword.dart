import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:surat/WelcomeScreen.dart';
import 'package:surat/shared/LoadingAnimation/loading.dart';
import 'package:http/http.dart' as http;

class lupaPasswordPage extends StatefulWidget {
  const lupaPasswordPage({Key key}) : super(key: key);

  @override
  _lupaPasswordPageState createState() => _lupaPasswordPageState();
}

class _lupaPasswordPageState extends State<lupaPasswordPage> {
  final controllerEmail = TextEditingController();
  var apiURLCekEmail = "http://192.168.18.10:8000/api/cekemail";
  var apiURLKirimEmailForgetPassword = "http://192.168.18.10:8000/api/lupapassword";
  bool Loading = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Loading? loading() : Scaffold(
        appBar: AppBar(
          title: Text("Lupa Password", style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w700,
            color: HexColor("#025393")
          )),
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: HexColor("#025393"),
            onPressed: (){Navigator.of(context).pop();},
          )
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                child: Image.asset(
                  'images/forgotpass.png',
                  height: 100,
                  width: 100,
                ),
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 50),
              ),
              Container(
                child: Text(
                  "Sebelum melanjutkan, silahkan masukkan email Anda",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 16,
                    fontWeight: FontWeight.w700
                  ),
                  textAlign: TextAlign.center,
                ),
                padding: EdgeInsets.only(left: 20, right: 20),
                margin: EdgeInsets.only(top: 50),
                alignment: Alignment.center,
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                  child: TextField(
                    controller: controllerEmail,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        borderSide: BorderSide(color: HexColor("#025393"))
                      ),
                      hintText: "Email Anda",
                      prefixIcon: Icon(Icons.email_rounded)
                    ),
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 14
                    ),
                  ),
                ),
                margin: EdgeInsets.only(top: 20),
              ),
              Container(
                alignment: Alignment.center,
                child: TextButton(
                  child: Text(
                    "Lanjutkan",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: HexColor("#025393")
                    ),
                  ),
                  onPressed: (){
                    if(controllerEmail.text == "") {
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
                                      "Email belum diinputkan",
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
                                      "Silahkan isi email Anda terlebih dahulu sebelum melanjutkan",
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
                    }else{
                      setState(() {
                        Loading = true;
                      });
                      var body = jsonEncode({
                        "email" : controllerEmail.text
                      });
                      http.post(Uri.parse(apiURLCekEmail),
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
                                            "Email tidak ditemukan",
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
                                            "Email yang Anda masukkan tidak terdaftar pada sistem. Silahkan masukkan email yang lain dan coba lagi",
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
                        }else if(data == 200) {
                          var body = jsonEncode({
                            "email" : controllerEmail.text
                          });
                          http.post(Uri.parse(apiURLKirimEmailForgetPassword),
                            headers: {"Content-Type" : "application/json"},
                            body: body
                          ).then((http.Response response) {
                            var data = response.statusCode;
                            if(data == 200) {
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
                                                'images/email.png',
                                                height: 50,
                                                width: 50,
                                              ),
                                            ),
                                            Container(
                                              child: Text(
                                                "Email telah dikirimkan",
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
                                                "Email lupa password telah dikirimkan ke email Anda. Silahkan periksa email Anda dan ikuti tahapan yang tertera pada email tersebut",
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
                                          onPressed: (){
                                            Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(builder: (context) => welcomeScreen()), (route) => false);
                                          },
                                        )
                                      ],
                                    );
                                  }
                                );
                              });
                            }
                          });
                        }
                      });
                    }
                  },
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
