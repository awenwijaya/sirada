import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:surat/shared/LoadingAnimation/loading.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:simple_time_range_picker/simple_time_range_picker.dart';
import 'package:surat/LoginAndRegistration/LoginPage.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';

class editSuratMasukAdmin extends StatefulWidget {
  static var idSuratMasuk;
  const editSuratMasukAdmin({Key key}) : super(key: key);

  @override
  State<editSuratMasukAdmin> createState() => _editSuratMasukAdminState();
}

class _editSuratMasukAdminState extends State<editSuratMasukAdmin> {
  var selectedKodeSurat;
  List kodeSuratList = List();
  var apiURLGetKodeSurat = "https://siradaskripsi.my.id/api/data/nomorsurat";
  var apiURLSimpanSurat = "https://siradaskripsi.my.id/api/admin/surat/masuk/edit/up";
  var apiURLGetDataSurat = "https://siradaskripsi.my.id/api/admin/surat/masuk/edit/${editSuratMasukAdmin.idSuratMasuk}";
  var apiURLUploadFileSurat = "https://siradaskripsi.my.id/api/upload/surat-masuk";
  bool availableKodeSurat = false;
  bool KodeSuratLoading = true;
  bool Loading = false;
  bool LoadingData = true;
  String tanggalSurat;
  String tanggalSuratValue;
  DateTime selectedTanggalSurat;
  TimeOfDay startTime;
  TimeOfDay endTime;
  final DateRangePickerController controllerTanggalKegiatan = DateRangePickerController();
  String tanggalMulai;
  String tanggalMulaiValue;
  String tanggalBerakhir;
  String tanggalBerakhirValue;
  DateTime tanggalMulaiKegiatan;
  DateTime tanggalAkhirKegiatan;
  File file;
  String namaFile;
  String filePath;
  final controllerNomorSurat = TextEditingController();
  final controllerParindikan = TextEditingController();
  final controllerAsalSurat = TextEditingController();
  final controllerWaktuKegiatan = TextEditingController();
  final controllerTanggalKegiatanText = TextEditingController();
  final controllerTanggalSurat = TextEditingController();
  final controllerBerkasSurat = TextEditingController();
  FToast ftoast;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future getDataSurat() async {
    Uri uri = Uri.parse(apiURLGetDataSurat);
    final response = await http.get(uri);
    if(response.statusCode == 200) {
      var jsonData = response.body;
      var parsedJson = json.decode(jsonData);
      setState(() {
        controllerNomorSurat.text = parsedJson['nomor_surat'];
        controllerParindikan.text = parsedJson['perihal'];
        controllerAsalSurat.text = parsedJson['asal_surat'];
        selectedKodeSurat = int.parse(parsedJson['master_surat_id']);
        tanggalAkhirKegiatan = parsedJson['tanggal_kegiatan_berakhir'] == null ? null : DateTime.parse(parsedJson['tanggal_kegiatan_berakhir']);
        tanggalMulaiKegiatan = parsedJson['tanggal_kegiatan_mulai'] == null ? null : DateTime.parse(parsedJson['tanggal_kegiatan_mulai']);
        if(tanggalAkhirKegiatan != null || tanggalMulaiKegiatan != null) {
          controllerTanggalKegiatan.selectedRange = PickerDateRange(tanggalMulaiKegiatan, tanggalAkhirKegiatan);
          tanggalMulai = DateFormat("dd-MMM-yyyy").format(tanggalMulaiKegiatan).toString();
          tanggalMulaiValue = DateFormat("yyyy-MM-dd").format(tanggalMulaiKegiatan).toString();
          tanggalBerakhir = DateFormat("dd-MMM-yyyy").format(tanggalAkhirKegiatan).toString();
          tanggalBerakhirValue = DateFormat("yyyy-MM-dd").format(tanggalAkhirKegiatan).toString();
          controllerTanggalKegiatanText.text = tanggalBerakhirValue == null ? "$tanggalMulai - $tanggalMulai" : "$tanggalMulai - $tanggalBerakhir";
        }
        startTime = parsedJson['waktu_kegiatan_mulai'] == null ? null : TimeOfDay(hour: int.parse(parsedJson['waktu_kegiatan_mulai'].split(":")[0]), minute: int.parse(parsedJson['waktu_kegiatan_mulai'].split(":")[1]));
        endTime = parsedJson['waktu_kegiatan_selesai'] == null ? null : TimeOfDay(hour: int.parse(parsedJson['waktu_kegiatan_selesai'].split(":")[0]), minute: int.parse(parsedJson['waktu_kegiatan_selesai'].split(":")[1]));
        selectedTanggalSurat = DateTime.parse(parsedJson['tanggal_surat']);
        tanggalSurat = DateFormat("dd-MMM-yyyy").format(selectedTanggalSurat).toString();
        tanggalSuratValue = DateFormat("yyyy-MM-dd").format(selectedTanggalSurat).toString();
        controllerTanggalSurat.text = tanggalSurat;
        controllerWaktuKegiatan.text = startTime == null ? "--:--" : endTime == null ? "${startTime.hour}:${startTime.minute} - ${startTime.hour}:${startTime.minute}": "${startTime.hour}:${startTime.minute} - ${endTime.hour}:${endTime.minute}";
        LoadingData = false;
        namaFile = parsedJson['file'];
        controllerBerkasSurat.text = namaFile;
      });
    }
  }

