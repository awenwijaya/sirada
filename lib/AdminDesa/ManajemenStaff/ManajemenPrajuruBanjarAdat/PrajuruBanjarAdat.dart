import 'dart:convert';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:surat/AdminDesa/ManajemenStaff/ManajemenPrajuruBanjarAdat/DetailPrajuruBanjarAdat.dart';
import 'package:surat/AdminDesa/ManajemenStaff/ManajemenPrajuruBanjarAdat/EditPrajuruBanjarAdat.dart';
import 'package:surat/AdminDesa/ManajemenStaff/ManajemenPrajuruBanjarAdat/TambahPrajuruBanjarAdat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:surat/LoginAndRegistration/LoginPage.dart';
import 'package:fluttertoast/fluttertoast.dart';

class prajuruBanjarAdatAdmin extends StatefulWidget {
  const prajuruBanjarAdatAdmin({Key key}) : super(key: key);

  @override
  _prajuruBanjarAdatAdminState createState() => _prajuruBanjarAdatAdminState();
}

class _prajuruBanjarAdatAdminState extends State<prajuruBanjarAdatAdmin> {
  var prajuruBanjarAdatIDAktif = [];
  var namaPrajuruAktif = [];
  var namaBanjarAktif = [];
  var jabatanAktif = [];
  var pendudukIdAktif = [];
  var prajuruBanjarAdatIDTidakAktif = [];
  var namaPrajuruTidakAktif = [];
  var namaBanjarTidakAktif = [];
  var jabatanTidakAktif = [];
  var pendudukIdTidakAktif = [];
  bool LoadingAktif = true;
  bool LoadingTidakAktif = true;
  bool LoadingProses = false;
  bool availableDataTidakAktif = false;
  bool availableDataAktif = false;
  var selectedIdPrajuruBanjarAdat;
  var selectedIdPenduduk;
  var apiURLShowListPrajuruBanjarAdatAktif = "https://siradaskripsi.my.id/api/data/staff/prajuru_banjar_adat/aktif/${loginPage.desaId}";
  var apiURLShowListPrajuruBanjarAdatTidakAktif =  "https://siradaskripsi.my.id/api/data/staff/prajuru_banjar_adat/tidak_aktif/${loginPage.desaId}";
  var apiURLDeletePrajuruBanjarAdat = "https://siradaskripsi.my.id/api/admin/prajuru/banjar_adat/delete";
  var apiURLSetPrajuruBanjarTidakAktif = "https://siradaskripsi.my.id/api/admin/prajuru/banjar_adat/set_tidak_aktif";
  var apiURLGetNamaBanjarFilter = "https://siradaskripsi.my.id/api/data/admin/prajuru_banjar_adat/filter/show_nama_banjar";
  var apiURLGetJabatanFilter = "https://siradaskripsi.my.id/api/data/admin/prajuru_banjar_adat/filter/show_jabatan";
  var apiURLShowFilterResult = "https://siradaskripsi.my.id/api/data/admin/prajuru_banjar_adat/filter/show_result";
  FToast ftoast;
  final controllerSearchAktif = TextEditingController();
  final controllerSearchTidakAktif = TextEditingController();

  List jabatanFilterAktif = List();
  List banjarFilterAktif = List();
  List jabatanFilterTidakAktif = List();
  List banjarFilterTidakAktif = List();
  var selectedJabatanFilterAktif;
  var selectedBanjarFilterAktif;
  var selectedJabatanFilterTidakAktif;
  var selectedBanjarFilterTidakAktif;
  bool LoadingFilterAktif = true;
  bool isFilterAktif = false;
  bool LoadingFilterTidakAktif = true;
  bool isFilterTidakAktif = false;

  //search
  bool isSearch = false;
  var apiURLSearchAktif = "https://siradaskripsi.my.id/api/admin/staff/prajuru_banjar_adat/aktif/${loginPage.desaId}/search";

