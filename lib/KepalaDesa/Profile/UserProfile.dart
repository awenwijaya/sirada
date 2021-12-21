import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class kepalaDesaProfile extends StatefulWidget {
  const kepalaDesaProfile({Key key}) : super(key: key);
  static var nama = "Nama Anda";
  static var nik = "NIK";
  static var alamat = "Alamat";
  static var golonganDarah = "Golongan Darah";
  static var kewarganegaraan = "Kewarganegaraan";
  static var asalDesa = "Asal Desa";
  static var jenisKelamin = "Jenis Kelamin";
  static var username = "Username";
  static var email = "Email";
  static var nomorTelepon = "Nomor Telepon";
  static var statusPerkawinan = "Status Perkawinan";
  static var agama = "Agama";
  static var pendidikanTerakhir = "Pendidikan Terakhir";

  @override
  _kepalaDesaProfileState createState() => _kepalaDesaProfileState();
}

class _kepalaDesaProfileState extends State<kepalaDesaProfile> {
  var apiURLGetDataPenduduk = "http://192.168.56.149:8000/api/getdatapendudukbyid";
  var apiURLGetDataDesa = "http://192.168.56.149:8000/api/getdatadesabyid";
  var apiURLGetDataUser = "http://192.168.56.149:8000/api/getdatapenggunabyid";

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
                  kepalaDesaProfile.nama.toString(),
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
                  kepalaDesaProfile.username.toString(),
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14
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
                            child: Text("NIK", style: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w700,
                              fontSize: 14
                            ),textAlign: TextAlign.left),
                            margin: EdgeInsets.only(top: 15),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              kepalaDesaProfile.nik.toString(),
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
                              kepalaDesaProfile.alamat.toString(),
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14
                              ),
                            ),
                            margin: EdgeInsets.only(top: 5),
                          ),
                          Container(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: Text("Status Perkawinan",
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  margin: EdgeInsets.only(top: 20),
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    kepalaDesaProfile.statusPerkawinan.toString(),
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
                                  child: Text(
                                    "Jenis Kelamin",
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
                                    kepalaDesaProfile.jenisKelamin.toString(),
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
                                    kepalaDesaProfile.golonganDarah.toString(),
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 14
                                    ),
                                    textAlign: TextAlign.left,
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
                                    kepalaDesaProfile.kewarganegaraan.toString(),
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
                                  child: Text(
                                    "Asal Desa",
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
                                    kepalaDesaProfile.asalDesa.toString(),
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
                                    kepalaDesaProfile.agama.toString(),
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
                                    kepalaDesaProfile.pendidikanTerakhir.toString(),
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
                    )
                  ],
                ),
                decoration: BoxDecoration(
                  color: HexColor("EEEEEE"),
                  borderRadius: BorderRadius.circular(25)
                ),
                padding: EdgeInsets.only(top: 10, bottom: 10, left: 30, right: 30),
                margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
              )
            ],
          ),
        ),
      )
    );
  }
}
