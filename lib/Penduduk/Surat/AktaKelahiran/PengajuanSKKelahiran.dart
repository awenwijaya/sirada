import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:surat/Penduduk/Surat/AktaKelahiran/Formulir.dart';

class pengajuanSKKelahiran extends StatelessWidget {
  const pengajuanSKKelahiran({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("SK Kelahiran", style: TextStyle(
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
                  'images/baby.png',
                  height: 100,
                  width: 100,
                ),
                margin: EdgeInsets.only(top: 20),
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  "Pengajuan SK Kelahiran",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 16,
                    fontWeight: FontWeight.w700
                  ),
                ),
              ),
              Container(
                child: Text(
                  "Sebelum melakukan pengurusan SK Kelahiran, silahkan siapkan dan lengkapi berkas-berkas dibawah ini",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20),
                margin: EdgeInsets.only(top: 20),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          Container(
                            child: Image.asset(
                              'images/paper.png',
                              height: 40,
                              width: 40,
                            ),
                            margin: EdgeInsets.only(left: 20),
                          ),
                          Container(
                            child: Text(
                              "Surat keterangan lahir dari dokter/bidan",
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14,
                                fontWeight: FontWeight.w700
                              ),
                            ),
                            margin: EdgeInsets.only(left: 15),
                          )
                        ],
                      ),
                      margin: EdgeInsets.only(top: 20),
                    ),
                    Container(
                      child: Row(
                        children: <Widget>[
                          Container(
                            child: Image.asset(
                              'images/paper.png',
                              height: 40,
                              width: 40,
                            ),
                            margin: EdgeInsets.only(left: 20),
                          ),
                          Container(
                            child: Text(
                              "Akta Nikah",
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700
                              ),
                            ),
                            margin: EdgeInsets.only(left: 15),
                          )
                        ],
                      ),
                      margin: EdgeInsets.only(top: 20),
                    ),
                    Container(
                      child: Row(
                        children: <Widget>[
                          Container(
                            child: Image.asset(
                              'images/paper.png',
                              height: 40,
                              width: 40,
                            ),
                            margin: EdgeInsets.only(left: 20),
                          ),
                          Container(
                            child: Text(
                              "KTP Orang Tua",
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700
                              ),
                            ),
                            margin: EdgeInsets.only(left: 15),
                          )
                        ],
                      ),
                      margin: EdgeInsets.only(top: 20),
                    ),
                    Container(
                      child: Row(
                        children: <Widget>[
                          Container(
                            child: Image.asset(
                              'images/paper.png',
                              height: 40,
                              width: 40,
                            ),
                            margin: EdgeInsets.only(left: 20),
                          ),
                          Container(
                            child: Text(
                              "KTP 2 orang saksi",
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700
                              ),
                            ),
                            margin: EdgeInsets.only(left: 15),
                          )
                        ],
                      ),
                      margin: EdgeInsets.only(top: 20),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: FlatButton(
                        onPressed: (){
                          Navigator.push(context, CupertinoPageRoute(builder: (context) => formPendaftaranAktaKelahiran()));
                        },
                        child: Text(
                          "Ajukan SK Kelahiran",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w700
                          ),
                        ),
                        color: HexColor("#025393"),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)
                        ),
                        padding: EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50),
                      ),
                      margin: EdgeInsets.only(top: 30),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
