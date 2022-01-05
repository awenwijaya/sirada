import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surat/KepalaDesa/DetailDesa.dart';
import 'package:surat/KepalaDesa/Profile/UserProfile.dart';
import 'package:surat/WelcomeScreen.dart';
import 'package:surat/LoginAndRegistration/LoginPage.dart';
import 'package:http/http.dart' as http;

class dashboardKepalaDesa extends StatefulWidget {
  static var namaDesa = "Nama Desa";
  const dashboardKepalaDesa({Key key}) : super(key: key);

  @override
  _dashboardKepalaDesaState createState() => _dashboardKepalaDesaState();
}

class _dashboardKepalaDesaState extends State<dashboardKepalaDesa> {
  var apiURLDataDesa = "http://192.168.18.10:8000/api/getdatadesabyid";

  getDesaInfo() async {
    var body = jsonEncode({
      'desa_id' : loginPage.desaId
    });
    http.post(Uri.parse(apiURLDataDesa),
      headers : {"Content-Type" : "application/json"},
      body: body
    ).then((http.Response response) {
      var responseValue = response.statusCode;
      if(responseValue == 200) {
        var jsonData = response.body;
        var parsedJson = json.decode(jsonData);
        setState(() {
          dashboardKepalaDesa.namaDesa = parsedJson['nama_desa'];
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDesaInfo();
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
                Navigator.of(context).push(CupertinoPageRoute(builder: (context) => kepalaDesaProfile()));
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
                                dashboardKepalaDesa.namaDesa,
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: HexColor("#025393")
                                ),
                              ),
                            ),
                      Container(
                          child: TextButton(
                            child: Text(
                              "Detail Desa",
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14,
                                  color: Colors.black
                              ),
                            ),
                            onPressed: (){
                              Navigator.push(context, CupertinoPageRoute(builder: (context) => detailDesa()));
                            },
                          )
                      )
                          ],
                        )
                    )
                  ],
                ),
                margin: EdgeInsets.only(top: 25, left: 20, right: 20),
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
                child: GestureDetector(
                  onTap: (){},
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: Image.asset(
                          'images/paper.png',
                          height: 40,
                          width: 40,
                        ),
                      ),
                      Container(
                        child: Text(
                          "Manajemen Pelaporan",
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
                margin: EdgeInsets.only(top: 35, left: 20, right: 20),
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
                  onTap: (){},
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: Image.asset(
                          'images/kalendar.png',
                          height: 40,
                          width: 40,
                        ),
                      ),
                      Container(
                        child: Text(
                          "Manajemen Agenda Acara",
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
                child: Text(
                  "Berkas Administrasi Surat Penduduk",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14,
                    fontWeight: FontWeight.w700
                  ),
                ),
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(top: 35, left: 15),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
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
                                  Tab(child: Text("Menunggu Verifikasi", style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w700
                                  ))),
                                  Tab(child: Text("Telah Diverifikasi", style: TextStyle(
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
                                    child: Center(
                                      child: Text("Menunggu Verifikasi"),
                                    ),
                                  ),
                                  Container(
                                    child: Center(
                                      child: Text("Telah Diverifikasi"),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        )
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