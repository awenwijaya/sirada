import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:surat/WelcomeScreen.dart';
import 'package:surat/shared/LoadingAnimation/loading.dart';

class registrationPage extends StatefulWidget {
  static var nik;
  const registrationPage({Key key}) : super(key: key);

  @override
  _registrationPageState createState() => _registrationPageState();
}

class _registrationPageState extends State<registrationPage> {
  final controllerNIK = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool Loading = false;
  FToast ftoast;
  var apiURLcekPenduduk = "https://siradaskripsi.my.id/api/autentikasi/registrasi/cek_nik";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ftoast = FToast();
    ftoast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: new ThemeData(scaffoldBackgroundColor: HexColor("#FFFFFF")),
      home: Loading ? loading() : Scaffold(
        appBar: AppBar(
          title: Text("Verifikasi NIK", style: TextStyle(
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
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                child: Image.asset(
                  'images/regisform.png',
                  height: 150,
                  width: 150,
                ),
                margin: EdgeInsets.only(top: 45),
              ),
              Container(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Text(
                          "Silahkan masukkan NIK yang tertera pada KTP Anda untuk melanjutkan",
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 16,
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
                          child: TextFormField(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if(value.isNotEmpty && value.length > 16) {
                                return 'NIK tidak boleh lebih dari 16 karakter';
                              }else if(value.isNotEmpty && value.length < 16) {
                                return 'NIK tidak boleh kurang dari 16 karakter';
                              }else if(value.isEmpty) {
                                return 'Data NIK tidak boleh kosong';
                              }else {
                                return null;
                              }
                            },
                            controller: controllerNIK,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                  borderSide: BorderSide(color: HexColor("#025393"))
                              ),
                              hintText: "Contoh: 3313091704330001",
                              prefixIcon: Icon(Icons.person_rounded),
                            ),
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14
                            ),
                          ),
                        ),
                        margin: EdgeInsets.only(top: 30),
                      )
                    ],
                  ),
                )
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
                    if(formKey.currentState.validate()) {
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
                                                  fontSize: 16,
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
                                                    fontSize: 14
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
                          setState((){
                            Loading = false;
                            var jsonData = response.body;
                            var parsedJson = json.decode(jsonData);
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context){
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
                                            "Silahkan konfirmasi data di bawah ini apakah data ini benar milik Anda",
                                            style: TextStyle(
                                                fontFamily: "Poppins",
                                                fontSize: 14
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
                                                  "Nama :",
                                                  style: TextStyle(
                                                      fontFamily: "Poppins",
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w700
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                child: Text(
                                                  parsedJson['nama'].toString(),
                                                  style: TextStyle(
                                                      fontFamily: "Poppins",
                                                      fontSize: 14
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          margin: EdgeInsets.only(top: 20),
                                        ),
                                        Container(
                                          child: Column(
                                            children: <Widget>[
                                              Container(
                                                child: Text(
                                                  "Jenis Kelamin :",
                                                  style: TextStyle(
                                                      fontFamily: "Poppins",
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w700
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                child: Text(
                                                  parsedJson['jenis_kelamin'].toString(),
                                                  style: TextStyle(
                                                      fontFamily: "Poppins",
                                                      fontSize: 14
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          margin: EdgeInsets.only(top: 20),
                                        ),
                                      ],
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('Benar', style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontWeight: FontWeight.w700,
                                            color: HexColor("#025393")
                                        )),
                                        onPressed: (){
                                          setState(() {
                                            enterEmail.desaId = parsedJson['desa_adat_id'];
                                            enterEmail.pendudukId = parsedJson['penduduk_id'];
                                          });
                                          Navigator.push(context, CupertinoPageRoute(builder: (context) => enterEmail()));
                                        },
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
                            );
                          });
                        }
                      });
                    }else{
                      ftoast.showToast(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Colors.redAccent
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.close),
                                Container(
                                    margin: EdgeInsets.only(left: 15),
                                    child: SizedBox(
                                        width: MediaQuery.of(context).size.width * 0.65,
                                        child: Text("Masih terdapat data yang kosong atau tidak valid. Silahkan diperiksa kembali", style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white
                                        ))
                                    )
                                )
                              ],
                            ),
                          ),
                          toastDuration: Duration(seconds: 3)
                      );
                    }
                  },
                ),
                margin: EdgeInsets.only(top: 15),
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
                          fontSize: 13,
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
                                          fontSize: 16,
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
                                                fontSize: 14,
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
                margin: EdgeInsets.only(top: 20),
              )
            ],
          ),
        )
      ),
    );
  }
}

class enterEmail extends StatefulWidget {
  static var pendudukId;
  static var desaId;
  const enterEmail({Key key}) : super(key: key);

  @override
  _enterEmailState createState() => _enterEmailState();
}

