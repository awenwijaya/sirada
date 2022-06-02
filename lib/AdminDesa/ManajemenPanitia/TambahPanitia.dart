import 'dart:convert';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class tambahPanitiaKegiatanAdmin extends StatefulWidget {
  const tambahPanitiaKegiatanAdmin({Key key}) : super(key: key);

  @override
  State<tambahPanitiaKegiatanAdmin> createState() => _tambahPanitiaKegiatanAdminState();
}

class _tambahPanitiaKegiatanAdminState extends State<tambahPanitiaKegiatanAdmin> {
  var selectedIdPanitiaKegiatan;
  List panitiaKegiatanList = List();
  var apiURLGetPanitiaKegiatan = "http://siradaskripsi.my.id/api/panitia/kegiatan/view";
  bool availablePanitiaKegiatan = false;
  bool LoadingPanitiaKegiatan = true;
  bool Loading = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  FToast ftoast;
  final controllerNamaTimKegiatan = TextEditingController();

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ftoast = FToast();
    ftoast.init(this.context);
    getPanitiaKegiatan();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: HexColor("#025393"),
            onPressed: (){
              Navigator.of(context).pop();
            },
          ),
          title: Text("Tambah Panitia Kegiatan", style: TextStyle(
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
                    'images/panitia.png',
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
                  alignment: Alignment.topLeft,
                  child: Text("1. Data Tim Kegiatan Kepanitiaan *", style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14,
                    fontWeight: FontWeight.w700
                  )),
                  margin: EdgeInsets.only(top: 30, left: 20),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text("Silahkan pilih tim kegiatan kepanitiaan terlebih dahulu.", style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14
                  )),
                  padding: EdgeInsets.only(left: 30, right: 30),
                  margin: EdgeInsets.only(top: 10),
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
                  child: Text("Jika tim kegiatan kepanitiaan tidak terdaftar di dalam list, silahkan masukkan nama tim kegiatan kepanitiaan secara manual.", style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 14
                  )),
                  padding: EdgeInsets.only(left: 30, right: 30),
                  margin: EdgeInsets.only(top: 15),
                ),
                Container(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if(value.isEmpty && selectedIdPanitiaKegiatan == null) {
                          return "Data tim kegiatan kepanitiaan tidak boleh kosong";
                        }else if(value.isNotEmpty && selectedIdPanitiaKegiatan != null) {
                          return "Data tidak perlu diisi";
                        }else {
                          return null;
                        }
                      },
                      controller: controllerNamaTimKegiatan,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          borderSide: BorderSide(color: HexColor("#025393"))
                        ),
                        hintText: "Tim Kegiatan Kepanitiaan"
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
          )
        ),
      ),
    );
  }
}