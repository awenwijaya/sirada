import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:surat/LoginAndRegistration/LoginPage.dart';
import 'package:surat/Penduduk/Surat/KelakuanBaik/Formulir.dart';
import 'package:http/http.dart' as http;
import 'package:surat/shared/API/Models/SKPenduduk/SKKelakuanBaik/SKKelakuanBaik.dart';
import 'package:surat/shared/API/Models/SKPenduduk/SKKelakuanBaik/SKKelakuanBaikSelesai.dart';
import 'package:surat/Penduduk/Surat/KelakuanBaik/DetailSK.dart';

class SKKelakuanBaik extends StatefulWidget {
  const SKKelakuanBaik({Key key}) : super(key: key);

  @override
  _SKKelakuanBaikState createState() => _SKKelakuanBaikState();
}

class _SKKelakuanBaikState extends State<SKKelakuanBaik> {
  var apiURLSedangDiproses = "http://192.168.18.10:8000/api/sk/kelakuanbaik/showSedangDiproses";
  var apiURLSelesai = "http://192.168.18.10:8000/api/sk/kelakuanbaik/showSelesai";

  Future<SkKelakuanBaik> SedangDiproses() async {
    var body = jsonEncode({
      "penduduk_id" : loginPage.pendudukId
    });
    return http.post(Uri.parse(apiURLSedangDiproses),
      headers: {"Content-Type" : "application/json"},
      body: body
    ).then((http.Response response) {
      if(response.statusCode == 200) {
        final body = response.body;
        final skKelakuanBaikData = skKelakuanBaikFromJson(body);
        return skKelakuanBaikData;
      }else{
        final body = response.body;
        final error = skKelakuanBaikFromJson(body);
        return error;
      }
    });
  }

  Future<SkKelakuanBaikSelesai> Selesai() async {
    var body = jsonEncode({
      "penduduk_id" : loginPage.pendudukId
    });
    return http.post(Uri.parse(apiURLSelesai),
      headers: {"Content-Type" : "application/json"},
      body: body
    ).then((http.Response response) {
      if(response.statusCode == 200) {
        final body = response.body;
        final skKelakuanBaikData = skKelakuanBaikSelesaiFromJson(body);
        return skKelakuanBaikData;
      }else{
        final body = response.body;
        final error = skKelakuanBaikSelesaiFromJson(body);
        return error;
      }
    });
  }

  Widget listSedangDiproses() {
    return FutureBuilder<SkKelakuanBaik>(
      future: SedangDiproses(),
      builder: (context, snapshot) {
        final data = snapshot.data;
        if(snapshot.hasData) {
          final skKelakuanBaikData = data.data;
          return ListView.builder(
            itemCount: skKelakuanBaikData.length,
            itemBuilder: (context, index) {
              final skKelakuanBaik = skKelakuanBaikData[index];
              return TextButton(
                onPressed: (){
                  setState(() {
                    detailSKKelakuanBaik.keperluan = skKelakuanBaik.keperluan;
                    detailSKKelakuanBaik.status = skKelakuanBaik.status;
                    detailSKKelakuanBaik.tanggalPengajuan = skKelakuanBaik.tanggalPengajuan;
                    detailSKKelakuanBaik.skKelakuanBaikId = skKelakuanBaik.idSkKelakuanBaik;
                    detailSKKelakuanBaik.suratMasyarakatId = skKelakuanBaik.suratMasyarakatId;
                  });
                  Navigator.push(context, CupertinoPageRoute(builder: (context) => detailSKKelakuanBaik()));
                },
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      skKelakuanBaik.status.toString(),
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
                                        skKelakuanBaik.keperluan.toString(),
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
                                      "Tanggal Pengajuan: ${skKelakuanBaik.tanggalPengajuan.day.toString()} - ${skKelakuanBaik.tanggalPengajuan.month.toString()} - ${skKelakuanBaik.tanggalPengajuan.year.toString()}",
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
    return FutureBuilder<SkKelakuanBaikSelesai>(
      future: Selesai(),
      builder: (context, snapshot) {
        final data = snapshot.data;
        if(snapshot.hasData) {
          final skKelakuanBaikData = data.data;
          return ListView.builder(
            itemCount: skKelakuanBaikData.length,
            itemBuilder: (context, index) {
              final skKelakuanBaik = skKelakuanBaikData[index];
              return TextButton(
                onPressed: (){
                  setState(() {
                    detailSKKelakuanBaik.keperluan = skKelakuanBaik.keperluan;
                    detailSKKelakuanBaik.status = skKelakuanBaik.status;
                    detailSKKelakuanBaik.tanggalPengesahan = skKelakuanBaik.tanggalPengesahan;
                    detailSKKelakuanBaik.tanggalPengajuan = skKelakuanBaik.tanggalPengajuan;
                    detailSKKelakuanBaik.suratMasyarakatId = skKelakuanBaik.suratMasyarakatId;
                  });
                  Navigator.push(context, CupertinoPageRoute(builder: (context) => detailSKKelakuanBaik()));
                },
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      skKelakuanBaik.status.toString(),
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
                                        skKelakuanBaik.keperluan.toString(),
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
                                      "Tanggal Pengajuan: ${skKelakuanBaik.tanggalPengajuan.day.toString()} - ${skKelakuanBaik.tanggalPengajuan.month.toString()} - ${skKelakuanBaik.tanggalPengajuan.year.toString()}",
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 14,
                                        color: Colors.black26
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "Tanggal Pengesahan: ${skKelakuanBaik.tanggalPengesahan.day.toString()} - ${skKelakuanBaik.tanggalPengesahan.month.toString()} - ${skKelakuanBaik.tanggalPengesahan.year.toString()}",
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
          title: Text("SK Kelakuan Baik", style: TextStyle(
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
                  'images/thumb.png',
                  height: 100,
                  width: 100,
                ),
                margin: EdgeInsets.only(top: 20),
              ),
              Container(
                child: FlatButton(
                  onPressed: (){
                    Navigator.push(context, CupertinoPageRoute(builder: (context) => formSKKelakuanBaik()));
                  },
                  child: Text("Ajukan SK Kelakuan Baik", style: TextStyle(
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
                  "Status Pengajuan SK Kelakuan Baik",
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
        ),
      ),
    );
  }
}