class _enterEmailState extends State<enterEmail> {
  final controllerUsername = TextEditingController();
  final controllerPhoneNumber = TextEditingController();
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  final controllerKonfirmasiPassword = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  FToast ftoast;
  bool Loading = false;
  var apiURLRegistrasiAkun = "https://siradaskripsi.my.id/api/autentikasi/registrasi/post";
  var apiURLKonfirmasiEmail = "https://siradaskripsi.my.id/api/autentikasi/registrasi/konfirmasi_email";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ftoast = FToast();
    ftoast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: new ThemeData(scaffoldBackgroundColor: HexColor("#FFFFFF")),
      home: Loading ? loading() : Scaffold(
        appBar: AppBar(
          title: Text("Registrasi Akun", style: TextStyle(
              fontFamily: "Poppins",
              fontWeight: FontWeight.w700,
              color: HexColor("#025393")
          )),
          backgroundColor: Colors.white,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                child: Image.asset(
                  'images/security.png',
                  height: 100,
                  width: 100,
                ),
                margin: EdgeInsets.only(top: 50),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Text(
                        "Silahkan masukkan data dibawah ini untuk melanjutkan",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 16,
                          fontWeight: FontWeight.w700
                        ),
                        textAlign: TextAlign.center,
                      ),
                      padding: EdgeInsets.only(left: 20, right: 20),
                      margin: EdgeInsets.only(top: 50),
                    ),
                    Container(
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                                child: TextFormField(
                                  controller: controllerUsername,
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    if(value.isEmpty) {
                                      return 'Username tidak boleh kosong';
                                    }else {
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(50.0),
                                        borderSide: BorderSide(color: HexColor("#025393")),
                                      ),
                                      hintText: "Username",
                                      prefixIcon: Icon(Icons.person_rounded)
                                  ),
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 14
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                                child: TextField(
                                  controller: controllerPhoneNumber,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(50.0),
                                        borderSide: BorderSide(color: HexColor("#025393")),
                                      ),
                                      hintText: "Nomor Telepon",
                                      prefixIcon: Icon(Icons.phone)
                                  ),
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 14
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                                child: TextFormField(
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    if(value.isNotEmpty && RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
                                      return null;
                                    }else if(value.isEmpty) {
                                      return "Data tidak boleh kosong";
                                    }else{
                                      return "Masukkan email yang valid";
                                    }
                                  },
                                  controller: controllerEmail,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(50.0),
                                        borderSide: BorderSide(color: HexColor("#025393")),
                                      ),
                                      hintText: "Email",
                                      prefixIcon: Icon(Icons.email_rounded)
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 14
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                                child: TextFormField(
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    if(value.isEmpty) {
                                      return 'Password tidak boleh kosong';
                                    }else if(value.isNotEmpty && value.length < 8) {
                                      return 'Password tidak boleh kurang dari 8 digit';
                                    }else {
                                      return null;
                                    }
                                  },
                                  controller: controllerPassword,
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
                                      fontSize: 14
                                  ),
                                  obscureText: true,
                                ),
                              ),
                            ),
                            Container(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                                child: TextFormField(
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    if(value.isNotEmpty && controllerPassword.text!=value) {
                                      return "Password tidak sesuai";
                                    }else if(value.isEmpty) {
                                      return "Konfirmasi password tidak boleh kosong";
                                    }else{
                                      return null;
                                    }
                                  },
                                  controller: controllerKonfirmasiPassword,
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
                                      fontSize: 14
                                  ),
                                  obscureText: true,
                                ),
                              ),
                            ),
                            Container(
                              child: FlatButton(
                                onPressed: (){
                                  if(formKey.currentState.validate()) {
                                    setState(() {
                                      Loading = true;
                                    });
                                    var body = jsonEncode({
                                      "username" : controllerUsername.text,
                                      "nomor_telepon" : controllerPhoneNumber.text,
                                      "email" : controllerEmail.text,
                                      "password" : controllerPassword.text,
                                      "desa_id" : enterEmail.desaId,
                                      "penduduk_id" : enterEmail.pendudukId
                                    });
                                    http.post(Uri.parse(apiURLRegistrasiAkun),
                                        headers: {"Content-Type" : "application/json"},
                                        body: body
                                    ).then((http.Response response) {
                                      var data = response.statusCode;
                                      print(response.statusCode.toString());
                                      if(data == 200) {
                                        setState(() {
                                          emailConfirmation.userEmail = controllerEmail.text;
                                        });
                                        var body = jsonEncode({
                                          "email" : controllerEmail.text
                                        });
                                        http.post(Uri.parse(apiURLKonfirmasiEmail),
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
                                                    return emailConfirmation();
                                                  }
                                              );
                                            });
                                          }
                                        });
                                      } else if(data == 501){
                                        setState(() {
                                          Loading = false;
                                        });
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
                                                          "Akun sudah terdaftar",
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
                                                          "Data yang Anda masukkan sudah terdaftar sebelumnya. Silahkan gunakan data username/email/nomor telefon yang lain untuk melanjutkan pendaftaran",
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
                                            children: [
                                              Icon(Icons.close),
                                              Container(
                                                  margin: EdgeInsets.only(left: 15),
                                                  child: SizedBox(
                                                      width: MediaQuery.of(context).size.width * 0.65,
                                                      child: Text("Masih terdapat data yang kosong atau tidak valid. Silahkan diperiksa kembali", style: TextStyle(
                                                          fontFamily: "Poppins",
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w700,
                                                          color: Colors.white
                                                      ))
                                                  )
                                              )
                                            ],
                                          ),
                                        ),
                                        toastDuration: Duration(seconds: 3)
                                    );
                                  }
                                },
                                child: Text('Daftar Akun', style: TextStyle(
                                    fontSize: 14,
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
                              margin: EdgeInsets.only(top: 20, bottom: 20),
                            )
                          ],
                        ),
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

class emailConfirmation extends StatefulWidget {
  static var userEmail;
  const emailConfirmation({Key key}) : super(key: key);

  @override
  _emailConfirmationState createState() => _emailConfirmationState();
}

class _emailConfirmationState extends State<emailConfirmation> {
  @override
  Widget build(BuildContext context) {
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
                "Konfirmasi Email Anda",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: HexColor("#025393")
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              child: Text(
                "Email konfirmasi sudah terkirim ke email Anda. Silahkan periksa email anda dan lakukan konfirmasi akun Anda",
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
            Navigator.of(context).pop();
            Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context)=>welcomeScreen()));
          },
        )
      ],
    );
  }
}