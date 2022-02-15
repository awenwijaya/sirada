import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:surat/shared/LoadingAnimation/loading.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';

class addDusunAdmin extends StatefulWidget {
  const addDusunAdmin({Key key}) : super(key: key);

  @override
  _addDusunAdminState createState() => _addDusunAdminState();
}

class _addDusunAdminState extends State<addDusunAdmin> {
  bool statusNamaDusun;
  bool statusKepalaDusun;
  bool Loading = false;
  var apiURLCekNamaDusun = "http://192.168.18.10:8000/api/dusun/cek";
  final controllerNamaDusunAdmin = TextEditingController();
  final controllerNIKKepalaDusun = TextEditingController();
  var namaDusun;
  var namaKepalaDusun;
  var nikKepalaDusun;
  DateTime selectMasaMulai;
  DateTime selectMasaBerakhir;
  String tanggalMasaMulai;
  String valueMasaMulai;
  String tanggalMasaBerakhir;
  String valueMasaBerakhir;
  File file;
  String namaFile;
  String filePath;

  Future getFile() async {
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Loading ? loading() : Scaffold(
        appBar: AppBar(
          title: Text("Tambah Dusun", style: TextStyle(
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
                child: Image.asset(
                  'images/location.png',
                  height: 100,
                  width: 100,
                ),
                margin: EdgeInsets.only(top: 30),
              ),
              Container(
                child: Text("1. Nama Dusun", style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14,
                  fontWeight: FontWeight.w700
                )),
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(top: 30, left: 20),
              ),
              Container(
                child: Text("Silahkan masukkan nama dusun yang akan Anda daftarkan. Setelah Anda memasukkan nama dusun, silahkan tekan tombol Periksa Dusun untuk memeriksa apakah dusun sudah terdaftar atau belum", style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14
                )),
                padding: EdgeInsets.only(left: 30, right: 30),
                margin: EdgeInsets.only(top: 10),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                  child: TextField(
                    controller: controllerNamaDusunAdmin,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                            borderSide: BorderSide(color: HexColor("#025393"))
                        ),
                        hintText: "Nama Dusun"
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
                child: statusNamaDusun == null ? Container() : statusNamaDusun == true ? Text("Dusun belum terdaftar", style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: HexColor("2EB086")
                )) : Text("Dusun sudah terdaftar", style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: HexColor("B33030")
                )),
                margin: EdgeInsets.only(top: 10),
                alignment: Alignment.center,
              ),
              Container(
                child: FlatButton(
                  onPressed: (){
                    if(controllerNamaDusunAdmin.text == "") {
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
                                    child: Text("Data nama dusun belum diisi", style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: HexColor("#025393")
                                    ), textAlign: TextAlign.center),
                                    margin: EdgeInsets.only(top: 10),
                                  ),
                                  Container(
                                    child: Text("Data nama dusun masih kosong. Silahkan isi data nama dusun terlebih dahulu sebelum melanjutkan", style: TextStyle(
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
                        "nama_dusun" : controllerNamaDusunAdmin.text
                      });
                      http.post(Uri.parse(apiURLCekNamaDusun),
                        headers: {"Content-Type" : "application/json"},
                        body: body
                      ).then((http.Response response) {
                        var responseValue = response.statusCode;
                        if(responseValue == 200) {
                          setState(() {
                            Loading = false;
                            statusNamaDusun = true;
                            namaDusun = controllerNamaDusunAdmin.text;
                          });
                        }else{
                          setState(() {
                            Loading = false;
                            statusNamaDusun = false;
                          });
                        }
                      });
                    }
                  },
                  child: Text("Periksa Dusun", style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14,
                    color: HexColor("#025393"),
                    fontWeight: FontWeight.w700
                  )),
                  color: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                    side: BorderSide(color: HexColor("#025393"), width: 2)
                  ),
                  padding: EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50),
                ),
                margin: EdgeInsets.only(top: 10),
              ),
              Container(
                child: Text("2. Kepala Dusun", style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14,
                  fontWeight: FontWeight.w700
                )),
                margin: EdgeInsets.only(top: 30, left: 20),
                alignment: Alignment.topLeft,
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text("Silahkan masukkan NIK dari Kepala Dusun pada form dibawah. Setelah Anda memasukkan NIK dari Kepala Dusun, silahkan tekan tombol Periksa Kepala Dusun untuk memeriksa apakah data NIK benar atau tidak", style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14
                )),
                padding: EdgeInsets.only(left: 30, right: 30),
                margin: EdgeInsets.only(top: 10),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                  child: TextField(
                    controller: controllerNIKKepalaDusun,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        borderSide: BorderSide(color: HexColor("#025393"))
                      ),
                      hintText: "NIK Kepala Dusun"
                    ),
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 14
                    ),
                  ),
                ),
                margin: EdgeInsets.only(top: 20),
              ),
              Container(
                alignment: Alignment.center,
                child: statusKepalaDusun == null ? Container() : statusKepalaDusun == true ? Text("Nama Kepala Dusun : ${namaKepalaDusun.toString()}", style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14
                )) : Text("NIK tidak terdaftar", style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: HexColor("B33030")
                )),
                margin: EdgeInsets.only(top: 10),
              ),
              Container(
                child: FlatButton(
                  onPressed: (){
                    if(controllerNIKKepalaDusun.text == "") {
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
                                    child: Text("Data NIK Kepala Dusun belum diisi", style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: HexColor("#025393")
                                    ), textAlign: TextAlign.center),
                                    margin: EdgeInsets.only(top: 10),
                                  ),
                                  Container(
                                    child: Text("Data NIK Kepala Dusun masih kosong. Silahkan isi data NIK Kepala Dusun terlebih dahulu sebelum melanjutkan", style: TextStyle(
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
                                ), textAlign: TextAlign.center),
                                onPressed: (){Navigator.of(context).pop();}
                              )
                            ],
                          );
                        }
                      );
                    }else{
                      setState(() {
                        Loading = true;
                      });
                      http.get(Uri.parse("http://192.168.18.10:8000/api/admin/addstaff/cek/${controllerNIKKepalaDusun.text}"),
                        headers: {"Content-Type" : "application/json"}
                      ).then((http.Response response) {
                        var responseValue = response.statusCode;
                        if(response.statusCode == 200) {
                          setState(() {
                            Loading = false;
                            var jsonData = response.body;
                            var parsedJson = json.decode(jsonData);
                            nikKepalaDusun = controllerNIKKepalaDusun.text;
                            statusKepalaDusun = true;
                            namaKepalaDusun = parsedJson['nama_lengkap'].toString();
                          });
                        }else{
                          setState(() {
                            Loading = false;
                            statusKepalaDusun = false;
                          });
                        }
                      });
                    }
                  },
                  child: Text("Periksa Kepala Dusun", style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14,
                    color: HexColor("#025393"),
                    fontWeight: FontWeight.w700
                  )),
                  color: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                    side: BorderSide(color: HexColor("#025393"), width: 2),
                  ),
                  padding: EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50),
                ),
                margin: EdgeInsets.only(top: 10),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text("3. Data Tambahan", style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14,
                  fontWeight: FontWeight.w700
                )),
                margin: EdgeInsets.only(top: 30, left: 20),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text("a. Masa mulai Kepala Dusun", style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14
                )),
                margin: EdgeInsets.only(top: 15, left: 20),
              ),
              Container(
                child: tanggalMasaMulai == null ? Container() : Text(tanggalMasaMulai.toString(), style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14
                )),
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
                        selectMasaMulai = value;
                        var tanggal = DateTime.parse(selectMasaMulai.toString());
                        tanggalMasaMulai = "${tanggal.day}-${tanggal.month}-${tanggal.year}";
                        valueMasaMulai = "${tanggal.year}-${tanggal.month}-${tanggal.day}";
                      });
                    });
                  },
                  child: Text("Pilih Masa Mulai", style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14,
                    color: HexColor("#025393"),
                    fontWeight: FontWeight.w700
                  )),
                  color: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                    side: BorderSide(color: HexColor("#025393"), width: 2),
                  ),
                  padding: EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50),
                ),
                margin: EdgeInsets.only(top: 10),
              ),
              Container(
                child: Text("b. Masa berakhir Kepala Dusun", style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14
                )),
                margin: EdgeInsets.only(top: 20, left: 20),
                alignment: Alignment.topLeft,
              ),
              Container(
                child: tanggalMasaBerakhir == null ? Container() : Text(tanggalMasaBerakhir.toString(), style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14
                )),
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
                        selectMasaBerakhir = value;
                        var tanggal = DateTime.parse(selectMasaBerakhir.toString());
                        tanggalMasaBerakhir = "${tanggal.day}-${tanggal.month}-${tanggal.year}";
                        valueMasaBerakhir = "${tanggal.year}-${tanggal.month}-${tanggal.day}";
                      });
                    });
                  },
                  child: Text("Pilih Masa Berakhir", style: TextStyle(
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
                margin: EdgeInsets.only(top: 10),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text("c. SK Kepala Dusun", style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14
                )),
                margin: EdgeInsets.only(top: 20, left: 20),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text("Silahkan unggah berkas SK Kepala Dusun dalam format PDF.", style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14
                )),
                padding: EdgeInsets.only(left: 30, right: 30),
                margin: EdgeInsets.only(top: 10),
              ),
              Container(
                child: file == null ? Container() : Text("Nama file: ${namaFile}", style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14
                ), textAlign: TextAlign.center),
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.only(left: 30, right: 30)
              ),
              Container(
                child: FlatButton(
                  onPressed: (){
                    getFile();
                  },
                  child: Text("Pilih SK Kepala Dusun", style: TextStyle(
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
                margin: EdgeInsets.only(top: 15),
              ),
              Container(
                child: Text("d. Email Kepala Dusun", style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14
                )),
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(top: 20, left: 20),
              ),
              Container(
                child: Text("Silahkan masukkan email dari Kepala Dusun. Email ini akan digunakan dalam proses pendaftaran akun Kepala Dusun", style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14
                )),
                padding: EdgeInsets.only(left: 30, right: 30),
                margin: EdgeInsets.only(top: 10),
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
                      hintText: "Email",
                      prefixIcon: Icon(Icons.mail)
                    ),
                    keyboardType: TextInputType.emailAddress,
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
                    if(namaDusun == null || nikKepalaDusun == null || valueMasaMulai == null || valueMasaBerakhir == null || file == null) {
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
                                    child: Text("Masih terdapat data yang kosong", style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: HexColor("#025393")
                                    ), textAlign: TextAlign.center),
                                    margin: EdgeInsets.only(top: 10)
                                  ),
                                  Container(
                                    child: Text("Masih terdapat data yang kosong. Silahkan isi semua data yang ditampilkan atau lakukan verifikasi data yang sudah Anda inputkan dan coba lagi", style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 14
                                    ), textAlign: TextAlign.center),
                                    margin: EdgeInsets.only(top: 10)
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
                            ]
                          );
                        }
                      );
                    }else if(nikKepalaDusun != controllerNIKKepalaDusun.text || namaDusun != controllerNamaDusunAdmin.text) {
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
                                            child: Text("Data belum diverifikasi", style: TextStyle(
                                                fontFamily: "Poppins",
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                color: HexColor("#025393")
                                            ), textAlign: TextAlign.center),
                                            margin: EdgeInsets.only(top: 10)
                                        ),
                                        Container(
                                            child: Text("Masih terdapat data yang belum di verifikasi. Silahkan lakukan verifikasi data nama dusun atau data NIK Kepala Dusun terlebih dahulu sebelum melanjutkan", style: TextStyle(
                                                fontFamily: "Poppins",
                                                fontSize: 14
                                            ), textAlign: TextAlign.center),
                                            margin: EdgeInsets.only(top: 10)
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
                                ]
                            );
                          }
                      );
                    }
                  },
                  child: Text("Simpan", style: TextStyle(
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
                margin: EdgeInsets.only(top: 20, bottom: 20),
              )
            ],
          ),
        ),
      ),
    );
  }
}