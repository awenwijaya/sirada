import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:surat/AdminDesa/ManajemenSurat/SuratKeluar/SuratKeluarNonPanitia/SuratKeluarNonPanitia.dart';
import 'package:surat/AdminDesa/ManajemenSurat/SuratKeluar/SuratKeluarPanitia/SuratKeluarPanitia.dart';
import 'package:surat/LoginAndRegistration/LoginPage.dart';
import 'package:http/http.dart' as http;

class suratKeluarAdmin extends StatefulWidget {
  const suratKeluarAdmin({Key key}) : super(key: key);

  @override
  State<suratKeluarAdmin> createState() => _suratKeluarAdminState();
}

class _suratKeluarAdminState extends State<suratKeluarAdmin> {
  var jumlahSuratPanitia = "0";
  var jumlahSuratPrajuruDesaAdat = "0";
  var jumlahSuratBendesaAdat = "0";
  var jumlahSuratParumanDesaAdat = "0";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: HexColor("#025393"),
            onPressed: (){
              Navigator.of(context).pop();
            },
          ),
          title: Text("Surat Keluar", style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w700,
            color: HexColor("#025393")
          )),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: Image.asset(
                  'images/email.png',
                  height: 100,
                  width: 100
                ),
                margin: EdgeInsets.only(top: 20)
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text("Kategori Surat Keluar", style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14,
                  fontWeight: FontWeight.w700
                )),
                margin: EdgeInsets.only(top: 20, left: 15)
              ),
              Container(
                child: Container(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, CupertinoPageRoute(builder: (context) => suratKeluarPanitiaAdmin()));
                    },
                    child: Container(
                        child: Stack(
                          alignment: Alignment.centerLeft,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                    child: Image.asset(
                                        "images/panitia.png",
                                        height: 40,
                                        width: 40
                                    ),
                                    margin: EdgeInsets.only(left: 15)
                                ),
                                Container(
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        child: Text(jumlahSuratPanitia, style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: HexColor("#025393")
                                        ))
                                      ),
                                      Container(
                                        child: Text("Surat Panitia", style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700
                                        ))
                                      )
                                    ]
                                  ),
                                  margin: EdgeInsets.only(left: 15)
                                )
                              ],
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              child: Icon(
                                CupertinoIcons.right_chevron,
                                color: HexColor("#025393")
                              ),
                              margin: EdgeInsets.only(right: 10)
                            )
                          ]
                        )
                    ),
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
              ),
              Container(
                child: Container(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, CupertinoPageRoute(builder: (context) => suratKeluarNonPanitiaAdmin()));
                    },
                    child: Container(
                        child: Stack(
                            alignment: Alignment.centerLeft,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                      child: Image.asset(
                                          "images/staff.png",
                                          height: 40,
                                          width: 40
                                      ),
                                      margin: EdgeInsets.only(left: 15)
                                  ),
                                  Container(
                                      child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                                child: Text(jumlahSuratPrajuruDesaAdat, style: TextStyle(
                                                    fontFamily: "Poppins",
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w700,
                                                    color: HexColor("#025393")
                                                ))
                                            ),
                                            Container(
                                                child: Text("Surat Non-Panitia", style: TextStyle(
                                                    fontFamily: "Poppins",
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w700
                                                ))
                                            )
                                          ]
                                      ),
                                      margin: EdgeInsets.only(left: 15)
                                  )
                                ],
                              ),
                              Container(
                                  alignment: Alignment.centerRight,
                                  child: Icon(
                                      CupertinoIcons.right_chevron,
                                      color: HexColor("#025393")
                                  ),
                                  margin: EdgeInsets.only(right: 10)
                              )
                            ]
                        )
                    ),
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
              ),
            ]
          )
        )
      ),
    );
  }
}