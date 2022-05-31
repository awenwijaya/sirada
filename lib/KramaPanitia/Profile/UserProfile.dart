import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surat/LoginAndRegistration/LoginPage.dart';
import 'package:http/http.dart' as http;
import 'package:surat/WelcomeScreen.dart';

class kramaPanitiaProfile extends StatefulWidget {
  static var namaPenduduk;
  static var nikPenduduk;
  static var alamatPenduduk;
  static var golonganDarah;
  static var asalDesaPenduduk;
  static var jenisKelaminPenduduk;
  static var usernamePenduduk;
  static var emailPenduduk;
  static var nomorTeleponPenduduk;
  static var statusPerkawinan;
  static var agamaPenduduk;
  static var pendidikanTerakhir;
  static var profilePicture;
  static var namaPekerjaan;
  static var pendudukId;
  const kramaPanitiaProfile({Key key}) : super(key: key);

  @override
  State<kramaPanitiaProfile> createState() => _kramaPanitiaProfileState();
}

class _kramaPanitiaProfileState extends State<kramaPanitiaProfile> {
  var apiURLUserProfile = "http://192.168.18.10:8000/api/data/userdata/${loginPage.userId}";
  var apiURLRemoveFCMToken = "http://192.168.18.10:8000/api/autentikasi/login/token/remove";

  getUserInfo() async {
    http.get(Uri.parse(apiURLUserProfile),
      headers: {"Content-Type" : "application/json"}
    ).then((http.Response response) {
      var responseValue = response.statusCode;
      if(responseValue == 200) {
        var jsonData = response.body;
        var parsedJson = json.decode(jsonData);
        setState(() {
          kramaPanitiaProfile.namaPenduduk = parsedJson['nama'];
          kramaPanitiaProfile.usernamePenduduk = parsedJson['username'];
          kramaPanitiaProfile.profilePicture = parsedJson['foto'];
          kramaPanitiaProfile.pendudukId = parsedJson['penduduk_id'].toString();
          kramaPanitiaProfile.nikPenduduk = parsedJson['nik'].toString();
          kramaPanitiaProfile.alamatPenduduk = parsedJson['alamat'];
          kramaPanitiaProfile.golonganDarah = parsedJson['golongan_darah'];
          kramaPanitiaProfile.asalDesaPenduduk = parsedJson['desadat_nama'];
          kramaPanitiaProfile.jenisKelaminPenduduk = parsedJson['jenis_kelamin'];
          kramaPanitiaProfile.emailPenduduk = parsedJson['email'];
          kramaPanitiaProfile.nomorTeleponPenduduk = parsedJson['telepon'];
          kramaPanitiaProfile.statusPerkawinan = parsedJson['status_perkawinan'];
          kramaPanitiaProfile.agamaPenduduk = parsedJson['agama'];
          kramaPanitiaProfile.namaPekerjaan = parsedJson['profesi'];
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Profil Saya", style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w700,
            color: Colors.white
          )),
          backgroundColor: HexColor("#025393"),
        ),
        body: kramaPanitiaProfile.namaPenduduk == null ? ProfilePageShimmer() : SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                child: kramaPanitiaProfile.profilePicture == null ? Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('images/profilepic.png'),
                      fit: BoxFit.fill
                    )
                  ),
                ) : Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage('http://192.168.18.10/SirajaProject/public/assets/img/profile/${kramaPanitiaProfile.profilePicture}')
                    )
                  ),
                ),
                margin: EdgeInsets.only(top: 30),
                alignment: Alignment.center,
              ),
              Container(
                child: Text(kramaPanitiaProfile.namaPenduduk.toString(), style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: HexColor("#025393")
                ), textAlign: TextAlign.center),
                margin: EdgeInsets.only(top: 20),
              ),

              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text("NIK", style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w700,
                                fontSize: 14
                            ), textAlign: TextAlign.center),
                            margin: EdgeInsets.only(top: 15),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(kramaPanitiaProfile.nikPenduduk.toString(), style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14
                            )),
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
                            child: Text("Alamat", style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w700,
                                fontSize: 14
                            ), textAlign: TextAlign.center),
                            margin: EdgeInsets.only(top: 15),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(kramaPanitiaProfile.alamatPenduduk.toString(), style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14
                            )),
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
                            child: Text("Status Perkawinan", style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w700,
                                fontSize: 14
                            ), textAlign: TextAlign.center),
                            margin: EdgeInsets.only(top: 15),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(kramaPanitiaProfile.statusPerkawinan.toString(), style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14
                            )),
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
                            child: Text("Pekerjaan", style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w700,
                                fontSize: 14
                            ), textAlign: TextAlign.center),
                            margin: EdgeInsets.only(top: 15),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(kramaPanitiaProfile.namaPekerjaan.toString(), style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14
                            )),
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
                            child: Text("Jenis Kelamin", style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w700,
                                fontSize: 14
                            ), textAlign: TextAlign.center),
                            margin: EdgeInsets.only(top: 15),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(kramaPanitiaProfile.jenisKelaminPenduduk.toString(), style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14
                            )),
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
                            child: Text("Golongan Darah", style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w700,
                                fontSize: 14
                            ), textAlign: TextAlign.center),
                            margin: EdgeInsets.only(top: 15),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(kramaPanitiaProfile.golonganDarah.toString(), style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14
                            )),
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
                            child: Text("Agama", style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w700,
                                fontSize: 14
                            ), textAlign: TextAlign.center),
                            margin: EdgeInsets.only(top: 15),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(kramaPanitiaProfile.agamaPenduduk.toString(), style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14
                            )),
                            margin: EdgeInsets.only(top: 5),
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
                margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
              ),
              Container(
                child: FlatButton(
                  onPressed: (){},
                  child: Text("Edit Profil", style: TextStyle(
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
                margin: EdgeInsets.only(bottom: 10),
              ),
              Container(
                child: FlatButton(
                  onPressed: (){},
                  child: Text("Logout", style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: HexColor("#B20600")
                  )),
                  color: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                    side: BorderSide(color: HexColor("B20600"), width: 2)
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