import 'dart:convert';
import 'package:surat/AdminDesa/ManajemenStaff/DetailStaff.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:surat/shared/LoadingAnimation/loading.dart';
import 'package:surat/AdminDesa/Dashboard.dart';

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
                    )
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
                      "nama_unit" : selectedUnit
                    });
                    http.post(Uri.parse(apiURLSimpanDataStaff),
                      headers: {"Content-Type" : "application/json"},
                      body: body
                    ).then((http.Response response) {
                      var responseValue = response.statusCode;
                      if(response.statusCode == 200) {
                        setState(() {
                          Loading = false;
                        });
                        Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(builder: (context) => dashboardAdminDesa()), (route) => false);
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