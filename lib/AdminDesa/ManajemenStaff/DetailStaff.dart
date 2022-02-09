import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class detailStaffAdmin extends StatefulWidget {
  static var status;
  static var masaBerakhir;
  static var namaLengkap;
  static var tempatLahir;
  static var tanggalLahir;
  static var alamat;
  static var agama;
  static var jenisKelamin;
  static var pendidikanTerakhir;
  static var namaUnit;
  static var jabatan;
  const detailStaffAdmin({Key key}) : super(key: key);

  @override
  _detailStaffAdminState createState() => _detailStaffAdminState();
}

class _detailStaffAdminState extends State<detailStaffAdmin> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: HexColor("#025393"),
            onPressed: (){
              Navigator.of(context).pop();
            },
          ),
          title: Text("Detail Staff", style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w700,
            color: HexColor("#025393")
          )),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Image.asset(
                          'images/person.png',
                        height: 100,
                        width: 100,
                      ),
                    ),
                    Container(
                      child: Text(detailStaffAdmin.namaLengkap.toString(), style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 16,
                        color: HexColor("#025393"),
                        fontWeight: FontWeight.w700
                      )),
                      margin: EdgeInsets.only(top: 15),
                    ),
                    Container(
                      child: Text(detailStaffAdmin.status.toString().toUpperCase(), style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.white
                      )),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: HexColor("#fab73d")
                      ),
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      margin: EdgeInsets.only(top: 10),
                    )
                  ],
                ),
                margin: EdgeInsets.only(top: 20),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text("Data Staff", style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.black
                )),
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
                            child: Text("Tempat Lahir", style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 14,
                              fontWeight: FontWeight.w700
                            )),
                            margin: EdgeInsets.only(top: 15),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(detailStaffAdmin.tempatLahir.toString(), style: TextStyle(
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
                            child: Text("Tanggal Lahir", style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14,
                                fontWeight: FontWeight.w700
                            )),
                            margin: EdgeInsets.only(top: 15),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text("${detailStaffAdmin.tanggalLahir.day.toString()}-${detailStaffAdmin.tanggalLahir.month.toString()}-${detailStaffAdmin.tanggalLahir.year.toString()}", style: TextStyle(
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
                                fontSize: 14,
                                fontWeight: FontWeight.w700
                            )),
                            margin: EdgeInsets.only(top: 15),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(detailStaffAdmin.alamat, style: TextStyle(
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
                                fontSize: 14,
                                fontWeight: FontWeight.w700
                            )),
                            margin: EdgeInsets.only(top: 15),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(detailStaffAdmin.agama.toString(), style: TextStyle(
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
                                fontSize: 14,
                                fontWeight: FontWeight.w700
                            )),
                            margin: EdgeInsets.only(top: 15),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(detailStaffAdmin.jenisKelamin.toString(), style: TextStyle(
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
                            child: Text("Pendidikan Terakhir", style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14,
                                fontWeight: FontWeight.w700
                            )),
                            margin: EdgeInsets.only(top: 15),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(detailStaffAdmin.pendidikanTerakhir.toString(), style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14
                            )),
                            margin: EdgeInsets.only(top: 5),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: detailStaffAdmin.masaBerakhir == null ? Container() : Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text("Masa Berakhir", style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14,
                                fontWeight: FontWeight.w700
                              )),
                              margin: EdgeInsets.only(top: 15),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text("${detailStaffAdmin.masaBerakhir.day.toString()}-${detailStaffAdmin.masaBerakhir.month.toString()}-${detailStaffAdmin.masaBerakhir.year.toString()}", style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14
                              )),
                              margin: EdgeInsets.only(top: 5),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text("Nama Unit", style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14,
                                fontWeight: FontWeight.w700
                            )),
                            margin: EdgeInsets.only(top: 15),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(detailStaffAdmin.namaUnit.toString(), style: TextStyle(
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
                            child: Text("Jabatan", style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14,
                                fontWeight: FontWeight.w700
                            )),
                            margin: EdgeInsets.only(top: 15),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(detailStaffAdmin.jabatan.toString(), style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14
                            )),
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
                  child: Text("Edit Staff", style: TextStyle(
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
                margin: EdgeInsets.only(bottom: 20),
              )
            ],
          ),
        ),
      ),
    );
  }
}
