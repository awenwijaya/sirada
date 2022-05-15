import 'dart:convert';

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

class editPrajuruDesaAdatAdmin extends StatefulWidget {
  static var idPegawai;
  const editPrajuruDesaAdatAdmin({Key key}) : super(key: key);

  @override
  State<editPrajuruDesaAdatAdmin> createState() => _editPrajuruDesaAdatAdminState();
}

class _editPrajuruDesaAdatAdminState extends State<editPrajuruDesaAdatAdmin> {
  List<String> jabatan = ["bendesa", "pangliman", "penyarikan", "patengen"];
  String selectedJabatan;
  String selectedMasaMulai;
  String selectedMasaMulaiValue;
  String selectedMasaBerakhir;
  String selectedMasaBerakhirValue;
  DateTime masaMulai;
  DateTime masaBerakhir;
  DateTime sekarang = DateTime.now();
  final DateRangePickerController controllerMasaAktif = DateRangePickerController();
  var apiURLShowDetailPrajuruDesaAdat = "http://192.168.138.149:8000/api/data/staff/prajuru_desa_adat/edit/${editPrajuruDesaAdatAdmin.idPegawai}";
  var apiURLSimpanPrajuruDesaAdat = "http://192.168.138.149:8000/api/admin/prajuru/desa_adat/edit/up";
  var selectedIdPenduduk;
  var selectedRole;
  bool Loading = false;
  final controllerEmail = TextEditingController();

  getPrajuruDesaAdatInfo() async {
    http.get(Uri.parse(apiURLShowDetailPrajuruDesaAdat),
      headers: {"Content-Type" : "application/json"}
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
          controllerMasaAktif.selectedRange = PickerDateRange(masaMulai, masaBerakhir);
          controllerEmail.text = parsedJson['email'];
          selectedIdPenduduk = parsedJson['penduduk_id'];
        });
      }
    });
  }

  void selectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      selectedMasaMulai = DateFormat("dd-MMM-yyyy").format(args.value.startDate).toString();
      selectedMasaMulaiValue = DateFormat("yyyy-MM-dd").format(args.value.startDate).toString();
      selectedMasaBerakhir = DateFormat("dd-MMM-yyyy").format(args.value.endDate ?? args.value.startDate).toString();
      selectedMasaBerakhirValue = DateFormat("yyyy-MM-dd").format(args.value.endDate ?? args.value.startDate).toString();
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPrajuruDesaAdatInfo();
    final DateTime sekarang = DateTime.now();
    selectedMasaMulai = DateFormat("dd-MMM-yyyy").format(masaMulai == null ? sekarang : masaMulai).toString();
    selectedMasaBerakhir = DateFormat("dd-MMM-yyyy").format(masaBerakhir == null ? sekarang : masaBerakhir).toString();
    controllerMasaAktif.selectedRange = PickerDateRange(masaMulai == null ? sekarang : masaMulai, masaBerakhir == null ? sekarang : masaBerakhir);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Loading ? loading() : Scaffold(
        appBar: AppBar(
          title: Text("Edit Prajuru Desa Adat", style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w700,
            color: HexColor("#025393")
          )),
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: HexColor("#025393"),
            onPressed: (){Navigator.of(context).pop(true);},
          ),
        ),
        body: masaMulai == null ? ProfilePageShimmer() : SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: Image.asset(
                  'images/person.png',
                  height: 100,
                  width: 100,
                ),
                margin: EdgeInsets.only(top: 30)
              ),
              Container(
                child: Text("* = diperlukan", style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14,
                  fontWeight: FontWeight.w700
                ), textAlign: TextAlign.center),
                margin: EdgeInsets.only(top: 20),
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
                      margin: EdgeInsets.only(top: 20, left: 20)
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
                            child: Text(selectedMasaMulaiValue == null ? "Masa aktif belum terpilih" : selectedMasaBerakhirValue == null ? "$selectedMasaMulai - $selectedMasaMulai" : "$selectedMasaMulai - $selectedMasaBerakhir", style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14,
                                fontWeight: FontWeight.w700
                            )),
                            margin: EdgeInsets.only(top: 10)
                        ),
                        Container(
                            child: Card(
                                margin: EdgeInsets.fromLTRB(50, 40, 50, 10),
                                child: SfDateRangePicker(
                                  controller: controllerMasaAktif,
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
                      child: Text("Email *", style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14
                      )),
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(top: 20, left: 20)
                    ),
                    Container(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                        child: TextField(
                          controller: controllerEmail,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              borderSide: BorderSide(color: HexColor("#025393"))
                            ),
                            hintText: "Email",
                            prefixIcon: Icon(Icons.alternate_email)
                          ),
                          keyboardType: TextInputType.emailAddress,
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
                child: FlatButton(
                  onPressed: (){
                    setState(() {
                      Loading = true;
                    });
                    if(selectedJabatan == "bendesa") {
                      setState(() {
                        selectedRole = "Bendesa";
                      });
                    }else{
                      setState(() {
                        selectedRole = "Admin";
                      });
                    }
                    var body = jsonEncode({
                      "prajuru_desa_adat_id" : editPrajuruDesaAdatAdmin.idPegawai,
                      "jabatan" : selectedJabatan,
                      "masa_mulai_menjabat" : selectedMasaMulaiValue,
                      "masa_akhir_menjabat" : selectedMasaBerakhirValue,
                      'penduduk_id' : selectedIdPenduduk,
                      'email' : controllerEmail.text,
                      'role' : selectedRole
                    });
                    http.post(Uri.parse(apiURLSimpanPrajuruDesaAdat),
                        headers : {"Content-Type" : "application/json"},
                        body : body
                    ).then((http.Response response) {
                      var responseValue = response.statusCode;
                      if(responseValue == 200) {
                        setState(() {
                          Loading = false;
                        });
                        Fluttertoast.showToast(
                            msg: "Data prajuru berhasil diperbaharui",
                            fontSize: 14,
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER
                        );
                        Navigator.of(context).pop(true);
                      }
                    });
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
            ]
          )
        )
      )
    );
  }
}