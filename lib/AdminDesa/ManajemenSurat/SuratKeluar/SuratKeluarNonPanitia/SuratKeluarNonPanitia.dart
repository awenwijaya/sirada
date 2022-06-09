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
  var apiURLGetDataSurat = "https://siradaskripsi.my.id/api/data/admin/surat/non-panitia/${loginPage.desaId}";
  var apiURLSearchSurat = "https://siradaskripsi.my.id/api/data/admin/surat/non-panitia/${loginPage.desaId}/search";
  var selectedIdSuratKeluar;

  //bool
  bool LoadingMenungguRespons = true;
  bool LoadingSedangDiproses = true;
  bool LoadingTelahDikonfirmasi = true;
  bool LoadingDibatalkan = true;
  bool availableMenungguRespons = false;
  bool availableSedangDiproses = false;
  bool availableTelahDikonfirmasi = false;
  bool availableDibatalkan = false;
  bool isSearchMenungguRespons = false;
  bool isSearchSedangDiproses = false;
  bool isSearchTelahDikonfirmasi = false;
  bool isSearchDibatalkan = false;

  final controllerSearchMenungguRespons = TextEditingController();
  final controllerSearchSedangDiproses = TextEditingController();
  final controllerSearchTelahDikonfirmasi = TextEditingController();
  final controllerSearchDibatalkan = TextEditingController();

  //list
  List MenungguRespons = [];
  List SedangDiproses = [];
  List TelahDikonfirmasi = [];
  List Dibatalkan = [];

  Future refreshListSearchMenungguRespons() async {
    setState(() {
      LoadingMenungguRespons = true;
      isSearchMenungguRespons = true;
    });
    var body = jsonEncode({
      "desa_adat_id" : loginPage.desaId.toString(),
      "search_query" : controllerSearchMenungguRespons.text,
      "status" : "Menunggu Respon"
    });
    http.post(Uri.parse(apiURLSearchSurat),
      headers: {"Content-Type" : "application/json"},
      body: body
    ).then((http.Response response) async {
      if(response.statusCode == 200) {
        var data = json.decode(response.body);
        setState(() {
          LoadingMenungguRespons = false;
          availableMenungguRespons = true;
          MenungguRespons = data;
        });
      }else {
        setState(() {
          LoadingMenungguRespons = false;
          availableMenungguRespons = false;
        });
      }
    });
  }

  Future refreshListSearchSedangDiproses() async {
    setState(() {
      LoadingSedangDiproses = true;
      isSearchSedangDiproses = true;
    });
    var body = jsonEncode({
      "desa_adat_id" : loginPage.desaId.toString(),
      "search_query" : controllerSearchSedangDiproses.text,
      "status" : "Sedang Diproses"
    });
    http.post(Uri.parse(apiURLSearchSurat),
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
        setState(() {
          LoadingSedangDiproses = false;
          availableSedangDiproses = false;
        });
      }
    });
  }

  Future refreshListSearchTelahDikonfirmasi() async {
    setState(() {
      LoadingTelahDikonfirmasi = true;
      isSearchTelahDikonfirmasi = true;
    });
    var body = jsonEncode({
      "desa_adat_id" : loginPage.desaId.toString(),
      "search_query" : controllerSearchTelahDikonfirmasi.text,
      "status" : "Telah Dikonfirmasi"
    });
    http.post(Uri.parse(apiURLSearchSurat),
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
        setState(() {
          LoadingTelahDikonfirmasi = false;
          availableTelahDikonfirmasi = false;
        });
      }
    });
  }

  Future refreshListSearchDibatalkan() async {
    setState(() {
      LoadingDibatalkan = true;
      isSearchDibatalkan = true;
    });
    var body = jsonEncode({
      "desa_adat_id" : loginPage.desaId.toString(),
      "search_query" : controllerSearchDibatalkan.text,
      "status" : "Dibatalkan"
    });
    http.post(Uri.parse(apiURLSearchSurat),
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
        setState(() {
          LoadingDibatalkan = false;
          availableDibatalkan = false;
        });
      }
    });
  }

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
        setState(() {
          LoadingSedangDiproses = false;
          availableSedangDiproses = false;
        });
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
        setState(() {
          LoadingTelahDikonfirmasi = false;
          availableTelahDikonfirmasi = false;
        });
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
        setState(() {
          LoadingDibatalkan = false;
          availableDibatalkan = false;
        });
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
                margin: EdgeInsets.only(top: 20)
              ),
              Container(
                child: FlatButton(
                  onPressed: (){
                    Navigator.push(context, CupertinoPageRoute(builder: (context) => tambahSuratKeluarNonPanitiaAdmin())).then((value) {
                      refreshListDibatalkan();
                      refreshListMenungguRespons();
                      refreshListSedangDiproses();
                      refreshListTelahDikonfirmasi();
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
                                Tab(
                                  child: Column(
                                    children: <Widget>[
                                      Icon(CupertinoIcons.hourglass_bottomhalf_fill),
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
                                      Icon(CupertinoIcons.time_solid),
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
                                      Icon(Icons.done),
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
                                      Icon(Icons.close),
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
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        child: TextField(
                                          controller: controllerSearchMenungguRespons,
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(50.0),
                                                  borderSide: BorderSide(color: HexColor("#025393"))
                                              ),
                                              hintText: "Cari surat keluar...",
                                              suffixIcon: isSearchMenungguRespons ? IconButton(
                                                icon: Icon(Icons.close),
                                                onPressed: (){
                                                  setState(() {
                                                    LoadingMenungguRespons = true;
                                                    controllerSearchMenungguRespons.text = "";
                                                    isSearchMenungguRespons = false;
                                                    refreshListMenungguRespons();
                                                  });
                                                },
                                              ) : IconButton(
                                                icon: Icon(Icons.search),
                                                onPressed: (){
                                                  if(controllerSearchMenungguRespons.text != "") {
                                                    setState(() {
                                                      isSearchMenungguRespons = true;
                                                    });
                                                    refreshListSearchMenungguRespons();
                                                  }
                                                },
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
                                        child: LoadingMenungguRespons ? ListTileShimmer() : availableMenungguRespons ? SizedBox(
                                            height: MediaQuery.of(context).size.height * 0.442,
                                            child: RefreshIndicator(
                                              onRefresh: isSearchMenungguRespons ? refreshListSearchMenungguRespons : refreshListMenungguRespons,
                                              child: ListView.builder(
                                                itemCount: MenungguRespons.length,
                                                itemBuilder: (context, index) {
                                                  return GestureDetector(
                                                    onTap: (){
                                                      setState(() {
                                                        detailSuratKeluarNonPanitia.suratKeluarId = MenungguRespons[index]['surat_keluar_id'];
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
                                          controller: controllerSearchSedangDiproses,
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(50.0),
                                                  borderSide: BorderSide(color: HexColor("#025393"))
                                              ),
                                              hintText: "Cari surat keluar...",
                                              suffixIcon: isSearchSedangDiproses ? IconButton(
                                                icon: Icon(Icons.close),
                                                onPressed: (){
                                                  setState(() {
                                                    LoadingSedangDiproses = true;
                                                    controllerSearchSedangDiproses.text = "";
                                                    isSearchSedangDiproses = false;
                                                    refreshListSedangDiproses();
                                                  });
                                                },
                                              ) : IconButton(
                                                icon: Icon(Icons.search),
                                                onPressed: (){
                                                  if(controllerSearchSedangDiproses.text != "") {
                                                    setState(() {
                                                      isSearchSedangDiproses = true;
                                                    });
                                                    refreshListSearchSedangDiproses();
                                                  }
                                                },
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
                                        child: LoadingSedangDiproses ? ListTileShimmer() : availableSedangDiproses ? SizedBox(
                                            height: MediaQuery.of(context).size.height * 0.442,
                                            child: RefreshIndicator(
                                              onRefresh: isSearchSedangDiproses ? refreshListSearchSedangDiproses : refreshListSedangDiproses,
                                              child: ListView.builder(
                                                itemCount: SedangDiproses.length,
                                                itemBuilder: (context, index) {
                                                  return GestureDetector(
                                                    onTap: (){
                                                      setState(() {
                                                        detailSuratKeluarNonPanitia.suratKeluarId = SedangDiproses[index]['surat_keluar_id'];
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
                                          controller: controllerSearchTelahDikonfirmasi,
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(50.0),
                                                  borderSide: BorderSide(color: HexColor("#025393"))
                                              ),
                                              hintText: "Cari surat keluar...",
                                              suffixIcon: isSearchTelahDikonfirmasi ? IconButton(
                                                icon: Icon(Icons.close),
                                                onPressed: (){
                                                  setState(() {
                                                    LoadingTelahDikonfirmasi = true;
                                                    controllerSearchTelahDikonfirmasi.text = "";
                                                    isSearchTelahDikonfirmasi = false;
                                                    refreshListTelahDikonfirmasi();
                                                  });
                                                },
                                              ) : IconButton(
                                                icon: Icon(Icons.search),
                                                onPressed: (){
                                                  if(controllerSearchTelahDikonfirmasi.text != "") {
                                                    setState(() {
                                                      isSearchTelahDikonfirmasi = true;
                                                    });
                                                    refreshListSearchTelahDikonfirmasi();
                                                  }
                                                },
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
                                        child: LoadingTelahDikonfirmasi ? ListTileShimmer() : availableTelahDikonfirmasi ? SizedBox(
                                            height: MediaQuery.of(context).size.height * 0.442,
                                            child: RefreshIndicator(
                                              onRefresh: isSearchTelahDikonfirmasi ? refreshListSearchTelahDikonfirmasi : refreshListTelahDikonfirmasi,
                                              child: ListView.builder(
                                                itemCount: TelahDikonfirmasi.length,
                                                itemBuilder: (context, index) {
                                                  return GestureDetector(
                                                    onTap: (){
                                                      setState(() {
                                                        detailSuratKeluarNonPanitia.suratKeluarId = TelahDikonfirmasi[index]['surat_keluar_id'];
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
                                          controller: controllerSearchDibatalkan,
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(50.0),
                                                  borderSide: BorderSide(color: HexColor("#025393"))
                                              ),
                                              hintText: "Cari surat keluar...",
                                              suffixIcon: isSearchDibatalkan ? IconButton(
                                                icon: Icon(Icons.close),
                                                onPressed: (){
                                                  setState(() {
                                                    LoadingDibatalkan = true;
                                                    controllerSearchDibatalkan.text = "";
                                                    isSearchDibatalkan = false;
                                                    refreshListDibatalkan();
                                                  });
                                                },
                                              ) : IconButton(
                                                icon: Icon(Icons.search),
                                                onPressed: (){
                                                  if(controllerSearchDibatalkan.text != "") {
                                                    setState(() {
                                                      isSearchDibatalkan = true;
                                                    });
                                                    refreshListSearchDibatalkan();
                                                  }
                                                },
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
                                        child: LoadingDibatalkan ? ListTileShimmer() : availableDibatalkan ? SizedBox(
                                            height: MediaQuery.of(context).size.height * 0.442,
                                            child: RefreshIndicator(
                                              onRefresh: isSearchDibatalkan ? refreshListSearchDibatalkan : refreshListDibatalkan,
                                              child: ListView.builder(
                                                itemCount: Dibatalkan.length,
                                                itemBuilder: (context, index) {
                                                  return GestureDetector(
                                                    onTap: (){
                                                      setState(() {
                                                        detailSuratKeluarNonPanitia.suratKeluarId = Dibatalkan[index]['surat_keluar_id'];
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