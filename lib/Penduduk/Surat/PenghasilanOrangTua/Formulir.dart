import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:surat/Penduduk/Surat/PengajuanBerhasil.dart';
import 'package:surat/shared/API/Models/OrangTua.dart';
import 'package:surat/LoginAndRegistration/LoginPage.dart';
import 'package:surat/shared/LoadingAnimation/loading.dart';

class formSPPenghasilanOrangTua extends StatefulWidget {
  const formSPPenghasilanOrangTua({Key key}) : super(key: key);

  @override
  _formSPPenghasilanOrangTuaState createState() => _formSPPenghasilanOrangTuaState();
}

class _formSPPenghasilanOrangTuaState extends State<formSPPenghasilanOrangTua> {
  var apiURLUpSPPenghasilanOrangTua = "http://192.168.18.10:8000/api/sp/penghasilanortu/up";
  bool Loading = false;
  var namaOrangTua = "Data orang tua belum terpilih";
  final controllerGaji = TextEditingController();
  final controllerKeperluan = TextEditingController();
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Loading ? loading() : Scaffold(
        appBar: AppBar(
          title: Text("Pengajuan SP", style: TextStyle(
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
                alignment: Alignment.center,
                child: Text(
                  namaOrangTua,
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 14,
                      fontWeight: FontWeight.bold
                  ),
                ),
                margin: EdgeInsets.only(top: 20),
              ),
              Container(
                child: FlatButton(
                  onPressed: (){
                    navigatePilihDataOrangTua(context);
                  },
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
                margin: EdgeInsets.only(top: 10),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                  child: TextField(
                    controller: controllerGaji,
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
                    controller: controllerKeperluan,
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
                  onPressed: (){
                    if(namaOrangTua == "Data orang tua belum terpilih" || controllerKeperluan.text == "" || controllerGaji.text ==  "") {
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
                                        "Data ada yang belum terisi",
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
                                        "Isikanlah semua data yang ada sebelum melanjutkan",
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
                        "nama_orang_tua" : namaOrangTua,
                        'penduduk_id' : loginPage.pendudukId,
                        'jumlah_penghasilan' : controllerGaji.text,
                        'keperluan' : controllerKeperluan.text,
                        'desa_id' : loginPage.desaId
                      });
                      http.post(Uri.parse(apiURLUpSPPenghasilanOrangTua),
                          headers: {"Content-Type" : "application/json"},
                          body: body
                      ).then((http.Response response) {
                        var responseValue = response.statusCode;
                        if(responseValue == 200) {
                          setState(() {
                            Loading = false;
                          });
                          Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => pengajuanSKKelahiranBerhasil()));
                        }
                      });
                    }
                  },
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

  void navigatePilihDataOrangTua(BuildContext context) async {
    final result = await Navigator.push(context, CupertinoPageRoute(builder: (context) => pilihDataOrangTua()));
    if(result == null) {
      namaOrangTua = namaOrangTua;
    }else{
      setState(() {
        namaOrangTua = result;
      });
    }
  }
}

class pilihDataOrangTua extends StatefulWidget {
  const pilihDataOrangTua({Key key}) : super(key: key);

  @override
  _pilihDataOrangTuaState createState() => _pilihDataOrangTuaState();
}

class _pilihDataOrangTuaState extends State<pilihDataOrangTua> {
  var apiURLGetDataOrangTua = "http://192.168.18.10:8000/api/sp/penghasilanortu/getdataortu";

  Future<OrangTua> functionListOrangTua() async {
    var body = jsonEncode({
      "penduduk_id" : loginPage.pendudukId
    });
    return http.post(Uri.parse(apiURLGetDataOrangTua),
      headers: {"Content-Type" : "application/json"},
      body: body
    ).then((http.Response response) {
      if(response.statusCode == 200) {
        final body = response.body;
        final orangTuaData = orangTuaFromJson(body);
        return orangTuaData;
      }else{
        final body = response.body;
        final error = orangTuaFromJson(body);
        return error;
      }
    });
  }

  Widget listOrangTua() {
    return FutureBuilder<OrangTua>(
      future: functionListOrangTua(),
      builder: (context, snapshot) {
        final data = snapshot.data;
        if(snapshot.hasData) {
          final orangTuaData = data.data;
          return ListView.builder(
            itemCount: orangTuaData.length,
            itemBuilder: (context, index) {
              final orangTua = orangTuaData[index];
              return TextButton(
                onPressed: (){
                  Navigator.of(context, rootNavigator: true).pop(orangTua.namaLengkap);
                },
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          Container(
                            child: Image.asset(
                              'images/person.png',
                              height: 50,
                              width: 50,
                            ),
                          ),
                          Container(
                            child: Text(
                              orangTua.namaLengkap.toString(),
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w700,
                                color: Colors.black
                              ),
                            ),
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(left: 10),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.symmetric(vertical: 10),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.black26, width: 1))
                      ),
                    )
                  ],
                ),
              );
            },
          );
        }else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Pilih Orang Tua", style: TextStyle(
              fontFamily: "Poppins",
              fontWeight: FontWeight.w700,
              color: HexColor("#025393")
          )),
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: (){Navigator.of(context, rootNavigator: true).pop();},
            color: HexColor("#025393"),
          ),
        ),
        body: listOrangTua()
      ),
    );
  }
}