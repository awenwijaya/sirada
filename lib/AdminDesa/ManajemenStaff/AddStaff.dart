import 'dart:convert';
import 'package:surat/AdminDesa/Dashboard.dart';
import 'package:surat/shared/API/Models/Jabatan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:surat/shared/LoadingAnimation/loading.dart';
import 'package:surat/shared/API/Models/Unit.dart';

class addStaffAdmin extends StatefulWidget {
  const addStaffAdmin({Key key}) : super(key: key);

  @override
  _addStaffAdminState createState() => _addStaffAdminState();
}

class _addStaffAdminState extends State<addStaffAdmin> {
  final controllerNIK = TextEditingController();
  bool Loading = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Loading ? loading(): Scaffold(
        appBar: AppBar(
          title: Text("Tambah Staff", style: TextStyle(
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
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: Image.asset('images/staff.png', height: 100, width: 100),
                margin: EdgeInsets.only(top: 70),
              ),
              Container(
                child: Text("Verifikasi NIK", style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: HexColor("#025393")
                )),
                margin: EdgeInsets.only(top: 20),
              ),
              Container(
                child: Text("Sebelum melanjutkan, silahkan masukkan NIK dari staff yang akan Anda input datanya", style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14
                ), textAlign: TextAlign.center),
                padding: EdgeInsets.symmetric(horizontal: 30),
                margin: EdgeInsets.only(top: 20),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                  child: TextField(
                    controller: controllerNIK,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          borderSide: BorderSide(color: HexColor("#025393"))
                      ),
                        prefixIcon: Icon(Icons.person_outline_rounded),
                        hintText: "NIK"
                    ),
                    style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14
                    ),
                  ),
                ),
                margin: EdgeInsets.only(top: 20),
              ),
              Container(
                child: FlatButton(
                  onPressed: (){
                    if(controllerNIK.text == "") {
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
                                      ),
                                    ),
                                    Container(
                                      child: Text("Data NIK belum diisi", style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: HexColor("#025393")
                                      ), textAlign: TextAlign.center),
                                      margin: EdgeInsets.only(top: 10),
                                    ),
                                    Container(
                                      child: Text("Data NIK masih kosong. Silahkan isi data NIK terlebih dahulu sebelum melanjutkan", style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 14
                                      ), textAlign: TextAlign.center),
                                      margin: EdgeInsets.only(top: 10),
                                    )
                                  ],
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
                              ],
                            );
                          }
                      );
                    }else{
                      setState(() {
                        Loading = true;
                      });
                      http.get(Uri.parse("http://192.168.18.10:8000/api/admin/addstaff/cek/${controllerNIK.text}"),
                        headers: {"Content-Type" : "application/json"}
                      ).then((http.Response response) {
                        var responseValue = response.statusCode;
                        if(response.statusCode == 200) {
                          setState(() {
                            Loading = false;
                            var jsonData = response.body;
                            var parsedJson = json.decode(jsonData);
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context){
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(40.0))
                                    ),
                                    content: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Container(
                                          child: Image.asset(
                                            'images/person.png',
                                            height: 50,
                                            width: 50,
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            "Konfirmasi Data Staff",
                                            style: TextStyle(
                                                fontFamily: "Poppins",
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                color: HexColor("#025393")
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          margin: EdgeInsets.only(top: 10),
                                        ),
                                        Container(
                                          child: Text(
                                            "Silahkan konfirmasi data di bawah ini apakah data tersebut benar",
                                            style: TextStyle(
                                                fontFamily: "Poppins",
                                                fontSize: 14
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          margin: EdgeInsets.only(top: 10),
                                        ),
                                        Container(
                                          child: Column(
                                            children: <Widget>[
                                              Container(
                                                child: Text(
                                                  "Nama :",
                                                  style: TextStyle(
                                                      fontFamily: "Poppins",
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w700
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                child: Text(
                                                  parsedJson['nama_lengkap'].toString(),
                                                  style: TextStyle(
                                                      fontFamily: "Poppins",
                                                      fontSize: 14
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          margin: EdgeInsets.only(top: 20),
                                        ),
                                        Container(
                                          child: Column(
                                            children: <Widget>[
                                              Container(
                                                child: Text(
                                                  "Jenis Kelamin :",
                                                  style: TextStyle(
                                                      fontFamily: "Poppins",
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w700
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                child: Text(
                                                  parsedJson['jenis_kelamin'].toString(),
                                                  style: TextStyle(
                                                      fontFamily: "Poppins",
                                                      fontSize: 14
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          margin: EdgeInsets.only(top: 20),
                                        ),
                                        Container(
                                          child: Column(
                                            children: <Widget>[
                                              Container(
                                                child: Text(
                                                  "Kewarganegaraan :",
                                                  style: TextStyle(
                                                      fontFamily: "Poppins",
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w700
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                child: Text(
                                                  parsedJson['kewarganegaraan'].toString(),
                                                  style: TextStyle(
                                                      fontFamily: "Poppins",
                                                      fontSize: 14
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          margin: EdgeInsets.only(top: 20),
                                        )
                                      ],
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('Benar', style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontWeight: FontWeight.w700,
                                            color: HexColor("#025393")
                                        )),
                                        onPressed: (){
                                          setState(() {
                                            inputDataStaff.pendudukId = parsedJson['penduduk_id'];
                                            Loading = false;
                                          });
                                          Navigator.push(context, CupertinoPageRoute(builder: (context) => inputDataStaff()));
                                        },
                                      ),
                                      TextButton(
                                        child: Text('Tidak', style: TextStyle(
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
                          });
                        }else if(response.statusCode == 500){
                          setState(() {
                            Loading = false;
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(40.0))
                                  ),
                                  content: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Container(
                                        child: Image.asset(
                                          'images/alert.png',
                                          height: 50,
                                          width: 50,
                                        ),
                                      ),
                                      Container(
                                        child: Text("Data pengguna tidak ditemukan", style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: HexColor("#025393")
                                        ), textAlign: TextAlign.center),
                                        margin: EdgeInsets.only(top: 10),
                                      ),
                                      Container(
                                        child: Text("Data pengguna tidak ditemukan. Silahkan periksa data NIK yang Anda masukkan dan coba lagi", style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 14
                                        ), textAlign: TextAlign.center),
                                        margin: EdgeInsets.only(top: 10),
                                      )
                                    ],
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('OK', style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w700,
                                        color: HexColor("#025393"),
                                      )),
                                      onPressed: (){Navigator.of(context).pop();},
                                    )
                                  ],
                                );
                              }
                            );
                          });
                        }else if(response.statusCode == 501){
                          setState(() {
                            Loading = false;
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(40.0))
                                    ),
                                    content: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Container(
                                          child: Image.asset(
                                            'images/alert.png',
                                            height: 50,
                                            width: 50,
                                          ),
                                        ),
                                        Container(
                                          child: Text("Staff sudah terdaftar", style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: HexColor("#025393")
                                          ), textAlign: TextAlign.center),
                                          margin: EdgeInsets.only(top: 10),
                                        ),
                                        Container(
                                          child: Text("Staff sudah terdaftar. Silahkan masukkan NIK dari staff yang belum terdaftar untuk melanjutkan", style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 14
                                          ), textAlign: TextAlign.center),
                                          margin: EdgeInsets.only(top: 10),
                                        )
                                      ],
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('OK', style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w700,
                                          color: HexColor("#025393"),
                                        )),
                                        onPressed: (){Navigator.of(context).pop();},
                                      )
                                    ],
                                  );
                                }
                            );
                          });
                        }
                      });
                    }
                  },
                  child: Text("Lanjutkan", style: TextStyle(
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
                margin: EdgeInsets.only(bottom: 20, top: 30),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class inputDataStaff extends StatefulWidget {
  static var pendudukId;
  const inputDataStaff({Key key}) : super(key: key);

  @override
  _inputDataStaffState createState() => _inputDataStaffState();
}

class _inputDataStaffState extends State<inputDataStaff> {
  var selectedJabatan;
  var selectedUnit;
  var apiURLUpDataStaff = "http://192.168.18.10:8000/api/admin/addstaff/post";
  bool Loading = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Loading ? loading() : Scaffold(
        appBar: AppBar(
          title: Text("Input Data Staff", style: TextStyle(
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
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: Container(
                  child: Image.asset(
                      'images/staff.png',
                    height: 100,
                    width: 100,
                  ),
                ),
                margin: EdgeInsets.only(top: 50),
              ),
              Container(
                child: Text("Data Staff", style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: HexColor("#025393")
                )),
                margin: EdgeInsets.only(top: 20),
              ),
              Container(
                child: Text("Silahkan lengkapi data staff pada form berikut", style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14
                )),
                padding: EdgeInsets.symmetric(horizontal: 28),
                margin: EdgeInsets.only(top: 10),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text("1. Unit", style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14,
                        fontWeight: FontWeight.w700
                      )),
                      margin: EdgeInsets.only(top: 30, left: 20),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: selectedUnit == null ? Text("Unit belum terpilih", style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w700,
                          fontSize: 14
                      )) : Text(selectedUnit, style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w700,
                          fontSize: 14
                      )),
                      margin: EdgeInsets.only(top: 10),
                    ),
                    Container(
                      child: FlatButton(
                        onPressed: (){
                          navigatePilihUnit(context);
                        },
                        child: Text("Pilih Unit", style: TextStyle(
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
                      margin: EdgeInsets.only(top: 15, bottom: 10),
                    )
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text("2. Jabatan", style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 14,
                          fontWeight: FontWeight.w700
                      )),
                      margin: EdgeInsets.only(top: 30, left: 20),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: selectedJabatan == null ? Text("Jabatan belum terpilih", style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w700,
                          fontSize: 14
                      )) : Text(selectedJabatan, style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w700,
                          fontSize: 14
                      )),
                      margin: EdgeInsets.only(top: 10),
                    ),
                    Container(
                      child: FlatButton(
                        onPressed: (){
                          navigatePilihJabatan(context);
                        },
                        child: Text("Pilih Jabatan", style: TextStyle(
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
                      margin: EdgeInsets.only(top: 15, bottom: 30),
                    )
                  ],
                ),
              ),
              Container(
                child: FlatButton(
                  onPressed: (){
                    if(selectedJabatan == null || selectedUnit == null) {
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
                                    ),
                                  ),
                                  Container(
                                    child: Text("Data belum terisi", style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: HexColor("#025393")
                                    ), textAlign: TextAlign.center),
                                    margin: EdgeInsets.only(top: 10),
                                  ),
                                  Container(
                                    child: Text("Masih terdapat data yang belum terisi. Silahkan isi data tersebut sebelum melanjutkan", style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 14
                                    ), textAlign: TextAlign.center),
                                    margin: EdgeInsets.only(top: 10),
                                  )
                                ],
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
                            ],
                          );
                        }
                      );
                    }else{
                      setState(() {
                        Loading = true;
                      });
                      var body = jsonEncode({
                        "penduduk_id" : inputDataStaff.pendudukId,
                        "nama_jabatan" : selectedJabatan,
                        "nama_unit" : selectedUnit
                      });
                      http.post(Uri.parse(apiURLUpDataStaff),
                        headers: {"Content-Type" : "application/json"},
                        body: body
                      ).then((http.Response response) {
                        var responseValue = response.statusCode;
                        if(responseValue == 200) {
                          setState(() {
                            Loading = false;
                          });
                          Navigator.of(context).push(CupertinoPageRoute(builder: (context) => addStaffBerhasil()));
                        }
                      });
                    }
                  },
                  child: Text("Lanjutkan", style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.white
                  )),
                  color: HexColor("#025393"),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  padding: EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50),
                ),
                margin: EdgeInsets.only(bottom: 20, top: 30),
              )
            ],
          ),
        ),
      ),
    );
  }

  void navigatePilihJabatan(BuildContext context) async {
    final result = await Navigator.push(context, CupertinoPageRoute(builder: (context) => pilihJabatan()));
    if(result == null) {
      selectedJabatan = selectedJabatan;
    }else{
      setState(() {
        selectedJabatan = result;
      });
    }
  }

  void navigatePilihUnit(BuildContext context) async {
    final result = await Navigator.push(context, CupertinoPageRoute(builder: (context) => pilihDataUnit()));
    if(result == null) {
      selectedUnit = selectedUnit;
    }else{
      setState(() {
        selectedUnit = result;
      });
    }
  }
}

