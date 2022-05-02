import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:surat/LoginAndRegistration/LoginPage.dart';
import 'package:http/http.dart' as http;
import 'package:surat/Penduduk/ValidasiSuratPanitia/ViewSurat.dart';

class validasiKrama extends StatefulWidget {
  const validasiKrama({Key key}) : super(key: key);

  @override
  State<validasiKrama> createState() => _validasiKramaState();
}

class _validasiKramaState extends State<validasiKrama> {
  var apiURLShowListSuratSudahDivalidasi = "http://192.168.18.10:8000/api/krama/surat/validasi/${loginPage.kramaId}";
  var apiURLShowListSuratBelumDivalidasi = "http://192.168.18.10:8000/api/krama/surat/no-validasi/${loginPage.kramaId}";

  //surat validasi
  var nomorSuratValidasi = [];
  var perihalSuratValidasi = [];
  var idSuratValidasi = [];
  bool LoadingValidasi = true;
  bool availableValidasi = false;

  //surat belum validasi
  var nomorSuratBelumValidasi = [];
  var perihalSuratBelumValidasi = [];
  var idSuratBelumValidasi = [];
  bool LoadingBelumValidasi = true;
  bool availableBelumValidasi = true;

  var selectedIdSurat;

  Future refreshListSuratBelumValidasi() async {
    http.get(Uri.parse(apiURLShowListSuratBelumDivalidasi),
      headers: {"Content-Type" : "application/json"}
    ).then((http.Response response) {
      var responseValue = response.statusCode;
      if(responseValue == 200) {
        var data = json.decode(response.body);
        this.nomorSuratBelumValidasi = [];
        this.perihalSuratBelumValidasi = [];
        this.idSuratBelumValidasi = [];
        setState(() {
          LoadingBelumValidasi = false;
          availableBelumValidasi = true;
          for(var i = 0; i < data.length; i++) {
            this.nomorSuratBelumValidasi.add(data[i]['nomor_surat']);
            this.perihalSuratBelumValidasi.add(data[i]['parindikan']);
            this.idSuratBelumValidasi.add(data[i]['surat_keluar_id']);
          }
        });
      }else{
        setState(() {
          LoadingBelumValidasi = false;
          availableBelumValidasi = false;
        });
      }
    });
  }

