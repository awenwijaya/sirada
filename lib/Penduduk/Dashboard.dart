import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surat/Penduduk/Profile/UserProfile.dart';
import 'package:surat/Penduduk/Surat/AktaKelahiran/Formulir.dart';
import 'package:surat/Penduduk/Surat/BelumMenikah/Formulir.dart';
import 'package:surat/Penduduk/Surat/DetailSuratMasyarakat.dart';
import 'package:surat/Penduduk/Surat/KelakuanBaik/Formulir.dart';
import 'package:surat/Penduduk/Surat/Kematian/Formulir.dart';
import 'package:surat/Penduduk/Surat/ListPengajuanSurat.dart';
import 'package:surat/Penduduk/Surat/TempatUsaha/DataTempatUsaha.dart';
import 'package:surat/Penduduk/Surat/TidakMampu/Formulir.dart';
import 'package:surat/WelcomeScreen.dart';

class dashboardPenduduk extends StatefulWidget {
  const dashboardPenduduk({Key key}) : super(key: key);

  @override
  _dashboardPendudukState createState() => _dashboardPendudukState();
}

class _dashboardPendudukState extends State<dashboardPenduduk> {
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
                            ))
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
                alignment: Alignment.topLeft,
                child: Text(
                  "Layanan Administrasi Surat",
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w700
                  ),
                  textAlign: TextAlign.left,
                ),
                margin: EdgeInsets.only(top: 20, left: 15),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: IconButton(
                              icon: Image.asset('images/baby.png'),
                              iconSize: 40,
                              onPressed: (){
                                Navigator.push(context, CupertinoPageRoute(builder: (context) => formPendaftaranAktaKelahiran()));
                              }
                            ),
                          ),
                          Container(
                            child: Text(
                              "SK Kelahiran",
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 13,
                                color: Colors.black
                              ),
                            ),
                            margin: EdgeInsets.only(top: 5),
                          )
                        ],
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 10),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: IconButton(
                                icon: Image.asset('images/thumb.png'),
                                iconSize: 40,
                                onPressed: (){
                                  Navigator.push(context, CupertinoPageRoute(builder: (context) => formSKKelakuanBaik()));
                                }
                            ),
                          ),
                          Container(
                            child: Text(
                              "Berkelakuan Baik",
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 13,
                                  color: Colors.black
                              ),
                            ),
                            margin: EdgeInsets.only(top: 5),
                          )
                        ],
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 10),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: IconButton(
                                icon: Image.asset('images/person.png'),
                                iconSize: 40,
                                onPressed: (){
                                  Navigator.push(context, CupertinoPageRoute(builder: (context) => formSKBelumMenikah()));
                                }
                            ),
                          ),
                          Container(
                            child: Text(
                              "SK Belum Menikah",
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 13,
                                  color: Colors.black
                              ),
                            ),
                            margin: EdgeInsets.only(top: 5),
                          )
                        ],
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 10),
                    )
                  ],
                ),
                margin: EdgeInsets.only(top: 20),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: IconButton(
                                icon: Image.asset('images/store.png'),
                                iconSize: 40,
                                onPressed: (){
                                  Navigator.push(context, CupertinoPageRoute(builder: (context) => formDataTempatUsaha()));
                                }
                            ),
                          ),
                          Container(
                            child: Text(
                              "SK Tempat Usaha",
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 13,
                                  color: Colors.black
                              ),
                            ),
                            margin: EdgeInsets.only(top: 5),
                          )
                        ],
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 10),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: IconButton(
                                icon: Image.asset('images/money.png'),
                                iconSize: 40,
                                onPressed: (){
                                  Navigator.push(context, CupertinoPageRoute(builder: (context) => formSKTidakMampu()));
                                }
                            ),
                          ),
                          Container(
                            child: Text(
                              "SK Tidak Mampu",
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 13,
                                  color: Colors.black
                              ),
                            ),
                            margin: EdgeInsets.only(top: 5),
                          )
                        ],
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 10),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: IconButton(
                                icon: Image.asset('images/scull.png'),
                                iconSize: 40,
                                onPressed: (){
                                  Navigator.push(context, CupertinoPageRoute(builder: (context) => formSKKematian()));
                                }
                            ),
                          ),
                          Container(
                            child: Text(
                              "SK Kematian",
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 13,
                                  color: Colors.black
                              ),
                            ),
                            margin: EdgeInsets.only(top: 5),
                          )
                        ],
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 10),
                    )
                  ],
                ),
                margin: EdgeInsets.only(top: 20),
              ),
              Container(
                child: FlatButton(
                  onPressed: (){
                    Navigator.push(context, CupertinoPageRoute(builder: (context) => listPengajuanSuratUser()));
                  },
                  color: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                    side: BorderSide(color: HexColor("#025393"))
                  ),
                  padding: EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Text(
                          "Surat keterangan lainnya",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 15,
                            color: HexColor("#025393"),
                            fontWeight: FontWeight.w700
                          ),
                        ),
                        margin: EdgeInsets.only(right: 5),
                      ),
                      Container(
                        child: Icon(Icons.arrow_forward, color: HexColor("#025393")),
                      )
                    ],
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 30),
                margin: EdgeInsets.only(top: 25),
              ),
              Container(
                child: Text(
                  "Status Surat Saya",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w700
                  ),
                  textAlign: TextAlign.left,
                ),
                margin: EdgeInsets.only(top: 35, left: 15),
                alignment: Alignment.topLeft,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    "0",
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: HexColor("#025393")
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    "Menunggu",
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 14
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    "0",
                                    style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: HexColor("#025393")
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    "Diproses",
                                    style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 14
                                    ),
                                  ),
                                )
                              ],
                            ),
                            margin: EdgeInsets.only(left: 20, right: 20),
                          ),
                          Container(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    "0",
                                    style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: HexColor("#025393")
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    "Sudah Verifikasi",
                                    style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 14
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                    )
                  ],
                ),
                margin: EdgeInsets.only(top: 20),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    DefaultTabController(
                      length: 2,
                      initialIndex: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            child: TabBar(
                              labelColor: HexColor("#074F78"),
                              unselectedLabelColor: Colors.black,
                              tabs: [
                                Tab(child: Text("Sedang Diproses", style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w700
                                ))),
                                Tab(child: Text("Selesai", style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w700
                                )))
                              ],
                            ),
                          ),
                          Container(
                            height: 400,
                            decoration: BoxDecoration(
                              border: Border(top: BorderSide(color: Colors.black26, width: 0.5))
                            ),
                            child: TabBarView(
                              children: <Widget>[
                                Container(
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        alignment: Alignment.topLeft,
                                        child: GestureDetector(
                                          onTap: (){
                                            Navigator.push(context, CupertinoPageRoute(builder: (context) => detailSurat()));
                                          },
                                          child: Row(
                                            children: <Widget>[
                                              Container(
                                                child: Image.asset(
                                                  'images/email.png',
                                                  height: 50,
                                                  width: 50,
                                                ),
                                              ),
                                              Container(
                                                child: Column(
                                                  children: <Widget>[
                                                    Container(
                                                      child: Text(
                                                        "Sedang Menunggu",
                                                        style: TextStyle(
                                                            fontFamily: "Poppins",
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.w700,
                                                            color: Colors.white
                                                        ),
                                                      ),
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.all(Radius.circular(20)),
                                                          color: HexColor("#fab73d")
                                                      ),
                                                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                                      margin: EdgeInsets.only(top: 15),
                                                    ),
                                                    Container(
                                                      child: Text(
                                                        "SK Belum Menikah",
                                                        style: TextStyle(
                                                            fontFamily: "Poppins",
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.w700,
                                                            color: HexColor("#025393")
                                                        ),
                                                      ),
                                                      margin: EdgeInsets.only(top: 5),
                                                    ),
                                                    Container(
                                                      child: Text(
                                                        "68/SP.TGK/V/2022",
                                                        style: TextStyle(
                                                            fontFamily: "Poppins",
                                                            fontSize: 14,
                                                            color: Colors.black26
                                                        ),
                                                      ),
                                                      margin: EdgeInsets.only(top: 5, bottom: 10),
                                                    )
                                                  ],
                                                ),
                                                margin: EdgeInsets.only(left: 30),
                                              )
                                            ],
                                          ),
                                        ),
                                        margin: EdgeInsets.only(top: 25, left: 20, right: 20),
                                        padding: EdgeInsets.symmetric(horizontal: 20),
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
                                ),
                                Container(
                                  child: Center(
                                    child: Text("Selesai"),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
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