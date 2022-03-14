import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:surat/shared/LoadingAnimation/loading.dart';

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
  var apiURLShowDetailPrajuruDesaAdat = "http://192.168.18.10:8000/api/data/staff/prajuru_desa_adat/edit/${editPrajuruDesaAdatAdmin.idPegawai}";
  var apiURLSimpanPrajuruDesaAdat = "http://192.168.18.10:8000/api/admin/prajuru/desa_adat/edit/up";
  bool Loading = false;

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
          selectedMasaMulaiValue = parsedJson['tanggal_mulai_menjabat'];
          masaMulai = new DateFormat("yyyy-mm-dd").parse(selectedMasaMulaiValue);
          selectedMasaBerakhirValue = parsedJson['tanggal_akhir_menjabat'];
          masaBerakhir = new DateFormat("yyyy-mm-dd").parse(selectedMasaBerakhirValue);
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPrajuruDesaAdatInfo();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Loading ? loading() : Scaffold(
        appBar: AppBar(
          title: Text("Edit Pegawai Desa Adat", style: TextStyle(
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
        body: masaMulai == null ? Center(
          child: Lottie.asset('assets/loading-circle.json')
        ) : SingleChildScrollView(
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
                          child: Text("Masa Mulai Menjabat *", style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 14
                          )),
                          margin: EdgeInsets.only(top: 20, left: 20),
                        ),
                        Container(
                            child: Text(selectedMasaMulai == null ? "${masaMulai.day.toString()} - ${masaMulai.month.toString()} - ${masaBerakhir.year.toString()}" : selectedMasaMulai, style: TextStyle(
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
                                  masaMulai = value;
                                  var tanggal = DateTime.parse(masaMulai.toString());
                                  selectedMasaMulai = "${tanggal.day} - ${tanggal.month} - ${tanggal.year}";
                                  selectedMasaMulaiValue = "${tanggal.year}-${tanggal.month}-${tanggal.day}";
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
                            padding: EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50),
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
                            child: Text("Masa Berakhir Menjabat", style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14
                            )),
                            alignment: Alignment.topLeft,
                            margin: EdgeInsets.only(top: 20, left: 20)
                        ),
                        Container(
                            child: Text(selectedMasaBerakhir == null ? "${masaBerakhir.day.toString()} - ${masaBerakhir.month.toString()} - ${masaBerakhir.year.toString()}" : selectedMasaBerakhir, style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w700,
                                fontSize: 14
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
                                  masaBerakhir = value;
                                  var tanggal = DateTime.parse(masaBerakhir.toString());
                                  selectedMasaBerakhir = "${tanggal.day} - ${tanggal.month} - ${tanggal.year}";
                                  selectedMasaBerakhirValue = "${tanggal.year}-${tanggal.month}-${tanggal.day}";
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
                            padding: EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50),
                          ),
                          margin: EdgeInsets.only(top: 10),
                        )
                      ]
                  )
              ),
              Container(
                child: FlatButton(
                  onPressed: (){
                    if(masaBerakhir.isBefore(masaMulai)) {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context){
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
                                            child: Text("Tanggal masa berakhir tidak valid", style: TextStyle(
                                                fontFamily: "Poppins",
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                color: HexColor("#025393")
                                            ), textAlign: TextAlign.center),
                                            margin: EdgeInsets.only(top: 10)
                                        ),
                                        Container(
                                            child: Text("Tanggal masa berakhir tidak valid. Silahkan masukkan tanggal masa berakhir karyawan di hari setelah masa mulai karyawan dan coba lagi", style: TextStyle(
                                                fontFamily: "Poppins",
                                                fontSize: 14
                                            ), textAlign: TextAlign.center),
                                            margin: EdgeInsets.only(top: 10)
                                        )
                                      ]
                                  ),
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
                      setState(() {
                        Loading = true;
                      });
                      var body = jsonEncode({
                        "prajuru_desa_adat_id" : editPrajuruDesaAdatAdmin.idPegawai,
                        "jabatan" : selectedJabatan,
                        "masa_mulai_menjabat" : selectedMasaMulaiValue,
                        "masa_akhir_menjabat" : selectedMasaBerakhirValue
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
                            msg: "Data pegawai berhasil diperbaharui",
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