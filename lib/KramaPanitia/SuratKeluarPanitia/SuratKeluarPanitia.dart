import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:surat/KramaPanitia/SuratKeluarPanitia/DetailSurat.dart';
import 'package:surat/KramaPanitia/SuratKeluarPanitia/TambahSuratKeluarPanitia.dart';
import 'package:surat/LoginAndRegistration/LoginPage.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class suratKeluarPanitiaKramaPanitia extends StatefulWidget {
  const suratKeluarPanitiaKramaPanitia({Key key}) : super(key: key);

  @override
  State<suratKeluarPanitiaKramaPanitia> createState() => _suratKeluarPanitiaKramaPanitiaState();
}

class _suratKeluarPanitiaKramaPanitiaState extends State<suratKeluarPanitiaKramaPanitia> {
  var apiURLGetDataSurat = "https://siradaskripsi.my.id/api/data/admin/surat/panitia/${loginPage.kramaId}";
  var apiURLGetKodeSuratFilter = "https://siradaskripsi.my.id/api/admin/surat/keluar/filter/kode_surat/panitia";
  var apiURLGetTimKegiatanFilter = "https://siradaskripsi.my.id/api/admin/surat/keluar/filter/tim_kegiatan/panitia";
  var apiURLShowFilterResultPanitia = "https://siradaskripsi.my.id/api/admin/surat/keluar/filter/result/panitia";

  final DateRangePickerController controllerFilterTanggalMenungguRespon = DateRangePickerController();
  final DateRangePickerController controllerFilterTanggalSedangDiproses = DateRangePickerController();
  final DateRangePickerController controllerFilterTanggalDibatalkan = DateRangePickerController();
  final DateRangePickerController controllerFilterTanggalTelahDikonfirmasi = DateRangePickerController();

  Future getFilterKomponenMenungguRespons() async {
    var body = jsonEncode({
      "krama_mipil_id" : loginPage.kramaId,
      "status" : "Menunggu Respon"
    });
    http.post(Uri.parse(apiURLGetKodeSuratFilter),
      headers: {"Content-Type" : "application/json"},
      body: body
    ).then((http.Response response) async {
      print(response.statusCode);
      if(response.statusCode == 200) {
        var data = json.decode(response.body);
        setState(() {
          kodeSuratFilterMenungguRespons = data;
        });
      }
    });
    http.post(Uri.parse(apiURLGetTimKegiatanFilter),
      headers: {"Content-Type" : "application/json"},
      body: body
    ).then((http.Response response) {
      print(response.statusCode);
      if(response.statusCode == 200) {
        var data = json.decode(response.body);
        setState(() {
          timKegiatanFilterMenungguRespons = data;
        });
      }
    });
    setState(() {
      LoadingKomponenFilterMenungguRespons = false;
    });
  }

  Future getFilterKomponenSedangDiproses() async {
    var body = jsonEncode({
      "krama_mipil_id" : loginPage.kramaId,
      "status" : "Sedang Diproses"
    });
    http.post(Uri.parse(apiURLGetKodeSuratFilter),
        headers: {"Content-Type" : "application/json"},
        body: body
    ).then((http.Response response) async {
      print(response.statusCode);
      if(response.statusCode == 200) {
        var data = json.decode(response.body);
        setState(() {
          kodeSuratFilterSedangDiproses = data;
        });
      }
    });
    http.post(Uri.parse(apiURLGetTimKegiatanFilter),
        headers: {"Content-Type" : "application/json"},
        body: body
    ).then((http.Response response) {
      print(response.statusCode);
      if(response.statusCode == 200) {
        var data = json.decode(response.body);
        setState(() {
          timKegiatanFilterSedangDiproses = data;
        });
      }
    });
    setState(() {
      LoadingKomponenFilterSedangDiproses = false;
    });
  }

  Future getFilterKomponenTelahDikonfirmasi() async {
    var body = jsonEncode({
      "krama_mipil_id" : loginPage.kramaId,
      "status" : "Telah Dikonfirmasi"
    });
    http.post(Uri.parse(apiURLGetKodeSuratFilter),
        headers: {"Content-Type" : "application/json"},
        body: body
    ).then((http.Response response) async {
      print(response.statusCode);
      if(response.statusCode == 200) {
        var data = json.decode(response.body);
        setState(() {
          kodeSuratFilterTelahDikonfirmasi = data;
        });
      }
    });
    http.post(Uri.parse(apiURLGetTimKegiatanFilter),
        headers: {"Content-Type" : "application/json"},
        body: body
    ).then((http.Response response) {
      print(response.statusCode);
      if(response.statusCode == 200) {
        var data = json.decode(response.body);
        setState(() {
          timKegiatanFilterTelahDikonfirmasi = data;
        });
      }
    });
    setState(() {
      LoadingKomponenFilterTelahDikonfirmasi = false;
    });
  }

