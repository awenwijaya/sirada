import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:surat/Penduduk/Surat/AktaKelahiran/Formulir.dart';

class pengajuanSurat extends StatelessWidget {
  const pengajuanSurat({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: Icon(CupertinoIcons.back),
                  color: Colors.black,
                  onPressed: (){Navigator.of(context).pop();},
                ),
                margin: EdgeInsets.only(top: 60, left: 10),
              ),
              Container(
                child: Text(
                  "Pengajuan Surat Akta Kelahiran",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    color: HexColor("#025393")
                  ),
                  textAlign: TextAlign.center,
                ),
                padding: EdgeInsets.symmetric(horizontal: 20),
              ),
              Container(
                child: Image.asset(('images/baby.png'), height: 150, width: 150),
                margin: EdgeInsets.only(top: 20),
              ),
              Container(
                child: Text(
                  "Sebelum melakukan pengurusan surat akta kelahiran, silahkan siapkan dan lengkapi berkas-berkas dibawah ini:",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 15,
                    color: Colors.black
                  ),
                ),
                alignment: Alignment.topLeft,
                padding: EdgeInsets.symmetric(horizontal: 20),
                margin: EdgeInsets.only(top: 50),
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
                              height: 30,
                              width: 30,
                            ),
                          ),
                          Container(
                            child: Text(
                              "KK Asli",
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700
                              ),
                            ),
                            margin: EdgeInsets.only(left: 20),
                          )
                        ],
                      ),
                      margin: EdgeInsets.only(top: 30, left: 20),
                    ),
                    Container(
                      child: Row(
                        children: <Widget>[
                          Container(
                            child: Image.asset(
                                'images/paper.png',
                              height: 30,
                              width: 30,
                            ),
                          ),
                          Container(
                            child: Text(
                              "Surat Keterangan Lahir",
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 15,
                                fontWeight: FontWeight.w700
                              ),
                            ),
                            margin: EdgeInsets.only(left: 20),
                          )
                        ],
                      ),
                      margin: EdgeInsets.only(top: 30, left: 20),
                    ),
                    Container(
                      child: Row(
                        children: <Widget>[
                          Container(
                            child: Image.asset(
                              'images/paper.png',
                              height: 30,
                              width: 30,
                            ),
                          ),
                          Container(
                            child: Text(
                              "Fotokopi KTP-EI orang tua",
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700
                              ),
                            ),
                            margin: EdgeInsets.only(left: 20),
                          )
                        ],
                      ),
                      margin: EdgeInsets.only(top: 30, left: 20),
                    ),
                    Container(
                      child: Row(
                        children: <Widget>[
                          Container(
                            child: Image.asset(
                              'images/paper.png',
                              height: 30,
                              width: 30,
                            ),
                          ),
                          Container(
                            child: Text(
                              "Fotokopi KTP-EI dua orang saksi",
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700
                              ),
                            ),
                            margin: EdgeInsets.only(left: 20),
                          )
                        ],
                      ),
                      margin: EdgeInsets.only(top: 30, left: 20),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: FlatButton(
                        onPressed: (){
                          Navigator.push(context, CupertinoPageRoute(builder: (context) => formPendaftaranAktaKelahiran()));
                        },
                        child: Text(
                          "Ajukan Akta Kelahiran",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 15,
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
