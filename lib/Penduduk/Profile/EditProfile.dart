import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:surat/Penduduk/Dashboard.dart';
import 'package:surat/Penduduk/Profile/UserProfile.dart';
import 'package:http/http.dart' as http;
import 'package:surat/shared/LoadingAnimation/loading.dart';
import 'package:surat/LoginAndRegistration/LoginPage.dart';

class editProfileUser extends StatefulWidget {
  const editProfileUser({Key key}) : super(key: key);

  @override
  _editProfileUserState createState() => _editProfileUserState();
}

class _editProfileUserState extends State<editProfileUser> {
  TextEditingController controllerUsername;
  TextEditingController controllerAlamat;
  List<String> agama = ["Hindu", "Buddha", "Kristen Katolik", "Kristen Protestan", "Islam", "Konghucu"];
  List<String> statusPerkawinan = ["Belum Menikah", "Sudah Menikah"];
  List<String> pendidikanTerakhir = ["SD", "SMP", "SMA", "D1", "D2", "D3", "D4/S1", "S2", "S3"];
  var apiURLEditProfile = "http://192.168.18.10:8000/api/editprofile";
  String selectedAgama = userProfile.agamaPenduduk;
  String selectedStatusPerkawinan = userProfile.statusPerkawinan;
  String selectedPendidikanTerakhir = userProfile.pendidikanTerakhir;
  bool Loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controllerUsername = new TextEditingController(text: userProfile.usernamePenduduk);
    controllerAlamat = new TextEditingController(text: userProfile.alamatPenduduk);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Loading ? loading() : Scaffold(
        appBar: AppBar(
          title: Text("Edit Profil", style: TextStyle(
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
                  'images/userprof.png',
                  height: 100,
                  width: 100,
                ),
                margin: EdgeInsets.only(top: 30),
              ),
              Container(
                child: Text(
                  "Edit Profil",
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: HexColor("#025393")
                  ),
                  textAlign: TextAlign.center,
                ),
                margin: EdgeInsets.only(top: 20),
              ),
              Container(
                child: Text(
                  "* = diperlukan",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14,
                    fontWeight: FontWeight.w700
                  ),
                  textAlign: TextAlign.center,
                ),
                margin: EdgeInsets.only(top: 10),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Username *",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 14
                        ),
                      ),
                      margin: EdgeInsets.only(top: 30, left: 20),
                    ),
                    Container(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                        child: TextField(
                          controller: controllerUsername,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              borderSide: BorderSide(color: HexColor("#025393"))
                            ),
                            prefixIcon: Icon(Icons.person_outline_rounded),
                            hintText: "Username"
                          ),
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 15
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Alamat *",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14
                        ),
                      ),
                      margin: EdgeInsets.only(top: 15, left: 20),
                    ),
                    Container(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                        child: TextField(
                          controller: controllerAlamat,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                  borderSide: BorderSide(color: HexColor("#025393"))
                              ),
                              prefixIcon: Icon(Icons.location_on_outlined),
                              hintText: "Alamat"
                          ),
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 14
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Agama",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14
                        ),
                      ),
                      margin: EdgeInsets.only(top: 15, left: 20),
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
                            selectedAgama = value;
                          });
                        },
                        value: selectedAgama,
                        underline: Container(),
                        hint: Center(
                          child: Text(
                            selectedAgama,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Poppins",
                              fontSize: 14
                            ),
                          ),
                        ),
                        icon: Icon(Icons.arrow_downward, color: Colors.white),
                        isExpanded: true,
                        items: agama.map((e) => DropdownMenuItem(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              e, style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 14
                            ),
                            ),
                          ),
                          value: e,
                        )).toList(),
                        selectedItemBuilder: (BuildContext context) => agama.map((e) => Center(
                          child: Text(
                            e, style: TextStyle(
                              fontFamily: "Poppins",
                              color: Colors.white,
                              fontSize: 14),
                          ),
                        )).toList(),
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
                      child: Text(
                        "Status Perkawinan",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 15
                        ),
                      ),
                      margin: EdgeInsets.only(top: 15, left: 20),
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
                            selectedStatusPerkawinan = value;
                          });
                        },
                        value: selectedStatusPerkawinan,
                        underline: Container(),
                        hint: Center(
                          child: Text(
                            selectedStatusPerkawinan,
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Poppins",
                                fontSize: 14
                            ),
                          ),
                        ),
                        icon: Icon(Icons.arrow_downward, color: Colors.white),
                        isExpanded: true,
                        items: statusPerkawinan.map((e) => DropdownMenuItem(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              e, style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 15
                            ),
                            ),
                          ),
                          value: e,
                        )).toList(),
                        selectedItemBuilder: (BuildContext context) => statusPerkawinan.map((e) => Center(
                          child: Text(
                            e, style: TextStyle(
                              fontFamily: "Poppins",
                              color: Colors.white,
                              fontSize: 14),
                          ),
                        )).toList(),
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
                      child: Text(
                        "Pendidikan Terakhir",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 15
                        ),
                      ),
                      margin: EdgeInsets.only(top: 15, left: 20),
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
                            selectedPendidikanTerakhir = value;
                          });
                        },
                        value: selectedPendidikanTerakhir,
                        underline: Container(),
                        hint: Center(
                          child: Text(
                            selectedPendidikanTerakhir,
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Poppins",
                                fontSize: 14
                            ),
                          ),
                        ),
                        icon: Icon(Icons.arrow_downward, color: Colors.white),
                        isExpanded: true,
                        items: pendidikanTerakhir.map((e) => DropdownMenuItem(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              e, style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 15
                            ),
                            ),
                          ),
                          value: e,
                        )).toList(),
                        selectedItemBuilder: (BuildContext context) => pendidikanTerakhir.map((e) => Center(
                          child: Text(
                            e, style: TextStyle(
                              fontFamily: "Poppins",
                              color: Colors.white,
                              fontSize: 14),
                          ),
                        )).toList(),
                      ),
                      margin: EdgeInsets.only(top: 15),
                    )
                  ],
                ),
              ),
              Container(
                child: FlatButton(
                  onPressed: (){
                    if(controllerAlamat.text == "" || controllerUsername.text == "") {
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
                                    child: Text(
                                      "Masih terdapat data yang kosong",
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
                                      "Masih terdapat data yang kosong. Silahkan isi semua data yang ditampilkan pada form ini dan silahkan coba lagi",
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 14
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
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
                        "user_id" : loginPage.userId,
                        "penduduk_id" : loginPage.pendudukId,
                        "username" : controllerUsername.text,
                        "alamat" : controllerAlamat.text,
                        "agama" : selectedAgama,
                        "status_perkawinan" : selectedStatusPerkawinan,
                        "pendidikan_terakhir" : selectedPendidikanTerakhir
                      });
                      http.post(Uri.parse(apiURLEditProfile),
                        headers: {"Content-Type" : "application/json"},
                        body: body
                      ).then((http.Response response) {
                        var responseValue = response.statusCode;
                        if(responseValue == 200) {
                          setState(() {
                            Loading = false;
                          });
                          Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => dashboardPenduduk()));
                        }
                      });
                    }
                  },
                  child: Text("Simpan", style: TextStyle(
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
                margin: EdgeInsets.only(bottom: 20, top: 30),
              )
            ],
          ),
        ),
      ),
    );
  }
}
