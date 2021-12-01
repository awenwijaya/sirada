import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  bool Loading = false;
  var apiURLcekPenduduk = "http://192.168.18.10:8000/api/cek_penduduk";

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
                                        "Isikanlah data NIK terlebih dahulu sebelum melanjutkan",
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
                                                parsedJson['nama_lengkap'].toString(),
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
                                      Container(
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              child: Text(
                                                "Kewarganegaraan :",
                                                style: TextStyle(
                                                    fontFamily: "Poppins",
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w700
                                                ),
                                              ),
                                            ),
                                            Container(
                                              child: Text(
                                                parsedJson['kewarganegaraan'].toString(),
                                                style: TextStyle(
                                                    fontFamily: "Poppins",
                                                    fontSize: 14
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        margin: EdgeInsets.only(top: 20),
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
                                      onPressed: (){
                                        setState(() {
                                          enterEmail.desaId = parsedJson['id_desa'];
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
                                                'images/noconnection.png',
                                                height: 50,
                                                width: 50,
                                              ),
                                            ),
                                            Container(
                                              child: Text(
                                                "Tidak dapat menghubungi server",
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
                                                "Mohon maaf sedang ada kendala saat kami berusaha menghubungi server. Silahkan coba lagi",
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
  bool Loading = false;
  var apiURLRegistrasiAkun = "http://192.168.18.10:8000/api/registrasi";
  var apiURLKonfirmasiEmail = "http://192.168.18.10:8000/api/konfirmasiemail";

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
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                              child: TextField(
                                controller: controllerUsername,
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
                              child: TextField(
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
                              child: TextField(
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
                              child: TextField(
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
                                if(controllerUsername.text == "" || controllerEmail.text == "" || controllerPhoneNumber.text == "" || controllerPassword.text == "" || controllerKonfirmasiPassword.text == "") {
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
                                                  "Data ada yang belum terisi",
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
                                                  "Isikanlah semua data yang ada sebelum melanjutkan",
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
                                            child: Text('OK', style: TextStyle(
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
                                }else if(controllerPassword.text != controllerKonfirmasiPassword.text) {
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
                                                    "Password tidak sesuai",
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
                                                    "Silahkan sesuaikan password dengan konfirmasi password dan coba lagi",
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
                                              child: Text('OK', style: TextStyle(
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
                                    "username" : controllerUsername.text,
                                    "nomor_telepon" : controllerPhoneNumber.text,
                                    "email" : controllerEmail.text,
                                    "password" : controllerPassword.text,
                                    "id_desa" : enterEmail.desaId,
                                    "penduduk_id" : enterEmail.pendudukId
                                  });
                                  http.post(Uri.parse(apiURLRegistrasiAkun),
                                    headers: {"Content-Type" : "application/json"},
                                    body: body
                                  ).then((http.Response response) {
                                    var data = response.statusCode;
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
                                    } else {
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
                                                        'images/noconnection.png',
                                                        height: 50,
                                                        width: 50,
                                                      ),
                                                    ),
                                                    Container(
                                                      child: Text(
                                                        "Tidak dapat menghubungi server",
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
                                                        "Mohon maaf sedang ada kendala saat kami berusaha menghubungi server. Silahkan coba lagi",
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
                                                  child: Text('OK', style: TextStyle(
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