  //search tidak aktif
  bool isSearchTidakAktif = false;
  var apiURLSearchTidakAktif = "https://siradaskripsi.my.id/api/admin/staff/prajuru_banjar_adat/tidak_aktif/${loginPage.desaId}/search";

  Future getFilterKomponenAktif() async{
    var body = jsonEncode({
      "status" : "aktif",
      "desa_adat_id" : loginPage.desaId
    });
    http.post(Uri.parse(apiURLGetNamaBanjarFilter),
      headers: {"Content-Type" : "application/json"},
      body: body
    ).then((http.Response response) {
      var responseValue = response.statusCode;
      if(responseValue == 200) {
        var jsonData = json.decode(response.body);
        setState(() {
          banjarFilterAktif = jsonData;
        });
      }
    });
    http.post(Uri.parse(apiURLGetJabatanFilter),
        headers: {"Content-Type" : "application/json"},
        body: body
    ).then((http.Response response) {
      var responseValue = response.statusCode;
      if(responseValue == 200) {
        var jsonData = json.decode(response.body);
        setState(() {
          jabatanFilterAktif = jsonData;
        });
      }
    });
    LoadingFilterAktif = false;
  }

  Future getFilterKomponenTidakAktif() {
    var body = jsonEncode({
      "status" : "tidak aktif",
      "desa_adat_id" : loginPage.desaId
    });
    http.post(Uri.parse(apiURLGetNamaBanjarFilter),
        headers: {"Content-Type" : "application/json"},
        body: body
    ).then((http.Response response) {
      var responseValue = response.statusCode;
      if(responseValue == 200) {
        var jsonData = json.decode(response.body);
        setState(() {
          banjarFilterTidakAktif = jsonData;
        });
      }
    });
    http.post(Uri.parse(apiURLGetJabatanFilter),
        headers: {"Content-Type" : "application/json"},
        body: body
    ).then((http.Response response) {
      var responseValue = response.statusCode;
      if(responseValue == 200) {
        var jsonData = json.decode(response.body);
        setState(() {
          jabatanFilterTidakAktif = jsonData;
        });
      }
    });
    LoadingFilterTidakAktif = false;
  }

  Future refreshListPrajuruBanjarAdatAktif() async {
    Uri uri = Uri.parse(apiURLShowListPrajuruBanjarAdatAktif);
    final response = await http.get(uri);
    if(response.statusCode == 200) {
      var data = json.decode(response.body);
      this.prajuruBanjarAdatIDAktif = [];
      this.namaPrajuruAktif = [];
      this.jabatanAktif = [];
      this.namaBanjarAktif = [];
      this.pendudukIdAktif = [];
      setState(() {
        LoadingAktif = false;
        availableDataAktif = true;
        for(var i = 0; i < data.length; i++) {
          this.prajuruBanjarAdatIDAktif.add(data[i]['prajuru_banjar_adat_id']);
          this.namaPrajuruAktif.add(data[i]['nama']);
          this.jabatanAktif.add(data[i]['jabatan']);
          this.namaBanjarAktif.add(data[i]['nama_banjar_adat']);
          this.pendudukIdAktif.add(data[i]['penduduk_id']);
        }
      });
    }else{
      setState(() {
        LoadingAktif = false;
        availableDataAktif = false;
      });
    }
  }

  Future refreshListSearchPrajuruDesaBanjarAktif() async {
    setState(() {
      LoadingAktif = true;
      isSearch = true;
    });
    var body = jsonEncode({
      "search_query" : controllerSearchAktif.text
    });
    http.post(Uri.parse(apiURLSearchAktif),
        headers: {"Content-Type" : "application/json"},
        body: body
    ).then((http.Response response) async {
      var statusCode = response.statusCode;
      if(statusCode == 200) {
        var data = json.decode(response.body);
        this.prajuruBanjarAdatIDAktif = [];
        this.namaPrajuruAktif = [];
        this.jabatanAktif = [];
        this.namaBanjarAktif = [];
        this.pendudukIdAktif = [];
        setState(() {
          LoadingAktif = false;
          availableDataAktif = true;
          for(var i = 0; i < data.length; i++) {
            this.prajuruBanjarAdatIDAktif.add(data[i]['prajuru_banjar_adat_id']);
            this.namaPrajuruAktif.add(data[i]['nama']);
            this.jabatanAktif.add(data[i]['jabatan']);
            this.namaBanjarAktif.add(data[i]['nama_banjar_adat']);
            this.pendudukIdAktif.add(data[i]['penduduk_id']);
          }
        });
      }else {
        setState(() {
          LoadingAktif = false;
          availableDataAktif = false;
        });
      }
    });
  }

