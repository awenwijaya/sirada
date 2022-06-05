import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:surat/shared/LoadingAnimation/loading.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class editPrajuruBanjarAdatAdmin extends StatefulWidget {
  static var idPegawai;
  const editPrajuruBanjarAdatAdmin({Key key}) : super(key: key);

  @override
  State<editPrajuruBanjarAdatAdmin> createState() => _editPrajuruBanjarAdatAdminState();
}

class _editPrajuruBanjarAdatAdminState extends State<editPrajuruBanjarAdatAdmin> {
  List<String> jabatan = ['kelihan_adat','pangliman_banjar','penyarikan_banjar','patengen_banjar'];
  String selectedJabatan;
  String selectedMasaMulai;
  String selectedMasaMulaiValue;
  String selectedMasaBerakhir;
  String selectedMasaBerakhirValue;
  DateTime masaMulai;
  DateTime masaBerakhir;
  DateTime sekarang = DateTime.now();
  var apiURLShowDetailPrajuruBanjarAdat = "https://siradaskripsi.my.id/api/data/staff/prajuru_banjar_adat/edit/${editPrajuruBanjarAdatAdmin.idPegawai}";
  var apiURLSimpanPrajuruBanjarAdat = "https://siradaskripsi.my.id/api/admin/prajuru/banjar_adat/edit/up";
  var apiURLUploadFileSKPrajuru = "https://siradaskripsi.my.id/api/upload/sk-prajuru";
  var selectedIdPenduduk;
  bool Loading = false;
  final controllerEmail = TextEditingController();
  final controllerNamaFile = TextEditingController();
  final controllerMasaMenjabat = TextEditingController();
  final DateRangePickerController controllerMasaAktif = DateRangePickerController();
  File file;
  String namaFile;
  String filePath;
  FToast ftoast;

