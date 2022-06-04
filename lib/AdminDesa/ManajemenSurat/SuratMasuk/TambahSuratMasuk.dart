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

class tambahSuratMasukAdmin extends StatefulWidget {
  const tambahSuratMasukAdmin({Key key}) : super(key: key);

  @override
  State<tambahSuratMasukAdmin> createState() => _tambahSuratMasukAdminState();
}

class _tambahSuratMasukAdminState extends State<tambahSuratMasukAdmin> {
  var selectedKodeSurat;
  List kodeSuratList = List();
  var apiURLGetKodeSurat = "https://siradaskripsi.my.id/api/data/nomorsurat";
  var apiURLSimpanSurat = "https://siradaskripsi.my.id/api/admin/surat/masuk/up";
  bool availableKodeSurat = false;
  bool KodeSuratLoading = true;
  bool Loading = false;
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
  File file;
  String namaFile;
  String filePath;
  final controllerNomorSurat = TextEditingController();
  final controllerParindikan = TextEditingController();
  final controllerAsalSurat = TextEditingController();
  final controllerBerkasSurat = TextEditingController();
  FToast ftoast;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getKodeSurat();
    final DateTime sekarang = DateTime.now();
    tanggalMulai = DateFormat("dd-MMM-yyyy").format(sekarang).toString();
    tanggalBerakhir = DateFormat("dd-MMM-yyyy").format(sekarang.add(Duration(days: 7))).toString();
    tanggalSurat = DateFormat("dd-MMM-yyyy").format(sekarang).toString();
    tanggalSuratValue = DateFormat("yyyy-MM-dd").format(sekarang).toString();
    controllerTanggalKegiatan.selectedRange = PickerDateRange(sekarang, sekarang.add(Duration(days: 7)));
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
          title: Text("Tambah Surat Masuk", style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w700,
            color: HexColor("#025393")
          )),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'images/email.png',
                    height: 100,
                    width: 100,
                  ),
                  margin: EdgeInsets.only(top: 30),
                ),
                Container(
                  child: Text("* = diperlukan", style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ), textAlign: TextAlign.center),
                  margin: EdgeInsets.only(top: 20, left: 20),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text("1. Atribut Surat", style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 14,
                      fontWeight: FontWeight.w700
                  )),
                  margin: EdgeInsets.only(top: 30, left: 20),
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
                      )
                    ],
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
                              child: Text(tanggalSurat, style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700
                              )),
                              margin: EdgeInsets.only(top: 10)
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
                              child: Text(tanggalMulaiValue == null ? "Tanggal kegiatan belum terpilih" : tanggalBerakhirValue == null ? "$tanggalMulai - $tanggalMulai" : "$tanggalMulai - $tanggalBerakhir", style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
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
                              }else if(formKey.currentState.validate()) {
                                setState(() {
                                  Loading = true;
                                });
                                Map<String, String> headers = {
                                  'Content-Type' : 'multipart/form-data'
                                };
                                Map<String, String> body = {
                                  "master_surat_id" : selectedKodeSurat.toString(),
                                  "perihal" : controllerParindikan.text,
                                  "asal_surat" : controllerAsalSurat.text,
                                  "tanggal_surat" : tanggalSuratValue.toString(),
                                  "tanggal_kegiatan_mulai" : tanggalMulaiValue.toString() == null ? null : tanggalMulaiValue.toString(),
                                  "tanggal_kegiatan_berakhir" : tanggalMulaiValue.toString() == null ? null : tanggalBerakhir.toString() == null ? tanggalMulaiValue.toString() : tanggalBerakhirValue.toString(),
                                  "waktu_kegiatan_mulai" : startTime == null ? null : "${startTime.hour}:${startTime.minute}",
                                  "waktu_kegiatan_selesai" : startTime == null ? null : endTime == null ? "${startTime.hour}:${startTime.minute}" : "${endTime.hour}:${endTime.minute}",
                                  "desa_adat_id" : loginPage.desaId.toString(),
                                  "prajuru_desa_adat_id" : loginPage.prajuruId.toString(),
                                  "nomor_surat" : controllerNomorSurat.text
                                };
                                var request = http.MultipartRequest('POST', Uri.parse(apiURLSimpanSurat))
                                                  ..fields.addAll(body)
                                                  ..headers.addAll(headers)
                                                  ..files.add(await http.MultipartFile.fromPath('surat', file.path));
                                var response = await request.send();
                                if(response.statusCode == 200) {
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
                )
              ],
            )
          )
        )
      ),
    );
  }
}