  Future refreshListPrajuruBanjarAdatTidakAktif() async {
    Uri uri = Uri.parse(apiURLShowListPrajuruBanjarAdatTidakAktif);
    final response = await http.get(uri);
    if(response.statusCode == 200) {
      var data = json.decode(response.body);
      this.prajuruBanjarAdatIDTidakAktif = [];
      this.namaPrajuruTidakAktif = [];
      this.jabatanTidakAktif = [];
      this.namaBanjarTidakAktif = [];
      this.pendudukIdTidakAktif = [];
      setState(() {
        LoadingTidakAktif = false;
        availableDataTidakAktif = true;
        for(var i = 0; i < data.length; i++) {
          this.prajuruBanjarAdatIDTidakAktif.add(data[i]['prajuru_banjar_adat_id']);
          this.namaPrajuruTidakAktif.add(data[i]['nama']);
          this.jabatanTidakAktif.add(data[i]['jabatan']);
          this.namaBanjarTidakAktif.add(data[i]['nama_banjar_adat']);
          this.pendudukIdTidakAktif.add(data[i]['penduduk_id']);
        }
      });
    }else{
      setState(() {
        LoadingTidakAktif = false;
        availableDataTidakAktif = false;
      });
    }
  }

  Future refreshListSearchPrajuruBanjarAdatTidakAktif() async {
    setState(() {
      LoadingTidakAktif = true;
      isSearchTidakAktif = true;
    });
    var body = jsonEncode({
      "search_query" : controllerSearchTidakAktif.text
    });
    http.post(Uri.parse(apiURLSearchTidakAktif),
        headers: {"Content-Type" : "application/json"},
        body: body
    ).then((http.Response response) async {
      var statusCode = response.statusCode;
      if(statusCode == 200) {
        var data = json.decode(response.body);
        this.prajuruBanjarAdatIDTidakAktif = [];
        this.namaPrajuruTidakAktif = [];
        this.jabatanTidakAktif = [];
        this.namaBanjarTidakAktif = [];
        this.pendudukIdTidakAktif = [];
        setState(() {
          LoadingTidakAktif = false;
          availableDataTidakAktif = true;
          for(var i = 0; i < data.length; i++) {
            this.prajuruBanjarAdatIDTidakAktif.add(data[i]['prajuru_banjar_adat_id']);
            this.namaPrajuruTidakAktif.add(data[i]['nama']);
            this.jabatanTidakAktif.add(data[i]['jabatan']);
            this.namaBanjarTidakAktif.add(data[i]['nama_banjar_adat']);
            this.pendudukIdTidakAktif.add(data[i]['penduduk_id']);
          }
        });
      }else {
        setState(() {
          LoadingTidakAktif = false;
          availableDataTidakAktif = false;
        });
      }
    });
  }

