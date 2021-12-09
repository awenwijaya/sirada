import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:surat/Penduduk/Profile/EditProfile.dart';
import 'package:surat/LoginAndRegistration/LoginPage.dart';
import 'package:http/http.dart' as http;

class userProfile extends StatefulWidget {
  const userProfile({Key key}) : super(key: key);
  static var namaPenduduk = "Nama Anda";
  static var nikPenduduk = "NIK";
  static var alamatPenduduk = "Alamat Anda";
  static var golonganDarah = "Golongan Darah";
  static var kewarganegaraanPenduduk = "Kewarganegaraan";
  static var asalDesaPenduduk = "Asal Desa";
  static var jenisKelaminPenduduk = "Jenis Kelamin";
  static var usernamePenduduk = "Username";
  static var emailPenduduk = "Email";
  static var nomorTeleponPenduduk = "Nomor Telepon";
  static var statusPerkawinan = "Status Perkawinan";
  static var agamaPenduduk = "Agama";
  static var pendidikanTerakhir = "Pendidikan Terakhir";


  @override
  _userProfileState createState() => _userProfileState();
}

class _userProfileState extends State<userProfile> {
  var apiURLGetDataPenduduk = "http://192.168.18.10:8000/api/getdatapendudukbyid";
  var apiURLGetDataDesa = "http://192.168.18.10:8000/api/getdatadesabyid";
  var apiURLGetDataUser = "http://192.168.18.10:8000/api/getdatapenggunabyid";

  getPendudukInfo() async {
    var body = jsonEncode({
      'penduduk_id' : loginPage.pendudukId
    });
    http.post(Uri.parse(apiURLGetDataPenduduk),
      headers: {"Content-Type" : "application/json"},
      body: body
    ).then((http.Response response) {
      var responseValue = response.statusCode;
      if(responseValue == 200) {
        var jsonData = response.body;
        var parsedJson = json.decode(jsonData);
        setState(() {
          userProfile.namaPenduduk = parsedJson['nama_lengkap'];
          userProfile.nikPenduduk = parsedJson['nik'];
          userProfile.alamatPenduduk = parsedJson['alamat'];
          userProfile.golonganDarah = parsedJson['golongan_darah'];
          userProfile.kewarganegaraanPenduduk = parsedJson['kewarganegaraan'];
          userProfile.jenisKelaminPenduduk = parsedJson['jenis_kelamin'];
          userProfile.statusPerkawinan = parsedJson['status_perkawinan'];
          userProfile.agamaPenduduk = parsedJson['agama'];
          userProfile.pendidikanTerakhir = parsedJson['pendidikan_terakhir'];
        });
      }
    });
  }

  getUserInfo() async {
    var body = jsonEncode({
      'user_id' : loginPage.userId
    });
    http.post(Uri.parse(apiURLGetDataUser),
      headers: {"Content-Type" : "application/json"},
      body: body
    ).then((http.Response response) {
      var responseValue = response.statusCode;
      if(responseValue == 200) {
        var jsonData = response.body;
        var parsedJson = json.decode(jsonData);
        setState(() {
          userProfile.usernamePenduduk = parsedJson['username'];
          userProfile.nomorTeleponPenduduk = parsedJson['nomor_telepon'];
        });
      }
    });
  }

  getDesaInfo() async {
    var body = jsonEncode({
      'desa_id' : loginPage.desaId
    });
    http.post(Uri.parse(apiURLGetDataDesa),
      headers: {"Content-Type" : "application/json"},
      body: body
    ).then((http.Response response) {
      var responseValue = response.statusCode;
      if(responseValue == 200) {
        var jsonData = response.body;
        var parsedJson = json.decode(jsonData);
        setState(() {
          userProfile.asalDesaPenduduk = parsedJson['nama_desa'];
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getPendudukInfo();
    getDesaInfo();
    getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Profil Saya", style: TextStyle(
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
                  userProfile.namaPenduduk.toString(),
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
                  userProfile.usernamePenduduk.toString(),
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
                margin: EdgeInsets.only(top: 5),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "Data Anda",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w700
                  ),
                ),
                margin: EdgeInsets.only(top: 15, left: 25),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text("NIK",
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14
                              ),
                              textAlign: TextAlign.left,
                            ),
                            margin: EdgeInsets.only(top: 15),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              userProfile.nikPenduduk.toString(),
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14
                              ),
                            ),
                            margin: EdgeInsets.only(top: 5),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text("Alamat",
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14
                              ),
                              textAlign: TextAlign.left,
                            ),
                            margin: EdgeInsets.only(top: 20),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              userProfile.alamatPenduduk.toString(),
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14
                              ),
                            ),
                            margin: EdgeInsets.only(top: 5),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text("Status Perkawinan",
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14
                              ),
                              textAlign: TextAlign.left,
                            ),
                            margin: EdgeInsets.only(top: 20),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              userProfile.statusPerkawinan.toString(),
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14
                              ),
                            ),
                            margin: EdgeInsets.only(top: 5),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text("Jenis Kelamin",
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14
                              ),
                              textAlign: TextAlign.left,
                            ),
                            margin: EdgeInsets.only(top: 20),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              userProfile.jenisKelaminPenduduk.toString(),
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14
                              ),
                            ),
                            margin: EdgeInsets.only(top: 5),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text("Golongan Darah",
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14
                              ),
                              textAlign: TextAlign.left,
                            ),
                            margin: EdgeInsets.only(top: 20),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              userProfile.golonganDarah.toString(),
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14
                              ),
                            ),
                            margin: EdgeInsets.only(top: 5),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text("Kewarganegaraan",
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14
                              ),
                              textAlign: TextAlign.left,
                            ),
                            margin: EdgeInsets.only(top: 20),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              userProfile.kewarganegaraanPenduduk.toString(),
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14
                              ),
                            ),
                            margin: EdgeInsets.only(top: 5),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text("Asal Desa",
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14
                              ),
                              textAlign: TextAlign.left,
                            ),
                            margin: EdgeInsets.only(top: 20),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              userProfile.asalDesaPenduduk.toString(),
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14
                              ),
                            ),
                            margin: EdgeInsets.only(top: 5),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text("Agama",
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14
                              ),
                              textAlign: TextAlign.left,
                            ),
                            margin: EdgeInsets.only(top: 20),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              userProfile.agamaPenduduk.toString(),
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14
                              ),
                            ),
                            margin: EdgeInsets.only(top: 5),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text("Pendidikan Terakhir",
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14
                              ),
                              textAlign: TextAlign.left,
                            ),
                            margin: EdgeInsets.only(top: 20),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              userProfile.pendidikanTerakhir.toString(),
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14
                              ),
                            ),
                            margin: EdgeInsets.only(top: 5, bottom: 15),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                decoration: BoxDecoration(
                  color: HexColor("EEEEEE"),
                  borderRadius: BorderRadius.circular(25)
                ),
                padding: EdgeInsets.only(top: 10, bottom: 10, left: 30, right: 30),
                margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
              ),
              Container(
                child: FlatButton(
                  onPressed: (){
                    Navigator.push(context, CupertinoPageRoute(builder: (context) => editProfileUser()));
                  },
                  child: Text('Edit Profil', style: TextStyle(
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
                margin: EdgeInsets.only(bottom: 20),
              )
            ],
          ),
        ),
      ),
    );
  }
}