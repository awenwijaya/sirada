import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:surat/AdminDesa/ManajemenSurat/SuratKeluar/SuratKeluarNonPanitia/DetailSurat.dart';
import 'package:surat/AdminDesa/ManajemenSurat/SuratKeluar/SuratKeluarNonPanitia/EditSuratKeluarNonPanitia.dart';
import 'package:surat/AdminDesa/ManajemenSurat/SuratKeluar/SuratKeluarNonPanitia/TambahSuratKeluarNonPanitia.dart';
import 'package:surat/LoginAndRegistration/LoginPage.dart';
import 'package:http/http.dart' as http;

class suratKeluarNonPanitiaAdmin extends StatefulWidget {
  const suratKeluarNonPanitiaAdmin({Key key}) : super(key: key);

  @override
  State<suratKeluarNonPanitiaAdmin> createState() => _suratKeluarNonPanitiaAdminState();
}

class _suratKeluarNonPanitiaAdminState extends State<suratKeluarNonPanitiaAdmin> {
  var apiURLShowListSuratKeluar = "http://192.168.122.149:8000/api/data/admin/surat/non-panitia/${loginPage.desaId}";
  var selectedIdSuratKeluar;

  //loading status
  bool LoadingMenunggu = true;
  bool LoadingSedangDiproses = true;
  bool LoadingDikonfirmasi = true;
  bool LoadingDibatalkan = true;

  //data surat menunggu
  var nomorSuratMenunggu = [];
  var perihalSuratMenunggu = [];
  var idSuratMenunggu = [];

  //data surat diproses
  var nomorSuratSedangDiproses = [];
  var perihalSuratSedangDiproses = [];
  var idSuratSedangDiproses = [];

  //data surat dikonfirmasi
  var nomorSuratDikonfirmasi = [];
  var perihalSuratDikonfirmasi = [];
  var idSuratDikonfirmasi = [];

  //data surat dibatalkan
  var nomorSuratDibatalkan = [];
  var perihalSuratDibatalkan = [];
  var idSuratDibatalkan = [];

  //status availableData
  bool availableDataMenunggu = false;
  bool availableDataSedangDiproses = false;
  bool availableDataDikonfirmasi = false;
  bool availableDataDibatalkan = false;

  var selectedIdSuratKeluarNonPanitia;

  Future refreshListSuratKeluarMenunggu() async {
    var body = jsonEncode({
      "status" : "Menunggu Respons"
    });
    http.post(Uri.parse(apiURLShowListSuratKeluar),
      headers: {"Content-Type" : "application/json"},
      body: body
    ).then((http.Response response) {
      if(response.statusCode == 200) {
        var data = json.decode(response.body);
        this.nomorSuratMenunggu = [];
        this.perihalSuratMenunggu = [];
        this.idSuratMenunggu = [];
        setState(() {
          LoadingMenunggu = false;
          availableDataMenunggu = true;
          for(var i = 0; i < data.length; i++) {
            this.nomorSuratMenunggu.add(data[i]['nomor_surat']);
            this.perihalSuratMenunggu.add(data[i]['parindikan']);
            this.idSuratMenunggu.add(data[i]['surat_keluar_id']);
          }
        });
      }else{
        setState(() {
          LoadingMenunggu = false;
          availableDataMenunggu = false;
        });
      }
    });
  }

  Future refreshListSuratKeluarSedangDiproses() async {
    var body = jsonEncode({
      "status" : "Sedang Diproses"
    });
    http.post(Uri.parse(apiURLShowListSuratKeluar),
        headers: {"Content-Type" : "application/json"},
        body: body
    ).then((http.Response response) {
      if(response.statusCode == 200) {
        var data = json.decode(response.body);
        this.nomorSuratSedangDiproses = [];
        this.perihalSuratSedangDiproses = [];
        this.idSuratSedangDiproses = [];
        setState(() {
          LoadingSedangDiproses = false;
          availableDataSedangDiproses = true;
          for(var i = 0; i < data.length; i++) {
            this.nomorSuratSedangDiproses.add(data[i]['nomor_surat']);
            this.perihalSuratSedangDiproses.add(data[i]['parindikan']);
            this.idSuratSedangDiproses.add(data[i]['surat_keluar_id']);
          }
        });
      }else{
        setState(() {
          LoadingSedangDiproses = false;
          availableDataSedangDiproses = false;
        });
      }
    });
  }

