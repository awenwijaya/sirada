import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surat/AdminDesa/Dashboard.dart';
import 'package:surat/KepalaDesa/Dashboard.dart';
import 'package:surat/KepalaDusun/Dashboard.dart';
import 'package:surat/LoginAndRegistration/LupaPassword.dart';
import 'package:surat/LoginAndRegistration/RegistrationPage.dart';
import 'package:surat/Penduduk/Dashboard.dart';
import 'package:surat/shared/LoadingAnimation/loading.dart';
import 'package:http/http.dart' as http;

class loginPage extends StatefulWidget {
  static var userEmail;
  static var userId;
  static var desaId;
  static var pendudukId;
  static var role;

  const loginPage({Key key}) : super(key: key);

  @override
  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  var apiURLLogin = "http://172.16.59.203:8000/api/autentikasi/login";
  var apiURLKonfirmasiEmail = "http://172.16.59.203:8000/api/autentikasi/registrasi/konfirmasi_email";
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  bool Loading = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: new ThemeData(scaffoldBackgroundColor: HexColor("#FFFFFF")),
      home: Loading ? loading() : Scaffold(
          appBar: AppBar(
            title: Text("Login", style: TextStyle(
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
                  'images/login2.jpg',
                  height: 200,
                  width: 200,
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
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
                            prefixIcon: Icon(Icons.email_rounded),
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
                          controller: controllerPassword,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50.0),
                                borderSide: BorderSide(color: HexColor("#025393")),
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
                      margin: EdgeInsets.only(top: 10),
                    )
                  ],
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: FlatButton(
                        onPressed: () async {
                          if(controllerEmail.text == "" || controllerPassword.text == "") {
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
                                            "Data email atau password belum diinputkan",
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
                                            "Silahkan isi data email dan password sebelum melanjutkan",
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
                          } else {
                            setState(() {
                              Loading = true;
                            });
                            var body = jsonEncode({
                              "email" : controllerEmail.text,
                              "password" : controllerPassword.text
                            });
                            http.post(Uri.parse(apiURLLogin),
                              headers: {"Content-Type" : "application/json"},
                              body: body
                            ).then((http.Response response) async {
                              var data = response.statusCode;
                              if(data == 500) {
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
                                                "Email atau password salah",
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
                                                "Pastikan Anda menginputkan data email dan password yang benar dan coba lagi",
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
                              } else if(data == 200) {
                                setState((){
                                  Loading = false;
                                });
                                var jsonData = response.body;
                                var parsedJson = json.decode(jsonData);
                                if(parsedJson['role'] == "Super Admin") {
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
                                                  child: Text("Hak Akses Ditolak", style: TextStyle(
                                                      fontFamily: "Poppins",
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w700,
                                                      color: HexColor("#025393")
                                                  ), textAlign: TextAlign.center),
                                                  margin: EdgeInsets.only(top: 10),
                                                ),
                                                Container(
                                                  child: Text("Hak akses untuk pengguna ini ditolak. Silahkan akses versi web dari aplikasi ini", style: TextStyle(
                                                      fontFamily: "Poppins",
                                                      fontSize: 14
                                                  ), textAlign: TextAlign.center),
                                                  margin: EdgeInsets.only(top: 10),
                                                )
                                              ],
                                            ),
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: (){Navigator.of(context).pop();},
                                              child: Text("OK", style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.w700,
                                                  color: HexColor("#025393")
                                              )),
                                            )
                                          ],
                                        );
                                      }
                                  );
                                }else{
                                  if(parsedJson['is_verified'] == "Verified") {
                                    if(parsedJson['desadat_status_register'] == 'Terdaftar') {
                                      setState(() {
                                        loginPage.pendudukId = parsedJson['penduduk_id'];
                                        loginPage.userEmail = parsedJson['email'];
                                        loginPage.desaId = parsedJson['desa_adat_id'];
                                        loginPage.userId = parsedJson['user_id'];
                                        loginPage.role = parsedJson['role'];
                                      });
                                      final SharedPreferences sharedpref = await SharedPreferences.getInstance();
                                      sharedpref.setInt('userId', loginPage.userId);
                                      sharedpref.setInt('pendudukId', loginPage.pendudukId);
                                      sharedpref.setString('desaId', loginPage.desaId);
                                      sharedpref.setString('email', loginPage.userEmail);
                                      sharedpref.setString('role', loginPage.role);
                                      sharedpref.setString('status', 'login');
                                      if(loginPage.role == "Krama") {
                                        Navigator.of(context).pushAndRemoveUntil(createRoutePendudukDashboard(), (route) => false);
                                      }else if(loginPage.role == "Kepala Desa") {
                                        Navigator.of(context).pushAndRemoveUntil(createRouteKepalaDesaDashboard(), (route) => false);
                                      }else if(loginPage.role == "Admin") {
                                        Navigator.of(context).pushAndRemoveUntil(createRouteAdminDesaDashboard(), (route) => false);
                                      }else if(loginPage.role == "Kepala Dusun") {
                                        Navigator.of(context).pushAndRemoveUntil(createRouteKepalaDusunDashboard(), (route) => false);
                                      }
                                    }else{
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
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: <Widget>[
                                                      Container(
                                                        child: Image.asset(
                                                          'images/alert.png',
                                                          height: 50,
                                                          width: 50,
                                                        ),
                                                        alignment: Alignment.center,
                                                      ),
                                                      Container(
                                                        child: Text(
                                                          "Desa belum terdaftar",
                                                          style: TextStyle(
                                                              fontFamily: "Poppins",
                                                              fontSize: 16,
                                                              fontWeight: FontWeight.w700,
                                                              color: HexColor("#025393")
                                                          ),
                                                          textAlign: TextAlign.center,
                                                        ),
                                                        margin: EdgeInsets.only(top: 10),
                                                        alignment: Alignment.center,
                                                      ),
                                                      Container(
                                                        child: Text(
                                                          "Anda tidak bisa login karena desa belum terdaftar. Silahkan hubungi admin desa untuk informasi lebih lanjut",
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
                                  } else {
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
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: <Widget>[
                                                    Container(
                                                      child: Image.asset(
                                                        'images/alert.png',
                                                        height: 50,
                                                        width: 50,
                                                      ),
                                                      alignment: Alignment.center,
                                                    ),
                                                    Container(
                                                      child: Text(
                                                        "Akun belum diverifikasi",
                                                        style: TextStyle(
                                                            fontFamily: "Poppins",
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.w700,
                                                            color: HexColor("#025393")
                                                        ),
                                                        textAlign: TextAlign.center,
                                                      ),
                                                      margin: EdgeInsets.only(top: 10),
                                                      alignment: Alignment.center,
                                                    ),
                                                    Container(
                                                      child: Text(
                                                        "Akun Anda belum terverifikasi. Silahkan periksa email verifikasi yang telah dikirimkan. Jika tidak ada email verifikasi, tekan tombol Kirim Ulang Email Verifikasi.",
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
                                                child: Text("OK", style: TextStyle(
                                                    fontFamily: "Poppins",
                                                    fontWeight: FontWeight.w700,
                                                    color: HexColor("#025393")
                                                )),
                                                onPressed: (){Navigator.of(context).pop();},
                                              ),
                                              TextButton(
                                                child: Text("Kirim Ulang Email Verifikasi", style: TextStyle(
                                                    fontFamily: "Poppins",
                                                    fontWeight: FontWeight.w700,
                                                    color: HexColor("#025393")
                                                )),
                                                onPressed: (){
                                                  Navigator.of(context).pop();
                                                  setState(() {
                                                    loginPage.userEmail = controllerEmail.text;
                                                    Loading = true;
                                                  });
                                                  var body = jsonEncode({
                                                    "email" : controllerEmail.text
                                                  });
                                                  http.post(Uri.parse(apiURLKonfirmasiEmail),
                                                      headers : {"Content-Type" : "application/json"},
                                                      body: body
                                                  ).then((http.Response response) {
                                                    var data = response.statusCode;
                                                    if(data == 200) {
                                                      setState(() {
                                                        Loading = false;
                                                      });
                                                    }
                                                  });
                                                },
                                              )
                                            ],
                                          );
                                        }
                                    );
                                  }
                                }
                              }
                            });
                          }
                        },
                        child: Text('Login', style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w700
                        )),
                        color: HexColor("#025393"),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)
                        ),
                        padding: EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50),
                      ),
                    ),
                    Container(
                      child: FlatButton(
                        onPressed: (){
                          Navigator.push(context, CupertinoPageRoute(builder: (context) => registrationPage()));
                        },
                        child: Text('Daftar Akun', style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            color: HexColor("#025393"),
                            fontWeight: FontWeight.w700
                        )),
                        color: Colors.transparent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          side: BorderSide(color: HexColor("#025393"), width: 2)
                        ),
                        padding: EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50),
                      ),
                      margin: EdgeInsets.only(left: 20),
                    )
                  ],
                ),
                margin: EdgeInsets.only(top: 30),
              ),
              Container(
                child: TextButton(
                  child: Text(
                    "Lupa Password",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 14,
                      color: HexColor("#025393"),
                      fontWeight: FontWeight.w700
                    ),
                  ),
                  onPressed: (){
                    Navigator.push(context, CupertinoPageRoute(builder: (context) => lupaPasswordPage()));
                  },
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

Route createRoutePendudukDashboard() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const dashboardPenduduk(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      }
  );
}

Route createRouteKepalaDesaDashboard() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const dashboardKepalaDesa(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      }
  );
}

Route createRouteAdminDesaDashboard() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const dashboardAdminDesa(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    }
  );
}

Route createRouteKepalaDusunDashboard() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const dashboardKepalaDusun(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    }
  );
}