import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surat/Penduduk/DetailDesa/DetailDesa.dart';
import 'package:surat/Penduduk/Profile/UserProfile.dart';
import 'package:surat/Penduduk/Surat/AktaKelahiran/SKKelahiran.dart';
import 'package:surat/Penduduk/Surat/BelumMenikah/SKBelumMenikah.dart';
import 'package:surat/Penduduk/Surat/Berpergian/SKBerpergian.dart';
import 'package:surat/Penduduk/Surat/DatangWNI/SKDatangWNI.dart';
import 'package:surat/Penduduk/Surat/KelakuanBaik/SKKelakuanBaik.dart';
import 'package:surat/Penduduk/Surat/Kematian/SKKematian.dart';
import 'package:surat/Penduduk/Surat/LainLain/SKLainLain.dart';
import 'package:surat/Penduduk/Surat/PenghasilanOrangTua/SPPenghasilanOrangTua.dart';
import 'package:surat/Penduduk/Surat/PindahWNI/SKPindahWNI.dart';
import 'package:surat/Penduduk/Surat/TempatUsaha/SKTempatUsaha.dart';
import 'package:surat/Penduduk/Surat/TidakMampu/SKTidakMampu.dart';
import 'package:surat/Penduduk/Surat/Usaha/SKUsaha.dart';
import 'package:surat/WelcomeScreen.dart';
import 'package:http/http.dart' as http;
import 'package:surat/LoginAndRegistration/LoginPage.dart';

class dashboardPenduduk extends StatefulWidget {
  const dashboardPenduduk({Key key}) : super(key: key);

  @override
  _dashboardPendudukState createState() => _dashboardPendudukState();
}

class _dashboardPendudukState extends State<dashboardPenduduk> {
  var namaDesa = "Desa";
  var namaPenduduk = "Pengguna";
  var apiURLGetDataPenduduk = "http://192.168.18.10:8000/api/getdatapendudukbyid";
  var apiURLGetDataDesa = "http://192.168.18.10:8000/api/getdatadesabyid";

  getDesaInfo() async {
    var body = jsonEncode({
      'desa_id' : loginPage.desaId
    });
    http.post(Uri.parse(apiURLGetDataDesa),
      headers: {"Content-Type" : "application/json"},
      body: body
    ).then((http.Response response) {
      var responseValue = response.statusCode;
      if(responseValue == 200) {
        var jsonData = response.body;
        var parsedJson = json.decode(jsonData);
        setState(() {
          namaDesa = parsedJson['nama_desa'];
        });
      }
    });
  }