  Future getKodeSurat() async {
    Uri uri = Uri.parse(apiURLGetKodeSurat);
    final response = await http.get(uri);
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
        controllerBerkasSurat.text = namaFile;
      });
      print(filePath);
      print(namaFile);
    }
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getKodeSurat();
    getDataSurat();
    final DateTime sekarang = DateTime.now();
    tanggalMulai = DateFormat("dd-MMM-yyyy").format(sekarang).toString();
    tanggalBerakhir = DateFormat("dd-MMM-yyyy").format(sekarang.add(Duration(days: 7))).toString();
    tanggalSurat = DateFormat("dd-MMM-yyyy").format(sekarang).toString();
    tanggalSuratValue = DateFormat("yyyy-MM-dd").format(sekarang).toString();
    controllerTanggalKegiatan.selectedRange = PickerDateRange(tanggalMulaiKegiatan == null ? sekarang : tanggalMulaiKegiatan, tanggalAkhirKegiatan == null ? sekarang : tanggalAkhirKegiatan);
    ftoast = FToast();
    ftoast.init(this.context);
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
          title: Text("Edit Surat Masuk", style: TextStyle(
              fontFamily: "Poppins",
              fontWeight: FontWeight.w700,
              color: HexColor("#025393")
          )),
        ),
        body: LoadingData ? ProfilePageShimmer() : SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
                  child: Text("1. Atribut Surat", style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 14,
                      fontWeight: FontWeight.w700
                  ), textAlign: TextAlign.center),
                  margin: EdgeInsets.only(top: 20, left: 20),
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text("Kode Surat *", style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14
                        )),
                        margin: EdgeInsets.only(top: 20, left: 20),
                      ),
                      Container(
                          child: KodeSuratLoading ? ListTileShimmer() : availableKodeSurat == false ? Container(
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
                                      value: kodeSurat['master_surat_id'],
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
                                },
                              ),
                              margin: EdgeInsets.only(top: 15)
                          )
                      )
                    ],
                  ),
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
                        margin: EdgeInsets.only(top: 20, left: 20),
                      ),
                      Container(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                          child: TextFormField(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if(value.isEmpty) {
                                return "Data tidak boleh kosong";
                              }else if(value.isNotEmpty && RegExp(r"[0-9]+/[A-Z- a-z]+/[A-Z]+/[0-9]").hasMatch(value)) {
                                return null;
                              }else {
                                return "Masukkan data nomor surat yang valid";
                              }
                            },
                            controller: controllerNomorSurat,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                    borderSide: BorderSide(color: HexColor("#025393"))
                                ),
                                hintText: "Nomor Surat"
                            ),
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14
                            ),
                          ),
                        ),
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
                                        hintText: "Parindikan *",
                                      ),
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 14
                                      ),
                                    )
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
                                  child: Text("Mawit Saking *", style: TextStyle(
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
                                      controller: controllerAsalSurat,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(50.0),
                                            borderSide: BorderSide(color: HexColor("#025393"))
                                        ),
                                        hintText: "Mawit Saking",
                                      ),
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 14
                                      ),
                                    )
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
                                    child: Text("Tanggal Surat *", style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 14
                                    )),
                                    margin: EdgeInsets.only(top: 20, left: 20)
                                ),
                                Container(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                                    child: TextField(
                                      controller: controllerTanggalSurat,
                                      enabled: false,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(50.0),
                                              borderSide: BorderSide(color: HexColor("#025393"))
                                          ),
                                          hintText: "Tanggal surat belum terpilih",
                                          prefixIcon: Icon(CupertinoIcons.calendar)
                                      ),
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 14
                                      ),
                                    ),
                                  ),
                                  margin: EdgeInsets.only(top: 10),
                                ),
                                Container(
                                    child: FlatButton(
                                        onPressed: (){
                                          showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(1900),
                                              lastDate: DateTime(2900)
                                          ).then((value) {
                                            setState(() {
                                              selectedTanggalSurat = value;
                                              tanggalSurat = DateFormat("dd-MMM-yyyy").format(selectedTanggalSurat).toString();
                                              tanggalSuratValue = DateFormat("yyyy-MM-dd").format(selectedTanggalSurat).toString();
                                              controllerTanggalSurat.text = tanggalSurat;
                                            });
                                          });
                                        },
                                        child: Text("Pilih Tanggal", style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white
                                        )),
                                        color: HexColor("#025393"),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(25)
                                        ),
                                        padding: EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50)
                                    ),
                                    margin: EdgeInsets.only(top: 10)
                                )
                              ]
                          )
                      ),
                      Container(
                        child: Text("2. Daging Surat", style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14,
                            fontWeight: FontWeight.w700
                        )),
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(top: 30, left: 20),
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
                                  ),
                                  margin: EdgeInsets.only(top: 10),
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
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                                  child: TextField(
                                    controller: controllerWaktuKegiatan,
                                    enabled: false,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(50.0),
                                            borderSide: BorderSide(color: HexColor("#025393"))
                                        ),
                                        hintText: "Waktu Kegiatan",
                                        prefixIcon: Icon(CupertinoIcons.clock_fill)
                                    ),
                                    style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 14
                                    ),
                                  ),
                                ),
                                margin: EdgeInsets.only(top: 10),
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
                                            controllerWaktuKegiatan.text = startTime == null ? "--:--" : endTime == null ? "${startTime.hour}:${startTime.minute} - ${startTime.hour}:${startTime.minute}": "${startTime.hour}:${startTime.minute} - ${endTime.hour}:${endTime.minute}";
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
                        alignment: Alignment.topLeft,
                        child: Text("Berkas Surat *", style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14
                        )),
                        margin: EdgeInsets.only(top: 20, left: 20),
                      ),
                      Container(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                          child: TextField(
                            controller: controllerBerkasSurat,
                            enabled: false,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                    borderSide: BorderSide(color: HexColor("#025393"))
                                ),
                                hintText: "Berkas surat belum terpilih",
                                prefixIcon: Icon(CupertinoIcons.paperclip)
                            ),
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14
                            ),
                          ),
                        ),
                        margin: EdgeInsets.only(top: 10),
                      ),
                      Container(
                        child: FlatButton(
                            onPressed: (){
                              pilihBerkas();
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
                      Container(
                        child: FlatButton(
                            onPressed: () async {
                              if(selectedTanggalSurat == null || namaFile == null) {
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
                                                child: Text("Masih terdapat data yang kosong. Silahkan diperiksa kembali", style: TextStyle(
                                                    fontFamily: "Poppins",
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.white
                                                ))
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    toastDuration: Duration(seconds: 3)
                                );
                              }else if(formKey.currentState.validate()){
                                setState(() {
                                  Loading = true;
                                });
                                if(file != null) {
                                  Map<String, String> headers = {
                                    'Content-Type' : 'multipart/form-data'
                                  };
                                  var request = http.MultipartRequest('POST', Uri.parse(apiURLUploadFileSurat))
                                                    ..headers.addAll(headers)
                                                    ..files.add(await http.MultipartFile.fromPath('file', filePath));
                                  var response = await request.send();
                                  print(response.statusCode.toString());
                                  if(response.statusCode == 200) {
                                    var body = jsonEncode({
                                      "surat_keluar_id" : editSuratMasukAdmin.idSuratMasuk,
                                      "master_surat_id" : selectedKodeSurat,
                                      "nomor_surat" : controllerNomorSurat.text,
                                      "perihal" : controllerParindikan.text,
                                      "asal_surat" : controllerAsalSurat.text,
                                      "tanggal_surat" : tanggalSuratValue,
                                      "tanggal_kegiatan_mulai" : tanggalMulaiValue == null ? null : tanggalMulaiValue,
                                      "tanggal_kegiatan_berakhir" : tanggalMulaiValue == null ? null : tanggalBerakhir == null ? tanggalMulaiValue : tanggalBerakhirValue,
                                      "waktu_kegiatan_mulai" : startTime == null ? null : "${startTime.hour}:${startTime.minute}",
                                      "waktu_kegiatan_selesai" : startTime == null ? null : endTime == null ? "${startTime.hour}:${startTime.minute}" : "${endTime.hour}:${endTime.minute}",
                                      "file" : namaFile,
                                      "desa_adat_id" : loginPage.desaId
                                    });
                                    http.post(Uri.parse(apiURLSimpanSurat),
                                        headers: {"Content-Type" : "application/json"},
                                        body: body
                                    ).then((http.Response response) {
                                      var responseValue = response.statusCode;
                                      if(responseValue == 200) {
                                        setState(() {
                                          Loading = false;
                                        });
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
                                                      child: Text("Data surat masuk berhasil ditambahkan", style: TextStyle(
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
                                        Navigator.of(context).pop(true);
                                      }
                                    });
                                  }
                                }else{
                                  var body = jsonEncode({
                                    "surat_keluar_id" : editSuratMasukAdmin.idSuratMasuk,
                                    "master_surat_id" : selectedKodeSurat,
                                    "perihal" : controllerParindikan.text,
                                    "asal_surat" : controllerAsalSurat.text,
                                    "tanggal_surat" : tanggalSuratValue,
                                    "tanggal_kegiatan_mulai" : tanggalMulaiValue == null ? null : tanggalMulaiValue,
                                    "tanggal_kegiatan_berakhir" : tanggalMulaiValue == null ? null : tanggalBerakhir == null ? tanggalMulaiValue : tanggalBerakhirValue,
                                    "waktu_kegiatan_mulai" : startTime == null ? null : "${startTime.hour}:${startTime.minute}",
                                    "waktu_kegiatan_selesai" : startTime == null ? null : endTime == null ? "${startTime.hour}:${startTime.minute}" : "${endTime.hour}:${endTime.minute}",
                                    "file" : namaFile,
                                    "desa_adat_id" : loginPage.desaId,
                                    "nomor_surat" : controllerNomorSurat.text
                                  });
                                  http.post(Uri.parse(apiURLSimpanSurat),
                                      headers: {"Content-Type" : "application/json"},
                                      body: body
                                  ).then((http.Response response) {
                                    var responseValue = response.statusCode;
                                    print(responseValue);
                                    if(responseValue == 200) {
                                      setState(() {
                                        Loading = false;
                                      });
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
                                                    child: Text("Data surat masuk berhasil ditambahkan", style: TextStyle(
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
                                      Navigator.of(context).pop(true);
                                    }
                                  });
                                }
                              }else {
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
                                              child: Text("Masih terdapat data yang kosong atau tidak valid. Silahkan periksa kembali", style: TextStyle(
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
                        margin: EdgeInsets.only(top: 20, bottom: 20),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        )
      )
    );
  }
}