class pilihJabatan extends StatefulWidget {
  const pilihJabatan({Key key}) : super(key: key);

  @override
  _pilihJabatanState createState() => _pilihJabatanState();
}

class _pilihJabatanState extends State<pilihJabatan> {
  var apiURLGetDataJabatan = "http://192.168.18.10:8000/api/admin/addstaff/list_jabatan";

  Future<Jabatan> functionListJabatan() async {
    return http.get(Uri.parse(apiURLGetDataJabatan),
      headers: {"Content-Type" : "application/json"}
    ).then((http.Response response) {
      if(response.statusCode == 200) {
        final body = response.body;
        final jabatanData = jabatanFromJson(body);
        return jabatanData;
      }else{
        final body = response.body;
        final error = jabatanFromJson(body);
        return error;
      }
    });
  }

  Widget listJabatan() {
    return FutureBuilder<Jabatan>(
      future: functionListJabatan(),
      builder: (context, snapshot) {
        final data = snapshot.data;
        if(snapshot.hasData) {
          final jabatanData = data.data;
          return ListView.builder(
            itemCount: jabatanData.length,
            itemBuilder: (context, index) {
              final jabatan = jabatanData[index];
              return GestureDetector(
                onTap: (){
                  Navigator.of(context, rootNavigator: true).pop(jabatan.namaJabatan);
                },
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: Image.asset(
                          'images/person.png',
                          height: 50,
                          width: 50,
                        ),
                      ),
                      Container(
                        child: Text(jabatan.namaJabatan.toString(), style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.black
                        )),
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(left: 10),
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
                )
              );
            },
          );
        }else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Pilih Jabatan", style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w700,
            color: HexColor("#025393")
          )),
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: (){Navigator.of(context, rootNavigator: true).pop();},
            color: HexColor("#025393"),
          ),
        ),
        body: listJabatan(),
      ),
    );
  }
}

