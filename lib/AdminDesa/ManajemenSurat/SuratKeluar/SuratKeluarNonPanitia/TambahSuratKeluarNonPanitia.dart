import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:surat/AdminDesa/Dashboard.dart';
import 'package:surat/LoginAndRegistration/LoginPage.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:surat/main.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:simple_time_range_picker/simple_time_range_picker.dart';
import 'package:intl/intl.dart';
import 'package:surat/shared/LoadingAnimation/loading.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class tambahSuratKeluarNonPanitiaAdmin extends StatefulWidget {
  const tambahSuratKeluarNonPanitiaAdmin({Key key}) : super(key: key);

  @override
  State<tambahSuratKeluarNonPanitiaAdmin> createState() => _tambahSuratKeluarNonPanitiaAdminState();
}

class _tambahSuratKeluarNonPanitiaAdminState extends State<tambahSuratKeluarNonPanitiaAdmin> {

  //url's
  var apiURLShowKodeSurat = "https://siradaskripsi.my.id/api/data/nomorsurat/${loginPage.desaId}";
  var apiURLShowKomponenNomorSurat = "https://siradaskripsi.my.id/api/data/admin/surat/nomor_surat/${loginPage.desaId}";
  var apiURLGetDataBendesaAdat = "https://siradaskripsi.my.id/api/data/staff/prajuru/desa_adat/bendesa/${loginPage.desaId}";
  var apiURLGetDataPenyarikan = "https://siradaskripsi.my.id/api/data/staff/prajuru/desa_adat/penyarikan/${loginPage.desaId}";
  var apiURLUpDataSuratNonPanitia = "https://siradaskripsi.my.id/api/admin/surat/keluar/non-panitia/up";
  var apiURLGetKelihanAdat = "https://siradaskripsi.my.id/api/data/staff/prajuru_banjar_adat/kelihan_adat";
  var apiURLGetBendesa = "https://siradaskripsi.my.id/api/data/staff/prajuru_desa_adat/bendesa";

  //url tetujon, tumusan, lampiran
  var apiURLUpTetujonPihakLain = "https://siradaskripsi.my.id/api/admin/surat/keluar/tetujon/pihak-lain/up";
  var apiURLUpTumusanPihakLain = "https://siradaskripsi.my.id/api/admin/surat/keluar/tumusan/pihak-lain/up";
  var apiURLUpTetujonPrajuruBanjar = "https://siradaskripsi.my.id/api/admin/surat/keluar/tetujon/banjar/up";
  var apiURLUpTumusanPrajuruBanjar = "https://siradaskripsi.my.id/api/admin/surat/keluar/tumusan/banjar/up";
  var apiURLUpTetujonPrajuruDesa = "https://siradaskripsi.my.id/api/admin/surat/keluar/tetujon/desa/up";
  var apiURLUpTumusanPrajuruDesa = "https://siradaskripsi.my.id/api/admin/surat/keluar/tumusan/desa/up";
  var apiURLUpLampiran = "https://siradaskripsi.my.id/api/admin/surat/keluar/lampiran/up";

  var kodeSurat;
  var selectedKodeSurat;
  var selectedPenyarikan;
  var selectedBendesaAdat;

  bool KodeSuratLoading = true;
  bool Loading = true;
  bool availableKodeSurat = false;
  bool LoadingPenyarikan = true;
  bool LoadingBendesa = true;
  bool LoadingProses = false;
  bool NomorSuratLoading = false;
  bool availableBendesa = false;
  bool availablePenyarikan = false;
  bool isSendToKrama = false;
  bool isVisible = true;

  List kodeSuratList = List();
  List bendesaList = List();
  List penyarikanList = List();
  List lampiranSurat = [];
  List fileName = [];

  final controllerNomorSurat = TextEditingController();
  final controllerLepihan = TextEditingController();
  final controllerParindikan = TextEditingController();
  final controllerDagingSurat = TextEditingController();
  final controllerPemahbah = TextEditingController();
  final controllerPamuput = TextEditingController();
  final controllerTempatKegiatan = TextEditingController();
  final controllerBusanaKegiatan = TextEditingController();
  final controllerPihakLainTetujon = TextEditingController();
  final controllerPihakLainTumusan = TextEditingController();
  final controllerWaktuKegiatan = TextEditingController();
  final controllerTanggalKegiatanText = TextEditingController();

  TimeOfDay startTime;
  TimeOfDay endTime;
  final DateRangePickerController controllerTanggalKegiatan = DateRangePickerController();
  String tanggalMulai;
  String tanggalMulaiValue;
  String tanggalBerakhir;
  String tanggalBerakhirValue;
  String tanggalSurat;
  String tanggalSuratValue;
  DateTime selectedTanggalSurat;
  File file;
  String namaFile;
  String filePath;
  final controllerTumusan = TextEditingController();

  //kodesurat
  var nomorUrutSurat;
  var kodeDesa;
  var bulan;
  var tahun;