  Future showFilterResultAktif() async {
    setState(() {
      LoadingAktif = true;
    });
    var body = jsonEncode({
      "filter_jabatan" : selectedJabatanFilterAktif == null ? null : selectedJabatanFilterAktif,
      "filter_banjar" : selectedBanjarFilterAktif == null ? null : selectedBanjarFilterAktif,
      "desa_adat_id" : loginPage.desaId,
      "status" : "aktif"
    });
    http.post(Uri.parse(apiURLShowFilterResult),
        headers: {"Content-Type" : "application/json"},
        body: body
    ).then((http.Response response) async {
      var statusCode = response.statusCode;
      if(statusCode == 200) {
        var data = json.decode(response.body);
        this.prajuruBanjarAdatIDAktif = [];
        this.namaPrajuruAktif = [];
        this.jabatanAktif = [];
        this.namaBanjarAktif = [];
        this.pendudukIdAktif = [];
        setState(() {
          LoadingAktif = false;
          availableDataAktif = true;
          for(var i = 0; i < data.length; i++) {
            this.prajuruBanjarAdatIDAktif.add(data[i]['prajuru_banjar_adat_id']);
            this.namaPrajuruAktif.add(data[i]['nama']);
            this.jabatanAktif.add(data[i]['jabatan']);
            this.namaBanjarAktif.add(data[i]['nama_banjar_adat']);
            this.pendudukIdAktif.add(data[i]['penduduk_id']);
          }
        });
      }else {
        setState(() {
          LoadingAktif = false;
          availableDataAktif = false;
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    refreshListPrajuruBanjarAdatAktif();
    refreshListPrajuruBanjarAdatTidakAktif();
    getFilterKomponenAktif();
    getFilterKomponenTidakAktif();
    ftoast = FToast();
    ftoast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
                backgroundColor: Colors.white,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  color: HexColor("#025393"),
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                ),
                title: Text("Prajuru Banjar Adat", style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w700,
                    color: HexColor("#025393")
                )),
              bottom: TabBar(
                labelColor: HexColor("#025393"),
                unselectedLabelColor: Colors.black,
                tabs: [
                  Tab(child: Column(
                    children: <Widget>[
                      Icon(Icons.done, color: HexColor("228B22")),
                      Text("Aktif", style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w700
                      ))
                    ],
                  )),
                  Tab(child: Column(
                    children: <Widget>[
                      Icon(Icons.close, color: HexColor("990000")),
                      Text("Tidak Aktif", style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w700
                      ))
                    ],
                  ))
                ],
              )
            ),
            body: TabBarView(
                children: <Widget>[
                  Container(
                      child: Column(
                          children: <Widget>[
                            Container(
                                child: TextField(
                                  controller: controllerSearchAktif,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(50.0),
                                          borderSide: BorderSide(color: HexColor("#025393"))
                                      ),
                                      hintText: "Cari Prajuru Banjar Adat...",
                                      suffixIcon: IconButton(
                                        icon: Icon(Icons.search),
                                        onPressed: (){
                                          if(controllerSearchAktif.text != "") {
                                            setState(() {
                                              isSearch = true;
                                              selectedJabatanFilterAktif = null;
                                              selectedBanjarFilterAktif = null;
                                            });
                                            refreshListSearchPrajuruDesaBanjarAktif();
                                          }else {
                                            setState(() {
                                              LoadingAktif = true;
                                              controllerSearchAktif.text = "";
                                              isSearch = false;
                                              refreshListPrajuruBanjarAdatAktif();
                                            });
                                          }
                                        },
                                      )
                                  ),
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 14
                                  ),
                                ),
                                margin: EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 20)
                            ),
                            Container(
                              child: LoadingFilterAktif ? ListTileShimmer() : Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Flexible(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(30),
                                              border: Border.all(width: 1, color: HexColor("025393"))
                                          ),
                                          child: DropdownButton(
                                            isExpanded: true,
                                            hint: Center(
                                                child: Text("Semua Jabatan", style: TextStyle(
                                                    fontFamily: "Poppins",
                                                    fontSize: 14
                                                ))
                                            ),
                                            value: selectedJabatanFilterAktif,
                                            underline: Container(),
                                            items: jabatanFilterAktif.map((jabatan) {
                                              return DropdownMenuItem(
                                                  value: jabatan['jabatan'],
                                                  child: Text("${jabatan['jabatan']}", style: TextStyle(
                                                      fontFamily: "Poppins",
                                                      fontSize: 14
                                                  ))
                                              );
                                            }).toList(),
                                            selectedItemBuilder: (BuildContext context) => jabatanFilterAktif.map((jabatan) => Center(
                                                child: Text("${jabatan['jabatan']}", style: TextStyle(
                                                    fontFamily: "Poppins",
                                                    fontSize: 14
                                                ))
                                            )).toList(),
                                            onChanged: (value) {
                                              setState(() {
                                                selectedJabatanFilterAktif = value;
                                              });
                                            },
                                          ),
                                          margin: EdgeInsets.symmetric(horizontal: 5),
                                        )
                                    ),
                                    Flexible(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(30),
                                              border: Border.all(width: 1, color: HexColor("025393"))
                                          ),
                                          child: DropdownButton(
                                            onChanged: (value) {
                                              setState(() {
                                                selectedBanjarFilterAktif = value;
                                              });
                                            },
                                            value: selectedBanjarFilterAktif,
                                            underline: Container(),
                                            hint: Center(
                                              child: Text("Semua Banjar", style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontSize: 14
                                              )),
                                            ),
                                            isExpanded: true,
                                            items: banjarFilterAktif.map((banjar) {
                                              return DropdownMenuItem(
                                                  value: banjar['banjar_adat_id'],
                                                  child: Text("${banjar['nama_banjar_adat']}", style: TextStyle(
                                                      fontFamily: "Poppins",
                                                      fontSize: 14
                                                  ))
                                              );
                                            }).toList(),
                                            selectedItemBuilder: (BuildContext context) => banjarFilterAktif.map((banjar) => Center(
                                              child: Text(banjar['nama_banjar_adat'], style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: "Poppins"
                                              )),
                                            )).toList(),
                                          ),
                                          margin: EdgeInsets.symmetric(horizontal: 5),
                                        )
                                    )
                                  ],
                                ),
                                margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                              ),
                            ),
                            Container(
                              child: Column(
                                children: [
                                  if(isSearch == true) Container(
                                    child: FlatButton(
                                      onPressed: (){
                                        setState(() {
                                          LoadingAktif = true;
                                          controllerSearchAktif.text = "";
                                          isSearch = false;
                                          refreshListPrajuruBanjarAdatAktif();
                                        });
                                      },
                                      child: Text("Reset Pencarian", style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white
                                      )),
                                      color: HexColor("#025393"),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(25),
                                          side: BorderSide(color: HexColor("#025393"), width: 2)
                                      ),
                                    ),
                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Column(
                                children: <Widget>[
                                  if(selectedJabatanFilterAktif != null || selectedBanjarFilterAktif != null) Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          child: FlatButton(
                                            onPressed: (){
                                              setState(() {
                                                selectedJabatanFilterAktif = null;
                                                selectedBanjarFilterAktif = null;
                                                controllerSearchAktif.text = "";
                                                LoadingAktif = true;
                                              });
                                              refreshListPrajuruBanjarAdatAktif();
                                            },
                                            child: Text("Reset Filter", style: TextStyle(
                                                fontFamily: "Poppins",
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white
                                            )),
                                            color: HexColor("#025393"),
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(25),
                                                side: BorderSide(color: HexColor("#025393"), width: 2)
                                            ),
                                          ),
                                          margin: EdgeInsets.symmetric(horizontal: 5),
                                        ),
                                        Container(
                                          child: FlatButton(
                                            onPressed: (){
                                              setState(() {
                                                controllerSearchAktif.text = "";
                                              });
                                              showFilterResultAktif();
                                            },
                                            child: Text("Cari Data", style: TextStyle(
                                                fontFamily: "Poppins",
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white
                                            )),
                                            color: HexColor("#025393"),
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(25),
                                                side: BorderSide(color: HexColor("#025393"), width: 2)
                                            ),
                                          ),
                                          margin: EdgeInsets.symmetric(horizontal: 5),
                                        )
                                      ],
                                    )
                                  )
                                ],
                              ),
                            ),
                            Container(
                                child: LoadingAktif ? ListTileShimmer() : availableDataAktif ? Expanded(
                                    flex: 1,
                                    child: RefreshIndicator(
                                        onRefresh: isSearch ? refreshListSearchPrajuruDesaBanjarAktif : isFilterAktif ? showFilterResultAktif : refreshListPrajuruBanjarAdatAktif,
                                        child: ListView.builder(
                                            itemCount: prajuruBanjarAdatIDAktif.length,
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                  onTap: (){
                                                    setState(() {
                                                      detailPrajuruBanjarAdatAdmin.prajuruBanjarAdatId = prajuruBanjarAdatIDAktif[index];
                                                    });
                                                    Navigator.push(context, CupertinoPageRoute(builder: (context) => detailPrajuruBanjarAdatAdmin()));
                                                  },
                                                  child: Container(
                                                      child: Stack(
                                                          children: <Widget>[
                                                            Container(
                                                                child: Row(
                                                                    children: <Widget>[
                                                                      Container(
                                                                          child: Image.asset(
                                                                              'images/person.png',
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
                                                                                        child: Text("${namaPrajuruAktif[index]}", style: TextStyle(
                                                                                            fontFamily: "Poppins",
                                                                                            fontSize: 16,
                                                                                            fontWeight: FontWeight.w700,
                                                                                            color: HexColor("#025393")
                                                                                        ), maxLines: 1,
                                                                                            overflow: TextOverflow.ellipsis,
                                                                                            softWrap: false
                                                                                        )
                                                                                    )
                                                                                ),
                                                                                Container(
                                                                                    child: Text("${jabatanAktif[index]}", style: TextStyle(
                                                                                        fontFamily: "Poppins",
                                                                                        fontSize: 14
                                                                                    ))
                                                                                ),
                                                                                Container(
                                                                                    child: Text("Banjar: ${namaBanjarAktif[index]}", style: TextStyle(
                                                                                        fontFamily: "Poppins",
                                                                                        fontSize: 14
                                                                                    ))
                                                                                )
                                                                              ]
                                                                          ),
                                                                          margin: EdgeInsets.only(left: 15)
                                                                      )
                                                                    ]
                                                                )
                                                            ),
                                                            Container(
                                                                alignment: Alignment.centerRight,
                                                                child: PopupMenuButton<int>(
                                                                    onSelected: (item) {
                                                                      setState(() {
                                                                        selectedIdPrajuruBanjarAdat = prajuruBanjarAdatIDAktif[index];
                                                                        selectedIdPenduduk = pendudukIdAktif[index];
                                                                      });
                                                                      onSelected(context, item);
                                                                    },
                                                                    itemBuilder: (context) => [
                                                                      PopupMenuItem<int>(
                                                                          value: 0,
                                                                          child: Row(
                                                                              children: <Widget>[
                                                                                Container(
                                                                                    child: Icon(
                                                                                        Icons.edit,
                                                                                        color: HexColor("#025393")
                                                                                    )
                                                                                ),
                                                                                Container(
                                                                                    child: Text("Edit", style: TextStyle(
                                                                                        fontFamily: "Poppins",
                                                                                        fontSize: 14
                                                                                    )),
                                                                                    margin: EdgeInsets.only(left: 10)
                                                                                )
                                                                              ]
                                                                          )
                                                                      ),
                                                                      PopupMenuItem<int>(
                                                                          value: 2,
                                                                          child: Row(
                                                                              children: <Widget>[
                                                                                Container(
                                                                                    child: Icon(
                                                                                        Icons.close,
                                                                                        color: HexColor("#025393")
                                                                                    )
                                                                                ),
                                                                                Container(
                                                                                    child: Text("Atur Menjadi Tidak Aktif", style: TextStyle(
                                                                                        fontFamily: "Poppins",
                                                                                        fontSize: 14
                                                                                    )),
                                                                                    margin: EdgeInsets.only(left: 10)
                                                                                )
                                                                              ]
                                                                          )
                                                                      ),
                                                                    ]
                                                                )
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
                                    )
                                ) : Container(
                                    child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                              child: Icon(
                                                CupertinoIcons.person_alt,
                                                size: 50,
                                                color: Colors.black26,
                                              )
                                          ),
                                          Container(
                                            child: Text("Tidak ada Data Prajuru Banjar Adat", style: TextStyle(
                                                fontFamily: "Poppins",
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black26
                                            ), textAlign: TextAlign.center),
                                            margin: EdgeInsets.only(top: 10),
                                            padding: EdgeInsets.symmetric(horizontal: 30),
                                          ),
                                          Container(
                                            child: Text("Tidak ada data prajuru banjar adat. Anda bisa menambahkannya dengan cara menekan tombol Tambah Data Prajuru dan isi data pada form yang telah disediakan", style: TextStyle(
                                                fontFamily: "Poppins",
                                                fontSize: 14,
                                                color: Colors.black26
                                            ), textAlign: TextAlign.center),
                                            padding: EdgeInsets.symmetric(horizontal: 30),
                                            margin: EdgeInsets.only(top: 10),
                                          )
                                        ]
                                    )
                                )
                            )
                          ]
                      )
                  ),
                  Container(
                      child: Container(
                          child: Column(
                              children: <Widget>[
                                Container(
                                    child: TextField(
                                      controller: controllerSearchTidakAktif,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(50.0),
                                              borderSide: BorderSide(color: HexColor("#025393"))
                                          ),
                                          hintText: "Cari nama, jabatan, atau asal banjar Prajuru Banjar Adat...",
                                          suffixIcon: isSearchTidakAktif ? IconButton(
                                            icon: Icon(Icons.close),
                                            onPressed: (){
                                              setState(() {
                                                LoadingTidakAktif = true;
                                                controllerSearchTidakAktif.text = "";
                                                isSearchTidakAktif = false;
                                                refreshListPrajuruBanjarAdatTidakAktif();
                                              });
                                            },
                                          ) : IconButton(
                                            icon: Icon(Icons.search),
                                            onPressed: (){
                                              if(controllerSearchTidakAktif.text != "") {
                                                setState(() {
                                                  isSearchTidakAktif = true;
                                                });
                                                refreshListSearchPrajuruBanjarAdatTidakAktif();
                                              }
                                            },
                                          )
                                      ),
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 14
                                      ),
                                    ),
                                    margin: EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 20)
                                ),
                                Container(
                                  child: LoadingTidakAktif ? ListTileShimmer() : availableDataTidakAktif ? Expanded(
                                    flex: 1,
                                    child: RefreshIndicator(
                                        onRefresh: isSearchTidakAktif ? refreshListSearchPrajuruBanjarAdatTidakAktif : refreshListPrajuruBanjarAdatTidakAktif,
                                        child: ListView.builder(
                                            itemCount: prajuruBanjarAdatIDTidakAktif.length,
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                  onTap: (){
                                                    setState(() {
                                                      detailPrajuruBanjarAdatAdmin.prajuruBanjarAdatId = prajuruBanjarAdatIDTidakAktif[index];
                                                    });
                                                    Navigator.push(context, CupertinoPageRoute(builder: (context) => detailPrajuruBanjarAdatAdmin()));
                                                  },
                                                  child: Container(
                                                      child: Stack(
                                                          children: <Widget>[
                                                            Container(
                                                                child: Row(
                                                                    children: <Widget>[
                                                                      Container(
                                                                          child: Image.asset(
                                                                              'images/person.png',
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
                                                                                        child: Text("${namaPrajuruTidakAktif[index]}", style: TextStyle(
                                                                                            fontFamily: "Poppins",
                                                                                            fontSize: 16,
                                                                                            fontWeight: FontWeight.w700,
                                                                                            color: HexColor("#025393")
                                                                                        ), maxLines: 1,
                                                                                            overflow: TextOverflow.ellipsis,
                                                                                            softWrap: false
                                                                                        )
                                                                                    )
                                                                                ),
                                                                                Container(
                                                                                    child: Text("${jabatanTidakAktif[index]}", style: TextStyle(
                                                                                        fontFamily: "Poppins",
                                                                                        fontSize: 14
                                                                                    ))
                                                                                ),
                                                                                Container(
                                                                                    child: Text("Banjar: ${namaBanjarTidakAktif[index]}", style: TextStyle(
                                                                                        fontFamily: "Poppins",
                                                                                        fontSize: 14
                                                                                    ))
                                                                                )
                                                                              ]
                                                                          ),
                                                                          margin: EdgeInsets.only(left: 15)
                                                                      )
                                                                    ]
                                                                )
                                                            ),
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
                                    ),
                                  ) : Container(
                                      child: Center(
                                          child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                Container(
                                                    child: Icon(
                                                        CupertinoIcons.person_alt,
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
                                )
                              ]
                          )
                      )
                  )
                ]
            ),
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              Navigator.push(context, CupertinoPageRoute(builder: (context) => tambahPrajuruBanjarAdatAdmin())).then((value) {
                refreshListPrajuruBanjarAdatAktif();
                refreshListPrajuruBanjarAdatTidakAktif();
              });
            },
            child: Icon(Icons.add),
            backgroundColor: HexColor("025393"),
          ),
        ),
      )
    );
  }

  void onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        setState(() {
          isSearch = false;
          isSearchTidakAktif = false;
          controllerSearchAktif.text = "";
          controllerSearchTidakAktif.text = "";
          editPrajuruBanjarAdatAdmin.idPegawai = selectedIdPrajuruBanjarAdat;
        });
        Navigator.push(context, CupertinoPageRoute(builder: (context) => editPrajuruBanjarAdatAdmin())).then((value) {
          refreshListPrajuruBanjarAdatAktif();
          refreshListPrajuruBanjarAdatTidakAktif();
        });
        break;

      case 2:
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(40.0))
              ),
              content: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                        child: Image.asset(
                          'images/question.png',
                          height: 50,
                          width: 50,
                        )
                    ),
                    Container(
                        child: Text("Atur Prajuru Menjadi Tidak Aktif", style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: HexColor("#025393")
                        ), textAlign: TextAlign.center),
                        margin: EdgeInsets.only(top: 10)
                    ),
                    Container(
                      child: Text("Apakah Anda yakin ingin menonaktifkan prajuru ini? Setelah prajuru di non-aktifkan maka ia akan kehilangan hak akses login dan tindakan ini tidak dapat dikembalikan", style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 14
                      ), textAlign: TextAlign.center),
                      margin: EdgeInsets.only(top: 10),
                    )
                  ]
                )
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: (){
                    var body = jsonEncode({
                      "prajuru_banjar_adat_id" : selectedIdPrajuruBanjarAdat,
                      "penduduk_id" : selectedIdPenduduk
                    });
                    http.post(Uri.parse(apiURLSetPrajuruBanjarTidakAktif),
                      headers: {"Content-Type" : "application/json"},
                      body: body
                    ).then((http.Response response) {
                      var responseValue = response.statusCode;
                      if(responseValue == 200) {
                        isSearch = false;
                        isSearchTidakAktif = false;
                        controllerSearchAktif.text = "";
                        controllerSearchTidakAktif.text = "";
                        refreshListPrajuruBanjarAdatAktif();
                        refreshListPrajuruBanjarAdatTidakAktif();
                        ftoast.showToast(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Colors.green
                              ),
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.done),
                                  Container(
                                    margin: EdgeInsets.only(left: 15),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.65,
                                      child: Text("Prajuru Banjar Adat berhasil dinonaktifkan", style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white
                                      )),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            toastDuration: Duration(seconds: 3)
                        );
                        Navigator.of(context).pop();
                      }
                    });
                  },
                  child: Text("Ya", style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w700,
                    color: HexColor("#025393")
                  ))
                ),
                TextButton(
                  onPressed: (){Navigator.of(context).pop();},
                  child: Text("Tidak", style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w700,
                    color: HexColor("#025393")
                  ))
                )
              ]
            );
          }
        );
        break;
    }
  }
}