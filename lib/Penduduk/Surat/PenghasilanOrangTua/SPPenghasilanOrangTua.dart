import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:surat/Penduduk/Surat/PenghasilanOrangTua/Formulir.dart';
import 'package:http/http.dart' as http;
import 'package:surat/shared/API/Models/SKPenduduk/SPPenghasilanOrangTua/SPPenghasilanOrangTua.dart';
import 'package:surat/shared/API/Models/SKPenduduk/SPPenghasilanOrangTua/SPPenghasilanOrangTuaSelesai.dart';
import 'package:surat/LoginAndRegistration/LoginPage.dart';

class SPPenghasilanOrangTua extends StatefulWidget {
  const SPPenghasilanOrangTua({Key key}) : super(key: key);

  @override
  _SPPenghasilanOrangTuaState createState() => _SPPenghasilanOrangTuaState();
}

class _SPPenghasilanOrangTuaState extends State<SPPenghasilanOrangTua> {
  var apiURLSedangDiproses = "http://192.168.18.10:8000/api/sp/penghasilanortu/showSedangDiproses";
  var apiURLSelesai = "http://192.168.18.10:8000/api/sp/penghasilanortu/showSelesai";

  Future<SpPenghasilanOrangTua> SedangDiproses() async {
    var body = jsonEncode({
      "penduduk_id" : loginPage.pendudukId
    });
    return http.post(Uri.parse(apiURLSedangDiproses),
      headers: {"Content-Type" : "application/json"},
      body: body
    ).then((http.Response response) {
      if(response.statusCode == 200) {
        final body = response.body;
        final spPenghasilanOrangTuaData = spPenghasilanOrangTuaFromJson(body);
        return spPenghasilanOrangTuaData;
      }else{
        final body = response.body;
        final error = spPenghasilanOrangTuaFromJson(body);
        return error;
      }
    });
  }

  Future<SpPenghasilanOrangTuaSelesai> Selesai() async {
    var body = jsonEncode({
      "penduduk_id" :  loginPage.pendudukId
    });
    return http.post(Uri.parse(apiURLSelesai),
      headers: {"Content-Type" : "application/json"},
      body: body
    ).then((http.Response response) {
      if(response.statusCode == 200) {
        final body = response.body;
        final spPenghasilanOrangTuaData = spPenghasilanOrangTuaSelesaiFromJson(body);
        return spPenghasilanOrangTuaData;
      }else{
        final body = response.body;
        final error = spPenghasilanOrangTuaSelesaiFromJson(body);
        return error;
      }
    });
  }

  Widget listSedangDiproses() {
    return FutureBuilder<SpPenghasilanOrangTua>(
      future: SedangDiproses(),
      builder: (context, snapshot) {
        final data = snapshot.data;
        if(snapshot.hasData) {
          final spPenghasilanOrangTuaData = data.data;
          return ListView.builder(
            itemCount: spPenghasilanOrangTuaData.length,
            itemBuilder: (context, index) {
              final spPenghasilanOrangTua = spPenghasilanOrangTuaData[index];
              return TextButton(
                onPressed: (){},
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Image.asset(
                                'images/paycheck.png',
                                height: 50,
                                width: 50,
                              ),
                            ),
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      spPenghasilanOrangTua.status.toString(),
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
                                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                  ),
                                  Container(
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.75,
                                      child: Text(
                                        spPenghasilanOrangTua.keperluan.toString(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                        style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black
                                        ),
                                      ),
                                    ),
                                    margin: EdgeInsets.only(top: 7, left: 5),
                                  ),
                                  Container(
                                    child: Text(
                                      "Tanggal Pengajuan: ${spPenghasilanOrangTua.tanggalPengajuan.day.toString()} - ${spPenghasilanOrangTua.tanggalPengajuan.month.toString()} - ${spPenghasilanOrangTua.tanggalPengajuan.year.toString()}",
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 14,
                                          color: Colors.black26
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              margin: EdgeInsets.only(left: 10, bottom: 10),
                            )
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: Colors.black26, width: 1))
                        ),
                      )
                    ],
                  ),
                  margin: EdgeInsets.only(left: 10),
                ),
              );
            },
          );
        }else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget listSelesai() {
    return FutureBuilder<SpPenghasilanOrangTuaSelesai>(
      future: Selesai(),
      builder: (context, snapshot) {
        final data = snapshot.data;
        if(snapshot.hasData) {
          final spPenghasilanOrangTuaData = data.data;
          return ListView.builder(
            itemCount: spPenghasilanOrangTuaData.length,
            itemBuilder: (context, index) {
              final spPenghasilanOrangTua = spPenghasilanOrangTuaData[index];
              return TextButton(
                onPressed: (){},
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Image.asset(
                                'images/paycheck.png',
                                height: 50,
                                width: 50,
                              ),
                            ),
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      spPenghasilanOrangTua.status.toString(),
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
                                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                  ),
                                  Container(
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.75,
                                      child: Text(
                                        spPenghasilanOrangTua.keperluan.toString(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black
                                        ),
                                      ),
                                    ),
                                    margin: EdgeInsets.only(top: 7, left: 5),
                                  ),
                                  Container(
                                    child: Text(
                                      "Tanggal Pengajuan: ${spPenghasilanOrangTua.tanggalPengajuan.day.toString()} - ${spPenghasilanOrangTua.tanggalPengajuan.month.toString()} - ${spPenghasilanOrangTua.tanggalPengajuan.year.toString()}",
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 14,
                                        color: Colors.black26
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "Tanggal Pengesahan: ${spPenghasilanOrangTua.tanggalPengesahan.day.toString()} - ${spPenghasilanOrangTua.tanggalPengesahan.month.toString()} - ${spPenghasilanOrangTua.tanggalPengesahan.year.toString()}",
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 14,
                                        color: Colors.black26
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              margin: EdgeInsets.only(left: 10, bottom: 10),
                            )
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: Colors.black26, width: 1))
                        ),
                      )
                    ],
                  ),
                  margin: EdgeInsets.only(left: 10),
                ),
              );
            },
          );
        }else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
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
            onPressed: (){Navigator.of(context).pop();},
          ),
          title: Text("SP Penghasilan Orang Tua", style: TextStyle(
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
                  'images/paycheck.png',
                  height: 100,
                  width: 100,
                ),
                margin: EdgeInsets.only(top: 20),
              ),
              Container(
                child: FlatButton(
                  onPressed: (){
                    Navigator.push(context, CupertinoPageRoute(builder: (context) => formSPPenghasilanOrangTua()));
                  },
                  child: Text("Ajukan SP Penghasilan Orang Tua", style: TextStyle(
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
                  padding: EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50),
                ),
                margin: EdgeInsets.only(top: 20),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "Status Pengajuan SP Penghasilan Orang Tua",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14,
                    fontWeight: FontWeight.w700
                  ),
                ),
                margin: EdgeInsets.only(top: 20, left: 15, bottom: 10),
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
                            height: MediaQuery.of(context).size.height,
                            decoration: BoxDecoration(
                              border: Border(top: BorderSide(color: Colors.black26, width: 0.5))
                            ),
                            child: TabBarView(
                              children: <Widget>[
                                Container(
                                  child: listSedangDiproses(),
                                ),
                                Container(
                                  child: listSelesai(),
                                )
                              ],
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
        ),
      ),
    );
  }
}