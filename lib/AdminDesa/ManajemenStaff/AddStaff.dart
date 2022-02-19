import 'dart:convert';
import 'dart:io';
import 'package:surat/AdminDesa/Dashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:surat/shared/API/Models/ListPenduduk.dart';
import 'package:surat/shared/LoadingAnimation/loading.dart';
import 'package:path/path.dart';
import 'package:file_picker/file_picker.dart';
import 'package:async/async.dart';
import 'package:surat/LoginAndRegistration/LoginPage.dart';

class addStaffAdmin extends StatefulWidget {
  const addStaffAdmin({Key key}) : super(key: key);

  @override
  _addStaffAdminState createState() => _addStaffAdminState();
}

class _addStaffAdminState extends State<addStaffAdmin> {
  bool Loading = false;
  final controllerNIKPegawai = TextEditingController();
  var selectedPegawai;
  var selectedJabatan;
  var selectedUnit;
  var apiURLAddStaff = "http://192.168.18.10:8000/api/admin/addstaff/post";
  List unitItemList = List();
  List jabatanItemList = List();
  File file;
  String namaFile;
  String filePath;
  DateTime selectMasaMulai;
  String tanggalMasaMulai;
  String valueMasaMulai;

  Future getAllUnit() async {
    var url = "http://192.168.18.10:8000/api/admin/addstaff/list_unit";
    var response = await http.get(Uri.parse(url));
    if(response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        unitItemList = jsonData;
      });
    }
  }

  Future getAllJabatan() async {
    var url = "http://192.168.18.10:8000/api/admin/addstaff/list_jabatan";
    var response = await http.get(Uri.parse(url));
    if(response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        jabatanItemList = jsonData;
      });
    }
  }

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
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllUnit();
    getAllJabatan();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Loading ? loading() : Scaffold(
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
          )
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: Image.asset(
                  'images/person.png',
                  height: 100,
                  width: 100,
                ),
                margin: EdgeInsets.only(top: 30),
              ),
              Container(
                child: Text("1. Data Karyawan", style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                )),
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(top: 30, left: 20),
              ),
              Container(
                child: Text("Silahkan pilih data karyawan yang akan Anda tambahkan dengan menekan tombol Pilih Staff", style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14,
                )),
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(right: 30, left: 30),
                margin: EdgeInsets.only(top: 10)
              ),
              Container(
                child: selectedPegawai == null ? Text("Pegawai belum terpilih", style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14
                )) : Text("Nama pegawai: ${selectedPegawai}", style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14
                )),
                margin: EdgeInsets.only(top: 10),
              ),
              Container(
                child: FlatButton(
                  onPressed: (){
                    navigatePilihKaryawan(context);
                  },
                  child: Text("Pilih Pegawai", style: TextStyle(
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
                child: Text("Masa mulai staff", style: TextStyle(
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
                    side: BorderSide(color: HexColor("#025393"), width: 2)
                  ),
                  padding: EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50),
                ),
                margin: EdgeInsets.only(top: 10),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text("2. Jabatan & Unit", style: TextStyle(
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
                      child: Text("a. Unit", style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14
                      )),
                      margin: EdgeInsets.only(top: 15, left: 20),
                    ),
                    Container(
                      width: 300,
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      decoration: BoxDecoration(
                        color: HexColor("#025393"),
                        borderRadius: BorderRadius.circular(30)
                      ),
                      child: DropdownButton(
                        isExpanded: true,
                        hint: Center(
                          child: Text("Pilih Unit", style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Poppins",
                            fontSize: 14
                          )),
                        ),
                        value: selectedUnit,
                        underline: Container(),
                        icon: Icon(Icons.arrow_downward, color: Colors.white),
                        items: unitItemList.map((unit) {
                          return DropdownMenuItem(
                            value: unit['nama_unit'],
                            child: Text(unit['nama_unit'].toString(), style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 14
                            )),
                          );
                        }).toList(),
                        selectedItemBuilder: (BuildContext context) => unitItemList.map((unit) => Center(
                          child: Text(unit['nama_unit'].toString(), style: TextStyle(
                            fontFamily: "Poppins",
                            color: Colors.white,
                            fontSize: 14
                          )),
                        )).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedUnit = value;
                          });
                        },
                      ),
                      margin: EdgeInsets.only(top: 15),
                    )
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text("b. Jabatan", style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 14
                      )),
                      margin: EdgeInsets.only(top: 15, left: 20),
                    ),
                    Container(
                      width: 300,
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      decoration: BoxDecoration(
                          color: HexColor("#025393"),
                          borderRadius: BorderRadius.circular(30)
                      ),
                      child: DropdownButton(
                        isExpanded: true,
                        hint: Center(
                          child: Text("Pilih Jabatan", style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Poppins",
                              fontSize: 14
                          )),
                        ),
                        value: selectedJabatan,
                        underline: Container(),
                        icon: Icon(Icons.arrow_downward, color: Colors.white),
                        items: jabatanItemList.map((jabatan) {
                          return DropdownMenuItem(
                            value: jabatan['nama_jabatan'],
                            child: Text(jabatan['nama_jabatan'].toString(), style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14
                            )),
                          );
                        }).toList(),
                        selectedItemBuilder: (BuildContext context) => jabatanItemList.map((jabatan) => Center(
                          child: Text(jabatan['nama_jabatan'].toString(), style: TextStyle(
                              fontFamily: "Poppins",
                              color: Colors.white,
                              fontSize: 14
                          )),
                        )).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedJabatan = value;
                          });
                        },
                      ),
                      margin: EdgeInsets.only(top: 15),
                    )
                  ],
                ),
              ),
              Container(
                child: Text("3. Berkas SK Pegawai", style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14,
                  fontWeight: FontWeight.w700
                )),
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(top: 30, left: 20),
              ),
              Container(
                child: Text("Silahkan unggah berkas SK pegawai dalam bentuk format PDF.", style: TextStyle(
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
                  child: Text("Pilih SK Pegawai", style: TextStyle(
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
                child: FlatButton(
                  onPressed: () async {
                    if(selectedPegawai == null || selectedJabatan == null || selectedUnit == null || valueMasaMulai == null) {
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
                                    child: Text("Masih terdapat data yang kosong", style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: HexColor("#025393")
                                    ), textAlign: TextAlign.center),
                                    margin: EdgeInsets.only(top: 10),
                                  ),
                                  Container(
                                    child: Text("Masih terdapat data yang kosong atau data yang belum diverifikasi. Silahkan isi semua data yang ditampilkan pada form ini atau lakukan verifikasi pada data yang sudah Anda inputkan dan coba lagi", style: TextStyle(
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
                                onPressed: (){
                                  Navigator.of(context).pop();
                                },
                              )
                            ],
                          );
                        }
                      );
                    }else{
                      setState(() {
                        Loading = true;
                      });
                      var stream = http.ByteStream(DelegatingStream.typed(file.openRead()));
                      var length = await file.length();
                      var url = Uri.parse("http://192.168.18.10/siraja-api-skripsi/upload-file-sk-staff.php");
                      var request = http.MultipartRequest("POST", url);
                      var multipartFile = http.MultipartFile("dokumen", stream, length, filename: basename(file.path));
                      request.files.add(multipartFile);
                      var response = await request.send();
                      if(response.statusCode == 200) {
                        var body = jsonEncode({
                          "nama_staff" : selectedPegawai,
                          "nama_jabatan" : selectedJabatan,
                          "nama_unit" : selectedUnit,
                          "masa_mulai" : valueMasaMulai,
                          "file_sk" : namaFile,
                          "desa_id" : loginPage.desaId
                        });
                        http.post(Uri.parse(apiURLAddStaff),
                          headers: {"Content-Type" : "application/json"},
                          body: body
                        ).then((http.Response response) {
                          var responseValue = response.statusCode;
                          if(responseValue == 200) {
                            setState(() {
                              Loading = false;
                            });
                            Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) => addStaffBerhasil()), (route) => false);
                          }else{
                            print("Staff gagal ditambahkan");
                          }
                        });
                      }else{
                        print("File gagal diupload");
                      }
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

  void navigatePilihKaryawan(BuildContext context) async {
    final result = await Navigator.push(context, CupertinoPageRoute(builder: (context) => selectStaff()));
    if(result == null) {
      selectedPegawai = selectedPegawai;
    }else{
      setState(() {
        selectedPegawai = result;
      });
    }
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

class selectStaff extends StatefulWidget {
  const selectStaff({Key key}) : super(key: key);

  @override
  _selectStaffState createState() => _selectStaffState();
}

class _selectStaffState extends State<selectStaff> {
  List<Penduduk> penduduk = [];
  List<Penduduk> searchResult = [];
  var url = "http://192.168.18.10:8000/api/data/penduduk/${loginPage.desaId}";

  Future<Penduduk> list() async {
    return http.get(Uri.parse(url),
      headers : {"Content-Type" : "application/json"}
    ).then((http.Response response) {
      if(response.statusCode == 200) {
        final body = response.body;
        final pendudukData = pendudukFromJson(body);
        return pendudukData;
      }else{
        final body = response.body;
        final error = pendudukFromJson(body);
        return error;
      }
    });
  }

  Widget listPenduduk() {
    return FutureBuilder<Penduduk>(
      future: list(),
      builder: (context, snapshot) {
        final data = snapshot.data;
        if(snapshot.hasData) {
          final pendudukData = data.data;
          return ListView.builder(
            itemCount: pendudukData.length,
            itemBuilder: (context, index) {
              final penduduk = pendudukData[index];
              return GestureDetector(
                onTap: (){
                  Navigator.of(context, rootNavigator: true).pop(penduduk.namaLengkap);
                },
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: Image.asset(
                          'images/person.png',
                          height: 40,
                          width: 40
                        )
                      ),
                      Container(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                    child: Text(penduduk.namaLengkap.toString(), style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black
                                    )),
                                    margin: EdgeInsets.only(left: 20)
                                ),
                                Container(
                                    child: Text(penduduk.pendudukId.toString(), style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 14,
                                        color: Colors.black
                                    )),
                                    margin: EdgeInsets.only(left: 20)
                                )
                              ]
                          )
                      )
                    ]
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
            }
          );
        }else{
          return Center(
            child: CircularProgressIndicator()
          );
        }
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Pilih Staff", style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w700,
            color: HexColor("#025393")
          )),
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: HexColor("#025393"),
            onPressed: (){
              Navigator.of(context).pop();
            },
          )
        ),
        body: listPenduduk()
      )
    );
  }
}