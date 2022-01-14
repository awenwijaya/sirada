import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class detailSurat extends StatefulWidget {
  const detailSurat({Key key}) : super(key: key);

  @override
  _detailSuratState createState() => _detailSuratState();
}

class _detailSuratState extends State<detailSurat> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Detail Surat", style: TextStyle(
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
                  'images/email.png',
                  height: 80,
                  width: 80,
                ),
                margin: EdgeInsets.only(top: 30),
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  "SK Belum Menikah",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: HexColor("#025393")
                  ),
                ),
                margin: EdgeInsets.only(top: 20),
              ),
              Container(
                child: Text(
                  "Sedang Menunggu",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.white
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: HexColor("#fab73d")
                ),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                margin: EdgeInsets.only(top: 15),
              ),
              Container(
                child: Text("Detail Surat", style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14,
                    fontWeight: FontWeight.w700
                )),
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(top: 15, left: 25),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text("Nomor Surat",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w700,
                          fontSize: 14
                        ),
                      ),
                      margin: EdgeInsets.only(top: 15),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text("68/SP.TGK/V/2022", style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14
                      )),
                      margin: EdgeInsets.only(top: 5),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text("Tanggal Pengajuan",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w700,
                            fontSize: 14
                        ),
                      ),
                      margin: EdgeInsets.only(top: 20),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text("09 - 01 - 2022", style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 14
                      )),
                      margin: EdgeInsets.only(top: 5),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text("Tanggal Pengesahan",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w700,
                            fontSize: 14
                        ),
                      ),
                      margin: EdgeInsets.only(top: 20),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text("09 - 01 - 2022", style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 14
                      )),
                      margin: EdgeInsets.only(top: 5),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text("Keperluan",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w700,
                            fontSize: 14
                        ),
                      ),
                      margin: EdgeInsets.only(top: 20),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text("Untuk pembuatan surat kerja", style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 14
                      )),
                      margin: EdgeInsets.only(top: 5, bottom: 15),
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
      ),
    );
  }
}
