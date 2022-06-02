import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:surat/AdminDesa/ManajemenPanitia/TambahPanitia.dart';

class manajemenPanitiaDesaAdatAdmin extends StatefulWidget {
  const manajemenPanitiaDesaAdatAdmin({Key key}) : super(key: key);

  @override
  State<manajemenPanitiaDesaAdatAdmin> createState() => _manajemenPanitiaDesaAdatAdminState();
}

class _manajemenPanitiaDesaAdatAdminState extends State<manajemenPanitiaDesaAdatAdmin> {
  var apiURLGetDataTimKegiatanAktif = "http://siradaskripsi.my.id/api/panitia/1487/aktif";
  var apiURLGetDataTimKegiatanTidakAktif = "http://siradaskripsi.my.id/api/panitia/1487/tidak-aktif";
  FToast ftoast;

  //list aktif
  bool LoadingAktif = true;
  bool availableDataAktif = false;
  var namaPanitiaAktif = [];
  var idPanitiaAktif = [];
  var jabatanPanitiaAktif = [];
  var timKegiatanPanitiaAktif = [];

  //list tidak aktif
  bool LoadingTidakAktif = true;
  bool availableDataTidakAktif = false;
  var namaPanitiaTidakAktif = [];
  var idPanitiaTidakAktif = [];
  var jabatanPanitiaTidakAktif = [];
  var timKegiatanPanitiaTidakAktif = [];

  Future refreshListPanitiaAktif() async {
    Uri uri = Uri.parse(apiURLGetDataTimKegiatanAktif);
    final response = await http.get(uri);
    if(response.statusCode == 200) {
      var data = json.decode(response.body);
      this.namaPanitiaAktif = [];
      this.idPanitiaAktif = [];
      this.jabatanPanitiaAktif = [];
      this.timKegiatanPanitiaAktif = [];
      setState(() {
        LoadingAktif = false;
        availableDataAktif = true;
      });
      for(var i = 0; i < data.length; i++) {
        this.namaPanitiaAktif.add(data[i]['nama']);
        this.idPanitiaAktif.add(data[i]['panitia_desa_adat_id']);
        this.jabatanPanitiaAktif.add(data[i]['jabatan']);
        this.timKegiatanPanitiaAktif.add(data[i]['panitia']);
      }
    }else {
      setState(() {
        LoadingAktif = false;
        availableDataAktif = false;
      });
    }
  }