class pilihDataUnit extends StatefulWidget {
  const pilihDataUnit({Key key}) : super(key: key);

  @override
  _pilihDataUnitState createState() => _pilihDataUnitState();
}

class _pilihDataUnitState extends State<pilihDataUnit> {
  var apiURLGetDataUnit = "http://192.168.18.10:8000/api/admin/addstaff/list_unit";

  Future<Unit> functionListUnit() async {
    return http.get(Uri.parse(apiURLGetDataUnit),
      headers: {"Content-Type" : "application/json"}
    ).then((http.Response response) {
      if(response.statusCode == 200) {
        final body = response.body;
        final unitData = unitFromJson(body);
        return unitData;
      }else{
        final body = response.body;
        final error = unitFromJson(body);
        return error;
      }
    });
  }

  Widget listUnit() {
    return FutureBuilder<Unit>(
      future: functionListUnit(),
      builder: (context, snapshot) {
        final data = snapshot.data;
        if(snapshot.hasData) {
          final unitData = data.data;
          return ListView.builder(
            itemCount: unitData.length,
            itemBuilder: (context, index) {
              final unit = unitData[index];
              return GestureDetector(
                onTap: (){
                  Navigator.of(context, rootNavigator: true).pop(unit.namaUnit);
                },
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: Image.asset(
                          'images/briefcase.png',
                          height: 50,
                          width: 50,
                        ),
                      ),
                      Container(
                        child: Text(unit.namaUnit.toString(), style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.black
                        )),
                        margin: EdgeInsets.only(left: 10),
                        alignment: Alignment.centerLeft,
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
          );
        }else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Pilih Unit", style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w700,
            color: HexColor("#025393")
          )),
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: (){Navigator.of(context, rootNavigator: true).pop();},
            color: HexColor("#025393"),
          ),
        ),
        body: listUnit(),
      ),
    );
  }
}

