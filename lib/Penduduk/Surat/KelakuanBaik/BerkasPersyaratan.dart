import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:io';
import 'dart:async';

class berkasPersyaratanKelakuanBaik extends StatefulWidget {
  const berkasPersyaratanKelakuanBaik({Key key}) : super(key: key);

  @override
  _berkasPersyaratanKelakuanBaikState createState() => _berkasPersyaratanKelakuanBaikState();
}

class _berkasPersyaratanKelakuanBaikState extends State<berkasPersyaratanKelakuanBaik> {
  File image;
  var suratPengantarRTStatus;
  var ktpPemohon;
  var pasFoto;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Unggah Berkas Persyaratan", style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w700,
            color: HexColor("#025393")
          )),
          backgroundColor: Colors.white
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
                alignment: Alignment.center,
                child: Text("Silahkan siapkan berkas-berkas persyaratan sesuai yang ditampilkan pada form ini dan silahkan unggah berkas persyaratan sebelum melanjutkan", style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14,
                ), textAlign: TextAlign.center),
                padding: EdgeInsets.only(left: 30, right: 30),
                margin: EdgeInsets.only(top: 20),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Stack(
                        children: <Widget>[
                          Container(
                            child: Text("1. Surat Pengantar RT/RW", style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 14,
                              fontWeight: FontWeight.w700
                            )),
                            margin: EdgeInsets.only(left: 20),
                          ),
                          Container(
                            alignment: Alignment.topRight,
                            child: suratPengantarRTStatus == null ? Text("Belum Terupload", style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: HexColor("#c33124")
                            )) : Text("Sudah Terupload", style: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: HexColor("#025b0e")
                            )),
                            margin: EdgeInsets.only(right: 20),
                          )
                        ],
                      ),
                      margin: EdgeInsets.only(top: 20),
                    ),
                    Container(
                      child: FlatButton(
                        onPressed: (){
                          navigateUpSuratPengantarRTKelakuanBaik(context);
                        },
                        child: Text("Unggah Berkas Surat Pengantar", style: TextStyle(
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
                      margin: EdgeInsets.only(top: 20),
                    )
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Stack(
                        children: <Widget>[
                          Container(
                            child: Text("2. KTP", style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14,
                                fontWeight: FontWeight.w700
                            )),
                            margin: EdgeInsets.only(left: 20),
                          ),
                          Container(
                            alignment: Alignment.topRight,
                            child: ktpPemohon == null ? Text("Belum Terupload", style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: HexColor("#c33124")
                            )) : Text("Sudah Terupload", style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: HexColor("#025b0e")
                            )),
                            margin: EdgeInsets.only(right: 20),
                          )
                        ],
                      ),
                      margin: EdgeInsets.only(top: 20),
                    ),
                    Container(
                      child: FlatButton(
                        onPressed: (){},
                        child: Text("Unggah Berkas KTP", style: TextStyle(
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
                      margin: EdgeInsets.only(top: 20),
                    )
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Stack(
                        children: <Widget>[
                          Container(
                            child: Text("3. Foto Diri", style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14,
                                fontWeight: FontWeight.w700
                            )),
                            margin: EdgeInsets.only(left: 20),
                          ),
                          Container(
                            alignment: Alignment.topRight,
                            child: pasFoto == null ? Text("Belum Terupload", style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: HexColor("#c33124")
                            )) : Text("Sudah Terupload", style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: HexColor("#025b0e")
                            )),
                            margin: EdgeInsets.only(right: 20),
                          )
                        ],
                      ),
                      margin: EdgeInsets.only(top: 20),
                    ),
                    Container(
                      child: FlatButton(
                        onPressed: (){},
                        child: Text("Unggah Pas Foto", style: TextStyle(
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
                      margin: EdgeInsets.only(top: 20),
                    )
                  ],
                ),
              ),
              Container(
                child: FlatButton(
                  onPressed: (){
                    if(pasFoto == null || ktpPemohon == null || suratPengantarRTStatus == null) {
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
                                      "Berkas ada yang belum terupload",
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
                                    child: Text("Silahkan unggah semua berkas persyaratan sebelum melanjutkan", style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 14
                                    ), textAlign: TextAlign.center),
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
                    }
                  },
                  child: Text("Simpan SK Kelakuan Baik", style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.white
                  )),
                  color: HexColor("#025393"),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)
                  ),
                  padding: EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50),
                ),
                margin: EdgeInsets.only(top: 50, bottom: 30),
              )
            ],
          ),
        ),
      ),
    );
  }

  void navigateUpSuratPengantarRTKelakuanBaik(BuildContext context) async {
    final result = await Navigator.push(context, CupertinoPageRoute(builder: (context) => upSuratPengantarRTKelakuanBaik()));
    if(result == null) {
      suratPengantarRTStatus = suratPengantarRTStatus;
    }else{
      setState(() {
        suratPengantarRTStatus = result;
      });
    }
  }
}

