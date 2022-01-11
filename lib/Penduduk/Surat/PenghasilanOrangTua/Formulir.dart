import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class formSPPenghasilanOrangTua extends StatefulWidget {
  const formSPPenghasilanOrangTua({Key key}) : super(key: key);

  @override
  _formSPPenghasilanOrangTuaState createState() => _formSPPenghasilanOrangTuaState();
}

class _formSPPenghasilanOrangTuaState extends State<formSPPenghasilanOrangTua> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Formulir SP Penghasilan Orang Tua", style: TextStyle(
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
                  'images/paycheck.png',
                  height: 100,
                  width: 100,
                ),
                margin: EdgeInsets.only(top: 20),
              ),
              Container(
                child: Text(
                  "Pengajuan SP Penghasilan Orang Tua",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: HexColor("#025393")
                  ),
                  textAlign: TextAlign.center,
                ),
                margin: EdgeInsets.only(top: 10),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "1. Data Orang Tua",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14,
                    fontWeight: FontWeight.w700
                  ),
                ),
                margin: EdgeInsets.only(top: 30, left: 20),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "Silahkan pilih data orang tua yang akan dibuat pernyataan gajinya. Bisa data Ibu ataupun data Ayah yang Anda masukkan.\n\nData orang tua ini nantinya akan otomatis dimasukkan ke dalam berkas surat ketika berkas surat sudah di verifikasi.",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14
                  ),
                ),
                padding: EdgeInsets.only(left: 30, right: 30),
                margin: EdgeInsets.only(top: 10),
              ),
              Container(
                child: FlatButton(
                  onPressed: (){},
                  child: Text(
                    "Pilih Data Orang Tua",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 14,
                      color: HexColor("#025393"),
                      fontWeight: FontWeight.w700
                    ),
                  ),
                  color: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                    side: BorderSide(color: HexColor("#025393"), width: 2)
                  ),
                  padding: EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50),
                ),
                margin: EdgeInsets.only(top: 20),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        borderSide: BorderSide(color: HexColor("#025393"))
                      ),
                      hintText: "Gaji Orang Tua (Dalam Rupiah)",
                      prefixIcon: Icon(Icons.attach_money)
                    ),
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 14
                    ),
                  ),
                ),
                margin: EdgeInsets.only(top: 20),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "2. Keperluan",
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 14,
                      fontWeight: FontWeight.w700
                  ),
                ),
                margin: EdgeInsets.only(top: 30, left: 20),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "Silahkan masukkan keperluan Anda dalam mengurus surat ini.\n\nKeperluan Anda nantinya akan otomatis dimasukkan ke dalam berkas surat ketika berkas surat sudah di verifikasi",
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 14
                  ),
                ),
                padding: EdgeInsets.only(left: 30, right: 30),
                margin: EdgeInsets.only(top: 10),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                  child: TextField(
                    maxLines: 5,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(color: HexColor("#025393"))
                      ),
                      hintText: "Keperluan Anda"
                    ),
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 14
                    ),
                  ),
                ),
                margin: EdgeInsets.only(top: 20),
              ),
              Container(
                child: FlatButton(
                  child: Text(
                    "Ajukan SP Penghasilan Orang Tua",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 14,
                      color: HexColor("#025393"),
                      fontWeight: FontWeight.w700
                    ),
                  ),
                  color: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                    side: BorderSide(color: HexColor("#025393"), width: 2)
                  ),
                  padding: EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50),
                ),
                margin: EdgeInsets.only(top: 20, bottom: 20),
              )
            ],
          ),
        ),
      ),
    );
  }
}