  Future getFilterKomponenDibatalkan() async {
    var body = jsonEncode({
      "krama_mipil_id" : loginPage.kramaId,
      "status" : "Dibatalkan"
    });
    http.post(Uri.parse(apiURLGetKodeSuratFilter),
        headers: {"Content-Type" : "application/json"},
        body: body
    ).then((http.Response response) async {
      print(response.statusCode);
      if(response.statusCode == 200) {
        var data = json.decode(response.body);
        setState(() {
          kodeSuratFilterDibatalkan = data;
        });
      }
    });
    http.post(Uri.parse(apiURLGetTimKegiatanFilter),
        headers: {"Content-Type" : "application/json"},
        body: body
    ).then((http.Response response) {
      print(response.statusCode);
      if(response.statusCode == 200) {
        var data = json.decode(response.body);
        setState(() {
          timKegiatanFilterDibatalkan = data;
        });
      }
    });
    setState(() {
      LoadingKomponenFilterDibatalkan = false;
    });
  }

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
  bool isFilterMenungguRespons = false;
  bool isFilterSedangDiproses = false;
  bool isFilterTelahDikonfirmasi = false;
  bool isFilterDibatalkan = false;
  bool LoadingKomponenFilterMenungguRespons = true;
  bool LoadingKomponenFilterSedangDiproses = true;
  bool LoadingKomponenFilterDibatalkan = true;
  bool LoadingKomponenFilterTelahDikonfirmasi = true;

  List kodeSuratFilterMenungguRespons = List();
  List kodeSuratFilterSedangDiproses = List();
  List kodeSuratFilterTelahDikonfirmasi = List();
  List kodeSuratFilterDibatalkan = List();
  List timKegiatanFilterMenungguRespons = List();
  List timKegiatanFilterSedangDiproses = List();
  List timKegiatanFilterTelahDikonfirmasi = List();
  List timKegiatanFilterDibatalkan = List();

  var selectedKodeSuratFilterMenungguRespons;
  var selectedKodeSuratFilterSedangDiproses;
  var selectedKodeSuratFilterDibatalkan;
  var selectedKodeSuratFilterTelahDikonfirmasi;
  var selectedTimKegiatanFilterMenungguRespons;
  var selectedTimKegiatanFilterSedangDiproses;
  var selectedTimKegiatanFilterDibatalkan;
  var selectedTimKegiatanFilterTelahDikonfirmasi;

  //filter tanggal keluar menunggu respons
  var selectedFilterTanggalMenungguRespons;
  String selectedRangeAwalMenungguRespons;
  String selectedRangeAwalValueMenungguRespons;
  String selectedRangeAkhirMenungguRespons;
  String selectedRangeAkhirValueMenungguRespons;
  DateTime rangeAwalMenungguRespons;
  DateTime rangeAkhirMenungguRespons;

  //filter tanggal keluar sedang diproses
  var selectedFilterTanggalSedangDiproses;
  String selectedRangeAwalSedangDiproses;
  String selectedRangeAwalValueSedangDiproses;
  String selectedRangeAkhirSedangDiproses;
  String selectedRangeAkhirValueSedangDiproses;
  DateTime rangeAwalSedangDiproses;
  DateTime rangeAkhirSedangDiproses;

  //filter tanggal keluar telah dikonfirmasi
  var selectedFilterTanggalTelahDikonfirmasi;
  String selectedRangeAwalTelahDikonfirmasi;
  String selectedRangeAwalValueTelahDikonfirmasi;
  String selectedRangeAkhirTelahDikonfirmasi;
  String selectedRangeAkhirValueTelahDikonfirmasi;
  DateTime rangeAwalTelahDikonfirmasi;
  DateTime rangeAkhirTelahDikonfirmasi;

  //filter tanggal keluar dibatalkan
  var selectedFilterTanggalDibatalkan;
  String selectedRangeAwalDibatalkan;
  String selectedRangeAwalValueDibatalkan;
  String selectedRangeAkhirDibatalkan;
  String selectedRangeAkhirValueDibatalkan;
  DateTime rangeAwalDibatalkan;
  DateTime rangeAkhirDibatalkan;

  //search
  final controllerSearchMenungguRespons = TextEditingController();
  final controllerSearchSedangDiproses = TextEditingController();
  final controllerSearchTelahDikonfirmasi = TextEditingController();
  final controllerSearchDibatalkan = TextEditingController();

