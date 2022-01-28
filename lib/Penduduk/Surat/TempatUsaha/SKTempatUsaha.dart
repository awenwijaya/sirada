import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:surat/Penduduk/Surat/TempatUsaha/DataTempatUsaha.dart';
import 'package:surat/Penduduk/Surat/TempatUsaha/DetailTempatUsaha.dart';
import 'package:surat/shared/API/Models/SKPenduduk/SKTempatUsaha/SKTempatUsaha.dart';
import 'package:surat/shared/API/Models/SKPenduduk/SKTempatUsaha/SKTempatUsahaSelesai.dart';
import 'package:surat/LoginAndRegistration/LoginPage.dart';
import 'package:http/http.dart' as http;

class SKTempatUsaha extends StatefulWidget {
  const SKTempatUsaha({Key key}) : super(key: key);

  @override
  _SKTempatUsahaState createState() => _SKTempatUsahaState();
}

class _SKTempatUsahaState extends State<SKTempatUsaha> {
  var apiURLSedangDiproses = "http://192.168.18.10:8000/api/sk/tempatusaha/showSedangDiproses";
  var apiURLSelesai = "http://192.168.18.10:8000/api/sk/tempatusaha/showSelesai";

  Future<SkTempatUsaha> SedangDiproses() async {
    var body = jsonEncode({
      "pemohon_id" : loginPage.pendudukId
    });
    return http.post(Uri.parse(apiURLSedangDiproses),
      headers: {"Content-Type" : "application/json"},
      body: body
    ).then((http.Response response) {
      if(response.statusCode == 200) {
        final body = response.body;
        final skTempatUsahaData = skTempatUsahaFromJson(body);
        return skTempatUsahaData;
      }else{
        final body = response.body;
        final error = skTempatUsahaFromJson(body);
        return error;
      }
    });
  }

  Future<SkTempatUsahaSelesai> Selesai() async {
    var body = jsonEncode({
      "pemohon_id" : loginPage.pendudukId
    });
    return http.post(Uri.parse(apiURLSelesai),
      headers: {"Content-Type" : "application/json"},
      body: body
    ).then((http.Response response) {
      if(response.statusCode == 200) {
        final body = response.body;
        final skTempatUsahaData = skTempatUsahaSelesaiFromJson(body);
        return skTempatUsahaData;
      }else{
        final body = response.body;
        final error = skTempatUsahaSelesaiFromJson(body);
        return error;
      }
    });
  }

  Widget listSedangDiproses() {
    return FutureBuilder<SkTempatUsaha>(
      future: SedangDiproses(),
      builder: (context, snapshot) {
        final data = snapshot.data;
        if(snapshot.hasData) {
          final skTempatUsahaData = data.data;
          return ListView.builder(
            itemCount: skTempatUsahaData.length,
            itemBuilder: (context, index) {
              final skTempatUsaha = skTempatUsahaData[index];
              return TextButton(
                onPressed: (){
                  setState(() {
                    detailTempatUsaha.gambarLokasi = skTempatUsaha.foto;
                    detailTempatUsaha.namaUsaha = skTempatUsaha.namaUsaha;
                    detailTempatUsaha.jenisUsaha = skTempatUsaha.jenisUsaha;
                    detailTempatUsaha.alamatUsaha = skTempatUsaha.alamatUsaha;
                    detailTempatUsaha.status = skTempatUsaha.status;
                    detailTempatUsaha.namaDusun = skTempatUsaha.namaDusun;
                    detailTempatUsaha.namaDesa = skTempatUsaha.namaDesa;
                    detailTempatUsaha.tanggalPengajuan = skTempatUsaha.tanggalPengajuan;
                    detailTempatUsaha.skTempatUsahaId = skTempatUsaha.idSkTempatUsaha;
                    detailTempatUsaha.tempatUsahaId = skTempatUsaha.idTempatUsaha;
                    detailTempatUsaha.suratMasyarakatId = skTempatUsaha.suratMasyarakatId;
                  });
                  Navigator.push(context, CupertinoPageRoute(builder: (context) => detailTempatUsaha()));
                },
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Image.asset(
                                'images/store.png',
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
                                      skTempatUsaha.status.toString(),
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
                                        skTempatUsaha.namaUsaha.toString(),
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
                                      "Tanggal Pengajuan: ${skTempatUsaha.tanggalPengajuan.day.toString()} - ${skTempatUsaha.tanggalPengajuan.month.toString()} - ${skTempatUsaha.tanggalPengajuan.year.toString()}",
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
    return FutureBuilder<SkTempatUsahaSelesai>(
      future: Selesai(),
      builder: (context, snapshot){
        final data = snapshot.data;
        if(snapshot.hasData) {
          final skTempatUsahaSelesaiData = data.data;
          return ListView.builder(
            itemCount: skTempatUsahaSelesaiData.length,
            itemBuilder: (context, index) {
              final skTempatUsaha = skTempatUsahaSelesaiData[index];
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
                                'images/store.png',
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
                                      skTempatUsaha.status.toString(),
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
                                        skTempatUsaha.namaUsaha.toString(),
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
                                      "Tanggal Pengajuan: ${skTempatUsaha.tanggalPengajuan.day.toString()} - ${skTempatUsaha.tanggalPengajuan.month.toString()} - ${skTempatUsaha.tanggalPengajuan.year.toString()}",
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 14,
                                        color: Colors.black26
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "Tanggal Pengesahan: ${skTempatUsaha.tanggalPengesahan.day.toString()} - ${skTempatUsaha.tanggalPengesahan.month.toString()} - ${skTempatUsaha.tanggalPengesahan.year.toString()}",
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
          title: Text("SK Tempat Usaha", style: TextStyle(
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
                  'images/store.png',
                  height: 100,
                  width: 100,
                ),
                margin: EdgeInsets.only(top: 20),
              ),
              Container(
                child: FlatButton(
                  onPressed: (){
                    Navigator.push(context, CupertinoPageRoute(builder: (context) => formDataTempatUsaha()));
                  },
                  child: Text("Ajukan SK Tempat Usaha", style: TextStyle(
                    fontFamily: "Poppins",
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
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "Status Pengajuan SK Tempat Usaha",
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
                                  height: 400,
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