  Future refreshListSuratValidasi() async {
    http.get(Uri.parse(apiURLShowListSuratSudahDivalidasi),
      headers: {"Content-Type" : "application/json"}
    ).then((http.Response response) {
      var responseValue = response.statusCode;
      if(responseValue == 200) {
        var data = json.decode(response.body);
        this.nomorSuratValidasi = [];
        this.perihalSuratValidasi = [];
        this.idSuratValidasi = [];
        setState(() {
          LoadingValidasi = false;
          availableValidasi = true;
          for(var i = 0; i < data.length; i++) {
            this.nomorSuratValidasi.add(data[i]['nomor_surat']);
            this.perihalSuratValidasi.add(data[i]['parindikan']);
            this.idSuratValidasi.add(data[i]['surat_keluar_id']);
          }
        });
      }else{
        setState(() {
          LoadingValidasi = false;
          availableValidasi = false;
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    refreshListSuratBelumValidasi();
    refreshListSuratValidasi();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Validasi Surat", style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w700,
            color: Colors.white
          )),
          backgroundColor: HexColor("#025393"),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: (){Navigator.of(context).pop();},
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: Image.asset(
                  'images/email.png',
                  height: 100,
                  width: 100,
                ),
                margin: EdgeInsets.only(top: 20, bottom: 10)
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
                              labelColor: HexColor("#025393"),
                              unselectedLabelColor: Colors.black,
                              tabs: [
                                Tab(child: Text("Belum Divalidasi", style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w700
                                ), textAlign: TextAlign.center)),
                                Tab(child: Text("Sudah Divalidasi", style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w700
                                ), textAlign: TextAlign.center))
                              ],
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.678,
                            decoration: BoxDecoration(
                              border: Border(top: BorderSide(color: Colors.black26, width: 0.5))
                            ),
                            child: TabBarView(
                              children: <Widget>[
                                Container(
                                  child: LoadingBelumValidasi ? ListTileShimmer() : availableBelumValidasi ? RefreshIndicator(
                                    onRefresh: refreshListSuratBelumValidasi,
                                    child: ListView.builder(
                                      itemCount: idSuratBelumValidasi.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: (){
                                            setState(() {
                                              viewSuratKrama.suratKeluarId = idSuratBelumValidasi[index];
                                            });
                                            Navigator.push(context, CupertinoPageRoute(builder: (context) => viewSuratKrama()));
                                          },
                                          child: Container(
                                            child: Row(
                                              children: <Widget>[
                                                Container(
                                                  child: Image.asset(
                                                    'images/email.png',
                                                    height: 40,
                                                    width: 40
                                                  )
                                                ),
                                                Container(
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      Container(
                                                        child: SizedBox(
                                                          width: MediaQuery.of(context).size.width * 0.55,
                                                          child: Text(
                                                            perihalSuratBelumValidasi[index],
                                                            style: TextStyle(
                                                              fontFamily: "Poppins",
                                                              fontSize: 16,
                                                              fontWeight: FontWeight.w700,
                                                              color: HexColor("#025393")
                                                            ),
                                                            maxLines: 1,
                                                            overflow: TextOverflow.ellipsis,
                                                            softWrap: false
                                                          ),
                                                        )
                                                      ),
                                                      Container(
                                                        child: Text(nomorSuratBelumValidasi[index], style: TextStyle(
                                                          fontFamily: "Poppins",
                                                          fontSize: 14
                                                        ))
                                                      )
                                                    ]
                                                  ),
                                                  margin: EdgeInsets.only(left: 15)
                                                )
                                              ]
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
                                          )
                                        );
                                      }
                                    )
                                  ) : Container(
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
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black26
                                          ), textAlign: TextAlign.center),
                                          margin: EdgeInsets.only(top: 10),
                                          padding: EdgeInsets.symmetric(horizontal: 30)
                                        )
                                      ]
                                    )
                                  )
                                ),
                                Container(
                                  child: LoadingValidasi ? ListTileShimmer() : availableValidasi ? RefreshIndicator(
                                    onRefresh: refreshListSuratValidasi,
                                    child: ListView.builder(
                                      itemCount: idSuratValidasi.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: (){},
                                          child: Container(
                                            child: Row(
                                              children: <Widget>[
                                                Container(
                                                  child: Image.asset(
                                                    'images/email.png',
                                                    height: 40,
                                                    width: 40
                                                  )
                                                ),
                                                Container(
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      Container(
                                                        child: SizedBox(
                                                          width: MediaQuery.of(context).size.width * 0.55,
                                                          child: Text(
                                                            perihalSuratValidasi[index],
                                                            style: TextStyle(
                                                              fontFamily: "Poppins",
                                                              fontSize: 16,
                                                              fontWeight: FontWeight.w700,
                                                              color: HexColor("#025393")
                                                            ),
                                                            maxLines: 1,
                                                            overflow: TextOverflow.ellipsis,
                                                            softWrap: false,
                                                          ),
                                                        )
                                                      ),
                                                      Container(
                                                        child: Text(nomorSuratValidasi[index], style: TextStyle(
                                                          fontFamily: "Poppins",
                                                          fontSize: 14
                                                        ))
                                                      )
                                                    ]
                                                  ),
                                                  margin: EdgeInsets.only(left: 15)
                                                )
                                              ]
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
                                          )
                                        );
                                      }
                                    )
                                  ) : Container(
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
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black26
                                          ), textAlign: TextAlign.center),
                                          margin: EdgeInsets.only(top: 10),
                                          padding: EdgeInsets.symmetric(horizontal: 30)
                                        )
                                      ]
                                    )
                                  )
                                )
                              ]
                            )
                          )
                        ],
                      ),
                    )
                  ],
                )
              )
            ]
          )
        )
      ),
    );
  }
}