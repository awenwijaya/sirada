import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:surat/Penduduk/Surat/AktaKelahiran/Formulir.dart';
import 'package:surat/Penduduk/Surat/BelumMenikah/Formulir.dart';
import 'package:surat/Penduduk/Surat/Berpergian/Formulir.dart';
import 'package:surat/Penduduk/Surat/DatangWNI/Formulir.dart';
import 'package:surat/Penduduk/Surat/KelakuanBaik/Formulir.dart';
import 'package:surat/Penduduk/Surat/Kematian/Formulir.dart';
import 'package:surat/Penduduk/Surat/LainLain/Formulir.dart';
import 'package:surat/Penduduk/Surat/PenghasilanOrangTua/Formulir.dart';
import 'package:surat/Penduduk/Surat/PindahWNI/Formulir.dart';
import 'package:surat/Penduduk/Surat/TempatUsaha/DataTempatUsaha.dart';
import 'package:surat/Penduduk/Surat/TidakMampu/Formulir.dart';
import 'package:surat/Penduduk/Surat/Usaha/Formulir.dart';

class listPengajuanSuratUser extends StatefulWidget {
  const listPengajuanSuratUser({Key key}) : super(key: key);

  @override
  _listPengajuanSuratUserState createState() => _listPengajuanSuratUserState();
}

class _listPengajuanSuratUserState extends State<listPengajuanSuratUser> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Surat Keterangan", style: TextStyle(
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
                        'images/email.png',
                        height: 50,
                        width: 50,
                      ),
                      margin: EdgeInsets.only(top: 30),
                    ),
                    Container(
                      child: Text(
                        "Surat Keterangan (SK)",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 16,
                            fontWeight: FontWeight.w700
                        ),
                        textAlign: TextAlign.center,
                      ),
                      margin: EdgeInsets.only(top: 20),
                    ),
                    Container(
                      child: Text(
                        "Pilihlah salah satu dari list pengajuan surat dibawah ini",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 14
                        ),
                        textAlign: TextAlign.center,
                      ),
                      margin: EdgeInsets.only(top: 10),
                      padding: EdgeInsets.symmetric(horizontal: 20),
                    )
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, CupertinoPageRoute(builder: (context) => formSKKelakuanBaik()));
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
                                "SK Berkelakuan Baik",
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
                      margin: EdgeInsets.only(top: 25, left: 20, right: 20),
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
                          Navigator.push(context, CupertinoPageRoute(builder: (context) => formSKBelumMenikah()));
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
                          Navigator.push(context, CupertinoPageRoute(builder: (context) => formSKKematian()));
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
                          Navigator.push(context, CupertinoPageRoute(builder: (context) => formSKUsaha()));
                        },
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Image.asset(
                                'images/briefcase.png',
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
                          Navigator.push(context, CupertinoPageRoute(builder: (context) => formDataTempatUsaha()));
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
                          Navigator.push(context, CupertinoPageRoute(builder: (context) => formSKTidakMampu()));
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
                          Navigator.push(context, CupertinoPageRoute(builder: (context) => formPendaftaranAktaKelahiran()));
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
                          Navigator.push(context, CupertinoPageRoute(builder: (context) => formSPPenghasilanOrangTua()));
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
                          Navigator.push(context, CupertinoPageRoute(builder: (context) => formSKPindahWNI()));
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
                          Navigator.push(context, CupertinoPageRoute(builder: (context) => formSKDatangWNI()));
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
                          Navigator.push(context, CupertinoPageRoute(builder: (context) => formSKLainLain()));
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
                          Navigator.push(context, CupertinoPageRoute(builder: (context) => formSKBerpergian()));
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