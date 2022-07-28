import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:surat/AdminDesa/ManajemenSurat/SuratKeluar/SuratKeluarNonPanitia/DetailSurat.dart';
import 'package:surat/AdminDesa/ManajemenSurat/SuratKeluar/SuratKeluarNonPanitia/DetailSuratPanitia.dart';
import 'package:surat/AdminDesa/ManajemenSurat/SuratKeluar/SuratKeluarNonPanitia/TambahSuratKeluarNonPanitia.dart';
import 'package:surat/LoginAndRegistration/LoginPage.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

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
  bool isFilterMenungguRespons = false;
  bool isFilterSedangDiproses = false;
  bool isFilterTelahDikonfirmasi = false;
  bool isFilterDibatalkan = false;
  bool LoadingKomponenFilterMenungguRespons = true;
  bool LoadingKomponenFilterSedangDiproses = true;
  bool LoadingKomponenFilterDibatalkan = true;
  bool LoadingKomponenFilterTelahDikonfirmasi = true;

  final controllerSearchMenungguRespons = TextEditingController();
  final controllerSearchSedangDiproses = TextEditingController();
  final controllerSearchTelahDikonfirmasi = TextEditingController();
  final controllerSearchDibatalkan = TextEditingController();

  //list
  List MenungguRespons = [];
  List SedangDiproses = [];
  List TelahDikonfirmasi = [];
  List Dibatalkan = [];
  List kodeSuratFilterMenungguRespons = List();
  List kodeSuratFilterSedangDiproses = List();
  List kodeSuratFilterTelahDikonfirmasi = List();
  List kodeSuratFilterDibatalkan = List();

  var selectedKodeSuratFilterMenungguRespons;
  var selectedKodeSuratFilterSedangDiproses;
  var selectedKodeSuratFilterDibatalkan;
  var selectedKodeSuratFilterTelahDikonfirmasi;

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

  final DateRangePickerController controllerFilterTanggalMenungguRespon = DateRangePickerController();
  final DateRangePickerController controllerFilterTanggalSedangDiproses = DateRangePickerController();
  final DateRangePickerController controllerFilterTanggalDibatalkan = DateRangePickerController();
  final DateRangePickerController controllerFilterTanggalTelahDikonfirmasi = DateRangePickerController();

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
      print("get filter komponen kode surat: ${responseValue.toString()}");
      if(responseValue == 200) {
        var jsonData = json.decode(response.body);
        setState(() {
          kodeSuratFilterMenungguRespons = jsonData;
          LoadingKomponenFilterMenungguRespons = false;
        });
      }
    });
  }

  Future getFilterKomponenSedangDiproses() async {
    var body = jsonEncode({
      "desa_adat_id" : loginPage.desaId.toString(),
      "status" : "Sedang Diproses"
    });
    http.post(Uri.parse(apiURLShowFilterKodeSurat),
        headers: {"Content-Type" : "application/json"},
        body: body
    ).then((http.Response response) {
      var responseValue = response.statusCode;
      print("get filter komponen kode surat: ${responseValue.toString()}");
      if(responseValue == 200) {
        var jsonData = json.decode(response.body);
        setState(() {
          kodeSuratFilterSedangDiproses = jsonData;
          LoadingKomponenFilterSedangDiproses = false;
        });
      }
    });
  }

  Future getFilterKomponenTelahDikonfirmasi() async {
    var body = jsonEncode({
      "desa_adat_id" : loginPage.desaId.toString(),
      "status" : "Telah Dikonfirmasi"
    });
    http.post(Uri.parse(apiURLShowFilterKodeSurat),
        headers: {"Content-Type" : "application/json"},
        body: body
    ).then((http.Response response) {
      var responseValue = response.statusCode;
      print("get filter komponen kode surat: ${responseValue.toString()}");
      if(responseValue == 200) {
        var jsonData = json.decode(response.body);
        setState(() {
          kodeSuratFilterTelahDikonfirmasi = jsonData;
          LoadingKomponenFilterTelahDikonfirmasi = false;
        });
      }
    });
  }

  Future getFilterKomponenDibatalkan() async {
    var body = jsonEncode({
      "desa_adat_id" : loginPage.desaId.toString(),
      "status" : "Dibatalkan"
    });
    http.post(Uri.parse(apiURLShowFilterKodeSurat),
        headers: {"Content-Type" : "application/json"},
        body: body
    ).then((http.Response response) {
      var responseValue = response.statusCode;
      print("get filter komponen kode surat: ${responseValue.toString()}");
      if(responseValue == 200) {
        var jsonData = json.decode(response.body);
        setState(() {
          kodeSuratFilterDibatalkan = jsonData;
          LoadingKomponenFilterDibatalkan = false;
        });
      }
    });
  }


  Future getFilterResultMenungguRespons() async {
    setState(() {
      LoadingMenungguRespons = true;
      isFilterMenungguRespons = true;
    });
    var body = jsonEncode({
      "tanggal_awal" : selectedRangeAwalValueMenungguRespons == null ? null : selectedRangeAwalValueMenungguRespons,
      "tanggal_akhir" : selectedRangeAkhirValueMenungguRespons == null ? selectedRangeAwalValueMenungguRespons == null ? null : selectedRangeAwalValueMenungguRespons : selectedRangeAkhirValueMenungguRespons,
      "desa_adat_id" : loginPage.desaId,
      "search_query" : controllerSearchMenungguRespons.text == "" ? null : controllerSearchMenungguRespons.text,
      "status" : "Menunggu Respon",
      "kode_surat_filter" : selectedKodeSuratFilterMenungguRespons == null ? null : selectedKodeSuratFilterMenungguRespons
    });
    http.post(Uri.parse(apiURLShowFilterResult),
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
        LoadingMenungguRespons = false;
        availableMenungguRespons = false;
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
      "desa_adat_id" : loginPage.desaId,
      "search_query" : controllerSearchSedangDiproses.text == "" ? null : controllerSearchSedangDiproses.text,
      "status" : "Sedang Diproses",
      "kode_surat_filter" : selectedKodeSuratFilterSedangDiproses == null ? null : selectedKodeSuratFilterSedangDiproses
    });
    http.post(Uri.parse(apiURLShowFilterResult),
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
      "desa_adat_id" : loginPage.desaId,
      "search_query" : controllerSearchTelahDikonfirmasi.text == "" ? null : controllerSearchTelahDikonfirmasi.text,
      "status" : "Telah Dikonfirmasi",
      "kode_surat_filter" : selectedKodeSuratFilterTelahDikonfirmasi == null ? null : selectedKodeSuratFilterTelahDikonfirmasi
    });
    http.post(Uri.parse(apiURLShowFilterResult),
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
      "desa_adat_id" : loginPage.desaId,
      "search_query" : controllerSearchDibatalkan.text == "" ? null : controllerSearchDibatalkan.text,
      "status" : "Dibatalkan",
      "kode_surat_filter" : selectedKodeSuratFilterDibatalkan == null ? null : selectedKodeSuratFilterDibatalkan
    });
    http.post(Uri.parse(apiURLShowFilterResult),
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
    getFilterKomponenSedangDiproses();
    getFilterKomponenTelahDikonfirmasi();
    getFilterKomponenDibatalkan();
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
                          margin: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
                        ),
                        Container(
                          child: LoadingKomponenFilterMenungguRespons ? ListTileShimmer() : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Flexible(
                                child: GestureDetector(
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
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Container(
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
                                      getFilterResultMenungguRespons();
                                    },
                                  ),
                                  margin: EdgeInsets.symmetric(horizontal: 5),
                                ),
                              ),
                            ],
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
                                      isFilterMenungguRespons = false;
                                      LoadingMenungguRespons = true;
                                      selectedRangeAwalValueMenungguRespons = null;
                                      selectedRangeAwalMenungguRespons = null;
                                      selectedRangeAkhirMenungguRespons = null;
                                      selectedRangeAkhirValueMenungguRespons = null;
                                      selectedKodeSuratFilterMenungguRespons = null;
                                      controllerSearchMenungguRespons.text = "";
                                      selectedFilterTanggalMenungguRespons = null;
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
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          detailSuratKeluarNonPanitia.suratKeluarId = MenungguRespons[index]['surat_keluar_id'];
                                          detailSuratKeluarNonPanitia.isTetujon = false;
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
                          child: LoadingKomponenFilterSedangDiproses ? ListTileShimmer() : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Flexible(
                                child: GestureDetector(
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
                                    height: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        border: Border.all(width: 1, color: Colors.black38)
                                    ),
                                    child: Center(
                                      child: SizedBox(
                                        width: MediaQuery.of(context).size.width,
                                        child: Text(selectedFilterTanggalSedangDiproses == null ? "Semua Tanggal Keluar" : selectedFilterTanggalSedangDiproses, style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 14,
                                            color: selectedFilterTanggalSedangDiproses == null ? Colors.black54 : Colors.black
                                        ), maxLines: 1, softWrap: false, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
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
                              ),
                            ],
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
                                      isFilterSedangDiproses = false;
                                      LoadingSedangDiproses = true;
                                      selectedRangeAwalValueSedangDiproses = null;
                                      selectedRangeAwalSedangDiproses = null;
                                      selectedRangeAkhirSedangDiproses = null;
                                      selectedRangeAkhirValueSedangDiproses = null;
                                      selectedKodeSuratFilterSedangDiproses = null;
                                      controllerSearchSedangDiproses.text = "";
                                      selectedFilterTanggalSedangDiproses = null;
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
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: (){
                                      if(SedangDiproses[index]['tim_kegiatan'] == null) {
                                        setState(() {
                                          detailSuratKeluarNonPanitia.suratKeluarId = SedangDiproses[index]['surat_keluar_id'];
                                          detailSuratKeluarNonPanitia.isTetujon = false;
                                        });
                                        Navigator.push(context, CupertinoPageRoute(builder: (context) => detailSuratKeluarNonPanitia()));
                                      }else {
                                        setState(() {
                                          detailSuratKeluarPanitiaAdmin.suratKeluarId = SedangDiproses[index]['surat_keluar_id'];
                                          detailSuratKeluarPanitiaAdmin.isTetujon = false;
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
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.search),
                                  onPressed: (){
                                    if(controllerSearchTelahDikonfirmasi.text != "") {
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
                          child: LoadingKomponenFilterTelahDikonfirmasi ? ListTileShimmer() : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Flexible(
                                child: GestureDetector(
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
                                  ),
                                ),
                              ),
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
                              ),
                            ],
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
                                      isFilterTelahDikonfirmasi = false;
                                      LoadingTelahDikonfirmasi = true;
                                      selectedRangeAwalValueTelahDikonfirmasi = null;
                                      selectedRangeAwalTelahDikonfirmasi = null;
                                      selectedRangeAkhirTelahDikonfirmasi = null;
                                      selectedRangeAkhirValueTelahDikonfirmasi = null;
                                      selectedKodeSuratFilterTelahDikonfirmasi = null;
                                      controllerSearchTelahDikonfirmasi.text = "";
                                      selectedFilterTanggalTelahDikonfirmasi = null;
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
                              onRefresh: isFilterTelahDikonfirmasi ? getFilterResultTelahDikonfirmasi : refreshListTelahDikonfirmasi,
                              child: ListView.builder(
                                itemCount: TelahDikonfirmasi.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: (){
                                      if(TelahDikonfirmasi[index]['tim_kegiatan'] == null) {
                                        setState(() {
                                          detailSuratKeluarNonPanitia.suratKeluarId = TelahDikonfirmasi[index]['surat_keluar_id'];
                                          detailSuratKeluarNonPanitia.isTetujon = false;
                                        });
                                        Navigator.push(context, CupertinoPageRoute(builder: (context) => detailSuratKeluarNonPanitia()));
                                      }else {
                                        setState(() {
                                          detailSuratKeluarPanitiaAdmin.suratKeluarId = TelahDikonfirmasi[index]['surat_keluar_id'];
                                          detailSuratKeluarPanitiaAdmin.isTetujon = false;
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
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.search),
                                  onPressed: (){
                                    if(controllerSearchDibatalkan.text != "") {
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
                          child: LoadingKomponenFilterDibatalkan ? ListTileShimmer() : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Flexible(
                                child: GestureDetector(
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
                                  ),
                                ),
                              ),
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
                              ),
                            ],
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
                                      isFilterDibatalkan = false;
                                      LoadingDibatalkan = true;
                                      selectedRangeAwalValueDibatalkan = null;
                                      selectedRangeAwalDibatalkan = null;
                                      selectedRangeAkhirDibatalkan = null;
                                      selectedRangeAkhirValueDibatalkan = null;
                                      selectedKodeSuratFilterDibatalkan = null;
                                      controllerSearchDibatalkan.text = "";
                                      selectedFilterTanggalDibatalkan = null;
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
                                        detailSuratKeluarNonPanitia.suratKeluarId = Dibatalkan[index]['surat_keluar_id'];
                                        detailSuratKeluarNonPanitia.isTetujon = false;
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