  getPendudukInfo() async {
    var body = jsonEncode({
      'penduduk_id' : loginPage.pendudukId
    });
    http.post(Uri.parse(apiURLGetDataPenduduk),
      headers: {"Content-Type" : "application/json"},
      body: body
    ).then((http.Response response) {
      var responseValue = response.statusCode;
      if(responseValue == 200) {
        var jsonData = response.body;
        var parsedJson = json.decode(jsonData);
        setState(() {
          namaPenduduk = parsedJson['nama_lengkap'];
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDesaInfo();
    getPendudukInfo();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("SiRaja", style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w700,
            color: HexColor("#025393")
          )),
          backgroundColor: Colors.white,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.person_outline_rounded),
              color: HexColor("#025393"),
              onPressed: (){
                Navigator.push(context, CupertinoPageRoute(builder: (context) => userProfile()));
              },
            ),
            IconButton(
              icon: Icon(Icons.logout),
              color: HexColor("#025393"),
              onPressed: (){
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
                                'images/logout.png',
                                height: 50,
                                width: 50,
                              ),
                            ),
                            Container(
                              child: Text(
                                "Logout?",
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
                                "Apakah Anda yakin ingin logout?",
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
                          onPressed: () async {
                            final SharedPreferences sharedpref = await SharedPreferences.getInstance();
                            sharedpref.remove('userId');
                            sharedpref.remove('pendudukId');
                            sharedpref.remove('desaId');
                            sharedpref.remove('email');
                            sharedpref.remove('role');
                            sharedpref.remove('status');
                            Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(builder: (context) => welcomeScreen()), (route) => false);
                          },
                          child: Text("Ya", style: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w700,
                              color: HexColor("#025393")
                          )),
                        ),
                        TextButton(
                          onPressed: (){Navigator.of(context).pop();},
                          child: Text("Tidak", style: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w700,
                              color: HexColor("#025393")
                          )),
                        )
                      ],
                    );
                  }
                );
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      child: Text(
                        "Selamat datang kembali,",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        "${namaPenduduk} !",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 16
                        ),
                      ),
                    )
                  ],
                ),
                margin: EdgeInsets.only(top: 20, left: 15),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "Desa Anda",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14,
                    fontWeight: FontWeight.bold
                  ),
                ),
                margin: EdgeInsets.only(top: 20, left: 15),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 20),
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage('https://googleflutter.com/sample_image.jpg'),
                          fit: BoxFit.fill
                        )
                      ),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Text(
                              "${namaDesa}",
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Container(
                            child: TextButton(
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      "Lihat Detail Desa",
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w700,
                                          color: HexColor("#025393"),
                                          fontSize: 14
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Icon(
                                      Icons.chevron_right,
                                      color: HexColor("#025393"),
                                    ),
                                  )
                                ],
                              ),
                              onPressed: (){
                                Navigator.push(context, CupertinoPageRoute(builder: (context) => detailDesaPenduduk()));
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                margin: EdgeInsets.only(top: 15, left: 20, right: 20),
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0,3)
                    )
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "Layanan Pengurusan Administrasi",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14,
                    fontWeight: FontWeight.bold
                  ),
                ),
                margin: EdgeInsets.only(top: 20, left: 15),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, CupertinoPageRoute(builder: (context) => SKBelumMenikah()));
                        },
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Image.asset(
                                'images/person.png',
                                height: 40,
                                width: 40,
                              ),
                            ),
                            Container(
                              child: Text(
                                "SK Belum Menikah",
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700
                                ),
                              ),
                              margin: EdgeInsets.only(left: 20),
                            )
                          ],
                        ),
                      ),
                      margin: EdgeInsets.only(top: 15, left: 20, right: 20),
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      height: 70,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0,3)
                            )
                          ]
                      ),
                    ),
                    Container(
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, CupertinoPageRoute(builder: (context) => SKBerpergian()));
                        },
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Image.asset(
                                'images/airplane.png',
                                height: 40,
                                width: 40,
                              ),
                            ),
                            Container(
                              child: Text(
                                "SK Berpergian",
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700
                                ),
                              ),
                              margin: EdgeInsets.only(left: 20),
                            )
                          ],
                        ),
                      ),
                      margin: EdgeInsets.only(top: 10, left: 20, right: 20),
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      height: 70,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0,3)
                            )
                          ]
                      ),
                    ),
                    Container(
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, CupertinoPageRoute(builder: (context) => SKKematian()));
                        },
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Image.asset(
                                'images/scull.png',
                                height: 40,
                                width: 40,
                              ),
                            ),
                            Container(
                              child: Text(
                                "SK Kematian",
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700
                                ),
                              ),
                              margin: EdgeInsets.only(left: 20),
                            )
                          ],
                        ),
                      ),
                      margin: EdgeInsets.only(top: 10, left: 20, right: 20),
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      height: 70,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0,3)
                            )
                          ]
                      ),
                    ),
                    Container(
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, CupertinoPageRoute(builder: (context) => SKLainLain()));
                        },
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Image.asset(
                                'images/gear.png',
                                height: 40,
                                width: 40,
                              ),
                            ),
                            Container(
                              child: Text(
                                "SK Lain-Lain",
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700
                                ),
                              ),
                              margin: EdgeInsets.only(left: 20),
                            )
                          ],
                        ),
                      ),
                      margin: EdgeInsets.only(top: 10, left: 20, right: 20),
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      height: 70,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0,3)
                            )
                          ]
                      ),
                    ),
                    Container(
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, CupertinoPageRoute(builder: (context) => SKTidakMampu()));
                        },
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Image.asset(
                                'images/money.png',
                                height: 40,
                                width: 40,
                              ),
                            ),
                            Container(
                              child: Text(
                                "SK Tidak Mampu",
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700
                                ),
                              ),
                              margin: EdgeInsets.only(left: 20),
                            )
                          ],
                        ),
                      ),
                      margin: EdgeInsets.only(top: 10, left: 20, right: 20),
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      height: 70,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0,3)
                            )
                          ]
                      ),
                    ),
                    Container(
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, CupertinoPageRoute(builder: (context) => SKTempatUsaha()));
                        },
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Image.asset(
                                'images/store.png',
                                height: 40,
                                width: 40,
                              ),
                            ),
                            Container(
                              child: Text(
                                "SK Tempat Usaha",
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700
                                ),
                              ),
                              margin: EdgeInsets.only(left: 20),
                            )
                          ],
                        ),
                      ),
                      margin: EdgeInsets.only(top: 10, left: 20, right: 20),
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      height: 70,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0,3)
                            )
                          ]
                      ),
                    ),
                    Container(
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, CupertinoPageRoute(builder: (context) => SKUsaha()));
                        },
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Image.asset(
                                'images/store.png',
                                height: 40,
                                width: 40,
                              ),
                            ),
                            Container(
                              child: Text(
                                "SK Usaha",
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700
                                ),
                              ),
                              margin: EdgeInsets.only(left: 20),
                            )
                          ],
                        ),
                      ),
                      margin: EdgeInsets.only(top: 10, left: 20, right: 20),
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      height: 70,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0,3)
                            )
                          ]
                      ),
                    ),
                    Container(
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, CupertinoPageRoute(builder: (context) => SPPenghasilanOrangTua()));
                        },
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Image.asset(
                                'images/paycheck.png',
                                height: 40,
                                width: 40,
                              ),
                            ),
                            Container(
                              child: Text(
                                "SP Penghasilan Orang Tua",
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700
                                ),
                              ),
                              margin: EdgeInsets.only(left: 20),
                            )
                          ],
                        ),
                      ),
                      margin: EdgeInsets.only(top: 10, left: 20, right: 20),
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      height: 70,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0,3)
                            )
                          ]
                      ),
                    ),
                    Container(
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, CupertinoPageRoute(builder: (context) => SKKelahiran()));
                        },
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Image.asset(
                                'images/baby.png',
                                height: 40,
                                width: 40,
                              ),
                            ),
                            Container(
                              child: Text(
                                "SK Kelahiran",
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700
                                ),
                              ),
                              margin: EdgeInsets.only(left: 20),
                            )
                          ],
                        ),
                      ),
                      margin: EdgeInsets.only(top: 10, left: 20, right: 20),
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      height: 70,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0,3)
                            )
                          ]
                      ),
                    ),
                    Container(
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, CupertinoPageRoute(builder: (context) => SKDatangWNI()));
                        },
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Image.asset(
                                'images/flag.png',
                                height: 40,
                                width: 40,
                              ),
                            ),
                            Container(
                              child: Text(
                                "SK Datang WNI",
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700
                                ),
                              ),
                              margin: EdgeInsets.only(left: 20),
                            )
                          ],
                        ),
                      ),
                      margin: EdgeInsets.only(top: 10, left: 20, right: 20),
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      height: 70,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0,3)
                            )
                          ]
                      ),
                    ),
                    Container(
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, CupertinoPageRoute(builder: (context) => SKPindahWNI()));
                        },
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Image.asset(
                                'images/flag.png',
                                height: 40,
                                width: 40,
                              ),
                            ),
                            Container(
                              child: Text(
                                "SK Pindah WNI",
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700
                                ),
                              ),
                              margin: EdgeInsets.only(left: 20),
                            )
                          ],
                        ),
                      ),
                      margin: EdgeInsets.only(top: 10, left: 20, right: 20),
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      height: 70,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0,3)
                            )
                          ]
                      ),
                    ),
                    Container(
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, CupertinoPageRoute(builder: (context) => SKKelakuanBaik()));
                        },
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Image.asset(
                                'images/thumb.png',
                                height: 40,
                                width: 40,
                              ),
                            ),
                            Container(
                              child: Text(
                                "SK Kelakuan Baik",
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700
                                ),
                              ),
                              margin: EdgeInsets.only(left: 20),
                            )
                          ],
                        ),
                      ),
                      margin: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      height: 70,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0,3)
                            )
                          ]
                      ),
                    ),
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