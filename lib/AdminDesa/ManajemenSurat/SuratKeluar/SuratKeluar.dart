import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:surat/LoginAndRegistration/LoginPage.dart';
import 'package:http/http.dart' as http;

class suratKeluarAdmin extends StatefulWidget {
  const suratKeluarAdmin({Key key}) : super(key: key);

  @override
  State<suratKeluarAdmin> createState() => _suratKeluarAdminState();
}

class _suratKeluarAdminState extends State<suratKeluarAdmin> {
  var apiURLSuratKeluarDiproses = "http://192.168.18.10:8000/api/data/surat/keluar/sedang_diproses/${loginPage.desaId}";
  var apiURLSuratKeluarDikonfirmasi = "http://192.168.18.10:8000/api/data/surat/keluar/dikonfirmasi/${loginPage.desaId}";
  var apiURLSuratKeluarDibatalkan = "http://192.168.18.10:8000/api/data/surat/keluar/dibatalkan/${loginPage.desaId}";
  bool LoadingDiproses = true;
  bool LoadingDikonfirmasi = true;
  bool LoadingDibatalkan = true;
  bool availableDataDiproses = false;
  bool availableDataDikonfirmasi = false;
  bool availableDataDibatalkan = false;

  Future refreshListSuratKeluarDiproses() async {
    Uri uri = Uri.parse(apiURLSuratKeluarDiproses);
    final response = await http.get(uri);
    if(response.statusCode == 501) {
      setState(() {
        LoadingDiproses = false;
        availableDataDiproses = false;
      });
    }
  }

  Future refreshListSuratKeluarDikonfirmasi() async {
    Uri uri = Uri.parse(apiURLSuratKeluarDikonfirmasi);
    final response = await http.get(uri);
    if(response.statusCode == 501) {
      setState(() {
        LoadingDikonfirmasi = false;
        availableDataDikonfirmasi = false;
      });
    }
  }

  Future refreshListSuratKeluarDibatalkan() async {
    Uri uri = Uri.parse(apiURLSuratKeluarDibatalkan);
    final response = await http.get(uri);
    if(response.statusCode == 501) {
      setState(() {
        LoadingDibatalkan = false;
        availableDataDibatalkan = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    refreshListSuratKeluarDiproses();
    refreshListSuratKeluarDikonfirmasi();
    refreshListSuratKeluarDibatalkan();
  }

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
          ))
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
                margin: EdgeInsets.only(top: 20),
              ),
              Container(
                child: FlatButton(
                  onPressed: (){},
                  child: Text("Tambah Data Surat Keluar", style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: HexColor("#025393")
                  )),
                  color: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                    side: BorderSide(color: HexColor("#025393"), width: 2)
                  ),
                  padding: EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50)
                ),
                margin: EdgeInsets.only(top: 20)
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text("Status Surat Keluar", style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14,
                  fontWeight: FontWeight.w700
                )),
                margin: EdgeInsets.only(top: 20, left: 15, bottom: 20),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    DefaultTabController(
                      length: 3,
                      initialIndex: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            child: TabBar(
                              labelColor: HexColor("#025393"),
                              unselectedLabelColor: Colors.black,
                              tabs: [
                                Tab(child: Text("Sedang Diproses", style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w700
                                ), textAlign: TextAlign.center)),
                                Tab(child: Text("Telah Dikonfirmasi", style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w700
                                ), textAlign: TextAlign.center)),
                                Tab(child: Text("Dibatalkan", style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w700
                                ), textAlign: TextAlign.center))
                              ],
                            )
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.5,
                            decoration: BoxDecoration(
                                border: Border(top: BorderSide(color: Colors.black26, width: 0.5))
                            ),
                            child: TabBarView(
                              children: <Widget>[
                                Container(
                                  child: LoadingDiproses ? ListTileShimmer() : availableDataDiproses ? Container() : Container(
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            child: Icon(
                                              CupertinoIcons.mail_solid,
                                              size: 50,
                                              color: Colors.black26
                                            )
                                          ),
                                          Container(
                                            child: Text("Tidak ada Data Surat Keluar", style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black26
                                            ), textAlign: TextAlign.center),
                                            margin: EdgeInsets.only(top: 10)
                                          ),
                                          Container(
                                            child: Text("Tidak ada data surat keluar. Anda bisa menambahkannya dengan cara menekan tombol Tambah Data Surat Keluar dan isi data surat keluar pada form yang telah disediakan", style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 14,
                                              color: Colors.black26
                                            ), textAlign: TextAlign.center),
                                            padding: EdgeInsets.symmetric(horizontal: 30),
                                            margin: EdgeInsets.only(top: 10)
                                          )
                                        ]
                                      )
                                    ),
                                      alignment: Alignment(0.0, 0.0)
                                  )
                                ),
                                Container(
                                  child: LoadingDikonfirmasi ? Center(
                                    child: Lottie.asset('assets/loading-circle.json')
                                  ) : availableDataDikonfirmasi ? Container() : Container(
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            child: Icon(
                                              CupertinoIcons.mail_solid,
                                              size: 50,
                                              color: Colors.black26
                                            )
                                          ),
                                          Container(
                                            child: Text("Tidak ada Data", style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black26
                                            ), textAlign: TextAlign.center),
                                            margin: EdgeInsets.only(top: 10)
                                          )
                                        ]
                                      )
                                    ),
                                      alignment: Alignment(0.0, 0.0)
                                  ),
                                ),
                                Container(
                                  child: LoadingDibatalkan ? ListTileShimmer() : availableDataDibatalkan ? Container() : Container(
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            child: Icon(
                                              CupertinoIcons.mail_solid,
                                              size: 50,
                                              color: Colors.black26
                                            )
                                          ),
                                          Container(
                                            child: Text("Tidak ada Data", style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black26
                                            ), textAlign: TextAlign.center),
                                            margin: EdgeInsets.only(top: 10)
                                          )
                                        ]
                                      )
                                    ),
                                      alignment: Alignment(0.0, 0.0)
                                  )
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ]
                ),
              )
            ]
          )
        ),
      )
    );
  }
}