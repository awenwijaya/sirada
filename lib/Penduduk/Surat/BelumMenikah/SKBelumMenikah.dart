import 'dart:convert';
import 'package:surat/LoginAndRegistration/LoginPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:surat/Penduduk/Surat/BelumMenikah/DetailSK.dart';
import 'package:surat/Penduduk/Surat/BelumMenikah/Formulir.dart';
import 'package:http/http.dart' as http;
import 'package:surat/shared/API/Models/SKBelumMenikah.dart';
import 'package:surat/shared/API/Models/SKBelumMenikahSelesai.dart';

class SKBelumMenikah extends StatefulWidget {
  const SKBelumMenikah({Key key}) : super(key: key);

  @override
  _SKBelumMenikahState createState() => _SKBelumMenikahState();
}

class _SKBelumMenikahState extends State<SKBelumMenikah> {
  var apiURLSedangDiproses = "http://192.168.18.10:8000/api/sk/belumnikah/showSedangDiproses";
  var apiURLSelesai = "http://192.168.18.10:8000/api/sk/belumnikah/showSelesai";

  Future<SkBelumMenikah> SedangDiproses() async {
    var body = jsonEncode({
      "penduduk_id" : loginPage.pendudukId
    });
    return http.post(Uri.parse(apiURLSedangDiproses),
      headers: {"Content-Type" : "application/json"},
      body: body
    ).then((http.Response response) {
      if(response.statusCode == 200) {
        final body = response.body;
        final skBelumMenikahData = skBelumMenikahFromJson(body);
        return skBelumMenikahData;
      }else{
        final body = response.body;
        final error = skBelumMenikahFromJson(body);
        return error;
      }
    });
  }

  Future<SkBelumMenikahSelesai> Selesai() async {
    var body = jsonEncode({
      "penduduk_id" : loginPage.pendudukId
    });
    return http.post(Uri.parse(apiURLSelesai),
      headers: {"Content-Type" : "application/json"},
      body: body
    ).then((http.Response response) {
      if(response.statusCode == 200) {
        final body = response.body;
        final skBelumMenikahData = skBelumMenikahSelesaiFromJson(body);
        return skBelumMenikahData;
      }else{
        final body = response.body;
        final error = skBelumMenikahSelesaiFromJson(body);
        return error;
      }
    });
  }

  Widget listSelesai() {
    return FutureBuilder<SkBelumMenikahSelesai>(
      future: Selesai(),
      builder: (context, snapshot){
        final data = snapshot.data;
        if(snapshot.hasData) {
          final skBelumMenikahData = data.data;
          return ListView.builder(
            itemCount: skBelumMenikahData.length,
            itemBuilder: (context, index) {
              final skBelumMenikah = skBelumMenikahData[index];
              return TextButton(
                onPressed: (){
                  setState(() {
                    detailSKBelumMenikah.keperluan = skBelumMenikah.keperluan;
                    detailSKBelumMenikah.status = skBelumMenikah.status;
                    detailSKBelumMenikah.tanggalPengesahan = skBelumMenikah.tanggalPengesahan;
                    detailSKBelumMenikah.tanggalPengajuan = skBelumMenikah.tanggalPengajuan;
                    detailSKBelumMenikah.skBelumMenikahId = skBelumMenikah.idSkBelumMenikah;
                    detailSKBelumMenikah.suratMasyarakatId = skBelumMenikah.suratMasyarakatId;
                  });
                  Navigator.push(context, CupertinoPageRoute(builder: (context) => detailSKBelumMenikah()));
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
                                      skBelumMenikah.status.toString(),
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
                                        skBelumMenikah.keperluan.toString(),
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
                                        "Tanggal Pengajuan: ${skBelumMenikah.tanggalPengajuan.day.toString()} - ${skBelumMenikah.tanggalPengajuan.month.toString()} - ${skBelumMenikah.tanggalPengajuan.year.toString()}",
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 14,
                                        color: Colors.black26
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "Tanggal Pengesahan: ${skBelumMenikah.tanggalPengesahan.day.toString()} - ${skBelumMenikah.tanggalPengesahan.month.toString()} - ${skBelumMenikah.tanggalPengesahan.year.toString()}",
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 14,
                                          color: Colors.black26
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              margin: EdgeInsets.only(left: 10, bottom: 10)
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
      }
    );
  }

  Widget listSedangDiproses() {
    return FutureBuilder<SkBelumMenikah>(
      future: SedangDiproses(),
      builder: (context, snapshot){
        final data = snapshot.data;
        if(snapshot.hasData) {
          final skBelumMenikahData = data.data;
          return ListView.builder(
            itemCount: skBelumMenikahData.length,
            itemBuilder: (context, index) {
              final skBelumMenikah = skBelumMenikahData[index];
              return TextButton(
                onPressed: (){
                  setState(() {
                    detailSKBelumMenikah.keperluan = skBelumMenikah.keperluan;
                    detailSKBelumMenikah.status = skBelumMenikah.status;
                    detailSKBelumMenikah.tanggalPengajuan = skBelumMenikah.tanggalPengajuan;
                    detailSKBelumMenikah.skBelumMenikahId = skBelumMenikah.idSkBelumMenikah;
                    detailSKBelumMenikah.suratMasyarakatId = skBelumMenikah.suratMasyarakatId;
                  });
                  Navigator.push(context, CupertinoPageRoute(builder: (context) => detailSKBelumMenikah()));
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
                                      skBelumMenikah.status.toString(),
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
                                        skBelumMenikah.keperluan.toString(),
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
                                        "Tanggal Pengajuan: ${skBelumMenikah.tanggalPengajuan.day.toString()} - ${skBelumMenikah.tanggalPengajuan.month.toString()} - ${skBelumMenikah.tanggalPengajuan.year.toString()}",
                                        style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 14,
                                            color: Colors.black26
                                        ),
                                      )
                                  )
                                ],
                              ),
                              margin: EdgeInsets.only(left: 10, bottom: 10),
                            ),
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
                )
              );
            },
          );
        }else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      }
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
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              color: HexColor("#025393"),
              onPressed: (){Navigator.push(context, CupertinoPageRoute(builder: (context) => formSKBelumMenikah()));},
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: Image.asset(
                  'images/person.png',
                  height: 100,
                  width: 100,
                ),
                margin: EdgeInsets.only(top: 20),
              ),
              Container(
                child: Text(
                  "SK Belum Menikah",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: HexColor("#025393")
                  ),
                ),
                margin: EdgeInsets.only(top: 10),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "Status Pengajuan SK Belum Menikah",
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
                                  child: listSedangDiproses()
                                ),
                                Container(
                                    child: listSelesai()
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