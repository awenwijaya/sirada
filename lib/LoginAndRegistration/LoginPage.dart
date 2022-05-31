import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surat/AdminDesa/Dashboard.dart';
import 'package:surat/KramaPanitia/BottomNavigationBar.dart';
import 'package:surat/KramaPanitia/Dashboard.dart';
import 'package:surat/LoginAndRegistration/LupaPassword.dart';
import 'package:surat/LoginAndRegistration/RegistrationPage.dart';
import 'package:surat/Penduduk/BottomNavigationBar.dart';
import 'package:surat/shared/LoadingAnimation/loading.dart';
import 'package:http/http.dart' as http;

class loginPage extends StatefulWidget {
  static var userEmail;
  static var userId;
  static var desaId;
  static var pendudukId;
  static var role;
  static var prajuruId;
  static var kramaId;
  static String token;

  const loginPage({Key key}) : super(key: key);

  @override
  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  var apiURLLogin = "http://192.168.18.10:8000/api/autentikasi/login";
  var apiURLKonfirmasiEmail = "http://192.168.18.10:8000/api/autentikasi/registrasi/konfirmasi_email";
  var apiURLUploadFCMToken = "http://192.168.18.10:8000/api/autentikasi/login/token";
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  bool Loading = false;
  var statusPrajuru;
  var tempPendudukId;
  var tempEmail;
  var tempRole;
  var tempDesaId;
  var tempUserId;
  FToast ftoast;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseMessaging.instance.getToken().then((value) {
      setState(() {
        loginPage.token = value;
      });
      print(loginPage.token);
    });
    ftoast = FToast();
    ftoast.init(context);
  }

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
                child: Form(
                  key: formKey,
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                          child: TextFormField(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if(value.isEmpty) {
                                return "Email tidak boleh kosong";
                              }else if(value.isNotEmpty && RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
                                return null;
                              }else {
                                return "Masukkan email yang valid";
                              }
                            },
                            keyboardType: TextInputType.emailAddress,
                            controller: controllerEmail,
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
                                return "Data tidak boleh kosong";
                              }else {
                                return null;
                              }
                            },
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
                  )
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: FlatButton(
                        onPressed: () async {
                          if(formKey.currentState.validate()) {
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
                                var jsonData = response.body;
                                var parsedJson = json.decode(jsonData);
                                setState(() {
                                  tempPendudukId = parsedJson['penduduk_id'];
                                  tempDesaId = parsedJson['desa_adat_id'];
                                  tempEmail = parsedJson['email'];
                                  tempUserId = parsedJson['user_id'];
                                  tempRole = parsedJson['role'];
                                });
                                print(parsedJson['role']);
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
                                      if(parsedJson['role'] == "Admin" || parsedJson['role'] == 'Bendesa' || parsedJson['role'] == 'Penyarikan') {
                                        var response = await http.get(Uri.parse("http://192.168.18.10:8000/api/autentikasi/login/status/prajuru_desa_adat/${tempPendudukId}"));
                                        if(response.statusCode == 200) {
                                          var jsonDataPrajuru = response.body;
                                          var parsedJsonPrajuru = json.decode(jsonDataPrajuru);
                                          if(parsedJsonPrajuru['status_prajuru_desa_adat'] == "aktif") {
                                            setState(() {
                                              loginPage.pendudukId = tempPendudukId;
                                              loginPage.userEmail = tempEmail;
                                              loginPage.desaId = tempDesaId;
                                              loginPage.userId = tempUserId;
                                              loginPage.role = tempRole;
                                              loginPage.prajuruId = parsedJsonPrajuru['prajuru_desa_adat_id'];
                                            });
                                            final SharedPreferences sharedpref = await SharedPreferences.getInstance();
                                            final SharedPreferences sharedprefadmin = await SharedPreferences.getInstance();
                                            sharedpref.setInt('userId', loginPage.userId);
                                            sharedpref.setInt('pendudukId', loginPage.pendudukId);
                                            sharedpref.setInt('desaId', loginPage.desaId);
                                            sharedpref.setString('email', loginPage.userEmail);
                                            sharedpref.setString('role', loginPage.role);
                                            sharedpref.setString('status', 'login');
                                            sharedprefadmin.setInt('prajuru_adat_id', loginPage.prajuruId);
                                            var bodyToken = jsonEncode({
                                              "user_id" : tempUserId,
                                              "token" : loginPage.token
                                            });
                                            http.post(Uri.parse(apiURLUploadFCMToken),
                                                headers: {"Content-Type" : "application/json"},
                                                body: bodyToken
                                            ).then((http.Response response) async {
                                              var data = response.statusCode;
                                              if(data == 200) {
                                                setState(() {
                                                  Loading = false;
                                                });
                                                Navigator.of(context).pushAndRemoveUntil(createRouteAdminDesaDashboard(), (route) => false);
                                              }
                                            });
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
                                                                "Akun Nonaktif",
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
                                                                "Anda tidak bisa login karena akun Anda sudah di nonaktifkan.",
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
                                        }
                                      }else if(parsedJson['role'] == "Krama") {
                                        var response = await http.get(Uri.parse("http://192.168.18.10:8000/api/krama/mipil/${tempPendudukId}"));
                                        if(response.statusCode == 200) {
                                          var jsonDataKrama = response.body;
                                          var parsedJsonKrama = json.decode(jsonDataKrama);
                                          setState(() {
                                            loginPage.pendudukId = parsedJson['penduduk_id'];
                                            loginPage.userEmail = parsedJson['email'];
                                            print(loginPage.userEmail);
                                            loginPage.desaId = parsedJson['desa_adat_id'];
                                            loginPage.userId = parsedJson['user_id'];
                                            loginPage.role = parsedJson['role'];
                                            loginPage.kramaId = parsedJsonKrama['krama_mipil_id'];
                                          });
                                          final SharedPreferences sharedpref = await SharedPreferences.getInstance();
                                          final SharedPreferences sharedprefkrama = await SharedPreferences.getInstance();
                                          sharedpref.setInt('userId', loginPage.userId);
                                          sharedpref.setInt('pendudukId', loginPage.pendudukId);
                                          sharedpref.setInt('desaId', loginPage.desaId);
                                          sharedpref.setString('email', loginPage.userEmail);
                                          sharedpref.setString('role', loginPage.role);
                                          sharedpref.setString('status', 'login');
                                          sharedprefkrama.setInt('kramaId', loginPage.kramaId);
                                          var bodyFCM = jsonEncode({
                                            "user_id" : loginPage.userId,
                                            "token" : loginPage.token
                                          });
                                          http.post(Uri.parse(apiURLUploadFCMToken),
                                              headers: {"Content-Type" : "application/json"},
                                              body: bodyFCM
                                          ).then((http.Response response) {
                                            var data = response.statusCode;
                                            if(data == 200) {
                                              setState(() {
                                                Loading = false;
                                              });
                                              Navigator.of(context).pushAndRemoveUntil(createRoutePendudukDashboard(), (route) => false);
                                            }
                                          });
                                        }
                                      }else if(parsedJson['role'] == "Panitia") {
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
                                        sharedpref.setInt('desaId', loginPage.desaId);
                                        sharedpref.setString('email', loginPage.userEmail);
                                        sharedpref.setString('role', loginPage.role);
                                        sharedpref.setString('status', 'login');
                                        var bodyFCM = jsonEncode({
                                          "user_id" : loginPage.userId,
                                          "token" : loginPage.token
                                        });
                                        http.post(Uri.parse(apiURLUploadFCMToken),
                                          headers: {"Content-Type" : "application/json"},
                                          body: bodyFCM
                                        ).then((http.Response response) {
                                          var data = response.statusCode;
                                          if(data == 200) {
                                            setState(() {
                                              Loading = false;
                                            });
                                            Navigator.of(context).pushAndRemoveUntil(createRouteKramaPanitiaDashboard(), (route) => false);
                                          }
                                        });
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
                                  }else {
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
      pageBuilder: (context, animation, secondaryAnimation) => const bottomNavigationBarPenduduk(),
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

Route createRouteKramaPanitiaDashboard() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const bottomNavigationBarPanitia(),
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