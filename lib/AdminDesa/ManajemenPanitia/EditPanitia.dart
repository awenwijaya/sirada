import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:surat/shared/LoadingAnimation/loading.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class editPanitiaDesaAdatAdmin extends StatefulWidget {
  static var panitiaId;
  const editPanitiaDesaAdatAdmin({Key key}) : super(key: key);

  @override
  State<editPanitiaDesaAdatAdmin> createState() => _editPanitiaDesaAdatAdminState();
}

class _editPanitiaDesaAdatAdminState extends State<editPanitiaDesaAdatAdmin> {
  //list
  List panitiaKegiatanList = List();
  List<String> jabatan = ['Ketua Panitia', 'Wakil Panitia', 'Sekretaris Panitia', 'Bendahara Panitia'];

  //Selected
  var selectedIdPanitiaKegiatan;
  var selectedJabatan;
  String selectedPeriodeMulai;
  String selectedPeriodeMulaiValue;
  String selectedPeriodeBerakhir;
  String selectedPeriodeBerakhirValue;
  var namaPanitia;

  //DateTime
  DateTime selectPeriodeMulai;
  DateTime selectPeriodeSelesai;
  DateTime sekarang = DateTime.now();

  //Controller
  final DateRangePickerController controllerPeriode = DateRangePickerController();
  final controllerMasaMenjabat = TextEditingController();
  FToast ftoast;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  //url
  var apiURLGetPanitiaKegiatan = "https://siradaskripsi.my.id/api/panitia/kegiatan/view";
  var apiURLGetDataPanitiaKegiatan = "https://siradaskripsi.my.id/api/panitia/edit/show/${editPanitiaDesaAdatAdmin.panitiaId}";
  var apiURLSimpanDataPanitiaKegiatan = "https://siradaskripsi.my.id/api/panitia/edit/save";

  //Bool
  bool availablePanitiaKegiatan = false;
  bool LoadingPanitiaKegiatan = true;
  bool Loading = false;
  bool LoadingData = true;

