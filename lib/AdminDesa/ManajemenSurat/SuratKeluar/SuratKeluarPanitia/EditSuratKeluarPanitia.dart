import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:simple_time_range_picker/simple_time_range_picker.dart';
import 'package:surat/LoginAndRegistration/LoginPage.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:surat/shared/LoadingAnimation/loading.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';

class editSuratKeluarPanitiaAdmin extends StatefulWidget {
  static var idSuratKeluar;
  const editSuratKeluarPanitiaAdmin({Key key}) : super(key: key);

  @override
  State<editSuratKeluarPanitiaAdmin> createState() => _editSuratKeluarPanitiaAdminState();
}

class _editSuratKeluarPanitiaAdminState extends State<editSuratKeluarPanitiaAdmin> {
  var apiURLShowDataEditSuratKeluar = "http://192.168.18.10:8000/api/admin/surat/keluar/panitia/edit/${editSuratKeluarPanitiaAdmin.idSuratKeluar}";
  var apiURLShowDataNomorSuratKeluarEdit = "http://192.168.18.10:8000/api/admin/surat/keluar/panitia/edit/nomor_surat/${editSuratKeluarPanitiaAdmin.idSuratKeluar}";
  var apiURLShowKodeSurat = "http://192.168.18.10:8000/api/data/admin/surat/panitia/kode/${loginPage.desaId}";
  var apiURLShowPanitia = "http://192.168.18.10:8000/api/data/admin/surat/keluar/panitia/${editSuratKeluarPanitiaAdmin.idSuratKeluar}";
  var apiURLShowPrajuru = "http://192.168.18.10:8000/api/data/admin/surat/keluar/prajuru/${editSuratKeluarPanitiaAdmin.idSuratKeluar}";
  var apiURLGetDataBendesaAdat = "http://192.168.18.10:8000/api/data/staff/prajuru/desa_adat/bendesa/${loginPage.desaId}";
  var apiURLGetDataPenduduk = "http://192.168.18.10:8000/api/data/penduduk/desa_adat/${loginPage.desaId}";
  var apiURLSimpanEditSuratKeluar = "http://192.168.18.10:8000/api/admin/surat/keluar/panitia/edit/panitia/up";

  //loading indicator
  bool LoadingData = true;
  bool LoadingNomorSurat = true;
  bool LoadingBendesa = true;
  bool KodeSuratLoading = true;
  bool LoadingPenduduk = true;
  bool Loading = false;

  //selected
  var selectedKodeSurat;
  var selectedBendesaAdat;
  var selectedKetuaPanitia;
  var selectedSekretarisPanitia;
  File file;
  String namaFile;
  String namaFileLampiran;
  String filePath;

  //kodesurat
  var nomorUrutSurat;
  var kodeDesa;
  var bulan;
  var tahun;

  //list
  List bendesaList = List();
  List kodeSuratList = List();
  List pendudukList = List();

  //komponen surat keluar
  final controllerNomorSurat = TextEditingController();
  final controllerLepihan = TextEditingController();
  final controllerParindikan = TextEditingController();
  final controllerTetujon = TextEditingController();
  final controllerDagingSurat = TextEditingController();
  final controllerPanitiaAcara = TextEditingController();
  final controllerPemahbah = TextEditingController();
  final controllerPamuput = TextEditingController();
  final controllerTempatKegiatan = TextEditingController();
  final controllerBusanaKegiatan = TextEditingController();
  final DateRangePickerController controllerTanggalKegiatan = DateRangePickerController();
  TimeOfDay startTime;
  TimeOfDay endTime;
  String tanggalMulai;
  String tanggalMulaiValue;
  String tanggalBerakhir;
  String tanggalBerakhirValue;
  DateTime tanggalMulaiKegiatan;
  DateTime tanggalAkhirKegiatan;

  Future getDataSuratKeluar() async {
    var response  = await http.get(Uri.parse(apiURLShowDataEditSuratKeluar));
    if(response.statusCode == 200) {
      var jsonData = response.body;
      var parsedJson = json.decode(jsonData);
      setState(() {
        controllerNomorSurat.text = parsedJson['nomor_surat'];
        controllerLepihan.text = parsedJson['lepihan'].toString();
        controllerParindikan.text = parsedJson['parindikan'];
        controllerTetujon.text = parsedJson['pihak_penerima'];
        controllerPemahbah.text = parsedJson['pemahbah_surat'] == null ? "" : parsedJson['pemahbah_surat'];
        controllerDagingSurat.text = parsedJson['daging_surat'] == null ? "" : parsedJson['daging_surat'];
        controllerPamuput.text = parsedJson['pamuput_surat'] == null ? "" : parsedJson['pamuput_surat'];
        controllerPanitiaAcara.text = parsedJson['tim_kegiatan'] == null ? "" : parsedJson['tim_kegiatan'];
        controllerTempatKegiatan.text = parsedJson['tempat_kegiatan'] == null ? "" : parsedJson['tempat_kegiatan'];
        controllerBusanaKegiatan.text = parsedJson['busana'] == null ? "" : parsedJson['busana'];
        selectedKodeSurat = parsedJson['kode_nomor_surat'];
        tanggalMulaiKegiatan = parsedJson['tanggal_mulai'];
        tanggalAkhirKegiatan = parsedJson['tanggal_selesai'];
        startTime = parsedJson['waktu_mulai'];
        endTime = parsedJson['waktu_selesai'];
        LoadingData = false;
      });
    }
  }