  Future refreshListPanitiaTidakAktif() async {
    Uri uri = Uri.parse(apiURLGetDataTimKegiatanTidakAktif);
    final response = await http.get(uri);
    if(response.statusCode == 200) {
      var data = json.decode(response.body);
      this.namaPanitiaTidakAktif = [];
      this.idPanitiaTidakAktif = [];
      this.jabatanPanitiaTidakAktif = [];
      this.timKegiatanPanitiaTidakAktif = [];
      setState(() {
        LoadingTidakAktif = false;
        availableDataTidakAktif = true;
      });
      for(var i = 0; i < data.length; i++) {
        this.namaPanitiaTidakAktif.add(data[i]['nama']);
        this.idPanitiaTidakAktif.add(data[i]['panitia_desa_adat_id']);
        this.jabatanPanitiaTidakAktif.add(data[i]['jabatan']);
        this.timKegiatanPanitiaTidakAktif.add(data[i]['panitia']);
      }
    }else {
      setState(() {
        LoadingTidakAktif = false;
        availableDataTidakAktif = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    refreshListPanitiaAktif();
    refreshListPanitiaTidakAktif();
    ftoast = FToast();
    ftoast.init(this.context);
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
          title: Text("Panitia Kegiatan", style: TextStyle(
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
                  'images/panitia.png',
                  height: 100,
                  width: 100,
                ),
                margin: EdgeInsets.only(top: 20),
              ),
              Container(
                child: FlatButton(
                  onPressed: (){
                    Navigator.push(context, CupertinoPageRoute(builder: (context) => tambahPanitiaKegiatanAdmin())).then((value) {
                      refreshListPanitiaAktif();
                      refreshListPanitiaTidakAktif();
                    });
                  },
                  child: Text("Tambah Data Panitia", style: TextStyle(
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
                margin: EdgeInsets.only(top: 15, bottom: 15),
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
                                Tab(child: Text("Aktif", style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w700
                                ))),
                                Tab(child: Text("Tidak Aktif", style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w700
                                )))
                              ],
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.55,
                            decoration: BoxDecoration(
                              border: Border(top: BorderSide(color: Colors.black26, width: 0.5))
                            ),
                            child: TabBarView(
                              children: <Widget>[
                                Container(
                                  child: LoadingAktif ? ListTileShimmer() : availableDataAktif ? RefreshIndicator(
                                    onRefresh: refreshListPanitiaAktif,
                                    child: ListView.builder(
                                      itemCount: idPanitiaAktif.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: (){},
                                          child: Container(
                                            child: Row(
                                              children: <Widget>[
                                                Container(
                                                  child: Image.asset(
                                                    'images/person.png',
                                                    height: 40,
                                                    width: 40,
                                                  ),
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
                                                            "${namaPanitiaAktif[index]}", style: TextStyle(
                                                            fontFamily: "Poppins",
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.w700,
                                                            color: HexColor("#025393")
                                                          ),
                                                            maxLines: 1,
                                                            overflow: TextOverflow.ellipsis,
                                                            softWrap: false,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        child: SizedBox(
                                                          width: MediaQuery.of(context).size.width * 0.55,
                                                          child: Text(
                                                            "${jabatanPanitiaAktif[index]}", style: TextStyle(
                                                            fontFamily: "Poppins",
                                                            fontSize: 14,
                                                            color: Colors.black
                                                          ),
                                                            maxLines: 1,
                                                            overflow: TextOverflow.ellipsis,
                                                            softWrap: false,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        child: SizedBox(
                                                          width: MediaQuery.of(context).size.width * 0.55,
                                                          child: Text(
                                                            "${timKegiatanPanitiaAktif[index]}", style: TextStyle(
                                                              fontFamily: "Poppins",
                                                              fontSize: 14,
                                                              color: Colors.black26
                                                          ),
                                                            maxLines: 1,
                                                            overflow: TextOverflow.ellipsis,
                                                            softWrap: false,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  margin: EdgeInsets.only(left: 15),
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
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ) : Container(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          child: Icon(
                                            CupertinoIcons.person_alt,
                                            size: 50,
                                            color: Colors.black26,
                                          ),
                                        ),
                                        Container(
                                          child: Text("Tidak ada Data Panitia Kegiatan", style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black26
                                          ), textAlign: TextAlign.center),
                                          margin: EdgeInsets.only(top: 10),
                                          padding: EdgeInsets.symmetric(horizontal: 30),
                                        ),
                                        Container(
                                          child: Text("Tidak ada data panitia kegiatan. Anda bisa menambahkannya dengan cara menekan tombol Tambah Data Panitia dan isi data pada form yang telah disediakan", style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 14,
                                            color: Colors.black26
                                          ), textAlign: TextAlign.center),
                                          padding: EdgeInsets.symmetric(horizontal: 30),
                                          margin: EdgeInsets.only(top: 10),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  child: LoadingTidakAktif ? ListTileShimmer() : availableDataTidakAktif ? RefreshIndicator(
                                    onRefresh: refreshListPanitiaAktif,
                                    child: ListView.builder(
                                      itemCount: idPanitiaTidakAktif.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: (){},
                                          child: Container(
                                            child: Row(
                                              children: <Widget>[
                                                Container(
                                                  child: Image.asset(
                                                    'images/person.png',
                                                    height: 40,
                                                    width: 40,
                                                  ),
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
                                                            "${namaPanitiaTidakAktif[index]}", style: TextStyle(
                                                              fontFamily: "Poppins",
                                                              fontSize: 16,
                                                              fontWeight: FontWeight.w700,
                                                              color: HexColor("#025393")
                                                          ),
                                                            maxLines: 1,
                                                            overflow: TextOverflow.ellipsis,
                                                            softWrap: false,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        child: SizedBox(
                                                          width: MediaQuery.of(context).size.width * 0.55,
                                                          child: Text(
                                                            "${jabatanPanitiaTidakAktif[index]}", style: TextStyle(
                                                              fontFamily: "Poppins",
                                                              fontSize: 14,
                                                              color: Colors.black
                                                          ),
                                                            maxLines: 1,
                                                            overflow: TextOverflow.ellipsis,
                                                            softWrap: false,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        child: SizedBox(
                                                          width: MediaQuery.of(context).size.width * 0.55,
                                                          child: Text(
                                                            "${timKegiatanPanitiaTidakAktif[index]}", style: TextStyle(
                                                              fontFamily: "Poppins",
                                                              fontSize: 14,
                                                              color: Colors.black26
                                                          ),
                                                            maxLines: 1,
                                                            overflow: TextOverflow.ellipsis,
                                                            softWrap: false,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  margin: EdgeInsets.only(left: 15)
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
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ) : Container(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          child: Icon(
                                            CupertinoIcons.person_alt,
                                            size: 50,
                                            color: Colors.black26,
                                          ),
                                        ),
                                        Container(
                                          child: Text("Tidak ada Data", style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black26
                                          ), textAlign: TextAlign.center),
                                          margin: EdgeInsets.only(top: 10),
                                          padding: EdgeInsets.symmetric(horizontal: 30),
                                        ),
                                      ],
                                    ),
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
        )
      ),
    );
  }
}