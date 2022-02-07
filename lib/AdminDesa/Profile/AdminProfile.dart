import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class adminProfile extends StatefulWidget {
  adminProfile({Key key}) : super(key: key);

  @override
  State<adminProfile> createState() => _adminProfileState();
}

class _adminProfileState extends State<adminProfile> {
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
                child: Text("Admin Desa", style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: HexColor("#025393")
                ), textAlign: TextAlign.center),
                margin: EdgeInsets.only(top: 20)
              ),
              Container(
                child: Text("admindesa", style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14
                ), textAlign: TextAlign.center),
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
                            ), textAlign: TextAlign.left),
                            margin: EdgeInsets.only(top: 15),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "123456789",
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
                            child: Text("Alamat", style: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w700,
                              fontSize: 14
                            ), textAlign: TextAlign.left),
                            margin: EdgeInsets.only(top: 15),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Denpasar",
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
                            child: Text("Status Perkawinan", style: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w700,
                              fontSize: 14
                            ), textAlign: TextAlign.left),
                            margin: EdgeInsets.only(top: 15),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Sudah Menikah",
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
                            child: Text("Jenis Kelamin", style: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w700,
                              fontSize: 14
                            ), textAlign: TextAlign.left),
                            margin: EdgeInsets.only(top: 15),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Laki-Laki",
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
                            child: Text("Golongan Darah", style: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w700,
                              fontSize: 14
                            ), textAlign: TextAlign.left),
                            margin: EdgeInsets.only(top: 15),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "A",
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
                            child: Text("Kewarganegaraan", style: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w700,
                              fontSize: 14
                            ), textAlign: TextAlign.left),
                            margin: EdgeInsets.only(top: 15),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "WNI",
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
                            child: Text("Asal Desa", style: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w700,
                              fontSize: 14
                            ), textAlign: TextAlign.left),
                            margin: EdgeInsets.only(top: 15),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Ubung Kaja",
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
                            child: Text("Agama", style: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w700,
                              fontSize: 14
                            ), textAlign: TextAlign.left),
                            margin: EdgeInsets.only(top: 15),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Buddha",
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
                            child: Text("Pendidikan Terakhir", style: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w700,
                              fontSize: 14
                            ), textAlign: TextAlign.left),
                            margin: EdgeInsets.only(top: 15),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "SMA",
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
                  onPressed: (){},
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