  Future refreshListSuratKeluarTelahDikonfirmasi() async {
    var body = jsonEncode({
      "status" : "Telah Dikonfirmasi"
    });
    http.post(Uri.parse(apiURLShowListSuratKeluar),
        headers: {"Content-Type" : "application/json"},
        body: body
    ).then((http.Response response) {
      if(response.statusCode == 200) {
        var data = json.decode(response.body);
        this.nomorSuratDikonfirmasi = [];
        this.perihalSuratDikonfirmasi = [];
        this.idSuratDikonfirmasi = [];
        setState(() {
          LoadingDikonfirmasi = false;
          availableDataDikonfirmasi = true;
          for(var i = 0; i < data.length; i++) {
            this.nomorSuratDikonfirmasi.add(data[i]['nomor_surat']);
            this.perihalSuratDikonfirmasi.add(data[i]['parindikan']);
            this.idSuratDikonfirmasi.add(data[i]['surat_keluar_id']);
          }
        });
      }else{
        setState(() {
          LoadingDikonfirmasi = false;
          availableDataDikonfirmasi = false;
        });
      }
    });
  }

  Future refreshListSuratKeluarDibatalkan() async {
    var body = jsonEncode({
      "status" : "Dibatalkan"
    });
    http.post(Uri.parse(apiURLShowListSuratKeluar),
        headers: {"Content-Type" : "application/json"},
        body: body
    ).then((http.Response response) {
      if(response.statusCode == 200) {
        var data = json.decode(response.body);
        this.nomorSuratDibatalkan = [];
        this.perihalSuratDibatalkan = [];
        this.idSuratDibatalkan = [];
        setState(() {
          LoadingDibatalkan = false;
          availableDataDibatalkan = true;
          for(var i = 0; i < data.length; i++) {
            this.nomorSuratDibatalkan.add(data[i]['nomor_surat']);
            this.perihalSuratDibatalkan.add(data[i]['parindikan']);
            this.idSuratDibatalkan.add(data[i]['surat_keluar_id']);
          }
        });
      }else{
        setState(() {
          LoadingDibatalkan = false;
          availableDataDibatalkan = false;
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    refreshListSuratKeluarMenunggu();
    refreshListSuratKeluarDibatalkan();
    refreshListSuratKeluarSedangDiproses();
    refreshListSuratKeluarTelahDikonfirmasi();
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
          title: Text("Surat Non-Panitia", style: TextStyle(
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
                  'images/staff.png',
                  height: 100,
                  width: 100
                ),
                margin: EdgeInsets.only(top: 20)
              ),
              Container(
                child: FlatButton(
                  onPressed: (){
                    Navigator.push(context, CupertinoPageRoute(builder: (context) => tambahSuratKeluarNonPanitiaAdmin())).then((value) {
                      refreshListSuratKeluarMenunggu();
                      refreshListSuratKeluarDibatalkan();
                      refreshListSuratKeluarSedangDiproses();
                      refreshListSuratKeluarTelahDikonfirmasi();
                    });
                  },
                  child: Text("Tambah Data Surat", style: TextStyle(
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
                margin: EdgeInsets.only(top: 15, bottom: 15)
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    DefaultTabController(
                      length: 4,
                      initialIndex: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            child: TabBar(
                              labelColor: HexColor("#025393"),
                              unselectedLabelColor: Colors.black,
                              tabs: [
                                Tab(child: SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.55,
                                  child: Text("Menunggu", style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w700
                                  ), maxLines: 1,
                                    overflow: TextOverflow.fade,
                                    softWrap: false,
                                    textAlign: TextAlign.center
                                  )
                                )),
                                Tab(child: Text("Sedang Diproses", style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w700
                                ), textAlign: TextAlign.center)),
                                Tab(child: SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.55,
                                  child: Text("Dikonfirmasi", style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w700
                                  ), maxLines: 1,
                                  overflow: TextOverflow.fade,
                                  softWrap: false,
                                  textAlign: TextAlign.center)
                                )),
                                Tab(child: SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.55,
                                  child: Text("Dibatalkan", style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w700
                                  ), maxLines: 1,
                                  overflow: TextOverflow.fade,
                                  softWrap: false,
                                  textAlign: TextAlign.center)
                                ))
                              ]
                            )
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.678,
                            decoration: BoxDecoration(
                              border: Border(top: BorderSide(color: Colors.black26, width: 0.5))
                            ),
                            child: TabBarView(
                              children: <Widget>[
                                Container(
                                  child: LoadingMenunggu ? ListTileShimmer() : availableDataMenunggu ? RefreshIndicator(
                                    onRefresh: refreshListSuratKeluarMenunggu,
                                    child: ListView.builder(
                                      itemCount: idSuratMenunggu.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: (){
                                            setState(() {
                                              detailSuratKeluarNonPanitia.suratKeluarId = idSuratMenunggu[index];
                                            });
                                            Navigator.push(context, CupertinoPageRoute(builder: (context) => detailSuratKeluarNonPanitia()));
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
                                                                    perihalSuratMenunggu[index],
                                                                    style: TextStyle(
                                                                        fontFamily: "Poppins",
                                                                        fontSize: 16,
                                                                        fontWeight: FontWeight.w700,
                                                                        color: HexColor("#025393")
                                                                    ),
                                                                    maxLines: 1,
                                                                    overflow: TextOverflow.ellipsis,
                                                                    softWrap: false,
                                                                  )
                                                              )
                                                          ),
                                                          Container(
                                                              child: Text(nomorSuratMenunggu[index], style: TextStyle(
                                                                  fontFamily: "Poppins",
                                                                  fontSize: 14
                                                              ))
                                                          )
                                                        ]
                                                    ),
                                                    margin: EdgeInsets.only(left: 15),
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
                                            )
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
                                          child: Text("Tidak ada Data Surat Keluar", style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black26
                                          ), textAlign: TextAlign.center),
                                          margin: EdgeInsets.only(top: 10),
                                          padding: EdgeInsets.symmetric(horizontal: 30)
                                        ),
                                        Container(
                                          child: Text("Tidak ada data surat keluar. Anda bisa menambahkannya dengan cara menekan tombol Tambah Data Surat dan isi data surat pada form yang telah disediakan", style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 14,
                                            color: Colors.black26
                                          ), textAlign: TextAlign.center),
                                          padding: EdgeInsets.symmetric(horizontal: 30),
                                          margin: EdgeInsets.only(top: 10)
                                        )
                                      ],
                                    )
                                  )
                                ),
                                Container(
                                    child: LoadingSedangDiproses ? ListTileShimmer() : availableDataSedangDiproses ? RefreshIndicator(
                                        onRefresh: refreshListSuratKeluarSedangDiproses,
                                        child: ListView.builder(
                                            itemCount: idSuratSedangDiproses.length,
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                  onTap: (){
                                                    setState(() {
                                                      detailSuratKeluarNonPanitia.suratKeluarId = idSuratSedangDiproses[index];
                                                    });
                                                    Navigator.push(context, CupertinoPageRoute(builder: (context) => detailSuratKeluarNonPanitia()));
                                                  },
                                                  child: Container(
                                                      child: Stack(
                                                        children: <Widget>[
                                                          Container(
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
                                                                                      perihalSuratSedangDiproses[index],
                                                                                      style: TextStyle(
                                                                                          fontFamily: "Poppins",
                                                                                          fontSize: 16,
                                                                                          fontWeight: FontWeight.w700,
                                                                                          color: HexColor("#025393")
                                                                                      ),
                                                                                      maxLines: 1,
                                                                                      overflow: TextOverflow.ellipsis,
                                                                                      softWrap: false,
                                                                                    )
                                                                                )
                                                                            ),
                                                                            Container(
                                                                                child: Text(nomorSuratSedangDiproses[index], style: TextStyle(
                                                                                    fontFamily: "Poppins",
                                                                                    fontSize: 14
                                                                                ))
                                                                            )
                                                                          ]
                                                                      ),
                                                                      margin: EdgeInsets.only(left: 15),
                                                                    )
                                                                  ]
                                                              )
                                                          )
                                                        ],
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
                                                      )
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
                                                child: Text("Tidak ada Data Surat", style: TextStyle(
                                                    fontFamily: "Poppins",
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black26
                                                ), textAlign: TextAlign.center),
                                                margin: EdgeInsets.only(top: 10),
                                                padding: EdgeInsets.symmetric(horizontal: 30)
                                            ),
                                          ],
                                        )
                                    )
                                ),
                                Container(
                                    child: LoadingDikonfirmasi ? ListTileShimmer() : availableDataDikonfirmasi ? RefreshIndicator(
                                        onRefresh: refreshListSuratKeluarTelahDikonfirmasi,
                                        child: ListView.builder(
                                            itemCount: idSuratDikonfirmasi.length,
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                  onTap: (){
                                                    setState(() {
                                                      detailSuratKeluarNonPanitia.suratKeluarId = idSuratDikonfirmasi[index];
                                                    });
                                                    Navigator.push(context, CupertinoPageRoute(builder: (context) => detailSuratKeluarNonPanitia()));
                                                  },
                                                  child: Container(
                                                      child: Stack(
                                                        children: <Widget>[
                                                          Container(
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
                                                                                      perihalSuratDikonfirmasi[index],
                                                                                      style: TextStyle(
                                                                                          fontFamily: "Poppins",
                                                                                          fontSize: 16,
                                                                                          fontWeight: FontWeight.w700,
                                                                                          color: HexColor("#025393")
                                                                                      ),
                                                                                      maxLines: 1,
                                                                                      overflow: TextOverflow.ellipsis,
                                                                                      softWrap: false,
                                                                                    )
                                                                                )
                                                                            ),
                                                                            Container(
                                                                                child: Text(nomorSuratDikonfirmasi[index], style: TextStyle(
                                                                                    fontFamily: "Poppins",
                                                                                    fontSize: 14
                                                                                ))
                                                                            )
                                                                          ]
                                                                      ),
                                                                      margin: EdgeInsets.only(left: 15),
                                                                    )
                                                                  ]
                                                              )
                                                          )
                                                        ],
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
                                                      )
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
                                                child: Text("Tidak ada Data Surat", style: TextStyle(
                                                    fontFamily: "Poppins",
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black26
                                                ), textAlign: TextAlign.center),
                                                margin: EdgeInsets.only(top: 10),
                                                padding: EdgeInsets.symmetric(horizontal: 30)
                                            ),
                                          ],
                                        )
                                    )
                                ),
                                Container(
                                    child: LoadingDibatalkan ? ListTileShimmer() : availableDataDibatalkan ? RefreshIndicator(
                                        onRefresh: refreshListSuratKeluarDibatalkan,
                                        child: ListView.builder(
                                            itemCount: idSuratDibatalkan.length,
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                  onTap: (){
                                                    setState(() {
                                                      detailSuratKeluarNonPanitia.suratKeluarId = idSuratDibatalkan[index];
                                                    });
                                                    Navigator.push(context, CupertinoPageRoute(builder: (context) => detailSuratKeluarNonPanitia()));
                                                  },
                                                  child: Container(
                                                      child: Stack(
                                                        children: <Widget>[
                                                          Container(
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
                                                                                      perihalSuratDibatalkan[index],
                                                                                      style: TextStyle(
                                                                                          fontFamily: "Poppins",
                                                                                          fontSize: 16,
                                                                                          fontWeight: FontWeight.w700,
                                                                                          color: HexColor("#025393")
                                                                                      ),
                                                                                      maxLines: 1,
                                                                                      overflow: TextOverflow.ellipsis,
                                                                                      softWrap: false,
                                                                                    )
                                                                                )
                                                                            ),
                                                                            Container(
                                                                                child: Text(nomorSuratDibatalkan[index], style: TextStyle(
                                                                                    fontFamily: "Poppins",
                                                                                    fontSize: 14
                                                                                ))
                                                                            )
                                                                          ]
                                                                      ),
                                                                      margin: EdgeInsets.only(left: 15),
                                                                    )
                                                                  ]
                                                              )
                                                          )
                                                        ],
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
                                                      )
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
                                                child: Text("Tidak ada Data Surat", style: TextStyle(
                                                    fontFamily: "Poppins",
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black26
                                                ), textAlign: TextAlign.center),
                                                margin: EdgeInsets.only(top: 10),
                                                padding: EdgeInsets.symmetric(horizontal: 30)
                                            ),
                                          ],
                                        )
                                    )
                                ),
                              ]
                            )
                          )
                        ]
                      )
                    )
                  ]
                )
              )
            ]
          )
        )
      )
    );
  }
}