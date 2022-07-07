import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:surat/AdminDesa/ManajemenSurat/SuratKeluar/SuratKeluarNonPanitia/DetailSurat.dart';
import 'package:surat/AdminDesa/ManajemenSurat/SuratKeluar/SuratKeluarNonPanitia/DetailSuratPanitia.dart';
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
  var apiURLShowFilterKodeSurat = "https://siradaskripsi.my.id/api/admin/surat/keluar/filter/kode_surat/prajuru";
  var apiURLShowFilterTahunTerbit = "https://siradaskripsi.my.id/api/admin/surat/keluar/filter/tahun_terbit/prajuru";
  var apiURLShowFilterResult = "https://siradaskripsi.my.id/api/admin/surat/keluar/filter/result/prajuru";
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
  bool isFilterMenungguRespons = false;
  bool isFilterSedangDiproses = false;
  bool isFilterTelahDikonfirmasi = false;
  bool isFilterDibatalkan = false;
  bool LoadingFilterMenungguRespons = true;
  bool LoadingFilterSedangDiproses = true;
  bool LoadingFilterTelahDikonfirmasi = true;
  bool LoadingFilterDibatalkan = true;
  bool LoadingKomponenFilterMenungguRespons = true;

  final controllerSearchMenungguRespons = TextEditingController();
  final controllerSearchSedangDiproses = TextEditingController();
  final controllerSearchTelahDikonfirmasi = TextEditingController();
  final controllerSearchDibatalkan = TextEditingController();

  //list
  List MenungguRespons = [];
  List SedangDiproses = [];
  List TelahDikonfirmasi = [];
  List Dibatalkan = [];
  List tahunTerbitFilterMenungguRespons = List();
  List tahunTerbitFilterSedangDiproses = List();
  List tahunTerbitFilterTelahDikonfirmasi = List();
  List tahunTerbitFilterDibatalkan = List();
  List kodeSuratFilterMenungguRespons = List();
  List kodeSuratFilterSedangDiproses = List();
  List kodeSuratFilterTelahDikonfirmasi = List();
  List kodeSuratFilterDibatalkan = List();

  var selectedTahunTerbitFilterMenungguRespons;
  var selectedTahunTerbitFilterSedangDiproses;
  var selectedTahunTerbitFilterTelahDikonfirmasi;
  var selectedTahunTerbitFilterDibatalkan;
  var selectedKodeSuratFilterMenungguRespons;
  var selectedKodeSuratFilterSedangDiproses;
  var selectedKodeSuratFilterDibatalkan;
  var selectedKodeSuratFilterTelahDikonfirmasi;

  Future showFilterTahunTerbitMenungguRespons() async {
    var body = jsonEncode({
      "desa_adat_id" : loginPage.desaId.toString(),
      "status" : "Menunggu Respon"
    });
    http.post(Uri.parse(apiURLShowFilterTahunTerbit),
      headers: {"Content-Type" : "application/json"},
      body: body
    ).then((http.Response response) {
      var responseValue = response.statusCode;
      if(responseValue == 200) {
        var jsonData = json.decode(response.body);
        setState(() {
          tahunTerbitFilterMenungguRespons = jsonData;
        });
      }
    });
  }

  Future showFilterKodeSuratMenungguRespons() async {
    var body = jsonEncode({
      "desa_adat_id" : loginPage.desaId.toString(),
      "status" : "Menunggu Respon"
    });
    http.post(Uri.parse(apiURLShowFilterKodeSurat),
      headers: {"Content-Type" : "application/json"},
      body: body
    ).then((http.Response response) {
      var responseValue = response.statusCode;
      if(responseValue == 200) {
        var jsonData = json.decode(response.body);
        setState(() {
          kodeSuratFilterMenungguRespons = jsonData;
        });
      }
    });
  }

  Future showFilterTahunTerbitSedangDiproses() async {
    var body = jsonEncode({
      "desa_adat_id" : loginPage.desaId.toString(),
      "status" : "Sedang Diproses"
    });
    http.post(Uri.parse(apiURLShowFilterTahunTerbit),
        headers: {"Content-Type" : "application/json"},
        body: body
    ).then((http.Response response) {
      var responseValue = response.statusCode;
      if(responseValue == 200) {
        var jsonData = json.decode(response.body);
        setState(() {
          tahunTerbitFilterSedangDiproses = jsonData;
        });
      }
    });
  }

  Future showFilterKodeSuratSedangDiproses() async {
    var body = jsonEncode({
      "desa_adat_id" : loginPage.desaId.toString(),
      "status" : "Sedang Diproses"
    });
    http.post(Uri.parse(apiURLShowFilterKodeSurat),
        headers: {"Content-Type" : "application/json"},
        body: body
    ).then((http.Response response) {
      var responseValue = response.statusCode;
      if(responseValue == 200) {
        var jsonData = json.decode(response.body);
        setState(() {
          kodeSuratFilterSedangDiproses = jsonData;
        });
      }
    });
  }

  Future showFilterKodeSuratDibatalkan() async {
    var body = jsonEncode({
      "desa_adat_id" : loginPage.desaId.toString(),
      "status" : "Dibatalkan"
    });
    http.post(Uri.parse(apiURLShowFilterKodeSurat),
        headers: {"Content-Type" : "application/json"},
        body: body
    ).then((http.Response response) {
      var responseValue = response.statusCode;
      if(responseValue == 200) {
        var jsonData = json.decode(response.body);
        setState(() {
          kodeSuratFilterDibatalkan = jsonData;
        });
      }
    });
  }

  Future showFilterKodeSuratTelahDikonfirmasi() async {
    var body = jsonEncode({
      "desa_adat_id" : loginPage.desaId.toString(),
      "status" : "Telah Dikonfirmasi"
    });
    http.post(Uri.parse(apiURLShowFilterKodeSurat),
        headers: {"Content-Type" : "application/json"},
        body: body
    ).then((http.Response response) {
      var responseValue = response.statusCode;
      if(responseValue == 200) {
        var jsonData = json.decode(response.body);
        setState(() {
          kodeSuratFilterTelahDikonfirmasi = jsonData;
        });
      }
    });
  }

  Future showFilterTahunTerbitDibatalkan() async {
    var body = jsonEncode({
      "desa_adat_id" : loginPage.desaId.toString(),
      "status" : "Dibatalkan"
    });
    http.post(Uri.parse(apiURLShowFilterTahunTerbit),
        headers: {"Content-Type" : "application/json"},
        body: body
    ).then((http.Response response) {
      var responseValue = response.statusCode;
      if(responseValue == 200) {
        var jsonData = json.decode(response.body);
        setState(() {
          tahunTerbitFilterDibatalkan = jsonData;
        });
      }
    });
  }

  Future showFilterTahunTerbitTelahDikonfirmasi() async {
    var body = jsonEncode({
      "desa_adat_id" : loginPage.desaId.toString(),
      "status" : "Telah Dikonfirmasi"
    });
    http.post(Uri.parse(apiURLShowFilterTahunTerbit),
        headers: {"Content-Type" : "application/json"},
        body: body
    ).then((http.Response response) {
      var responseValue = response.statusCode;
      if(responseValue == 200) {
        var jsonData = json.decode(response.body);
        setState(() {
          tahunTerbitFilterTelahDikonfirmasi = jsonData;
        });
      }
    });
  }

  Future showFilterResultMenungguRespons() async {
    var body = jsonEncode({
      "search_query" : controllerSearchMenungguRespons.text == "" ? null : controllerSearchMenungguRespons.text,
      "kode_surat_filter" : selectedKodeSuratFilterMenungguRespons == null ? null : selectedKodeSuratFilterMenungguRespons,
      "tahun_terbit_filter" : selectedTahunTerbitFilterMenungguRespons == null ? null : selectedTahunTerbitFilterMenungguRespons,
      "status" : "Menunggu Respon"
    });
    http.post(Uri.parse(apiURLShowFilterResult),
      headers: {"Content-Type" : "application/json"},
      body: body
    ).then((http.Response response) {
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

  Future getFilterKomponenMenungguRespons() async {
    var body = jsonEncode({
      "desa_adat_id" : loginPage.desaId.toString(),
      "status" : "Menunggu Respon"
    });
    http.post(Uri.parse(apiURLShowFilterKodeSurat),
        headers: {"Content-Type" : "application/json"},
        body: body
    ).then((http.Response response) {
      var responseValue = response.statusCode;
      if(responseValue == 200) {
        var jsonData = json.decode(response.body);
        setState(() {
          kodeSuratFilterMenungguRespons = jsonData;
        });
      }
    });
    http.post(Uri.parse(apiURLShowFilterTahunTerbit),
        headers: {"Content-Type" : "application/json"},
        body: body
    ).then((http.Response response) {
      var responseValue = response.statusCode;
      if(responseValue == 200) {
        var jsonData = json.decode(response.body);
        setState(() {
          tahunTerbitFilterMenungguRespons = jsonData;
        });
      }
    });
    setState(() {
      LoadingKomponenFilterMenungguRespons = false;
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
    getFilterKomponenMenungguRespons();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 4,
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
                title: Text("Surat Keluar", style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w700,
                    color: HexColor("#025393")
                )),
              bottom: TabBar(
                  labelColor: HexColor("#025393"),
                  unselectedLabelColor: Colors.black,
                  tabs: [
                    Tab(
                      child: Column(
                        children: <Widget>[
                          Icon(CupertinoIcons.hourglass_bottomhalf_fill, color: HexColor("4B8673")),
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
                          Icon(CupertinoIcons.time_solid, color: HexColor("354259")),
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
                          Icon(Icons.done, color: HexColor("228B22")),
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
                          Icon(Icons.close, color: HexColor("990000")),
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
              ),
            ),
            body: TabBarView(
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
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.search),
                                  onPressed: (){
                                    if(controllerSearchMenungguRespons.text != "") {
                                      setState(() {
                                        isFilterMenungguRespons = true;
                                      });
                                      showFilterResultMenungguRespons();
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
                          child: LoadingFilterMenungguRespons ? ListTileShimmer() : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Flexible(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(width: 1, color: Colors.black38)
                                  ),
                                  child: DropdownButton(
                                    isExpanded: true,
                                    hint: Center(
                                      child: Text("Semua Kode Surat", style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 14
                                      )),
                                    ),
                                    value: selectedKodeSuratFilterMenungguRespons,
                                    underline: Container(),
                                    items: kodeSuratFilterMenungguRespons.map((e) {
                                      return DropdownMenuItem(
                                        value: e['master_surat_id'],
                                        child: SizedBox(
                                          width: MediaQuery.of(context).size.width,
                                          child: Text("${e['kode_nomor_surat']} - ${e['keterangan']}", style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 14
                                          ), maxLines: 1, overflow: TextOverflow.ellipsis, softWrap: false),
                                        ),
                                      );
                                    }).toList(),
                                    selectedItemBuilder: (BuildContext context) => kodeSuratFilterMenungguRespons.map((e) => Center(
                                      child: SizedBox(
                                        width: MediaQuery.of(context).size.width,
                                        child: Text(e['kode_nomor_surat'], style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 14
                                        )),
                                      ),
                                    )).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        selectedKodeSuratFilterMenungguRespons = value;
                                      });
                                      showFilterResultMenungguRespons();
                                    },
                                  ),
                                  margin: EdgeInsets.symmetric(horizontal: 5),
                                ),
                              ),
                              Flexible(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(width: 1, color: Colors.black38)
                                  ),
                                  child: DropdownButton(
                                    onChanged: (value) {
                                      setState(() {
                                        selectedTahunTerbitFilterMenungguRespons = value;
                                      });
                                      showFilterResultMenungguRespons();
                                    },
                                    value: selectedTahunTerbitFilterMenungguRespons,
                                    underline: Container(),
                                    hint: Center(
                                      child: Text("Semua Tahun Terbit", style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 14
                                      )),
                                    ),
                                    isExpanded: true,
                                    items: tahunTerbitFilterMenungguRespons.map((e) {
                                      return DropdownMenuItem(
                                        value: e['tahun_terbit'],
                                        child: Text(e['tahun_terbit'], style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 14
                                        )),
                                      );
                                    }).toList(),
                                    selectedItemBuilder: (BuildContext context) => tahunTerbitFilterMenungguRespons.map((e) => Center(
                                      child: Text(e['tahun_terbit'], style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 14
                                      )),
                                    )).toList(),
                                  ),
                                  margin: EdgeInsets.symmetric(horizontal: 5),
                                ),
                              )
                            ],
                          ),
                          margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                        ),
                        Container(
                          child: LoadingMenungguRespons ? ListTileShimmer() : availableMenungguRespons ? Expanded(
                              flex: 1,
                              child: RefreshIndicator(
                                onRefresh: isSearchMenungguRespons ? refreshListSearchMenungguRespons : refreshListMenungguRespons,
                                child: ListView.builder(
                                  itemCount: MenungguRespons.length,
                                  shrinkWrap: true,
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
                          child: LoadingSedangDiproses ? ListTileShimmer() : availableSedangDiproses ? Expanded(
                            flex: 1,
                            child: RefreshIndicator(
                              onRefresh: isSearchSedangDiproses ? refreshListSearchSedangDiproses : refreshListSedangDiproses,
                              child: ListView.builder(
                                itemCount: SedangDiproses.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: (){
                                      if(SedangDiproses[index]['tim_kegiatan'] == null) {
                                        setState(() {
                                          detailSuratKeluarNonPanitia.suratKeluarId = SedangDiproses[index]['surat_keluar_id'];
                                        });
                                        Navigator.push(context, CupertinoPageRoute(builder: (context) => detailSuratKeluarNonPanitia()));
                                      }else {
                                        setState(() {
                                          detailSuratKeluarPanitiaAdmin.suratKeluarId = SedangDiproses[index]['surat_keluar_id'];
                                        });
                                        Navigator.push(context, CupertinoPageRoute(builder: (context) => detailSuratKeluarPanitiaAdmin()));
                                      }
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
                            ),
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
                          child: LoadingTelahDikonfirmasi ? ListTileShimmer() : availableTelahDikonfirmasi ? Expanded(
                            flex: 1,
                            child: RefreshIndicator(
                              onRefresh: isSearchTelahDikonfirmasi ? refreshListSearchTelahDikonfirmasi : refreshListTelahDikonfirmasi,
                              child: ListView.builder(
                                itemCount: TelahDikonfirmasi.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: (){
                                      if(TelahDikonfirmasi[index]['tim_kegiatan'] == null) {
                                        setState(() {
                                          detailSuratKeluarNonPanitia.suratKeluarId = TelahDikonfirmasi[index]['surat_keluar_id'];
                                        });
                                        Navigator.push(context, CupertinoPageRoute(builder: (context) => detailSuratKeluarNonPanitia()));
                                      }else {
                                        setState(() {
                                          detailSuratKeluarPanitiaAdmin.suratKeluarId = TelahDikonfirmasi[index]['surat_keluar_id'];
                                        });
                                        Navigator.push(context, CupertinoPageRoute(builder: (context) => detailSuratKeluarPanitiaAdmin()));
                                      }
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
                            ),
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
                          child: LoadingDibatalkan ? ListTileShimmer() : availableDibatalkan ? Expanded(
                            flex: 1,
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
                            ),
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
            ),
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              Navigator.push(context, CupertinoPageRoute(builder: (context) => tambahSuratKeluarNonPanitiaAdmin())).then((value) {
                refreshListDibatalkan();
                refreshListMenungguRespons();
                refreshListSedangDiproses();
                refreshListTelahDikonfirmasi();
              });
            },
            child: Icon(Icons.add),
            backgroundColor: HexColor("025393"),
          ),
        )
      )
    );
  }
}