  Future getListPenduduk() async {
    Uri uri = Uri.parse(apiURLGetDataPenduduk);
    final response = await http.get(uri);
    if(response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        pendudukList = jsonData;
        LoadingPenduduk = false;
      });
    }
  }

  Future pilihBerkas() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        allowMultiple: false
    );
    if(result != null) {
      setState(() {
        filePath = result.files.first.path;
        namaFile = result.files.first.name;
        file = File(result.files.single.path);
      });
      print(filePath);
      print(namaFile);
    }
  }

  getKetuaPanitiaInfo() async {
    var body = jsonEncode({
      "jabatan" : "Ketua Panitia"
    });
    http.post(Uri.parse(apiURLShowPanitia),
        headers: {"Content-Type" : "application/json"},
        body: body
    ).then((http.Response response) {
      if(response.statusCode == 200) {
        var jsonData = response.body;
        var parsedJson = json.decode(jsonData);
        setState(() {
          selectedKetuaPanitia = parsedJson['krama_mipil_id'];
          LoadingPenduduk = false;
        });
      }
    });
  }

  getSekretarisPanitiaInfo() async {
    var body = jsonEncode({
      "jabatan" : "Sekretaris Panitia"
    });
    http.post(Uri.parse(apiURLShowPanitia),
        headers: {"Content-Type" : "application/json"},
        body: body
    ).then((http.Response response) {
      if(response.statusCode == 200) {
        var jsonData = response.body;
        var parsedJson = json.decode(jsonData);
        setState(() {
          selectedSekretarisPanitia = parsedJson['krama_mipil_id'];
          LoadingPenduduk = false;
        });
      }
    });
  }

  getBendesaInfo() async {
    var body = jsonEncode({
      "jabatan" : "Bendesa"
    });
    http.post(Uri.parse(apiURLShowPrajuru),
        headers: {"Content-Type" : "application/json"},
        body: body
    ).then((http.Response response) {
      if(response.statusCode == 200) {
        var jsonData = response.body;
        var parsedJson = json.decode(jsonData);
        setState(() {
          selectedBendesaAdat = parsedJson['prajuru_desa_adat_id'];
        });
      }
    });
  }

  Future getKodeSurat() async {
    var response = await http.get(Uri.parse(apiURLShowKodeSurat));
    if(response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        kodeSuratList = jsonData;
        KodeSuratLoading = false;
      });
    }
  }

  Future getKomponenNomorSurat() async {
    var body = jsonEncode({
      "desa_adat_id" : loginPage.desaId
    });
    http.post(Uri.parse(apiURLShowDataNomorSuratKeluarEdit),
      headers: {"Content-Type" : "application/json"},
      body: body
    ).then((http.Response response) {
      if(response.statusCode == 200) {
        var jsonData = response.body;
        var parsedJson = json.decode(jsonData);
        setState(() {
          nomorUrutSurat = parsedJson['nomor_urut_surat'];
          kodeDesa = parsedJson['kode_desa'];
          bulan = parsedJson['bulan'];
          tahun = parsedJson['tahun'];
          LoadingNomorSurat = false;
        });
      }
    });
  }

  Future getBendesaAdat() async {
    var response = await http.get(Uri.parse(apiURLGetDataBendesaAdat));
    if(response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        bendesaList = jsonData;
        LoadingBendesa = false;
      });
    }
  }

  void selectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      tanggalMulai = DateFormat("dd-MMM-yyyy").format(args.value.startDate).toString();
      tanggalMulaiValue = DateFormat("yyyy-MM-dd").format(args.value.startDate).toString();
      tanggalBerakhir = DateFormat("dd-MMM-yyyy").format(args.value.endDate ?? args.value.startDate).toString();
      tanggalBerakhirValue = DateFormat("yyyy-MM-dd").format(args.value.endDate ?? args.value.startDate).toString();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataSuratKeluar();
    getKomponenNomorSurat();
    getKodeSurat();
    getKetuaPanitiaInfo();
    getSekretarisPanitiaInfo();
    getBendesaInfo();
    getBendesaAdat();
    getListPenduduk();
    final DateTime sekarang = DateTime.now();
    tanggalMulai = DateFormat("dd-MMM-yyyy").format(tanggalMulaiKegiatan == null ? sekarang : tanggalMulaiKegiatan).toString();
    tanggalBerakhir = DateFormat("dd-MMM-yyyy").format(tanggalAkhirKegiatan == null ? sekarang.add(Duration(days: 7)) : tanggalAkhirKegiatan).toString();
    controllerTanggalKegiatan.selectedRange = PickerDateRange(sekarang, sekarang.add(Duration(days: 7)));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Loading ? loading() : Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: HexColor("#025393"),
            onPressed: (){
              Navigator.of(context).pop();
            },
          ),
          title: Text("Edit Surat", style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w700,
            color: HexColor("#025393")
          ))
        ),
        body: LoadingData ? ProfilePageShimmer() : SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: Image.asset(
                  'images/panitia.png',
                  height: 100,
                  width: 100
                ),
                margin: EdgeInsets.only(top: 30)
              ),
              Container(
                  child: Text("* = diperlukan", style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 14,
                      fontWeight: FontWeight.w700
                  ), textAlign: TextAlign.center),
                  margin: EdgeInsets.only(top: 20, left: 20)
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text("1. Kode Surat *", style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14,
                  fontWeight: FontWeight.w700
                )),
                margin: EdgeInsets.only(top: 30, left: 20)
              ),
              Container(
                  child: KodeSuratLoading ? ListTileShimmer() : Container(
                      width: 300,
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      decoration: BoxDecoration(
                          color: HexColor("#025393"),
                          borderRadius: BorderRadius.circular(30)
                      ),
                      child: DropdownButton(
                        isExpanded: true,
                        hint: Center(
                            child: Text("Pilih Kode Surat", style: TextStyle(
                                fontFamily: "Poppins",
                                color: Colors.white,
                                fontSize: 14
                            ))
                        ),
                        value: selectedKodeSurat,
                        underline: Container(),
                        icon: Icon(Icons.arrow_downward, color: Colors.white),
                        items: kodeSuratList.map((kodeSurat) {
                          return DropdownMenuItem(
                              value: kodeSurat['kode_nomor_surat'],
                              child: Text("${kodeSurat['kode_nomor_surat']} - ${kodeSurat['keterangan']}", style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14
                              ))
                          );
                        }).toList(),
                        selectedItemBuilder: (BuildContext context) => kodeSuratList.map((kodeSurat) => Center(
                            child: Text("${kodeSurat['kode_nomor_surat']}", style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14,
                                color: Colors.white
                            ))
                        )).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedKodeSurat = value;
                            controllerNomorSurat.text = "$nomorUrutSurat/$selectedKodeSurat-$kodeDesa/$bulan/$tahun";
                          });
                        },
                      ),
                      margin: EdgeInsets.only(top: 15)
                  )
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text("2. Atribut Surat", style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14,
                  fontWeight: FontWeight.w700
                )),
                margin: EdgeInsets.only(top: 30, left: 20)
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text("Nomor Surat *", style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14
                      )),
                      margin: EdgeInsets.only(top: 20, left: 20)
                    ),
                    Container(
                      child: LoadingNomorSurat ? ListTileShimmer() : Padding(
                        padding: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                        child: TextField(
                          controller: controllerNomorSurat,
                          enabled: false,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              borderSide: BorderSide(color: HexColor("#025393"))
                            ),
                          ),
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14
                          ),
                        )
                      ),
                      margin: EdgeInsets.only(top: 10)
                    ),
                    Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                                alignment: Alignment.topLeft,
                                child: Text("Lepihan (Lampiran) *", style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 14
                                )),
                                margin: EdgeInsets.only(top: 20, left: 20)
                            ),
                            Container(
                                child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                                    child: TextField(
                                      controller: controllerLepihan,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(50.0),
                                            borderSide: BorderSide(color: HexColor("#025393"))
                                        ),
                                        hintText: "Lepihan",
                                      ),
                                      keyboardType: TextInputType.number,
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 14
                                      ),
                                    )
                                ),
                                margin: EdgeInsets.only(top: 10)
                            )
                          ],
                        )
                    ),
                    Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                                alignment: Alignment.topLeft,
                                child: Text("Parindikan *", style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 14
                                )),
                                margin: EdgeInsets.only(top: 20, left: 20)
                            ),
                            Container(
                                child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                                    child: TextField(
                                      controller: controllerParindikan,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(50.0),
                                            borderSide: BorderSide(color: HexColor("#025393"))
                                        ),
                                        hintText: "Parindikan",
                                      ),
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 14
                                      ),
                                    )
                                ),
                                margin: EdgeInsets.only(top: 10)
                            )
                          ],
                        )
                    ),
                    Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                                alignment: Alignment.topLeft,
                                child: Text("Tetujon (tujuan) *", style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 14
                                )),
                                margin: EdgeInsets.only(top: 20, left: 20)
                            ),
                            Container(
                                child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                                    child: TextField(
                                      controller: controllerTetujon,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(50.0),
                                            borderSide: BorderSide(color: HexColor("#025393"))
                                        ),
                                        hintText: "Tetujon",
                                      ),
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 14
                                      ),
                                    )
                                ),
                                margin: EdgeInsets.only(top: 10)
                            )
                          ],
                        )
                    ),
                    Container(
                      child: Text("2. Daging Surat *", style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14,
                        fontWeight: FontWeight.w700
                      )),
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(top: 30, left: 20)
                    ),
                    Container(
                        child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                            child: TextField(
                              controller: controllerPemahbah,
                              maxLines: 5,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide(color: HexColor("#025393"))
                                  ),
                                  hintText: "Pemahbah (Pendahuluan)"
                              ),
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14
                              ),
                            )
                        ),
                        margin: EdgeInsets.only(top: 15)
                    ),
                    Container(
                        child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                            child: TextField(
                              controller: controllerDagingSurat,
                              maxLines: 20,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide(color: HexColor("#025393"))
                                  ),
                                  hintText: "Daging (Isi)"
                              ),
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14
                              ),
                            )
                        ),
                        margin: EdgeInsets.only(top: 15)
                    ),
                    Container(
                        child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                            child: TextField(
                              controller: controllerPamuput,
                              maxLines: 5,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide(color: HexColor("#025393"))
                                  ),
                                  hintText: "Pamuput (Penutup)"
                              ),
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14
                              ),
                            )
                        ),
                        margin: EdgeInsets.only(top: 15)
                    ),
                    Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text("Tempat Kegiatan", style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14
                              )),
                              margin: EdgeInsets.only(top: 20, left: 20),
                            ),
                            Container(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                                child: TextField(
                                  controller: controllerTempatKegiatan,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(50.0),
                                          borderSide: BorderSide(color: HexColor("#025393"))
                                      ),
                                      hintText: "Tempat Kegiatan"
                                  ),
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 14
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text("Tanggal Kegiatan", style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 14
                            )),
                            margin: EdgeInsets.only(top: 20, left: 20)
                          ),
                          Container(
                            child: Text(tanggalMulaiValue == null ? "Tanggal kegiatan belum terpilih" : tanggalBerakhirValue == null ? "$tanggalMulai - $tanggalMulai" : "$tanggalMulai - $tanggalBerakhir", style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 14,
                              fontWeight: FontWeight.w700
                            )),
                            margin: EdgeInsets.only(top: 20, left: 20)
                          ),
                          Container(
                              child: Card(
                                  margin: EdgeInsets.fromLTRB(50, 40, 50, 10),
                                  child: SfDateRangePicker(
                                    controller: controllerTanggalKegiatan,
                                    selectionMode: DateRangePickerSelectionMode.range,
                                    onSelectionChanged: selectionChanged,
                                    allowViewNavigation: false,
                                  )
                              )
                          )
                        ]
                      )
                    ),
                    Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text("Waktu Kegiatan", style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14
                              )),
                              margin: EdgeInsets.only(top: 20, left: 20),
                            ),
                            Container(
                              child: Text(startTime == null ? "--:--" : endTime == null ? "${startTime.hour}:${startTime.minute} - ${startTime.hour}:${startTime.minute}": "${startTime.hour}:${startTime.minute} - ${endTime.hour}:${endTime.minute}", style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700
                              )),
                              margin: EdgeInsets.only(top: 15),
                            ),
                            Container(
                              child: FlatButton(
                                onPressed: (){
                                  TimeRangePicker.show(
                                      context: context,
                                      unSelectedEmpty: true,
                                      headerDefaultStartLabel: "Waktu Mulai",
                                      headerDefaultEndLabel: "Waktu Selesai",
                                      onSubmitted: (TimeRangeValue value) {
                                        setState(() {
                                          startTime = value.startTime;
                                          endTime = value.endTime;
                                        });
                                      }
                                  );
                                },
                                child: Text("Pilih Waktu Kegiatan", style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white
                                )),
                                color: HexColor("#025393"),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25)
                                ),
                                padding: EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50),
                              ),
                              margin: EdgeInsets.only(top: 10),
                            )
                          ],
                        )
                    ),
                    Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text("Busana Kegiatan", style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14
                              )),
                              margin: EdgeInsets.only(top: 20, left: 20),
                            ),
                            Container(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                                child: TextField(
                                  controller: controllerBusanaKegiatan,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(50.0),
                                          borderSide: BorderSide(color: HexColor("#025393"))
                                      ),
                                      hintText: "Busana Kegiatan"
                                  ),
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 14
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                    ),
                    Container(
                        child: Column(
                            children: <Widget>[
                              Container(
                                  alignment: Alignment.topLeft,
                                  child: Text("Panitia Acara", style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 14
                                  )),
                                  margin: EdgeInsets.only(top: 20, left: 20)
                              ),
                              Container(
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                                      child: TextField(
                                        controller: controllerPanitiaAcara,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(50.0),
                                                borderSide: BorderSide(color: HexColor("#025393"))
                                            ),
                                            hintText: "Nama Panitia Acara"
                                        ),
                                        style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 14
                                        ),
                                      )
                                  )
                              )
                            ]
                        )
                    ),
                    Container(
                        child: Text("4. Lingga Tangan Miwah Pesengan", style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14,
                            fontWeight: FontWeight.w700
                        )),
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(top: 30, left: 20)
                    ),
                    Container(
                        child: Column(
                            children: <Widget>[
                              Container(
                                  alignment: Alignment.topLeft,
                                  child: Text("Sekretaris Panitia *", style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 14
                                  )),
                                  margin: EdgeInsets.only(top: 20, left: 20)
                              ),
                              Container(
                                child: LoadingPenduduk ? ListTileShimmer() : Container(
                                    width: 300,
                                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                    decoration: BoxDecoration(
                                        color: HexColor("#025393"),
                                        borderRadius: BorderRadius.circular(30)
                                    ),
                                    child: DropdownButton(
                                        isExpanded: true,
                                        hint: Center(
                                            child: Text("Pilih Sekretaris", style: TextStyle(
                                                fontFamily: "Poppins",
                                                fontSize: 14,
                                                color: Colors.white
                                            ))
                                        ),
                                        value: selectedSekretarisPanitia,
                                        underline: Container(),
                                        icon: Icon(Icons.arrow_downward, color: Colors.white),
                                        items: pendudukList.map((penduduk) {
                                          return DropdownMenuItem(
                                              value: penduduk['krama_mipil_id'],
                                              child: Text("${penduduk['nik']} - ${penduduk['nama']}", style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontSize: 14
                                              ))
                                          );
                                        }).toList(),
                                        selectedItemBuilder: (BuildContext context) => pendudukList.map((penduduk) => Center(
                                            child: Text("${penduduk['nik']} - ${penduduk['nama']}", style: TextStyle(
                                                fontFamily: "Poppins",
                                                fontSize: 14,
                                                color: Colors.white
                                            ))
                                        )).toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            selectedSekretarisPanitia = value;
                                          });
                                        }
                                    ),
                                    margin: EdgeInsets.only(top: 15)
                                )
                              )
                            ]
                        )
                    ),
                    Container(
                        child: Column(
                            children: <Widget>[
                              Container(
                                  alignment: Alignment.topLeft,
                                  child: Text("Ketua Panitia *", style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 14
                                  )),
                                  margin: EdgeInsets.only(top: 20, left: 20)
                              ),
                              Container(
                                  child: LoadingPenduduk ? ListTileShimmer() : Container(
                                      width: 300,
                                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                      decoration: BoxDecoration(
                                          color: HexColor("#025393"),
                                          borderRadius: BorderRadius.circular(30)
                                      ),
                                      child: DropdownButton(
                                          isExpanded: true,
                                          hint: Center(
                                              child: Text("Pilih Ketua", style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontSize: 14,
                                                  color: Colors.white
                                              ))
                                          ),
                                          value: selectedKetuaPanitia,
                                          underline: Container(),
                                          icon: Icon(Icons.arrow_downward, color: Colors.white),
                                          items: pendudukList.map((penduduk) {
                                            return DropdownMenuItem(
                                                value: penduduk['krama_mipil_id'],
                                                child: Text("${penduduk['nik']} - ${penduduk['nama']}", style: TextStyle(
                                                    fontFamily: "Poppins",
                                                    fontSize: 14
                                                ))
                                            );
                                          }).toList(),
                                          selectedItemBuilder: (BuildContext context) => pendudukList.map((penduduk) => Center(
                                              child: Text("${penduduk['nik']} - ${penduduk['nama']}", style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontSize: 14,
                                                  color: Colors.white
                                              ))
                                          )).toList(),
                                          onChanged: (value) {
                                            setState(() {
                                              selectedKetuaPanitia = value;
                                            });
                                          }
                                      ),
                                      margin: EdgeInsets.only(top: 15)
                                  )
                              )
                            ]
                        )
                    ),
                    Container(
                        child: Column(
                            children: <Widget>[
                              Container(
                                  alignment: Alignment.topLeft,
                                  child: Text("Bendesa *", style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 14
                                  )),
                                  margin: EdgeInsets.only(top: 20, left: 20)
                              ),
                              Container(
                                  child: LoadingPenduduk ? ListTileShimmer() : Container(
                                      width: 300,
                                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                      decoration: BoxDecoration(
                                          color: HexColor("#025393"),
                                          borderRadius: BorderRadius.circular(30)
                                      ),
                                      child: DropdownButton(
                                          isExpanded: true,
                                          hint: Center(
                                              child: Text("Pilih Bendesa Adat", style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontSize: 14,
                                                  color: Colors.white
                                              ))
                                          ),
                                          value: selectedBendesaAdat,
                                          underline: Container(),
                                          icon: Icon(Icons.arrow_downward, color: Colors.white),
                                          items: bendesaList.map((bendesa) {
                                            return DropdownMenuItem(
                                                value: bendesa['prajuru_desa_adat_id'],
                                                child: Text("${bendesa['nik']} - ${bendesa['nama']}", style: TextStyle(
                                                    fontFamily: "Poppins",
                                                    fontSize: 14
                                                ))
                                            );
                                          }).toList(),
                                          selectedItemBuilder: (BuildContext context) => bendesaList.map((bendesa) => Center(
                                              child: Text("${bendesa['nik']} - ${bendesa['nama']}", style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontSize: 14,
                                                  color: Colors.white
                                              ))
                                          )).toList(),
                                          onChanged: (value) {
                                            setState(() {
                                              selectedBendesaAdat = value;
                                            });
                                          }
                                      ),
                                      margin: EdgeInsets.only(top: 15)
                                  )
                              )
                            ]
                        )
                    ),
                    Container(
                      child: Text("5. Lepihan Surat", style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14,
                        fontWeight: FontWeight.w700
                      )),
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(top: 30, left: 20)
                    ),
                    Container(
                        child: Text("Silahkan unggah berkas lepihan (lampiran) dalam format file PDF jika Anda ingin melakukan perubahan pada file. Anda bisa kosongkan field ini jika Anda tidak ingin melakukan perubahan file.", style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14
                        )),
                        padding: EdgeInsets.only(left: 30, right: 30),
                        margin: EdgeInsets.only(top: 10)
                    ),
                    Container(
                        child: namaFileLampiran == null ? namaFile == null ? Text("Berkas lampiran belum terpilih", style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14,
                            fontWeight: FontWeight.w700
                        )) : Text("Nama berkas: ${namaFile}", style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14,
                            fontWeight: FontWeight.w700
                        )) : Text("Nama berkas: ${namaFileLampiran}", style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14,
                            fontWeight: FontWeight.w700
                        )),
                        margin: EdgeInsets.only(top: 10)
                    ),
                    Container(
                      child: FlatButton(
                          onPressed: (){
                            if(controllerLepihan.text == "") {
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
                                                        'images/alert.png',
                                                        height: 50,
                                                        width: 50,
                                                      )
                                                  ),
                                                  Container(
                                                      child: Text("Data Lepihan Belum Terisi", style: TextStyle(
                                                          fontFamily: "Poppins",
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.w700,
                                                          color: HexColor("#025393")
                                                      ), textAlign: TextAlign.center),
                                                      margin: EdgeInsets.only(top: 10)
                                                  ),
                                                  Container(
                                                      child: Text("Data lepihan belum terisi. Silahkan isi data lepihan terlebih dahulu dan coba lagi", style: TextStyle(
                                                          fontFamily: "Poppins",
                                                          fontSize: 14
                                                      ), textAlign: TextAlign.center),
                                                      margin: EdgeInsets.only(top: 10)
                                                  )
                                                ]
                                            )
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            child: Text("OK", style: TextStyle(
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w700,
                                                color: HexColor("#025393")
                                            )),
                                            onPressed: (){Navigator.of(context).pop();},
                                          )
                                        ]
                                    );
                                  }
                              );
                            }else if(controllerLepihan.text == "0" || controllerLepihan.text == "-") {
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
                                                        'images/alert.png',
                                                        height: 50,
                                                        width: 50,
                                                      )
                                                  ),
                                                  Container(
                                                      child: Text("Tidak Dapat Memilih Berkas Lepihan", style: TextStyle(
                                                          fontFamily: "Poppins",
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.w700,
                                                          color: HexColor("#025393")
                                                      ), textAlign: TextAlign.center),
                                                      margin: EdgeInsets.only(top: 10)
                                                  ),
                                                  Container(
                                                      child: Text("Tidak dapat memilih berkas lepihan karena Anda menginputkan tidak ada berkas lepihan", style: TextStyle(
                                                          fontFamily: "Poppins",
                                                          fontSize: 14
                                                      ), textAlign: TextAlign.center),
                                                      margin: EdgeInsets.only(top: 10)
                                                  )
                                                ]
                                            )
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            child: Text("OK", style: TextStyle(
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w700,
                                                color: HexColor("#025393")
                                            )),
                                            onPressed: (){Navigator.of(context).pop();},
                                          )
                                        ]
                                    );
                                  }
                              );
                            }else{
                              pilihBerkas();
                            }
                          },
                          child: Text("Unggah Berkas", style: TextStyle(
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
                          padding: EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50)
                      ),
                      margin: EdgeInsets.only(top: 20),
                    ),
                  ],
                )
              ),
              Container(
                child: FlatButton(
                  onPressed: () async {
                    if(controllerParindikan.text == "" || controllerLepihan.text == "" || controllerPemahbah.text == "" || controllerNomorSurat.text == "") {
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
                                            'images/warning.png',
                                            height: 50,
                                            width: 50,
                                          )
                                      ),
                                      Container(
                                          child: Text("Masih ada data yang kosong", style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: HexColor("#025393")
                                          ), textAlign: TextAlign.center),
                                          margin: EdgeInsets.only(top: 10)
                                      ),
                                      Container(
                                        child: Text("Masih ada data yang kosong. Silahkan lengkapi form yang telah disediakan dan coba lagi", style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 14
                                        ), textAlign: TextAlign.center),
                                        margin: EdgeInsets.only(top: 10),
                                      )
                                    ],
                                  )
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: Text("OK", style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w700,
                                      color: HexColor("#025393")
                                  )),
                                  onPressed: (){Navigator.of(context).pop();},
                                )
                              ],
                            );
                          }
                      );
                    }else if(controllerLepihan.text != "0") {
                      if(namaFile == null || namaFileLampiran == null) {
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
                                              'images/warning.png',
                                              height: 50,
                                              width: 50,
                                            )
                                        ),
                                        Container(
                                            child: Text("Berkas lepihan belum terpilih", style: TextStyle(
                                                fontFamily: "Poppins",
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                color: HexColor("#025393")
                                            ), textAlign: TextAlign.center),
                                            margin: EdgeInsets.only(top: 10)
                                        ),
                                        Container(
                                          child: Text("Berkas lepihan (lampiran) belum terpilih. Silahkan unggah berkas lepihan dan coba lagi nanti", style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 14
                                          ), textAlign: TextAlign.center),
                                          margin: EdgeInsets.only(top: 10),
                                        )
                                      ],
                                    )
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text("OK", style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w700,
                                        color: HexColor("#025393")
                                    )),
                                    onPressed: (){Navigator.of(context).pop();},
                                  )
                                ],
                              );
                            }
                        );
                      }else{
                        setState(() {
                          Loading = true;
                        });
                        var stream = http.ByteStream(DelegatingStream.typed(file.openRead()));
                        var length = await file.length();
                        var url = Uri.parse('http://192.168.18.10/siraja-api-skripsi-new/upload-file-lampiran.php');
                        var request = http.MultipartRequest("POST", url);
                        var multipartFile = http.MultipartFile("dokumen", stream, length, filename: basename(file.path));
                        request.files.add(multipartFile);
                        var response = await request.send();
                        print(response.statusCode.toString());
                        if(response.statusCode == 200) {
                          var body = jsonEncode({
                            "surat_keluar_id" : editSuratKeluarPanitiaAdmin.idSuratKeluar,
                            "desa_adat_id" : loginPage.desaId,
                            "master_surat" : selectedKodeSurat,
                            "nomor_surat" : controllerNomorSurat.text,
                            "lepihan" : controllerLepihan.text,
                            "parindikan" : controllerParindikan.text,
                            "pihak_penerima" : controllerTetujon.text,
                            "pemahbah_surat" : controllerPemahbah.text,
                            "daging_surat" : controllerDagingSurat.text == "" ? null : controllerDagingSurat.text,
                            "tanggal_mulai" : tanggalMulaiValue == null ? null : tanggalMulaiValue,
                            "tanggal_selesai" : tanggalMulaiValue == null ? null : tanggalBerakhir == null ? tanggalMulaiValue : tanggalBerakhirValue,
                            "waktu_mulai" : startTime == null ? null : "${startTime.hour}:${startTime.minute}",
                            "waktu_selesai" : startTime == null ? null : endTime == null ? "${startTime.hour}:${startTime.minute}" : "${endTime.hour}:${endTime.minute}",
                            "pamuput_surat" : controllerPamuput.text == "" ? null : controllerPamuput.text,
                            "busana" : controllerBusanaKegiatan.text == "" ? null : controllerBusanaKegiatan.text,
                            "tempat_kegiatan" : controllerTempatKegiatan.text == "" ? null : controllerTempatKegiatan.text,
                            "tim_kegiatan" : controllerPanitiaAcara.text == "" ? null : controllerPanitiaAcara.text,
                            "bendesa_adat_id" : selectedBendesaAdat,
                            "krama_mipil_ketua_id" : selectedKetuaPanitia,
                            "krama_mipil_sekretaris_id" : selectedSekretarisPanitia,
                            "lampiran" : namaFile == null ? namaFileLampiran : namaFile
                          });
                          http.post(Uri.parse(apiURLSimpanEditSuratKeluar),
                              headers: {"Content-Type" : "application/json"},
                              body: body
                          ).then((http.Response response) {
                            var responseValue = response.statusCode;
                            print(response.statusCode);
                            if(responseValue == 500) {
                              setState(() {
                                Loading = false;
                              });
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
                                                          'images/alert.png',
                                                          height: 50,
                                                          width: 50
                                                      )
                                                  ),
                                                  Container(
                                                      child: Text("Data kode desa tidak terdaftar", style: TextStyle(
                                                          fontFamily: "Poppins",
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.w700,
                                                          color: HexColor("#025393")
                                                      ), textAlign: TextAlign.center),
                                                      margin: EdgeInsets.only(top: 10)
                                                  ),
                                                  Container(
                                                      child: Text("Data kode desa tidak terdaftar. Silahkan hubungi Administrator untuk informasi lebih lanjut", style: TextStyle(
                                                          fontFamily: "Poppins",
                                                          fontSize: 14
                                                      ), textAlign: TextAlign.center),
                                                      margin: EdgeInsets.only(top: 10)
                                                  )
                                                ]
                                            )
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            child: Text("OK", style: TextStyle(
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w700,
                                                color: HexColor("#025393")
                                            )),
                                            onPressed: (){Navigator.of(context).pop();},
                                          )
                                        ]
                                    );
                                  }
                              );
                            }else if(responseValue == 200) {
                              setState(() {
                                Loading = false;
                              });
                              Fluttertoast.showToast(
                                  msg: "Data surat keluar berhasil diperbaharui",
                                  fontSize: 14,
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER
                              );
                              Navigator.of(context).pop(true);
                            }
                          });
                        }
                      }
                    }else{
                      setState(() {
                        Loading = true;
                      });
                      var body = jsonEncode({
                        "surat_keluar_id" : editSuratKeluarPanitiaAdmin.idSuratKeluar,
                        "desa_adat_id" : loginPage.desaId,
                        "master_surat" : selectedKodeSurat,
                        "nomor_surat" : controllerNomorSurat.text,
                        "lepihan" : controllerLepihan.text,
                        "parindikan" : controllerParindikan.text,
                        "pihak_penerima" : controllerTetujon.text,
                        "pemahbah_surat" : controllerPemahbah.text,
                        "daging_surat" : controllerDagingSurat.text == "" ? null : controllerDagingSurat.text,
                        "tanggal_mulai" : tanggalMulaiValue == null ? null : tanggalMulaiValue,
                        "tanggal_selesai" : tanggalMulaiValue == null ? null : tanggalBerakhir == null ? tanggalMulaiValue : tanggalBerakhirValue,
                        "waktu_mulai" : startTime == null ? null : "${startTime.hour}:${startTime.minute}",
                        "waktu_selesai" : startTime == null ? null : endTime == null ? "${startTime.hour}:${startTime.minute}" : "${endTime.hour}:${endTime.minute}",
                        "pamuput_surat" : controllerPamuput.text == "" ? null : controllerPamuput.text,
                        "busana" : controllerBusanaKegiatan.text == "" ? null : controllerBusanaKegiatan.text,
                        "tempat_kegiatan" : controllerTempatKegiatan.text == "" ? null : controllerTempatKegiatan.text,
                        "tim_kegiatan" : controllerPanitiaAcara.text == "" ? null : controllerPanitiaAcara.text,
                        "bendesa_adat_id" : selectedBendesaAdat,
                        "krama_mipil_ketua_id" : selectedKetuaPanitia,
                        "krama_mipil_sekretaris_id" : selectedSekretarisPanitia
                      });
                      http.post(Uri.parse(apiURLSimpanEditSuratKeluar),
                          headers: {"Content-Type" : "application/json"},
                          body: body
                      ).then((http.Response response) {
                        var responseValue = response.statusCode;
                        if(responseValue == 200) {
                          setState(() {
                            Loading = false;
                          });
                          Fluttertoast.showToast(
                              msg: "Data surat keluar berhasil diperbaharui",
                              fontSize: 14,
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER
                          );
                          Navigator.of(context).pop(true);
                        }
                      });
                    }
                  },
                    child: Text("Simpan", style: TextStyle(
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
                margin: EdgeInsets.only(top: 20, bottom: 20)
              )
            ]
          )
        )
      )
    );
  }
}