  Future getPanitiaKegiatan() async {
    Uri uri = Uri.parse(apiURLGetPanitiaKegiatan);
    final response = await http.get(uri);
    if(response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        panitiaKegiatanList = jsonData;
        LoadingPanitiaKegiatan = false;
        availablePanitiaKegiatan = true;
      });
    }else {
      setState(() {
        setState(() {
          availablePanitiaKegiatan = false;
          LoadingPanitiaKegiatan = false;
        });
      });
    }
  }

  Future getDataPanitia() async {
    Uri uri = Uri.parse(apiURLGetDataPanitiaKegiatan);
    final response = await http.get(uri);
    if(response.statusCode == 200) {
      var jsonData = response.body;
      var parsedJson = json.decode(jsonData);
      setState(() {
        selectedIdPanitiaKegiatan = int.parse(parsedJson['kegiatan_panitia_id']);
        namaPanitia = parsedJson['nama'];
        selectedJabatan = parsedJson['jabatan'];
        selectPeriodeMulai = DateTime.parse(parsedJson['tanggal_mulai_menjabat']);
        selectPeriodeSelesai = DateTime.parse(parsedJson['tanggal_akhir_menjabat']);
        selectedPeriodeMulai = DateFormat("dd-MMM-yyyy").format(selectPeriodeMulai).toString();
        selectedPeriodeBerakhir = DateFormat("dd-MMM-yyyy").format(selectPeriodeSelesai).toString();
        selectedPeriodeMulaiValue = DateFormat("yyyy-MM-dd").format(selectPeriodeMulai).toString();
        selectedPeriodeBerakhirValue = DateFormat("yyyy-MM-dd").format(selectPeriodeSelesai).toString();
        controllerMasaMenjabat.text = "$selectedPeriodeMulai - $selectedPeriodeBerakhir";
        controllerPeriode.selectedRange = PickerDateRange(selectPeriodeMulai, selectPeriodeSelesai);
        LoadingData = false;
      });
    }
  }

  void SelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      selectPeriodeSelesai = args.value.endDate;
      selectedPeriodeMulai = DateFormat("dd-MMM-yyyy").format(args.value.startDate).toString();
      selectedPeriodeMulaiValue = DateFormat("yyyy-MM-dd").format(args.value.startDate).toString();
      selectedPeriodeBerakhir = DateFormat("dd-MMM-yyyy").format(args.value.endDate?? args.value.startDate).toString();
      selectedPeriodeBerakhirValue = DateFormat("yyyy-MM-dd").format(args.value.endDate ?? args.value.startDate).toString();
      controllerMasaMenjabat.text = selectedPeriodeBerakhirValue == null ? "$selectedPeriodeMulai - $selectedPeriodeMulai" : "$selectedPeriodeMulai - $selectedPeriodeBerakhir";
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ftoast = FToast();
    ftoast.init(this.context);
    getDataPanitia();
    getPanitiaKegiatan();
    selectedPeriodeMulai = DateFormat("dd-MMM-yyyy").format(sekarang).toString();
    selectedPeriodeBerakhir = DateFormat("dd-MMM-yyyy").format(sekarang.add(Duration(days: 7))).toString();
    controllerPeriode.selectedRange = PickerDateRange(sekarang, sekarang.add(Duration(days: 7)));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Loading ? loading() : Scaffold(
        appBar: AppBar(
          title: Text("Edit Panitia Kegiatan", style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w700,
            color: HexColor("#025393")
          )),
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: HexColor("#025393"),
            onPressed: (){Navigator.of(context).pop();},
          ),
        ),
        body: LoadingData ? ProfilePageShimmer() : SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'images/panitia.png',
                    height: 100,
                    width: 100,
                  ),
                  margin: EdgeInsets.only(top: 30),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text("1. Data Tim Kegiatan Kepanitiaan *", style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14,
                    fontWeight: FontWeight.w700
                  )),
                  margin: EdgeInsets.only(top: 30, left: 20),
                ),
                Container(
                  alignment: Alignment.center,
                  child: LoadingPanitiaKegiatan ? ListTileShimmer() : availablePanitiaKegiatan ? Container(
                    width: 300,
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    decoration: BoxDecoration(
                      color: HexColor("#025393"),
                      borderRadius: BorderRadius.circular(30)
                    ),
                    child: DropdownButton(
                      isExpanded: true,
                      hint: Center(
                        child: Text("Pilih Panitia Kegiatan", style: TextStyle(
                          fontFamily: "Poppins",
                          color: Colors.white,
                          fontSize: 14
                        )),
                      ),
                      value: selectedIdPanitiaKegiatan,
                      underline: Container(),
                      icon: Icon(Icons.arrow_downward, color: Colors.white),
                      items: panitiaKegiatanList.map((panitiaKegiatan) {
                        return DropdownMenuItem(
                          value: panitiaKegiatan['kegiatan_panitia_id'],
                          child: Text(panitiaKegiatan['panitia'], style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14
                          )),
                        );
                      }).toList(),
                      selectedItemBuilder: (BuildContext context) => panitiaKegiatanList.map((panitiaKegiatan) => Center(
                        child: Text(panitiaKegiatan['panitia'], style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 14,
                          color: Colors.white
                        )),
                      )).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedIdPanitiaKegiatan = value;
                        });
                      },
                    ),
                    margin: EdgeInsets.only(top: 15),
                  ) : Container(
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          child: Flexible(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  child: Text("Tidak ada Data Tim Kegiatan Kepanitiaan", style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white
                                  )),
                                ),
                                Container(
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.7,
                                    child: Text("Silahkan inputkan nama tim kegiatan kepanitiaan pada Text Box dibawah", style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 14,
                                        color: Colors.white
                                    )),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                        color: HexColor("B20600"),
                        borderRadius: BorderRadius.circular(25)
                    ),
                    padding: EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
                    margin: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 5),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text("2. Data Diri", style: TextStyle(
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
                            child: Text("Jabatan *", style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14
                            )),
                            margin: EdgeInsets.only(top: 20, left: 20),
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
                                    color: Colors.white,
                                    fontSize: 14
                                )),
                              ),
                              icon: Icon(Icons.arrow_downward, color: Colors.white),
                              isExpanded: true,
                              items: jabatan.map((e) {
                                return DropdownMenuItem(
                                  value: e,
                                  child: Text(e, style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 14
                                  )),
                                );
                              }).toList(),
                              selectedItemBuilder: (BuildContext context) => jabatan.map((e) => Center(
                                child: Text(e, style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontFamily: "Poppins"
                                )),
                              )).toList(),
                            ),
                            margin: EdgeInsets.only(top: 10),
                          )
                        ]
                    )
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text("Periode Menjabat *", style: TextStyle(
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
                                hintText: "Periode menjabat belum terpilih",
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
                            controller: controllerPeriode,
                            selectionMode: DateRangePickerSelectionMode.range,
                            onSelectionChanged: SelectionChanged,
                            allowViewNavigation: true,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  child: FlatButton(
                    onPressed: (){
                      if(selectPeriodeSelesai.isBefore(sekarang)) {
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
                                      child: Text("Periode selesai tidak valid. Silahkan masukkan tanggal periode selesai setelah tanggal hari ini dan coba lagi", style: TextStyle(
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
                      }else {
                        setState(() {
                          Loading = true;
                        });
                        var body = jsonEncode({
                          "panitia_desa_adat_id" : editPanitiaDesaAdatAdmin.panitiaId,
                          "jabatan" : selectedJabatan,
                          "tanggal_mulai_menjabat" : selectedPeriodeMulaiValue,
                          "tanggal_akhir_menjabat" : selectedPeriodeBerakhirValue,
                          "kegiatan_panitia_id" : selectedIdPanitiaKegiatan
                        });
                        http.post(Uri.parse(apiURLSimpanDataPanitiaKegiatan),
                          headers: {"Content-Type" : "application/json"},
                          body: body
                        ).then((http.Response response) {
                          var responseValue = response.statusCode;
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
                                          child: Text("Data panitia kegiatan berhasil diperbaharui!", style: TextStyle(
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
                          }else if(response.statusCode == 500) {
                            setState(() {
                              Loading = false;
                            });
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
                                          child: Text("Tidak bisa menyimpan panitia karena jabatan yang terpilih sudah terisi. Silahkan pilih jabatan lain dan coba lagi", style: TextStyle(
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
                    padding: EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50),
                  ),
                  margin: EdgeInsets.only(top: 20, bottom: 20),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}