  Future getFilterResultMenungguRespons() async {
    setState(() {
      LoadingMenungguRespons = true;
      isFilterMenungguRespons = true;
    });
    var body = jsonEncode({
      "tanggal_awal" : selectedRangeAwalValueMenungguRespons == null ? null : selectedRangeAwalValueMenungguRespons,
      "tanggal_akhir" : selectedRangeAkhirValueMenungguRespons == null ? selectedRangeAwalValueMenungguRespons == null ? null : selectedRangeAwalValueMenungguRespons : selectedRangeAkhirValueMenungguRespons,
      "search_query" : controllerSearchMenungguRespons.text == "" ? null : controllerSearchMenungguRespons.text,
      "status" : "Menunggu Respon",
      "kode_surat_filter" : selectedKodeSuratFilterMenungguRespons == null ? null : selectedKodeSuratFilterMenungguRespons,
      "krama_mipil_id" : loginPage.kramaId,
      "tim_kegiatan_filter" : selectedTimKegiatanFilterMenungguRespons == null ? null : selectedTimKegiatanFilterMenungguRespons
    });
    http.post(Uri.parse(apiURLShowFilterResultPanitia),
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
        setState(() {
          LoadingMenungguRespons = false;
          availableMenungguRespons = false;
        });
      }
    });
  }

  Future getFilterResultSedangDiproses() async {
    setState(() {
      LoadingSedangDiproses = true;
      isFilterSedangDiproses = true;
    });
    var body = jsonEncode({
      "tanggal_awal" : selectedRangeAwalValueSedangDiproses == null ? null : selectedRangeAwalValueSedangDiproses,
      "tanggal_akhir" : selectedRangeAkhirValueSedangDiproses == null ? selectedRangeAwalValueSedangDiproses == null ? null : selectedRangeAwalValueSedangDiproses : selectedRangeAkhirValueSedangDiproses,
      "search_query" : controllerSearchSedangDiproses.text == "" ? null : controllerSearchSedangDiproses.text,
      "status" : "Sedang Diproses",
      "kode_surat_filter" : selectedKodeSuratFilterSedangDiproses == null ? null : selectedKodeSuratFilterSedangDiproses,
      "krama_mipil_id" : loginPage.kramaId,
      "tim_kegiatan_filter" : selectedTimKegiatanFilterSedangDiproses == null ? null : selectedTimKegiatanFilterSedangDiproses
    });
    http.post(Uri.parse(apiURLShowFilterResultPanitia),
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

  Future getFilterResultTelahDikonfirmasi() async {
    setState(() {
      LoadingTelahDikonfirmasi = true;
      isFilterTelahDikonfirmasi = true;
    });
    var body = jsonEncode({
      "tanggal_awal" : selectedRangeAwalValueTelahDikonfirmasi == null ? null : selectedRangeAwalValueTelahDikonfirmasi,
      "tanggal_akhir" : selectedRangeAkhirValueTelahDikonfirmasi == null ? selectedRangeAwalValueTelahDikonfirmasi == null ? null : selectedRangeAwalValueTelahDikonfirmasi : selectedRangeAkhirValueTelahDikonfirmasi,
      "search_query" : controllerSearchTelahDikonfirmasi.text == "" ? null : controllerSearchTelahDikonfirmasi.text,
      "status" : "Telah Dikonfirmasi",
      "kode_surat_filter" : selectedKodeSuratFilterTelahDikonfirmasi == null ? null : selectedKodeSuratFilterTelahDikonfirmasi,
      "krama_mipil_id" : loginPage.kramaId,
      "tim_kegiatan_filter" : selectedTimKegiatanFilterTelahDikonfirmasi == null ? null : selectedTimKegiatanFilterTelahDikonfirmasi
    });
    http.post(Uri.parse(apiURLShowFilterResultPanitia),
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

  Future getFilterResultDibatalkan() async {
    setState(() {
      LoadingDibatalkan = true;
      isFilterDibatalkan = true;
    });
    var body = jsonEncode({
      "tanggal_awal" : selectedRangeAwalValueDibatalkan == null ? null : selectedRangeAwalValueDibatalkan,
      "tanggal_akhir" : selectedRangeAkhirValueDibatalkan == null ? selectedRangeAwalValueDibatalkan == null ? null : selectedRangeAwalValueDibatalkan : selectedRangeAkhirValueDibatalkan,
      "search_query" : controllerSearchDibatalkan.text == "" ? null : controllerSearchDibatalkan.text,
      "status" : "Dibatalkan",
      "kode_surat_filter" : selectedKodeSuratFilterDibatalkan == null ? null : selectedKodeSuratFilterDibatalkan,
      "krama_mipil_id" : loginPage.kramaId,
      "tim_kegiatan_filter" : selectedTimKegiatanFilterDibatalkan == null ? null : selectedTimKegiatanFilterDibatalkan
    });
    http.post(Uri.parse(apiURLShowFilterResultPanitia),
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
    getFilterKomponenMenungguRespons();
    getFilterKomponenDibatalkan();
    getFilterKomponenTelahDikonfirmasi();
    getFilterKomponenSedangDiproses();
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
                                getFilterResultMenungguRespons();
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
                    child: LoadingKomponenFilterMenungguRespons ? ListTileShimmer() : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: <Widget>[
                          GestureDetector(
                            onTap: (){
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                        title: Text("Pilih Tanggal", style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: HexColor("025393")
                                        )),
                                        content: Container(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Container(
                                                height: 250,
                                                width: 250,
                                                child: SfDateRangePicker(
                                                  controller: controllerFilterTanggalMenungguRespon,
                                                  selectionMode: DateRangePickerSelectionMode.range,
                                                  onSelectionChanged: selectionChangedMenungguRespons,
                                                  allowViewNavigation: true,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            child: Text("OK", style: TextStyle(
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w700,
                                                color: HexColor("025393")
                                            )),
                                            onPressed: (){
                                              Navigator.of(context).pop();
                                            },
                                          )
                                        ]
                                    );
                                  }
                              );
                            },
                            child: Container(
                              width: 150,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(width: 1, color: Colors.black38)
                              ),
                              child: Center(
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Text(selectedFilterTanggalMenungguRespons == null ? "Semua Tanggal Keluar" : selectedFilterTanggalMenungguRespons, style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 14,
                                    color: selectedFilterTanggalMenungguRespons == null ? Colors.black54 : Colors.black
                                  ), maxLines: 1, softWrap: false, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center),
                                ),
                              ),
                              margin: EdgeInsets.symmetric(horizontal: 5),
                            ),
                          ),
                          Container(
                            width: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(width: 1, color: Colors.black38)
                            ),
                            child: DropdownButton(
                              isExpanded: true,
                              hint: Center(
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Text("Semua Kode Surat", style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 14
                                  ), maxLines: 1, softWrap: false, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center),
                                )
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
                              },
                            ),
                            margin: EdgeInsets.symmetric(horizontal: 5),
                          ),
                          Container(
                            width: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(width: 1, color: Colors.black38)
                            ),
                            child: DropdownButton(
                              isExpanded: true,
                              hint: Center(
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Text("Semua Tim Kegiatan", style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 14
                                    ), maxLines: 1, softWrap: false, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center),
                                  )
                              ),
                              value: selectedTimKegiatanFilterMenungguRespons,
                              underline: Container(),
                              items: timKegiatanFilterMenungguRespons.map((e) {
                                return DropdownMenuItem(
                                  value: e['tim_kegiatan'],
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Text("${e['tim_kegiatan']}", style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 14
                                    ), maxLines: 1, overflow: TextOverflow.ellipsis, softWrap: false),
                                  ),
                                );
                              }).toList(),
                              selectedItemBuilder: (BuildContext context) => timKegiatanFilterMenungguRespons.map((e) => Center(
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Text(e['tim_kegiatan'], style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 14
                                  )),
                                ),
                              )).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedTimKegiatanFilterMenungguRespons = value;
                                });
                              },
                            ),
                            margin: EdgeInsets.symmetric(horizontal: 5),
                          )
                        ],
                      ),
                    ),
                    margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                  ),
                  Container(
                    child: Column(
                      children: <Widget>[
                        if(isFilterMenungguRespons == true) Container(
                          child: FlatButton(
                            onPressed: (){
                              setState(() {
                                selectedTimKegiatanFilterMenungguRespons = null;
                                selectedKodeSuratFilterMenungguRespons = null;
                                selectedFilterTanggalMenungguRespons = null;
                                selectedRangeAwalMenungguRespons = null;
                                selectedRangeAkhirMenungguRespons = null;
                                selectedRangeAwalValueMenungguRespons = null;
                                selectedRangeAkhirValueMenungguRespons = null;
                                controllerSearchMenungguRespons.text = "";
                                isFilterMenungguRespons = false;
                                LoadingMenungguRespons = true;
                              });
                              refreshListMenungguRespons();
                            },
                            child: Text("Hapus Filter", style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.white
                            )),
                            color: HexColor("025393"),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                                side: BorderSide(color: HexColor("025393"), width: 2)
                            ),
                          ),
                          margin: EdgeInsets.symmetric(horizontal: 5),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: LoadingMenungguRespons ? ListTileShimmer() : availableMenungguRespons ? Expanded(
                      flex: 1,
                        child: RefreshIndicator(
                          onRefresh: isFilterMenungguRespons ? getFilterResultMenungguRespons : refreshListMenungguRespons,
                          child: ListView.builder(
                            itemCount: MenungguRespons.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: (){
                                  setState(() {
                                    detailSuratKeluarPanitia.isTetujon = false;
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
                          suffixIcon: IconButton(
                            icon: Icon(Icons.search),
                            onPressed: (){
                              if(controllerSearchSedangDiproses.text != "") {
                                setState(() {
                                  isFilterSedangDiproses = true;
                                });
                                getFilterResultSedangDiproses();
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
                    child: LoadingKomponenFilterSedangDiproses ? ListTileShimmer() : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: <Widget>[
                          GestureDetector(
                            onTap: (){
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                        title: Text("Pilih Tanggal", style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: HexColor("025393")
                                        )),
                                        content: Container(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Container(
                                                height: 250,
                                                width: 250,
                                                child: SfDateRangePicker(
                                                  controller: controllerFilterTanggalSedangDiproses,
                                                  selectionMode: DateRangePickerSelectionMode.range,
                                                  onSelectionChanged: selectionChangedSedangDiproses,
                                                  allowViewNavigation: true,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            child: Text("OK", style: TextStyle(
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w700,
                                                color: HexColor("025393")
                                            )),
                                            onPressed: (){
                                              Navigator.of(context).pop();
                                            },
                                          )
                                        ]
                                    );
                                  }
                              );
                            },
                            child: Container(
                              width: 150,
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(width: 1, color: Colors.black38)
                              ),
                              child: Center(
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Text(selectedFilterTanggalSedangDiproses== null ? "Semua Tanggal Keluar" : selectedFilterTanggalSedangDiproses, style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 14,
                                      color: selectedFilterTanggalSedangDiproses == null ? Colors.black54 : Colors.black
                                  ), maxLines: 1, softWrap: false, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center),
                                ),
                              ),
                              margin: EdgeInsets.symmetric(horizontal: 5),
                            ),
                          ),
                          Container(
                            width: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(width: 1, color: Colors.black38)
                            ),
                            child: DropdownButton(
                              isExpanded: true,
                              hint: Center(
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Text("Semua Kode Surat", style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 14
                                    ), maxLines: 1, softWrap: false, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center),
                                  )
                              ),
                              value: selectedKodeSuratFilterSedangDiproses,
                              underline: Container(),
                              items: kodeSuratFilterSedangDiproses.map((e) {
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
                              selectedItemBuilder: (BuildContext context) => kodeSuratFilterSedangDiproses.map((e) => Center(
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
                                  selectedKodeSuratFilterSedangDiproses = value;
                                });
                                getFilterResultSedangDiproses();
                              },
                            ),
                            margin: EdgeInsets.symmetric(horizontal: 5),
                          ),
                          Container(
                            width: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(width: 1, color: Colors.black38)
                            ),
                            child: DropdownButton(
                              isExpanded: true,
                              hint: Center(
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Text("Semua Tim Kegiatan", style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 14
                                    ), maxLines: 1, softWrap: false, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center),
                                  )
                              ),
                              value: selectedTimKegiatanFilterSedangDiproses,
                              underline: Container(),
                              items: timKegiatanFilterSedangDiproses.map((e) {
                                return DropdownMenuItem(
                                  value: e['tim_kegiatan'],
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Text("${e['tim_kegiatan']}", style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 14
                                    ), maxLines: 1, overflow: TextOverflow.ellipsis, softWrap: false),
                                  ),
                                );
                              }).toList(),
                              selectedItemBuilder: (BuildContext context) => timKegiatanFilterSedangDiproses.map((e) => Center(
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Text(e['tim_kegiatan'], style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 14
                                  )),
                                ),
                              )).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedTimKegiatanFilterSedangDiproses = value;
                                });
                                getFilterResultSedangDiproses();
                              },
                            ),
                            margin: EdgeInsets.symmetric(horizontal: 5),
                          )
                        ],
                      ),
                    ),
                    margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                  ),
                  Container(
                    child: Column(
                      children: <Widget>[
                        if(isFilterSedangDiproses == true) Container(
                          child: FlatButton(
                            onPressed: (){
                              setState(() {
                                selectedTimKegiatanFilterSedangDiproses = null;
                                selectedKodeSuratFilterSedangDiproses = null;
                                selectedFilterTanggalSedangDiproses = null;
                                selectedRangeAwalSedangDiproses = null;
                                selectedRangeAkhirSedangDiproses = null;
                                selectedRangeAwalValueSedangDiproses = null;
                                selectedRangeAkhirValueSedangDiproses = null;
                                controllerSearchSedangDiproses.text = "";
                                isFilterSedangDiproses = false;
                                LoadingSedangDiproses = true;
                              });
                              refreshListSedangDiproses();
                            },
                            child: Text("Hapus Filter", style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.white
                            )),
                            color: HexColor("025393"),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                                side: BorderSide(color: HexColor("025393"), width: 2)
                            ),
                          ),
                          margin: EdgeInsets.symmetric(horizontal: 5),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: LoadingSedangDiproses ? ListTileShimmer() : availableSedangDiproses ? Expanded(
                      flex: 1,
                        child: RefreshIndicator(
                          onRefresh: isFilterSedangDiproses ? getFilterResultSedangDiproses : refreshListSedangDiproses,
                          child: ListView.builder(
                            itemCount: SedangDiproses.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: (){
                                  setState(() {
                                    detailSuratKeluarPanitia.isTetujon = false;
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
                      controller: controllerSearchTelahDikonfirmasi,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              borderSide: BorderSide(color: HexColor("#025393"))
                          ),
                          hintText: "Cari surat keluar...",
                          suffixIcon: IconButton(
                            icon: Icon(Icons.search),
                            onPressed: (){
                              if(controllerSearchTelahDikonfirmasi.text != '') {
                                setState(() {
                                  isFilterTelahDikonfirmasi = true;
                                });
                                getFilterResultTelahDikonfirmasi();
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
                    child: LoadingKomponenFilterTelahDikonfirmasi ? ListTileShimmer() : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: <Widget>[
                          GestureDetector(
                            onTap: (){
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                        title: Text("Pilih Tanggal", style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: HexColor("025393")
                                        )),
                                        content: Container(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Container(
                                                height: 250,
                                                width: 250,
                                                child: SfDateRangePicker(
                                                  controller: controllerFilterTanggalTelahDikonfirmasi,
                                                  selectionMode: DateRangePickerSelectionMode.range,
                                                  onSelectionChanged: selectionChangedTelahDikonfirmasi,
                                                  allowViewNavigation: true,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            child: Text("OK", style: TextStyle(
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w700,
                                                color: HexColor("025393")
                                            )),
                                            onPressed: (){
                                              Navigator.of(context).pop();
                                            },
                                          )
                                        ]
                                    );
                                  }
                              );
                            },
                            child: Container(
                              width: 150,
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(width: 1, color: Colors.black38)
                              ),
                              child: Center(
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Text(selectedFilterTanggalTelahDikonfirmasi == null ? "Semua Tanggal Keluar" : selectedFilterTanggalTelahDikonfirmasi, style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 14,
                                      color: selectedFilterTanggalTelahDikonfirmasi == null ? Colors.black54 : Colors.black
                                  ), maxLines: 1, softWrap: false, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center),
                                ),
                              ),
                              margin: EdgeInsets.symmetric(horizontal: 5),
                            ),
                          ),
                          Container(
                            width: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(width: 1, color: Colors.black38)
                            ),
                            child: DropdownButton(
                              isExpanded: true,
                              hint: Center(
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Text("Semua Kode Surat", style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 14
                                    ), maxLines: 1, softWrap: false, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center),
                                  )
                              ),
                              value: selectedKodeSuratFilterTelahDikonfirmasi,
                              underline: Container(),
                              items: kodeSuratFilterTelahDikonfirmasi.map((e) {
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
                              selectedItemBuilder: (BuildContext context) => kodeSuratFilterTelahDikonfirmasi.map((e) => Center(
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
                                  selectedKodeSuratFilterTelahDikonfirmasi = value;
                                });
                                getFilterResultTelahDikonfirmasi();
                              },
                            ),
                            margin: EdgeInsets.symmetric(horizontal: 5),
                          ),
                          Container(
                            width: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(width: 1, color: Colors.black38)
                            ),
                            child: DropdownButton(
                              isExpanded: true,
                              hint: Center(
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Text("Semua Tim Kegiatan", style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 14
                                    ), maxLines: 1, softWrap: false, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center),
                                  )
                              ),
                              value: selectedTimKegiatanFilterTelahDikonfirmasi,
                              underline: Container(),
                              items: timKegiatanFilterTelahDikonfirmasi.map((e) {
                                return DropdownMenuItem(
                                  value: e['tim_kegiatan'],
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Text("${e['tim_kegiatan']}", style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 14
                                    ), maxLines: 1, overflow: TextOverflow.ellipsis, softWrap: false),
                                  ),
                                );
                              }).toList(),
                              selectedItemBuilder: (BuildContext context) => timKegiatanFilterTelahDikonfirmasi.map((e) => Center(
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Text(e['tim_kegiatan'], style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 14
                                  )),
                                ),
                              )).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedTimKegiatanFilterTelahDikonfirmasi = value;
                                });
                                getFilterResultTelahDikonfirmasi();
                              },
                            ),
                            margin: EdgeInsets.symmetric(horizontal: 5),
                          )
                        ],
                      ),
                    ),
                    margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                  ),
                  Container(
                    child: Column(
                      children: <Widget>[
                        if(isFilterTelahDikonfirmasi == true) Container(
                          child: FlatButton(
                            onPressed: (){
                              setState(() {
                                selectedTimKegiatanFilterTelahDikonfirmasi = null;
                                selectedKodeSuratFilterTelahDikonfirmasi = null;
                                selectedFilterTanggalTelahDikonfirmasi = null;
                                selectedRangeAwalTelahDikonfirmasi = null;
                                selectedRangeAkhirTelahDikonfirmasi = null;
                                selectedRangeAwalValueTelahDikonfirmasi = null;
                                selectedRangeAkhirValueTelahDikonfirmasi = null;
                                controllerSearchTelahDikonfirmasi.text = "";
                                isFilterTelahDikonfirmasi = false;
                                LoadingTelahDikonfirmasi = true;
                              });
                              refreshListTelahDikonfirmasi();
                            },
                            child: Text("Hapus Filter", style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.white
                            )),
                            color: HexColor("025393"),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                                side: BorderSide(color: HexColor("025393"), width: 2)
                            ),
                          ),
                          margin: EdgeInsets.symmetric(horizontal: 5),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: LoadingTelahDikonfirmasi ? ListTileShimmer() : availableTelahDikonfirmasi ? Expanded(
                      flex: 1,
                        child: RefreshIndicator(
                          onRefresh: isFilterTelahDikonfirmasi ? getFilterResultTelahDikonfirmasi :refreshListTelahDikonfirmasi,
                          child: ListView.builder(
                            itemCount: TelahDikonfirmasi.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: (){
                                  setState(() {
                                    detailSuratKeluarPanitia.isTetujon = false;
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
                      controller: controllerSearchDibatalkan,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              borderSide: BorderSide(color: HexColor("#025393"))
                          ),
                          hintText: "Cari surat keluar...",
                          suffixIcon: IconButton(
                            icon: Icon(Icons.search),
                            onPressed: (){
                              if(controllerSearchDibatalkan.text != '') {
                                setState(() {
                                  isFilterDibatalkan = true;
                                });
                                getFilterResultDibatalkan();
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
                    child: LoadingKomponenFilterDibatalkan ? ListTileShimmer() : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: <Widget>[
                          GestureDetector(
                            onTap: (){
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                        title: Text("Pilih Tanggal", style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: HexColor("025393")
                                        )),
                                        content: Container(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Container(
                                                height: 250,
                                                width: 250,
                                                child: SfDateRangePicker(
                                                  controller: controllerFilterTanggalDibatalkan,
                                                  selectionMode: DateRangePickerSelectionMode.range,
                                                  onSelectionChanged: selectionChangedDibatalkan,
                                                  allowViewNavigation: true,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            child: Text("OK", style: TextStyle(
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w700,
                                                color: HexColor("025393")
                                            )),
                                            onPressed: (){
                                              Navigator.of(context).pop();
                                            },
                                          )
                                        ]
                                    );
                                  }
                              );
                            },
                            child: Container(
                              width: 150,
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(width: 1, color: Colors.black38)
                              ),
                              child: Center(
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Text(selectedFilterTanggalDibatalkan == null ? "Semua Tanggal Keluar" : selectedFilterTanggalDibatalkan, style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 14,
                                      color: selectedFilterTanggalDibatalkan == null ? Colors.black54 : Colors.black
                                  ), maxLines: 1, softWrap: false, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center),
                                ),
                              ),
                              margin: EdgeInsets.symmetric(horizontal: 5),
                            ),
                          ),
                          Container(
                            width: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(width: 1, color: Colors.black38)
                            ),
                            child: DropdownButton(
                              isExpanded: true,
                              hint: Center(
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Text("Semua Kode Surat", style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 14
                                    ), maxLines: 1, softWrap: false, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center),
                                  )
                              ),
                              value: selectedKodeSuratFilterDibatalkan,
                              underline: Container(),
                              items: kodeSuratFilterDibatalkan.map((e) {
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
                              selectedItemBuilder: (BuildContext context) => kodeSuratFilterDibatalkan.map((e) => Center(
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
                                  selectedKodeSuratFilterDibatalkan = value;
                                });
                                getFilterResultDibatalkan();
                              },
                            ),
                            margin: EdgeInsets.symmetric(horizontal: 5),
                          ),
                          Container(
                            width: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(width: 1, color: Colors.black38)
                            ),
                            child: DropdownButton(
                              isExpanded: true,
                              hint: Center(
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Text("Semua Tim Kegiatan", style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 14
                                    ), maxLines: 1, softWrap: false, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center),
                                  )
                              ),
                              value: selectedTimKegiatanFilterDibatalkan,
                              underline: Container(),
                              items: timKegiatanFilterDibatalkan.map((e) {
                                return DropdownMenuItem(
                                  value: e['tim_kegiatan'],
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Text("${e['tim_kegiatan']}", style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 14
                                    ), maxLines: 1, overflow: TextOverflow.ellipsis, softWrap: false),
                                  ),
                                );
                              }).toList(),
                              selectedItemBuilder: (BuildContext context) => timKegiatanFilterDibatalkan.map((e) => Center(
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Text(e['tim_kegiatan'], style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 14
                                  )),
                                ),
                              )).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedTimKegiatanFilterDibatalkan = value;
                                });
                                getFilterResultDibatalkan();
                              },
                            ),
                            margin: EdgeInsets.symmetric(horizontal: 5),
                          )
                        ],
                      ),
                    ),
                    margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                  ),
                  Container(
                    child: Column(
                      children: <Widget>[
                        if(isFilterDibatalkan == true) Container(
                          child: FlatButton(
                            onPressed: (){
                              setState(() {
                                selectedTimKegiatanFilterDibatalkan = null;
                                selectedKodeSuratFilterDibatalkan = null;
                                selectedFilterTanggalDibatalkan = null;
                                selectedRangeAwalDibatalkan = null;
                                selectedRangeAkhirDibatalkan = null;
                                selectedRangeAwalValueDibatalkan= null;
                                selectedRangeAkhirValueDibatalkan = null;
                                controllerSearchDibatalkan.text = "";
                                isFilterDibatalkan = false;
                                LoadingDibatalkan = true;
                              });
                              refreshListDibatalkan();
                            },
                            child: Text("Hapus Filter", style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.white
                            )),
                            color: HexColor("025393"),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                                side: BorderSide(color: HexColor("025393"), width: 2)
                            ),
                          ),
                          margin: EdgeInsets.symmetric(horizontal: 5),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: LoadingDibatalkan ? ListTileShimmer() : availableDibatalkan ? Expanded(
                        flex: 1,
                        child: RefreshIndicator(
                          onRefresh: isFilterDibatalkan ? getFilterResultDibatalkan : refreshListDibatalkan,
                          child: ListView.builder(
                            itemCount: Dibatalkan.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: (){
                                  setState(() {
                                    detailSuratKeluarPanitia.isTetujon = false;
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

  void selectionChangedMenungguRespons(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      selectedRangeAwalMenungguRespons = DateFormat("dd-MMM-yyyy").format(args.value.startDate).toString();
      selectedRangeAwalValueMenungguRespons = DateFormat("yyyy-MM-dd").format(args.value.startDate).toString();
      selectedRangeAkhirMenungguRespons = DateFormat("dd-MMM-yyyy").format(args.value.endDate ?? args.value.startDate).toString();
      selectedRangeAkhirValueMenungguRespons = DateFormat("yyyy-MM-dd").format(args.value.endDate ?? args.value.startDate).toString();
      selectedFilterTanggalMenungguRespons = selectedRangeAkhirValueMenungguRespons == null ? "$selectedRangeAwalMenungguRespons" : "$selectedRangeAwalMenungguRespons - $selectedRangeAkhirMenungguRespons";
    });
    getFilterResultMenungguRespons();
  }

  void selectionChangedSedangDiproses(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      selectedRangeAwalSedangDiproses = DateFormat("dd-MMM-yyyy").format(args.value.startDate).toString();
      selectedRangeAwalValueSedangDiproses = DateFormat("yyyy-MM-dd").format(args.value.startDate).toString();
      selectedRangeAkhirSedangDiproses = DateFormat("dd-MMM-yyyy").format(args.value.endDate ?? args.value.startDate).toString();
      selectedRangeAkhirValueSedangDiproses = DateFormat("yyyy-MM-dd").format(args.value.endDate ?? args.value.startDate).toString();
      selectedFilterTanggalSedangDiproses = selectedRangeAkhirValueSedangDiproses == null ? "$selectedRangeAwalSedangDiproses" : "$selectedRangeAwalSedangDiproses - $selectedRangeAkhirSedangDiproses";
    });
    getFilterResultSedangDiproses();
  }

  void selectionChangedTelahDikonfirmasi(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      selectedRangeAwalTelahDikonfirmasi = DateFormat("dd-MMM-yyyy").format(args.value.startDate).toString();
      selectedRangeAwalValueTelahDikonfirmasi = DateFormat("yyyy-MM-dd").format(args.value.startDate).toString();
      selectedRangeAkhirTelahDikonfirmasi = DateFormat("dd-MMM-yyyy").format(args.value.endDate ?? args.value.startDate).toString();
      selectedRangeAkhirValueTelahDikonfirmasi = DateFormat("yyyy-MM-dd").format(args.value.endDate ?? args.value.startDate).toString();
      selectedFilterTanggalTelahDikonfirmasi = selectedRangeAkhirValueTelahDikonfirmasi == null ? "$selectedRangeAwalTelahDikonfirmasi" : "$selectedRangeAwalTelahDikonfirmasi - $selectedRangeAkhirTelahDikonfirmasi";
    });
    getFilterResultTelahDikonfirmasi();
  }

  void selectionChangedDibatalkan(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      selectedRangeAwalDibatalkan = DateFormat("dd-MMM-yyyy").format(args.value.startDate).toString();
      selectedRangeAwalValueDibatalkan = DateFormat("yyyy-MM-dd").format(args.value.startDate).toString();
      selectedRangeAkhirDibatalkan = DateFormat("dd-MMM-yyyy").format(args.value.endDate ?? args.value.startDate).toString();
      selectedRangeAkhirValueDibatalkan = DateFormat("yyyy-MM-dd").format(args.value.endDate ?? args.value.startDate).toString();
      selectedFilterTanggalDibatalkan = selectedRangeAkhirValueDibatalkan == null ? "$selectedRangeAwalDibatalkan" : "$selectedRangeAwalDibatalkan - $selectedRangeAkhirDibatalkan";
    });
    getFilterResultDibatalkan();
  }
}
