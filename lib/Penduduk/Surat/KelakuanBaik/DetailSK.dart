import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:surat/Penduduk/Dashboard.dart';
import 'package:surat/shared/LoadingAnimation/loading.dart';

class detailSKKelakuanBaik extends StatefulWidget {
  static var status;
  static var keperluan;
  static var tanggalPengajuan;
  static var tanggalPengesahan;
  static var skKelakuanBaikId;
  static var suratMasyarakatId;
  const detailSKKelakuanBaik({Key key}) : super(key: key);

  @override
  _detailSKKelakuanBaikState createState() => _detailSKKelakuanBaikState();
}

class _detailSKKelakuanBaikState extends State<detailSKKelakuanBaik> {
  var apiURLBatalSK = "http://192.168.18.10:8000/api/sk/kelakuanbaik/cancel";
  bool Loading = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Loading ? loading() : Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: HexColor("#025393"),
            onPressed: (){Navigator.of(context).pop();},
          ),
          title: Text("Detail SK", style: TextStyle(
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
                child: Image.asset(
                  'images/thumb.png',
                  height: 100,
                  width: 100,
                ),
                margin: EdgeInsets.only(top: 20),
              ),
              Container(
                child: Text(
                  detailSKKelakuanBaik.status.toString(),
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
                child: Text("Detail SK", style: TextStyle(
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
                      child: Text("Tanggal Pengajuan", style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14,
                        fontWeight: FontWeight.w700
                      )),
                      margin: EdgeInsets.only(top: 15),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text("${detailSKKelakuanBaik.tanggalPengajuan.day.toString()} - ${detailSKKelakuanBaik.tanggalPengajuan.month.toString()} - ${detailSKKelakuanBaik.tanggalPengajuan.year.toString()}", style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14
                      )),
                      margin: EdgeInsets.only(top: 5),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text("Tanggal Pengesahan", style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14,
                        fontWeight: FontWeight.w700
                      )),
                      margin: EdgeInsets.only(top: 20),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: detailSKKelakuanBaik.tanggalPengesahan == null ? Text("SK ini belum disahkan oleh Kepala Desa", style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 14
                      )) : Text("${detailSKKelakuanBaik.tanggalPengajuan.day.toString()} - ${detailSKKelakuanBaik.tanggalPengajuan.month.toString()} - ${detailSKKelakuanBaik.tanggalPengajuan.year.toString()}", style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 14
                      )),
                      margin: EdgeInsets.only(top: 5),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text("Keperluan", style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14,
                        fontWeight: FontWeight.w700
                      )),
                      margin: EdgeInsets.only(top: 20),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(detailSKKelakuanBaik.keperluan.toString(), style: TextStyle(
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
                margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
              ),
              Container(
                child: FlatButton(
                  onPressed: (){
                    if(detailSKKelakuanBaik.status == "Dalam Verifikasi" || detailSKKelakuanBaik.status == "Selesai" || detailSKKelakuanBaik.status == "Sedang Diproses") {
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
                                      'images/alert.png',
                                      height: 50,
                                      width: 50,
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "Tidak bisa membatalkan pengajuan",
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
                                      "Maaf! Anda tidak dapat mengajukan pembatalan SK",
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
                        "surat_masyarakat_id" : detailSKKelakuanBaik.suratMasyarakatId,
                        "id_sk_kelakuan_baik" : detailSKKelakuanBaik.skKelakuanBaikId
                      });
                      http.post(Uri.parse(apiURLBatalSK),
                        headers: {"Content-Type" : "application/json"},
                        body: body
                      ).then((http.Response response) {
                        var responseValue = response.statusCode;
                        if(responseValue == 200) {
                          setState(() {
                            Loading = false;
                          });
                          Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(builder: (context) => dashboardPenduduk()), (route) => false);
                        }
                      });
                    }
                  },
                  child: Text("Batalkan Pengajuan SK", style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14,
                    color: HexColor("#c33124"),
                    fontWeight: FontWeight.w700
                  )),
                  color: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                    side: BorderSide(color: HexColor("#c33124"), width: 2)
                  ),
                  padding: EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50),
                ),
                margin: EdgeInsets.only(top: 10, bottom: 30),
              )
            ],
          ),
        ),
      ),
    );
  }
}