  getPrajuruBanjarAdatInfo() async {
    http.get(Uri.parse(apiURLShowDetailPrajuruBanjarAdat),
      headers: {"Content-Type" : "application/json"},
    ).then((http.Response response) {
      var responseValue = response.statusCode;
      if(responseValue == 200) {
        var jsonData = response.body;
        var parsedJson = json.decode(jsonData);
        setState(() {
          selectedJabatan = parsedJson['jabatan'];
          masaMulai = DateTime.parse(parsedJson['tanggal_mulai_menjabat']);
          selectedMasaMulaiValue = DateFormat("yyyy-MM-dd").format(masaMulai).toString();
          masaBerakhir = DateTime.parse(parsedJson['tanggal_akhir_menjabat']);
          selectedMasaBerakhirValue = DateFormat("yyyy-MM-dd").format(masaBerakhir).toString();
          selectedMasaMulai = DateFormat("dd-MMM-yyyy").format(masaMulai).toString();
          selectedMasaBerakhir = DateFormat("dd-MMM-yyyy").format(masaBerakhir).toString();
          controllerMasaMenjabat.text = selectedMasaBerakhirValue == null ? "$selectedMasaMulai - $selectedMasaMulai" : "$selectedMasaMulai - $selectedMasaBerakhir";
          controllerMasaAktif.selectedRange = PickerDateRange(masaMulai, masaBerakhir);
          controllerEmail.text = parsedJson['email'];
          selectedIdPenduduk = parsedJson['penduduk_id'];
          namaFile = parsedJson['sk_prajuru_banjar'];
          controllerNamaFile.text = parsedJson['sk_prajuru_banjar'];
        });
      }
    });
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
        controllerNamaFile.text = namaFile;
      });
      print(filePath);
      print(namaFile);
    }
  }

  void selectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      masaBerakhir = args.value.endDate;
      selectedMasaMulai = DateFormat("dd-MMM-yyyy").format(args.value.startDate).toString();
      selectedMasaMulaiValue = DateFormat("yyyy-MM-dd").format(args.value.startDate).toString();
      selectedMasaBerakhir = DateFormat("dd-MMM-yyyy").format(args.value.endDate ?? args.value.startDate).toString();
      selectedMasaBerakhirValue = DateFormat("yyyy-MM-dd").format(args.value.endDate ?? args.value.startDate).toString();
      controllerMasaMenjabat.text = selectedMasaBerakhirValue == null ? "$selectedMasaMulai - $selectedMasaMulai" : "$selectedMasaMulai - $selectedMasaBerakhir";
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPrajuruBanjarAdatInfo();
    final DateTime sekarang = DateTime.now();
    selectedMasaMulai = DateFormat("dd-MMM-yyyy").format(masaMulai == null ? sekarang : masaMulai).toString();
    selectedMasaBerakhir = DateFormat("dd-MMM-yyyy").format(masaBerakhir == null ? sekarang : masaBerakhir).toString();
    controllerMasaAktif.selectedRange = PickerDateRange(masaMulai == null ? sekarang : masaMulai, masaBerakhir == null ? sekarang : masaBerakhir);
    ftoast = FToast();
    ftoast.init(this.context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Loading ? loading() : Scaffold(
        appBar: AppBar(
          title: Text("Edit Prajuru Banjar Adat", style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w700,
            color: HexColor("#025393")
          )),
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: HexColor("#025393"),
            onPressed: (){Navigator.of(context).pop(true);},
          )
        ),
        body: masaMulai == null ? ProfilePageShimmer() : SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.topLeft,
                child: Text("1. Data Prajuru", style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14,
                  fontWeight: FontWeight.w700
                )),
                margin: EdgeInsets.only(top: 20, left: 20),
              ),
              Container(
                  child: Column(
                      children: <Widget>[
                        Container(
                            alignment: Alignment.topLeft,
                            child: Text("Jabatan *", style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14
                            )),
                            margin: EdgeInsets.only(top: 10, left: 20)
                        ),
                        Container(
                            width: 300,
                            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                            decoration: BoxDecoration(
                                color: HexColor("#025393"),
                                borderRadius: BorderRadius.circular(30)
                            ),
                            child: DropdownButton<String>(
                              onChanged: (value) {
                                setState(() {
                                  selectedJabatan = value;
                                });
                              },
                              value: selectedJabatan,
                              underline: Container(),
                              hint: Center(
                                  child: Text("Pilih Jabatan", style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 14,
                                      color: Colors.white
                                  ))
                              ),
                              icon: Icon(Icons.arrow_downward, color: Colors.white),
                              isExpanded: true,
                              items: jabatan.map((e) => DropdownMenuItem(
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  child: Text(e, style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 14
                                  )),
                                ),
                                value: e,
                              )).toList(),
                              selectedItemBuilder: (BuildContext context) => jabatan.map((e) => Center(
                                  child: Text(e, style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontFamily: "Poppins"
                                  ))
                              )).toList(),
                            ),
                            margin: EdgeInsets.only(top: 20)
                        )
                      ]
                  )
              ),
              Container(
                  child: Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text("Masa Jabatan *", style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 14
                          )),
                          margin: EdgeInsets.only(top: 20, left: 20),
                        ),
                        Container(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                            child: TextField(
                              controller: controllerMasaMenjabat,
                              enabled: false,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50.0),
                                      borderSide: BorderSide(color: HexColor("#025393"))
                                  ),
                                  hintText: "Masa menjabat belum terpilih",
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
                                margin: EdgeInsets.fromLTRB(50, 10, 50, 10),
                                child: SfDateRangePicker(
                                  controller: controllerMasaAktif,
                                  selectionMode: DateRangePickerSelectionMode.range,
                                  onSelectionChanged: selectionChanged,
                                  allowViewNavigation: true,
                                )
                            )
                        )
                      ]
                  )
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text("2. File SK", style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14,
                  fontWeight: FontWeight.w700
                )),
                margin: EdgeInsets.only(top: 30, left: 20),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                  child: TextField(
                    controller: controllerNamaFile,
                    enabled: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        borderSide: BorderSide(color: HexColor("#025393"))
                      ),
                      hintText: "Berkas SK belum terpilih",
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
                margin: EdgeInsets.only(top: 20)
              ),
              Container(
                child: FlatButton(
                  onPressed: () async {
                    if(masaBerakhir.isBefore(sekarang)) {
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
                                  child: Text("Masa jabatan tidak valid. Silahkan masukkan tanggal masa akhir setelah tanggal hari ini dan coba lagi", style: TextStyle(
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
                    }else{
                      setState(() {
                        Loading = true;
                      });
                      if(file!=null) {
                        Map<String, String> headers = {
                          'Content-Type' : 'multipart/form-data'
                        };
                        var request = http.MultipartRequest('POST', Uri.parse(apiURLUploadFileSKPrajuru))
                          ..headers.addAll(headers)
                          ..files.add(await http.MultipartFile.fromPath('file', filePath));
                        var response = await request.send();
                        if(response.statusCode == 200) {
                          var body = jsonEncode({
                            "prajuru_banjar_adat_id" : editPrajuruBanjarAdatAdmin.idPegawai,
                            "jabatan" : selectedJabatan,
                            "masa_mulai_menjabat" : selectedMasaMulaiValue,
                            "masa_akhir_menjabat" : selectedMasaBerakhirValue,
                            'penduduk_id' : selectedIdPenduduk,
                            'sk_prajuru' : namaFile
                          });
                          http.post(Uri.parse(apiURLSimpanPrajuruBanjarAdat),
                              headers : {"Content-Type" : "application/json"},
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
                                            child: Text("Data Prajuru Banjar Adat berhasil diperbaharui", style: TextStyle(
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
                          "prajuru_banjar_adat_id" : editPrajuruBanjarAdatAdmin.idPegawai,
                          "jabatan" : selectedJabatan,
                          "masa_mulai_menjabat" : selectedMasaMulaiValue,
                          "masa_akhir_menjabat" : selectedMasaBerakhirValue,
                          'penduduk_id' : selectedIdPenduduk,
                          'sk_prajuru' : namaFile
                        });
                        http.post(Uri.parse(apiURLSimpanPrajuruBanjarAdat),
                            headers : {"Content-Type" : "application/json"},
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
                                          child: Text("Data Prajuru Banjar Adat berhasil diperbaharui", style: TextStyle(
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