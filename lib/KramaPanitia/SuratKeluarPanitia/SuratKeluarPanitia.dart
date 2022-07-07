import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:surat/KramaPanitia/SuratKeluarPanitia/DetailSurat.dart';
import 'package:surat/KramaPanitia/SuratKeluarPanitia/TambahSuratKeluarPanitia.dart';
import 'package:surat/LoginAndRegistration/LoginPage.dart';
import 'package:http/http.dart' as http;

class suratKeluarPanitiaKramaPanitia extends StatefulWidget {
  const suratKeluarPanitiaKramaPanitia({Key key}) : super(key: key);

  @override
  State<suratKeluarPanitiaKramaPanitia> createState() => _suratKeluarPanitiaKramaPanitiaState();
}

class _suratKeluarPanitiaKramaPanitiaState extends State<suratKeluarPanitiaKramaPanitia> {
  var apiURLGetDataSurat = "https://siradaskripsi.my.id/api/data/admin/surat/panitia/${loginPage.kramaId}";
  //list
  List MenungguRespons = [];
  List SedangDiproses = [];
  List TelahDikonfirmasi = [];
  List Dibatalkan = [];

  //bool
  bool LoadingMenungguRespons = true;
  bool LoadingSedangDiproses = true;
  bool LoadingTelahDikonfirmasi = true;
  bool LoadingDibatalkan = true;
  bool availableMenungguRespons = false;
  bool availableSedangDiproses = false;
  bool availableTelahDikonfirmasi = false;
  bool availableDibatalkan = false;

  Future refreshListMenungguRespons() async {
    var body = jsonEncode({
      "status" : "Menunggu Respon"
    });
    http.post(Uri.parse(apiURLGetDataSurat),
        headers: {"Content-Type" : "application/json"},
        body: body
    ).then((http.Response response) async {
      print(response.statusCode);
      if(response.statusCode == 200) {
        var data = json.decode(response.body);
        setState(() {
          LoadingMenungguRespons = false;
          availableMenungguRespons = true;
          MenungguRespons = data;
        });
      }else {
        LoadingMenungguRespons = false;
        availableMenungguRespons = false;
      }
    });
  }

  Future refreshListSedangDiproses() async {
    var body = jsonEncode({
      "status" : "Sedang Diproses"
    });
    http.post(Uri.parse(apiURLGetDataSurat),
        headers: {"Content-Type" : "application/json"},
        body: body
    ).then((http.Response response) async {
      if(response.statusCode == 200) {
        var data = json.decode(response.body);
        setState(() {
          LoadingSedangDiproses = false;
          availableSedangDiproses = true;
          SedangDiproses = data;
        });
      }else {
        LoadingSedangDiproses = false;
        availableSedangDiproses = false;
      }
    });
  }

  Future refreshListTelahDikonfirmasi() async {
    var body = jsonEncode({
      "status" : "Telah Dikonfirmasi"
    });
    http.post(Uri.parse(apiURLGetDataSurat),
        headers: {"Content-Type" : "application/json"},
        body: body
    ).then((http.Response response) async {
      if(response.statusCode == 200) {
        var data = json.decode(response.body);
        setState(() {
          LoadingTelahDikonfirmasi = false;
          availableTelahDikonfirmasi = true;
          TelahDikonfirmasi = data;
        });
      }else {
        LoadingTelahDikonfirmasi = false;
        availableTelahDikonfirmasi = false;
      }
    });
  }