class addStaffBerhasil extends StatelessWidget {
  const addStaffBerhasil({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: Image.asset(
                  'images/done.png',
                  height: 50,
                  width: 50,
                ),
                margin: EdgeInsets.only(top: 100),
              ),
              Container(
                child: Text(
                  "Tambah Staff Berhasil",
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: HexColor("#025393")
                  ),
                ),
                margin: EdgeInsets.only(top: 20),
              ),
              Container(
                child: Text(
                  "Proses tambah staff telah berhasil. Silahkan akses menu Manajemen Staff yang terdapat pada Dashboard untuk melihat data staff",
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 14
                  ),
                  textAlign: TextAlign.center,
                ),
                padding: EdgeInsets.symmetric(horizontal: 20),
                margin: EdgeInsets.only(top: 30),
              ),
              Container(
                child: FlatButton(
                  onPressed: (){
                    Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(builder: (context) => dashboardAdminDesa()), (route) => false);
                  },
                  color: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                      side: BorderSide(color: HexColor("#025393"))
                  ),
                  padding: EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50),
                  child: Container(
                    child: Text(
                      "Kembali ke Halaman Utama",
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 15,
                          color: HexColor("#025393"),
                          fontWeight: FontWeight.w700
                      ),
                    ),
                  ),
                ),
                margin: EdgeInsets.only(top: 30),
              )
            ],
          ),
        ),
      ),
    );
  }
}
