import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:surat/AdminDesa/ManajemenStaff/DetailStaff.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:surat/shared/LoadingAnimation/loading.dart';
import 'package:surat/AdminDesa/Dashboard.dart';
import 'package:async/async.dart';
import 'package:path/path.dart';

class editStaffAdmin extends StatefulWidget {
  const editStaffAdmin({Key key}) : super(key: key);

  @override
  _editStaffAdminState createState() => _editStaffAdminState();
}

class _editStaffAdminState extends State<editStaffAdmin> {
  String selectedUnit = detailStaffAdmin.namaUnit;
  String selectedJabatan = detailStaffAdmin.jabatan;
  List unitItemList = List();
  List jabatanItemList = List();
  var apiURLSimpanDataStaff = "http://192.168.18.10:8000/api/admin/staff/update";
  bool Loading = false;
  File file;
  String namaFile;
  String filePath;

  Future getAllUnit() async {
    var url = "http://192.168.18.10:8000/api/admin/addstaff/list_unit";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        unitItemList = jsonData;
      });
    }
  }

  Future getAllJabatan() async {
    var url = "http://192.168.18.10:8000/api/admin/addstaff/list_jabatan";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
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
    getAllJabatan();
    getAllUnit();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Loading ? loading() : Scaffold(
        appBar: AppBar(
          title: Text("Edit Staff", style: TextStyle(
              fontFamily: "Poppins",
              fontWeight: FontWeight.w700,
              color: HexColor("#025393")
          )),
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: HexColor("#025393"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: Image.asset('images/staff.png', height: 100, width: 100),
                margin: EdgeInsets.only(top: 20),
              ),
              Container(
                child: Text("Edit Data Staff", style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: HexColor("#025393")
                )),
                margin: EdgeInsets.only(top: 20),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text("Unit", style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 14,
                          fontWeight: FontWeight.w700
                      )),
                      margin: EdgeInsets.only(top: 30, left: 20),
                    ),
                    Container(
                      width: 300,
                      padding: EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
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
                            child: Text(
                                unit['nama_unit'].toString(), style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14
                            )),
                          );
                        }).toList(),
                        selectedItemBuilder: (BuildContext context) =>
                            unitItemList.map((unit) =>
                                Center(
                                  child: Text(
                                    unit['nama_unit'].toString(),
                                    style: TextStyle(
                                        fontFamily: "Poppins",
                                        color: Colors.white,
                                        fontSize: 14),
                                  ),
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
                      child: Text("Jabatan", style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 14,
                          fontWeight: FontWeight.w700
                      )),
                      margin: EdgeInsets.only(top: 30, left: 20),
                    ),
                    Container(
                      width: 300,
                      padding: EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
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
                            child: Text(jabatan['nama_jabatan'].toString(),
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 14
                                )),
                          );
                        }).toList(),
                        selectedItemBuilder: (BuildContext context) =>
                            jabatanItemList.map((jabatan) =>
                                Center(
                                  child: Text(
                                      jabatan['nama_jabatan'].toString(),
                                      style: TextStyle(
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
                    ),
                    Container(
                      child: Text("File SK", style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w700,
                        fontSize: 14
                      )),
                      margin: EdgeInsets.only(top: 15, left: 20),
                      alignment: Alignment.topLeft,
                    ),
                    Container(
                      child: Text("Silahkan unggah berkas SK pegawai dalam bentuk format PDF. Kosongkan jika tidak ingin diubah.", style: TextStyle(
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
                  ],
                ),
              ),
              Container(
                child: FlatButton(
                  onPressed: (){
                    setState(() {
                      Loading = true;
                    });
                    var body = jsonEncode({
                      "staff_id" : detailStaffAdmin.staffId,
                      "nama_jabatan" : selectedJabatan,
                      "nama_unit" : selectedUnit,
                      'file_sk' : file == null ? detailStaffAdmin.fileSK : namaFile
                    });
                    http.post(Uri.parse(apiURLSimpanDataStaff),
                      headers: {"Content-Type" : "application/json"},
                      body: body
                    ).then((http.Response response) async {
                      var responseValue = response.statusCode;
                      if(response.statusCode == 200) {
                        if(file == null) {
                          setState(() {
                            Loading = false;
                          });
                          Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(builder: (context) => dashboardAdminDesa()), (route) => false);
                        }else{
                          var stream = http.ByteStream(DelegatingStream.typed(file.openRead()));
                          var length = await file.length();
                          var url = Uri.parse("http://192.168.18.10/siraja-api-skripsi/upload-file-sk-staff.php");
                          var request = http.MultipartRequest("POST", url);
                          var multipartFile = http.MultipartFile("dokumen", stream, length, filename: basename(file.path));
                          request.files.add(multipartFile);
                          var response = await request.send();
                          if(response.statusCode == 200) {
                            Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) => dashboardAdminDesa()), (route) => false);
                          }else{
                            print("File gagal diupload");
                          }
                        }
                      }else{
                        print("Staff gagal diperbaharui");
                      }
                    });
                  },
                  child: Text("Simpan Data", style: TextStyle(
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
                margin: EdgeInsets.only(bottom: 20, top: 50),
              )
            ],
          ),
        ),
      ),
    );
  }
}