  Future refreshListDibatalkan() async {
    var body = jsonEncode({
      "status" : "Dibatalkan"
    });
    http.post(Uri.parse(apiURLGetDataSurat),
        headers: {"Content-Type" : "application/json"},
        body: body
    ).then((http.Response response) async {
      if(response.statusCode == 200) {
        var data = json.decode(response.body);
        setState(() {
          LoadingDibatalkan = false;
          availableDibatalkan = true;
          Dibatalkan = data;
        });
      }else {
        LoadingDibatalkan = false;
        availableDibatalkan = false;
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    refreshListDibatalkan();
    refreshListMenungguRespons();
    refreshListSedangDiproses();
    refreshListTelahDikonfirmasi();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: HexColor("025393"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: (){
              Navigator.of(context).pop();
            },
          ),
          title: Text("Manajemen Surat", style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w700,
            color: Colors.white
          )),
          bottom: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.black26,
            tabs: [
              Tab(
                child: Column(
                  children: <Widget>[
                    Icon(CupertinoIcons.hourglass_bottomhalf_fill, color: HexColor("D6EFED")),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.55,
                      child: Text(
                        "Menunggu", style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w700
                      ),
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
              Tab(
                child: Column(
                  children: <Widget>[
                    Icon(CupertinoIcons.time_solid, color: HexColor("F8F9D7")),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.55,
                      child: Text(
                        "Sedang Diproses", style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w700
                      ),
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
              Tab(
                child: Column(
                  children: <Widget>[
                    Icon(Icons.done, color: HexColor("B4CFB0")),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.55,
                      child: Text(
                        "Telah Dikonfirmasi", style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w700
                      ),
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
              Tab(
                child: Column(
                  children: <Widget>[
                    Icon(Icons.close, color: HexColor("EFB7B7")),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.55,
                      child: Text(
                        "Dibatalkan", style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w700
                      ),
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    child: TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              borderSide: BorderSide(color: HexColor("#025393"))
                          ),
                          hintText: "Cari surat keluar...",
                          suffixIcon: IconButton(
                            icon: Icon(Icons.search),
                            onPressed: (){},
                          )
                      ),
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 14
                      ),
                    ),
                    margin: EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 20),
                  ),
                  Container(
                    child: LoadingMenungguRespons ? ListTileShimmer() : availableMenungguRespons ? Expanded(
                      flex: 1,
                        child: RefreshIndicator(
                          onRefresh: refreshListMenungguRespons,
                          child: ListView.builder(
                            itemCount: MenungguRespons.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: (){
                                  setState(() {
                                    detailSuratKeluarPanitia.suratKeluarId = MenungguRespons[index]['surat_keluar_id'];
                                  });
                                  Navigator.push(context, CupertinoPageRoute(builder: (context) => detailSuratKeluarPanitia())).then((value) {
                                    refreshListDibatalkan();
                                    refreshListMenungguRespons();
                                    refreshListSedangDiproses();
                                    refreshListTelahDikonfirmasi();
                                  });
                                },
                                child: Container(
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        child: Image.asset(
                                          'images/email.png',
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
                                                  MenungguRespons[index]['parindikan'].toString(),
                                                  style: TextStyle(
                                                    fontFamily: "Poppins",
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w700,
                                                    color: HexColor("#025393"),
                                                  ),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  softWrap: false,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              child: Text(MenungguRespons[index]['nomor_surat'].toString(), style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontSize: 14
                                              )),
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
                            Container(
                                child: Text("Tidak ada data surat. Anda bisa menambahkannya dengan cara menekan tombol Tambah Data Surat dan isi data surat pada form yang telah disediakan", style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 14,
                                    color: Colors.black26
                                ), textAlign: TextAlign.center),
                                padding: EdgeInsets.symmetric(horizontal: 30),
                                margin: EdgeInsets.only(top: 10)
                            )
                          ],
                        )
                    ),
                  )
                ],
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    child: TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              borderSide: BorderSide(color: HexColor("#025393"))
                          ),
                          hintText: "Cari surat keluar...",
                          suffixIcon: IconButton(
                            icon: Icon(Icons.search),
                            onPressed: (){},
                          )
                      ),
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 14
                      ),
                    ),
                    margin: EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 20),
                  ),
                  Container(
                    child: LoadingSedangDiproses ? ListTileShimmer() : availableSedangDiproses ? Expanded(
                      flex: 1,
                        child: RefreshIndicator(
                          onRefresh: refreshListSedangDiproses,
                          child: ListView.builder(
                            itemCount: SedangDiproses.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: (){
                                  setState(() {
                                    detailSuratKeluarPanitia.suratKeluarId = SedangDiproses[index]['surat_keluar_id'];
                                  });
                                  Navigator.push(context, CupertinoPageRoute(builder: (context) => detailSuratKeluarPanitia())).then((value) {
                                    refreshListDibatalkan();
                                    refreshListMenungguRespons();
                                    refreshListSedangDiproses();
                                    refreshListTelahDikonfirmasi();
                                  });
                                },
                                child: Container(
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        child: Image.asset(
                                          'images/email.png',
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
                                                  SedangDiproses[index]['parindikan'].toString(),
                                                  style: TextStyle(
                                                    fontFamily: "Poppins",
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w700,
                                                    color: HexColor("#025393"),
                                                  ),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  softWrap: false,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              child: Text(SedangDiproses[index]['nomor_surat'].toString(), style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontSize: 14
                                              )),
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
                    ),
                  )
                ],
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    child: TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              borderSide: BorderSide(color: HexColor("#025393"))
                          ),
                          hintText: "Cari surat keluar...",
                          suffixIcon: IconButton(
                            icon: Icon(Icons.search),
                            onPressed: (){},
                          )
                      ),
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 14
                      ),
                    ),
                    margin: EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 20),
                  ),
                  Container(
                    child: LoadingTelahDikonfirmasi ? ListTileShimmer() : availableTelahDikonfirmasi ? Expanded(
                      flex: 1,
                        child: RefreshIndicator(
                          onRefresh: refreshListTelahDikonfirmasi,
                          child: ListView.builder(
                            itemCount: TelahDikonfirmasi.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: (){
                                  setState(() {
                                    detailSuratKeluarPanitia.suratKeluarId = TelahDikonfirmasi[index]['surat_keluar_id'];
                                  });
                                  Navigator.push(context, CupertinoPageRoute(builder: (context) => detailSuratKeluarPanitia())).then((value) {
                                    refreshListDibatalkan();
                                    refreshListMenungguRespons();
                                    refreshListSedangDiproses();
                                    refreshListTelahDikonfirmasi();
                                  });
                                },
                                child: Container(
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        child: Image.asset(
                                          'images/email.png',
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
                                                  TelahDikonfirmasi[index]['parindikan'].toString(),
                                                  style: TextStyle(
                                                    fontFamily: "Poppins",
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w700,
                                                    color: HexColor("#025393"),
                                                  ),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  softWrap: false,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              child: Text(TelahDikonfirmasi[index]['nomor_surat'].toString(), style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontSize: 14
                                              )),
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
                    ),
                  )
                ],
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    child: TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              borderSide: BorderSide(color: HexColor("#025393"))
                          ),
                          hintText: "Cari surat keluar...",
                          suffixIcon: IconButton(
                            icon: Icon(Icons.search),
                            onPressed: (){},
                          )
                      ),
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 14
                      ),
                    ),
                    margin: EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 20),
                  ),
                  Container(
                    child: LoadingDibatalkan ? ListTileShimmer() : availableDibatalkan ? Expanded(
                        flex: 1,
                        child: RefreshIndicator(
                          onRefresh: refreshListDibatalkan,
                          child: ListView.builder(
                            itemCount: Dibatalkan.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: (){
                                  setState(() {
                                    detailSuratKeluarPanitia.suratKeluarId = Dibatalkan[index]['surat_keluar_id'];
                                  });
                                  Navigator.push(context, CupertinoPageRoute(builder: (context) => detailSuratKeluarPanitia())).then((value) {
                                    refreshListDibatalkan();
                                    refreshListMenungguRespons();
                                    refreshListSedangDiproses();
                                    refreshListTelahDikonfirmasi();
                                  });
                                },
                                child: Container(
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        child: Image.asset(
                                          'images/email.png',
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
                                                  Dibatalkan[index]['parindikan'].toString(),
                                                  style: TextStyle(
                                                    fontFamily: "Poppins",
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w700,
                                                    color: HexColor("#025393"),
                                                  ),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  softWrap: false,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              child: Text(Dibatalkan[index]['nomor_surat'].toString(), style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontSize: 14
                                              )),
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
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.push(context, CupertinoPageRoute(builder: (context) => tambahSuratKeluarPanitia())).then((value) {
              refreshListDibatalkan();
              refreshListMenungguRespons();
              refreshListSedangDiproses();
              refreshListTelahDikonfirmasi();
            });
          },
          child: Icon(Icons.add, color: Colors.white),
          backgroundColor: HexColor("025393"),
        ),
      ),
    );
  }
}