class upSuratPengantarRTKelakuanBaik extends StatefulWidget {
  const upSuratPengantarRTKelakuanBaik({Key key}) : super(key: key);

  @override
  _upSuratPengantarRTKelakuanBaikState createState() => _upSuratPengantarRTKelakuanBaikState();
}

class _upSuratPengantarRTKelakuanBaikState extends State<upSuratPengantarRTKelakuanBaik> {
  File image;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: HexColor("#025393"),
            onPressed: (){Navigator.of(context, rootNavigator: true).pop();},
          ),
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
                alignment: Alignment.center,
                child: Text("Unggah Surat Pengantar", style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: HexColor("#025393")
                )),
                margin: EdgeInsets.only(top: 30),
              ),
              Container(
                alignment: Alignment.center,
                child: Text("Silahkan upload berkas surat pengatar kelakuan baik dari RT/RW dengan cara melakukan scan terhadap surat tersebut dan upload dalam bentuk gambar. Usahakan hasil scan dari surat Anda terlihat jelas dan tidak blur", style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14
                ), textAlign: TextAlign.center),
                padding: EdgeInsets.only(left: 30, right: 30),
                margin: EdgeInsets.only(top: 20),
              ),
              Container(
                child: image == null ? Text('Surat pengantar dari RT/RW belum terpilih', style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14,
                  fontWeight: FontWeight.w700
                )) : Image.file(image, height: 100, width: 100),
                margin: EdgeInsets.only(top: 30),
              ),
              Container(
                child: FlatButton(
                  onPressed: (){},
                  child: Text("Pilih Berkas Surat Pengantar", style: TextStyle(
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
                margin: EdgeInsets.only(top: 10, bottom: 30),
              ),
              Container(
                child: FlatButton(
                  onPressed: (){
                    if(image == null) {
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
                                    child: Text("Berkas belum terpilih", style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: HexColor("#025393")
                                    ), textAlign: TextAlign.center),
                                    margin: EdgeInsets.only(top: 10),
                                  ),
                                  Container(
                                    child: Text("Silahkan pilih berkas surat pengantar terlebih dahulu sebelum melanjutkan", style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 14
                                    ), textAlign: TextAlign.center),
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
                    }
                  },
                  child: Text("Unggah Berkas", style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w700,
                    color: Colors.white
                  )),
                  color: HexColor("#025393"),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)
                  ),
                  padding: EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50),
                ),
                margin: EdgeInsets.only(top: 20, bottom: 30),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class upKTPKelakuanBaik extends StatefulWidget {
  const upKTPKelakuanBaik({Key key}) : super(key: key);

  @override
  _upKTPKelakuanBaikState createState() => _upKTPKelakuanBaikState();
}

class _upKTPKelakuanBaikState extends State<upKTPKelakuanBaik> {
  File image;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: HexColor("#025393"),
            onPressed: (){Navigator.of(context, rootNavigator: true).pop();},
          ),
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
                alignment: Alignment.center,
                child: Text("Unggah KTP", style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: HexColor("#025393")
                )),
                margin: EdgeInsets.only(top: 30),
              ),
              Container(
                alignment: Alignment.center,
                child: Text("Silahkan upload KTP dengan cara melakukan scan terhadap KTP Anda dan upload dalam bentuk gambar. Usahakan hasil scan dari KTP Anda terlihat jelas dan tidak blur", style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14,
                ), textAlign: TextAlign.center),
                padding: EdgeInsets.only(left: 30, right: 30),
                margin: EdgeInsets.only(top: 20),
              ),
              Container(
                child: image == null ? Text('KTP belum terpilih', style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                )) : Image.file(image, height: 100, width: 100),
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.only(left: 30, right: 30),
              )
            ],
          ),
        ),
      ),
    );
  }
}