  //get tetujon
  List prajuruDesaList = List();
  List prajuruBanjarList = [];
  List selectedKelihanAdat = [];
  List selectedBendesa = [];

  List selectedKelihanAdatTumusan = [];
  List selectedBendesaTumusan = [];

  List pihakLain = [];
  List pihakLainTumusan = [];

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  FToast ftoast;

  void showNotification() {
    flutterLocalNotificationsPlugin.show(0, "Surat keluar berhasil ditambahkan!", "Surat keluar berhasil ditambahkan! Silahkan tunggu hingga pihak yang terkait melakukan validasi", NotificationDetails(
        android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            importance: Importance.high,
            color: Colors.blue,
            playSound: true,
            icon: '@mipmap/ic_launcher'
        )
    ));
  }

  void selectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      tanggalMulai = DateFormat("dd-MMM-yyyy").format(args.value.startDate).toString();
      tanggalMulaiValue = DateFormat("yyyy-MM-dd").format(args.value.startDate).toString();
      tanggalBerakhir = DateFormat("dd-MMM-yyyy").format(args.value.endDate ?? args.value.startDate).toString();
      tanggalBerakhirValue = DateFormat("yyyy-MM-dd").format(args.value.endDate ?? args.value.startDate).toString();
      controllerTanggalKegiatanText.text = tanggalBerakhirValue == null ? "$tanggalMulai - $tanggalMulai" : "$tanggalMulai - $tanggalBerakhir";
    });
  }

  Future getBendesa() async {
    var response = await http.get(Uri.parse(apiURLGetBendesa));
    if(response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        prajuruDesaList = jsonData;
      });
    }
  }

  Future getKelihanAdat() async {
    var response = await http.get(Uri.parse(apiURLGetKelihanAdat));
    if(response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        prajuruBanjarList = jsonData;
      });
    }
  }

  Future getKodeSurat() async {
    var response = await http.get(Uri.parse(apiURLShowKodeSurat));
    if(response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        kodeSuratList = jsonData;
        KodeSuratLoading = false;
        availableKodeSurat = true;
      });
    }else{
      setState(() {
        KodeSuratLoading = false;
        availableKodeSurat = false;
      });
    }
  }

  Future getKomponenNomorSurat() async {
    setState(() {
      NomorSuratLoading = true;
    });
    var body = jsonEncode({
      "kode_surat" : selectedKodeSurat
    });
    http.post(Uri.parse(apiURLShowKomponenNomorSurat),
        headers: {"Content-Type" : "application/json"},
        body: body
    ).then((http.Response response) {
      var responseValue = response.statusCode;
      print(responseValue);
      if(responseValue == 200) {
        var jsonData = response.body;
        var parsedJson = json.decode(jsonData);
        setState(() {
          NomorSuratLoading = false;
          nomorUrutSurat = parsedJson['nomor_urut_surat'];
          kodeDesa = parsedJson['kode_desa'];
          bulan = parsedJson['bulan'];
          tahun = parsedJson['tahun'];
          controllerNomorSurat.text = "$nomorUrutSurat/$selectedKodeSurat-$kodeDesa/$bulan/$tahun";
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
        availableBendesa = true;
        selectedBendesaAdat = int.parse(bendesaList[0]['prajuru_desa_adat_id'].toString());
      });
    }else{
      setState(() {
        LoadingBendesa = false;
        availableBendesa = false;
      });
    }
  }

  Future getPenyarikan() async {
    var response = await http.get(Uri.parse(apiURLGetDataPenyarikan));
    if(response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        penyarikanList = jsonData;
        LoadingPenyarikan = false;
        availablePenyarikan = true;
        selectedPenyarikan = int.parse(penyarikanList[0]['prajuru_desa_adat_id'].toString());
      });
    }else{
      setState(() {
        LoadingPenyarikan = false;
        availablePenyarikan = false;
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
        lampiranSurat.add(file);
        fileName.add(namaFile);
      });
      print(filePath);
      print(namaFile);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getKodeSurat();
    getBendesaAdat();
    getPenyarikan();
    getKelihanAdat();
    getBendesa();
    ftoast = FToast();
    ftoast.init(this.context);
    final DateTime sekarang = DateTime.now();
    tanggalMulai = DateFormat("dd-MMM-yyyy").format(sekarang).toString();
    tanggalBerakhir = DateFormat("dd-MMM-yyyy").format(sekarang.add(Duration(days: 7))).toString();
    tanggalSurat = DateFormat("dd-MMM-yyyy").format(sekarang).toString();
    tanggalSuratValue = DateFormat("yyyy-MM-dd").format(sekarang).toString();
    controllerTanggalKegiatan.selectedRange = PickerDateRange(sekarang, sekarang.add(Duration(days: 7)));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoadingProses ? loading() : Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: HexColor("#025393"),
            onPressed: (){
              Navigator.of(context).pop(true);
            },
          ),
          title: Text("Tambah Data Surat", style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w700,
            color: HexColor("#025393")
          ))
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
                children: <Widget>[
                  Container(
                      alignment: Alignment.topLeft,
                      child: Text("1. Kode Surat *", style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 14,
                          fontWeight: FontWeight.w700
                      )),
                      margin: EdgeInsets.only(top: 20, left: 20)
                  ),
                  Container(
                      child: KodeSuratLoading ? ListTileShimmer() : Column(
                          children: <Widget>[
                            Container(
                                child: Text("Silahkan pilih salah satu kode surat dari surat yang ingin Anda ajukan.", style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 14
                                )),
                                padding: EdgeInsets.only(left: 30, right: 30),
                                margin: EdgeInsets.only(top: 10)
                            ),
                            Container(
                                child: availableKodeSurat == false ? Container(
                                    child: Row(
                                        children: <Widget>[
                                          Container(
                                              child: Icon(
                                                  Icons.close,
                                                  color: Colors.white
                                              )
                                          ),
                                          Container(
                                              child: Flexible(
                                                  child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: <Widget>[
                                                        Container(
                                                            child: Text("Tidak ada Data Kode Surat", style: TextStyle(
                                                                fontFamily: "Poppins",
                                                                fontSize: 14,
                                                                fontWeight: FontWeight.bold,
                                                                color: Colors.white
                                                            ))
                                                        ),
                                                        Container(
                                                            child: SizedBox(
                                                                width: MediaQuery.of(context).size.width * 0.7,
                                                                child: Text("Anda tidak bisa melanjutkan proses ini sebelum Anda menambahkan data kode surat pada menu Nomor Surat", style: TextStyle(
                                                                    fontFamily: "Poppins",
                                                                    fontSize: 14,
                                                                    color: Colors.white
                                                                ))
                                                            )
                                                        )
                                                      ]
                                                  )
                                              ),
                                              margin: EdgeInsets.only(left: 15)
                                          )
                                        ]
                                    ),
                                    decoration: BoxDecoration(
                                        color: HexColor("B20600"),
                                        borderRadius: BorderRadius.circular(25)
                                    ),
                                    padding: EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
                                    margin: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 5)
                                ) : Container(
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
                                        });
                                        getKomponenNomorSurat();
                                      },
                                    ),
                                    margin: EdgeInsets.only(top: 15)
                                )
                            )
                          ]
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
                              child: NomorSuratLoading ? ListTileShimmer() : Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                                  child: TextFormField(
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    validator: (value) {
                                      if(value.isEmpty) {
                                        return "Data tidak boleh kosong";
                                      }else {
                                        return null;
                                      }
                                    },
                                    controller: controllerNomorSurat,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(50.0),
                                            borderSide: BorderSide(color: HexColor("#025393"))
                                        ),
                                        hintText: "Otomatis"
                                    ),
                                    style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 14
                                    ),
                                  )
                              ),
                            )
                          ]
                      )
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
                                  child: TextFormField(
                                      autovalidateMode: AutovalidateMode.onUserInteraction,
                                      validator: (value) {
                                        if(value.isEmpty) {
                                          return "Data tidak boleh kosong";
                                        }else {
                                          return null;
                                        }
                                      },
                                      controller: controllerLepihan,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(50.0),
                                              borderSide: BorderSide(color: HexColor("#025393"))
                                          ),
                                          hintText: "Lepihan"
                                      ),
                                      keyboardType: TextInputType.number,
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 14
                                      )
                                  )
                              ),
                            )
                          ]
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
                                  child: TextFormField(
                                      autovalidateMode: AutovalidateMode.onUserInteraction,
                                      validator: (value) {
                                        if(value.isEmpty) {
                                          return "Data tidak boleh kosong";
                                        }else {
                                          return null;
                                        }
                                      },
                                      controller: controllerParindikan,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(50.0),
                                              borderSide: BorderSide(color: HexColor("#025393"))
                                          ),
                                          hintText: "Parindikan"
                                      ),
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 14
                                      )
                                  )
                              ),
                            )
                          ]
                      )
                  ),
                  Container(
                      child: Text("3. Daging Surat", style: TextStyle(
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
                                child: Text("Pemahbah", style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 14
                                )),
                                margin: EdgeInsets.only(top: 20, left: 20)
                            ),
                            Container(
                              child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                                  child: TextField(
                                      maxLines: 5,
                                      controller: controllerPemahbah,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(30),
                                              borderSide: BorderSide(color: HexColor("#025393"))
                                          ),
                                          hintText: "Pemahbah"
                                      ),
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 14
                                      )
                                  )
                              ),
                            )
                          ]
                      )
                  ),
                  Container(
                      child: Column(
                          children: <Widget>[
                            Container(
                                alignment: Alignment.topLeft,
                                child: Text("Daging Surat", style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 14
                                )),
                                margin: EdgeInsets.only(top: 20, left: 20)
                            ),
                            Container(
                              child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                                  child: TextField(
                                      controller: controllerDagingSurat,
                                      maxLines: 10,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(30),
                                              borderSide: BorderSide(color: HexColor("#025393"))
                                          ),
                                          hintText: "Daging Surat"
                                      ),
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 14
                                      )
                                  )
                              ),
                            )
                          ]
                      )
                  ),
                  Container(
                      child: Column(
                          children: <Widget>[
                            Container(
                                alignment: Alignment.topLeft,
                                child: Text("Pamuput Surat", style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 14
                                )),
                                margin: EdgeInsets.only(top: 20, left: 20)
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
                                          hintText: "Pamuput Surat"
                                      ),
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 14
                                      )
                                  )
                              ),
                            )
                          ]
                      )
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
                                margin: EdgeInsets.only(top: 20, left: 20)
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
                                        )
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
                                child: Text("Tanggal Kegiatan", style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 14
                                )),
                                margin: EdgeInsets.only(top: 20, left: 20)
                            ),
                            Container(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                                child: GestureDetector(
                                  onTap: (){
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text("Pilih Tanggal Kegiatan", style: TextStyle(
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
                                                      controller: controllerTanggalKegiatan,
                                                      selectionMode: DateRangePickerSelectionMode.range,
                                                      onSelectionChanged: selectionChanged,
                                                      allowViewNavigation: true
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              child: Text("Simpan", style: TextStyle(
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w700,
                                                color: HexColor("025393")
                                              )),
                                              onPressed: (){
                                                Navigator.of(context).pop();
                                              },
                                            )
                                          ],
                                        );
                                      }
                                    );
                                  },
                                  child: TextField(
                                    controller: controllerTanggalKegiatanText,
                                    enabled: false,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(50.0),
                                            borderSide: BorderSide(color: HexColor("#025393"))
                                        ),
                                        hintText: "Tanggal kegiatan belum terpilih",
                                        prefixIcon: Icon(CupertinoIcons.calendar)
                                    ),
                                    style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 14
                                    ),
                                  ),
                                )
                              ),
                              margin: EdgeInsets.only(top: 10),
                            ),
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
                                margin: EdgeInsets.only(top: 20, left: 20)
                            ),
                            Container(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                                child: GestureDetector(
                                  onTap: (){
                                    TimeRangePicker.show(
                                        context: context,
                                        unSelectedEmpty: true,
                                        headerDefaultStartLabel: "Waktu Mulai",
                                        headerDefaultEndLabel: "Waktu Selesai",
                                        onSubmitted: (TimeRangeValue value) {
                                          setState(() {
                                            startTime = value.startTime;
                                            endTime = value.endTime;
                                            controllerWaktuKegiatan.text = startTime == null ? "--:--" : endTime == null ? "${startTime.hour}:${startTime.minute} - ${startTime.hour}:${startTime.minute}": "${startTime.hour}:${startTime.minute} - ${endTime.hour}:${endTime.minute}";
                                          });
                                        }
                                    );
                                  },
                                  child: TextField(
                                    controller: controllerWaktuKegiatan,
                                    enabled: false,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(50.0),
                                            borderSide: BorderSide(color: HexColor("#025393"))
                                        ),
                                        hintText: "Waktu kegiatan belum terpilih",
                                        prefixIcon: Icon(CupertinoIcons.time_solid)
                                    ),
                                    style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 14
                                    ),
                                  ),
                                ),
                              ),
                              margin: EdgeInsets.only(top: 10),
                            ),
                          ]
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
                      child: Text("4. Lingga Tangan Miwah Pesengan", style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 14,
                          fontWeight: FontWeight.w700
                      )),
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(top: 30, left: 20)
                  ),
                  Container(
                      child: Text("Silahkan isi data pihak yang akan tanda tangan pada form dibawah ini", style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 14
                      )),
                      padding: EdgeInsets.only(left: 30, right: 30),
                      margin: EdgeInsets.only(top: 10)
                  ),
                  Container(
                      child: Column(
                          children: <Widget>[
                            Container(
                                alignment: Alignment.topLeft,
                                child: Text("Penyarikan *", style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 14
                                )),
                                margin: EdgeInsets.only(top: 20, left: 20)
                            ),
                            Container(
                                child: LoadingPenyarikan ? ListTileShimmer() : availablePenyarikan == false ? Container(
                                    child: Row(
                                        children: <Widget>[
                                          Container(
                                              child: Icon(
                                                  Icons.close,
                                                  color: Colors.white
                                              )
                                          ),
                                          Container(
                                              child: Flexible(
                                                  child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: <Widget>[
                                                        Container(
                                                            child: Text("Tidak ada Data Penyarikan", style: TextStyle(
                                                                fontFamily: "Poppins",
                                                                fontSize: 14,
                                                                fontWeight: FontWeight.bold,
                                                                color: Colors.white
                                                            ))
                                                        ),
                                                        Container(
                                                            child: SizedBox(
                                                              width: MediaQuery.of(context).size.width * 0.7,
                                                              child: Text("Anda tidak bisa melanjutkan proses ini sebelum Anda menambahkan data Penyarikan pada menu Prajuru Desa Adat", style: TextStyle(
                                                                  fontFamily: "Poppins",
                                                                  fontSize: 14,
                                                                  color: Colors.white
                                                              )),
                                                            )
                                                        )
                                                      ]
                                                  )
                                              ),
                                              margin: EdgeInsets.only(left: 15)
                                          )
                                        ]
                                    ),
                                    decoration: BoxDecoration(
                                        color: HexColor("B20600"),
                                        borderRadius: BorderRadius.circular(25)
                                    ),
                                    padding: EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
                                    margin: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 5)
                                ) : Container(
                                    width: 300,
                                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                    decoration: BoxDecoration(
                                        color: HexColor("#025393"),
                                        borderRadius: BorderRadius.circular(30)
                                    ),
                                    child: DropdownButton(
                                      isExpanded: true,
                                      hint: Center(
                                          child: Text("Pilih Data Penyarikan", style: TextStyle(
                                              fontFamily: "Poppins",
                                              color: Colors.white,
                                              fontSize: 14
                                          ))
                                      ),
                                      value: selectedPenyarikan,
                                      underline: Container(),
                                      icon: Icon(Icons.arrow_downward, color: Colors.white),
                                      items: penyarikanList.map((penyarikan) {
                                        return DropdownMenuItem(
                                            value: penyarikan['prajuru_desa_adat_id'],
                                            child: Text("${penyarikan['nik']} - ${penyarikan['nama']}", style: TextStyle(
                                                fontFamily: "Poppins",
                                                fontSize: 14
                                            ))
                                        );
                                      }).toList(),
                                      selectedItemBuilder: (BuildContext context) => penyarikanList.map((penyarikan) => Center(
                                          child: Text("${penyarikan['nik']} - ${penyarikan['nama']}", style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 14,
                                              color: Colors.white
                                          ))
                                      )).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          selectedPenyarikan = value;
                                        });
                                      },
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
                                child: LoadingBendesa ? ListTileShimmer() : availableBendesa == false ? Container(
                                    child: Row(
                                        children: <Widget>[
                                          Container(
                                              child: Icon(
                                                  Icons.close,
                                                  color: Colors.white
                                              )
                                          ),
                                          Container(
                                              child: Flexible(
                                                  child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: <Widget>[
                                                        Container(
                                                            child: Text("Tidak ada Data Bendesa", style: TextStyle(
                                                                fontFamily: "Poppins",
                                                                fontSize: 14,
                                                                fontWeight: FontWeight.bold,
                                                                color: Colors.white
                                                            ))
                                                        ),
                                                        Container(
                                                            child: SizedBox(
                                                                width: MediaQuery.of(context).size.width * 0.7,
                                                                child: Text("Anda tidak bisa melanjutkan proses ini sebelum Anda menambahkan data Bendesa pada menu Prajuru Desa Adat", style: TextStyle(
                                                                    fontFamily: "Poppins",
                                                                    fontSize: 14,
                                                                    color: Colors.white
                                                                ))
                                                            )
                                                        )
                                                      ]
                                                  )
                                              ),
                                              margin: EdgeInsets.only(left: 15)
                                          )
                                        ]
                                    ),
                                    decoration: BoxDecoration(
                                        color: HexColor("B20600"),
                                        borderRadius: BorderRadius.circular(25)
                                    ),
                                    padding: EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
                                    margin: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 5)
                                ) : Container(
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
                      child: Text("Silahkan unggah berkas lepihan (lampiran) dalam format file PDF.", style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 14
                      )),
                      padding: EdgeInsets.only(left: 30, right: 30),
                      margin: EdgeInsets.only(top: 10)
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                    child: MultiSelectChipDisplay(
                      items: lampiranSurat.map((e) => MultiSelectItem(e, e.path.split('/').last)).toList(),
                      onTap: (value) {
                        setState(() {
                          lampiranSurat.remove(value);
                        });
                      },
                    ),
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
                          child: Text("Tambah Berkas", style: TextStyle(
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
                      margin: EdgeInsets.only(top: 20)
                  ),
                  Container(
                    child: Text("6. Tetujon Surat", style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14,
                        fontWeight: FontWeight.w700
                    )),
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(top: 30, left: 20),
                  ),
                  Visibility(
                    visible: isVisible,
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text("Prajuru Desa Adat", style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14,
                                fontWeight: FontWeight.w700
                            )),
                            margin: EdgeInsets.only(top: 15, left: 20),
                          ),
                          Container(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              child: MultiSelectDialogField(
                                title: Text("Pilih Penerima Prajuru Desa Adat"),
                                buttonText: Text("Pilih Penerima Prajuru Desa Adat", style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 14
                                )),
                                buttonIcon: Icon(Icons.expand_more),
                                searchable: false,
                                checkColor: Colors.white,
                                items: prajuruDesaList.map((item) => MultiSelectItem(item, "Desa ${item['desadat_nama']} - ${item['nama']}")).toList(),
                                listType: MultiSelectListType.LIST,
                                onConfirm: (values) {
                                  selectedBendesa = values;
                                },
                              )
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text("Prajuru Banjar Adat", style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14,
                                fontWeight: FontWeight.w700
                            )),
                            margin: EdgeInsets.only(top: 15, left: 20),
                          ),
                          Container(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              child: MultiSelectDialogField(
                                title: Text("Pilih Penerima Prajuru Banjar Adat"),
                                buttonText: Text("Pilih Penerima Prajuru Banjar Adat", style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 14
                                )),
                                buttonIcon: Icon(Icons.expand_more),
                                searchable: false,
                                checkColor: Colors.white,
                                items: prajuruBanjarList.map((item) => MultiSelectItem(item, "Banjar ${item['nama_banjar_adat']} - ${item['nama']}")).toList(),
                                listType: MultiSelectListType.LIST,
                                onConfirm: (values) {
                                  selectedKelihanAdat = values;
                                },
                              )
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text("Pihak Lain", style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14,
                                fontWeight: FontWeight.w700
                            )),
                            margin: EdgeInsets.only(top: 15, left: 20),
                          ),
                          Container(
                              child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                                  child: TextField(
                                    controller: controllerPihakLainTetujon,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(50.0),
                                            borderSide: BorderSide(color: HexColor("#025393"))
                                        ),
                                        hintText: "Nama Penerima Pihak Lain",
                                        suffixIcon: IconButton(
                                          icon: Icon(Icons.add),
                                          onPressed: (){
                                            if(controllerPihakLainTetujon.text != "") {
                                              setState(() {
                                                pihakLain.add(controllerPihakLainTetujon.text);
                                                controllerPihakLainTetujon.text = "";
                                              });
                                            }
                                          },
                                        )
                                    ),
                                    style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 14
                                    ),
                                  )
                              )
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            child: MultiSelectChipDisplay(
                              items: pihakLain.map((e) => MultiSelectItem(e, e)).toList(),
                              onTap: (value) {
                                setState(() {
                                  pihakLain.remove(value);
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: CheckboxListTile(
                      title: Text("Kirimkan surat ini ke Krama Desa ${dashboardAdminDesa.namaDesaAdat}", style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14,
                        color: Colors.black
                      )),
                      value: isSendToKrama,
                      controlAffinity: ListTileControlAffinity.leading,
                      onChanged: (bool value) {
                        setState(() {
                          isSendToKrama = value;
                          isVisible = !isVisible;
                        });
                      },
                    ),
                  ),
                  Container(
                    child: Text("7. Tumusan Surat", style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14,
                        fontWeight: FontWeight.w700
                    )),
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(top: 10, left: 20),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text("Prajuru Desa Adat", style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14,
                        fontWeight: FontWeight.w700
                    )),
                    margin: EdgeInsets.only(top: 15, left: 20),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                      child: MultiSelectDialogField(
                        title: Text("Pilih Tumusan Prajuru Desa Adat"),
                        buttonText: Text("Pilih Tumusan Prajuru Desa Adat", style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14
                        )),
                        buttonIcon: Icon(Icons.expand_more),
                        searchable: false,
                        checkColor: Colors.white,
                        items: prajuruDesaList.map((item) => MultiSelectItem(item, "Desa ${item['desadat_nama']} - ${item['nama']}")).toList(),
                        listType: MultiSelectListType.LIST,
                        onConfirm: (values) {
                          selectedBendesaTumusan = values;
                        },
                      )
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text("Prajuru Banjar Adat", style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14,
                        fontWeight: FontWeight.w700
                    )),
                    margin: EdgeInsets.only(top: 15, left: 20),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                      child: MultiSelectDialogField(
                        title: Text("Pilih Tumusan Prajuru Banjar Adat"),
                        buttonText: Text("Pilih Tumusan Prajuru Banjar Adat", style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14
                        )),
                        buttonIcon: Icon(Icons.expand_more),
                        searchable: false,
                        checkColor: Colors.white,
                        items: prajuruBanjarList.map((item) => MultiSelectItem(item, "Banjar ${item['nama_banjar_adat']} - ${item['nama']}")).toList(),
                        listType: MultiSelectListType.LIST,
                        onConfirm: (values) {
                          selectedKelihanAdatTumusan = values;
                        },
                      )
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text("Pihak Lain", style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14,
                        fontWeight: FontWeight.w700
                    )),
                    margin: EdgeInsets.only(top: 15, left: 20),
                  ),
                  Container(
                      child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                          child: TextField(
                            controller: controllerPihakLainTumusan,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                    borderSide: BorderSide(color: HexColor("#025393"))
                                ),
                                hintText: "Nama Tumusan Pihak Lain",
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.add),
                                  onPressed: (){
                                    if(controllerPihakLainTumusan.text != "") {
                                      setState(() {
                                        pihakLainTumusan.add(controllerPihakLainTumusan.text);
                                        controllerPihakLainTumusan.text = "";
                                      });
                                    }
                                  },
                                )
                            ),
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14
                            ),
                          )
                      )
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: MultiSelectChipDisplay(
                        items: pihakLainTumusan.map((e) => MultiSelectItem(e, e)).toList(),
                        onTap: (value) {
                          setState(() {
                            pihakLainTumusan.remove(value);
                          });
                        },
                      )
                  ),
                  Container(
                      child: FlatButton(
                          onPressed: () async {
                            if(controllerLepihan.text != "0" && fileName.isEmpty) {
                              ftoast.showToast(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color: Colors.redAccent
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        Icon(Icons.close),
                                        Container(
                                          margin: EdgeInsets.only(left: 15),
                                          child: SizedBox(
                                            width: MediaQuery.of(context).size.width * 0.65,
                                            child: Text("Silahkan unggah berkas lampiran", style: TextStyle(
                                                fontFamily: "Poppins",
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white
                                            )),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                              );
                            }else if(selectedKelihanAdat.isEmpty && selectedBendesa.isEmpty && pihakLain.isEmpty) {
                              ftoast.showToast(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color: Colors.redAccent
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        Icon(Icons.close),
                                        Container(
                                          margin: EdgeInsets.only(left: 15),
                                          child: SizedBox(
                                            width: MediaQuery.of(context).size.width * 0.65,
                                            child: Text("Silahkan masukkan penerima surat", style: TextStyle(
                                                fontFamily: "Poppins",
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white
                                            )),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                              );
                            }else if(formKey.currentState.validate()) {
                              setState(() {
                                LoadingProses = true;
                              });
                              var body = jsonEncode({
                                "desa_adat_id" : loginPage.desaId,
                                "master_surat" : selectedKodeSurat,
                                "nomor_surat" : controllerNomorSurat.text,
                                "nomor_urut_surat" : nomorUrutSurat.toString(),
                                "lepihan" : controllerLepihan.text,
                                "parindikan" : controllerParindikan.text,
                                "pemahbah_surat" : controllerPemahbah.text == "" ? null : controllerPemahbah.text,
                                "daging_surat" : controllerDagingSurat.text == "" ? null : controllerDagingSurat.text,
                                "pamuput_surat" : controllerPamuput.text == "" ? null : controllerPamuput.text,
                                "tanggal_mulai" : tanggalMulaiValue == null ? null : tanggalMulaiValue,
                                "tanggal_selesai" : tanggalMulaiValue == null ? null : tanggalBerakhir == null ? tanggalMulaiValue : tanggalBerakhirValue,
                                "waktu_mulai" : startTime == null ? null : "${startTime.hour}:${startTime.minute}",
                                "waktu_selesai" : startTime == null ? null : endTime == null ? "${startTime.hour}:${startTime.minute}" : "${endTime.hour}:${endTime.minute}",
                                "busana" : controllerBusanaKegiatan.text == "" ? null : controllerBusanaKegiatan.text,
                                "tempat_kegiatan" : controllerTempatKegiatan.text == "" ? null : controllerTempatKegiatan.text,
                                "bendesa_adat_id" : selectedBendesaAdat,
                                "tanggal_surat" : tanggalSuratValue,
                                "bendesa_adat_id" : selectedBendesaAdat.toString(),
                                "penyarikan_id" : selectedPenyarikan.toString(),
                                "user_id" : loginPage.userId,
                                "pihak_krama" : isSendToKrama ? "Desa Adat ${dashboardAdminDesa.namaDesaAdat}" : null
                              });
                              http.post(Uri.parse(apiURLUpDataSuratNonPanitia),
                                  headers: {"Content-Type" : "application/json"},
                                  body: body
                              ).then((http.Response response) {
                                var responseValue = response.statusCode;
                                print("status upload surat keluar panitia: ${responseValue.toString()}");
                                if(responseValue == 200) {
                                  var data = json.decode(response.body);
                                  uploadLampiran(data);
                                  uploadPrajuruBanjar(data);
                                  uploadPrajuruDesa(data);
                                  uploadPihakLain(data);
                                  setState(() {
                                    Loading = false;
                                  });
                                  showNotification();
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
            ),
          )
        )
      )
    );
  }

  Future uploadLampiran(var suratKeluarId) async {
    Map<String, String> headers = {
      'Content-Type' : 'multipart/form-data'
    };
    Map<String, String> body = {
      "surat_keluar_id" : suratKeluarId.toString()
    };
    if(lampiranSurat.isNotEmpty) {
      for(var i = 0; i < lampiranSurat.length; i++) {
        var request = http.MultipartRequest('POST', Uri.parse(apiURLUpLampiran))
          ..fields.addAll(body)
          ..headers.addAll(headers)
          ..files.add(await http.MultipartFile.fromPath('lampiran', lampiranSurat[i].path));
        var response = await request.send();
        print("upload lampiran status code: ${response.statusCode.toString()}");
      }
    }else {
      print("lampiran surat kosong");
    }
  }

  Future uploadPrajuruBanjar(var suratKeluarId) async {
    Map<String, String> headers = {
      'Content-Type' : 'multipart/form-data'
    };
    if(isSendToKrama == false) {
      if(selectedKelihanAdat.isNotEmpty) {
        for(var i = 0; i < selectedKelihanAdat.length; i++) {
          Map<String, String> body = {
            "surat_keluar_id" : suratKeluarId.toString(),
            "prajuru_banjar_adat_id" : selectedKelihanAdat[i]['prajuru_banjar_adat_id'].toString()
          };
          var request = http.MultipartRequest("POST", Uri.parse(apiURLUpTetujonPrajuruBanjar))
            ..fields.addAll(body)
            ..headers.addAll(headers);
          var response = await request.send();
          print("upload tetujon prajuru banjar status code: ${response.statusCode.toString()}");
        }
      }
    }
    if(selectedKelihanAdatTumusan.isNotEmpty) {
      for(var i = 0; i < selectedKelihanAdatTumusan.length; i++) {
        Map<String, String> bodyTumusan = {
          "surat_keluar_id" : suratKeluarId.toString(),
          "prajuru_banjar_adat_id" : selectedKelihanAdatTumusan[i]['prajuru_banjar_adat_id'].toString()
        };
        var requestTumusan = http.MultipartRequest("POST", Uri.parse(apiURLUpTumusanPrajuruBanjar))
          ..fields.addAll(bodyTumusan)
          ..headers.addAll(headers);
        var response = await requestTumusan.send();
        print("upload tumusan prajuru banjar status code: ${response.statusCode.toString()}");
      }
    }
  }

  Future uploadPrajuruDesa(var suratKeluarId) async {
    Map<String, String> headers = {
      'Content-Type' : 'multipart/form-data'
    };
    if(isSendToKrama == false) {
      if(selectedBendesa.isNotEmpty) {
        for(var i = 0; i < selectedBendesa.length; i++) {
          Map<String, String> body = {
            "surat_keluar_id" : suratKeluarId.toString(),
            "prajuru_desa_adat_id" : selectedBendesa[i]['prajuru_desa_adat_id'].toString()
          };
          var request = http.MultipartRequest("POST", Uri.parse(apiURLUpTetujonPrajuruDesa))
            ..fields.addAll(body)
            ..headers.addAll(headers);
          var response = await request.send();
          print("upload tetujon prajuru desa status code: ${response.statusCode.toString()}");
        }
      }
    }
    if(selectedBendesaTumusan.isNotEmpty) {
      for(var i = 0; i < selectedBendesaTumusan.length; i++) {
        Map<String, String> bodyTumusan = {
          "surat_keluar_id" : suratKeluarId.toString(),
          "prajuru_desa_adat_id" : selectedBendesaTumusan[i]['prajuru_desa_adat_id'].toString()
        };
        var requestTumusan = http.MultipartRequest("POST", Uri.parse(apiURLUpTumusanPrajuruDesa))
          ..fields.addAll(bodyTumusan)
          ..headers.addAll(headers);
        var response = await requestTumusan.send();
        print("upload tumusan prajuru desa status code: ${response.statusCode.toString()}");
      }
    }
  }

  Future uploadPihakLain(var suratKeluarId) async {
    Map<String, String> headers = {
      'Content-Type' : 'multipart/form-data'
    };
    if(isSendToKrama == false) {
      if(pihakLain.isNotEmpty) {
        for(var i = 0; i < pihakLain.length; i++) {
          Map<String, String> body = {
            "surat_keluar_id" : suratKeluarId.toString(),
            "pihak_lain" : pihakLain[i].toString()
          };
          var request = http.MultipartRequest("POST", Uri.parse(apiURLUpTetujonPihakLain))
            ..fields.addAll(body)
            ..headers.addAll(headers);
          var response = await request.send();
          print("upload tetujon pihak lain status code: ${response.statusCode.toString()}");
        }
      }
    }
    if(pihakLainTumusan.isNotEmpty) {
      for(var i = 0; i < pihakLainTumusan.length; i++) {
        Map<String, String> bodyTumusan = {
          "surat_keluar_id" : suratKeluarId.toString(),
          "pihak_lain" : pihakLainTumusan[i].toString()
        };
        var requestTumusan = http.MultipartRequest("POST", Uri.parse(apiURLUpTumusanPihakLain))
          ..fields.addAll(bodyTumusan)
          ..headers.addAll(headers);
        var response = await requestTumusan.send();
        print("upload tumusan pihak lain status code: ${response.statusCode.toString()}");
      }
    }
  }

}