import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:surat/Penduduk/Surat/PengajuanBerhasil.dart';

class uploadBerkasPersyaratan extends StatefulWidget {
  const uploadBerkasPersyaratan({Key key}) : super(key: key);

  @override
  _uploadBerkasPersyaratanState createState() => _uploadBerkasPersyaratanState();
}

class _uploadBerkasPersyaratanState extends State<uploadBerkasPersyaratan> {
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
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      child: Image.asset(
                        'images/paper.png',
                        height: 80,
                        width: 80,
                      ),
                      margin: EdgeInsets.only(top: 20),
                    ),
                    Container(
                      child: Text(
                        "Berkas Persyaratan",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: HexColor("#025393")
                        ),
                        textAlign: TextAlign.center,
                      ),
                      margin: EdgeInsets.only(top: 10),
                    )
                  ],
                ),
              ),
              Container(
                child: Text(
                  "Tinggal selangkah lagi sebelum pengurusan SK Kelahiran selesai! \n\n Silahkan unggah semua berkas persyaratan yang ditunjukkan pada halaman persyaratan berkas pada form dibawah ini",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20),
                margin: EdgeInsets.only(top: 30),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Text(
                        "1. Surat Keterangan Lahir dari Dokter/Bidan",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Container(
                      child: FlatButton(
                        onPressed: (){},
                        color: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                          side: BorderSide(color: HexColor("#025393"))
                        ),
                        padding: EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: Text(
                                "Unggah Berkas",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 15,
                                  color: HexColor("#025393"),
                                  fontWeight: FontWeight.w700
                                ),
                              ),
                              margin: EdgeInsets.only(right: 5),
                            ),
                            Container(
                              child: Icon(Icons.arrow_forward, color: HexColor("#025393")),
                            )
                          ],
                        ),
                      ),
                      margin: EdgeInsets.only(top: 20, left: 30, right: 30),
                    )
                  ],
                ),
                margin: EdgeInsets.only(top: 30),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Text(
                        "2. Akta Nikah",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Container(
                      child: FlatButton(
                        onPressed: (){},
                        color: Colors.transparent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                            side: BorderSide(color: HexColor("#025393"))
                        ),
                        padding: EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: Text(
                                "Unggah Berkas",
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 15,
                                    color: HexColor("#025393"),
                                    fontWeight: FontWeight.w700
                                ),
                              ),
                              margin: EdgeInsets.only(right: 5),
                            ),
                            Container(
                              child: Icon(Icons.arrow_forward, color: HexColor("#025393")),
                            )
                          ],
                        ),
                      ),
                      margin: EdgeInsets.only(top: 20, left: 30, right: 30),
                    )
                  ],
                ),
                margin: EdgeInsets.only(top: 30),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Text(
                        "3. KTP Ayah",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Container(
                      child: FlatButton(
                        onPressed: (){},
                        color: Colors.transparent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                            side: BorderSide(color: HexColor("#025393"))
                        ),
                        padding: EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: Text(
                                "Unggah Berkas",
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 15,
                                    color: HexColor("#025393"),
                                    fontWeight: FontWeight.w700
                                ),
                              ),
                              margin: EdgeInsets.only(right: 5),
                            ),
                            Container(
                              child: Icon(Icons.arrow_forward, color: HexColor("#025393")),
                            )
                          ],
                        ),
                      ),
                      margin: EdgeInsets.only(top: 20, left: 30, right: 30),
                    )
                  ],
                ),
                margin: EdgeInsets.only(top: 30),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Text(
                        "4. KTP Ibu",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Container(
                      child: FlatButton(
                        onPressed: (){},
                        color: Colors.transparent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                            side: BorderSide(color: HexColor("#025393"))
                        ),
                        padding: EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: Text(
                                "Unggah Berkas",
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 15,
                                    color: HexColor("#025393"),
                                    fontWeight: FontWeight.w700
                                ),
                              ),
                              margin: EdgeInsets.only(right: 5),
                            ),
                            Container(
                              child: Icon(Icons.arrow_forward, color: HexColor("#025393")),
                            )
                          ],
                        ),
                      ),
                      margin: EdgeInsets.only(top: 20, left: 30, right: 30),
                    )
                  ],
                ),
                margin: EdgeInsets.only(top: 30),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Text(
                        "5. KTP Saksi I",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Container(
                      child: FlatButton(
                        onPressed: (){},
                        color: Colors.transparent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                            side: BorderSide(color: HexColor("#025393"))
                        ),
                        padding: EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: Text(
                                "Unggah Berkas",
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 15,
                                    color: HexColor("#025393"),
                                    fontWeight: FontWeight.w700
                                ),
                              ),
                              margin: EdgeInsets.only(right: 5),
                            ),
                            Container(
                              child: Icon(Icons.arrow_forward, color: HexColor("#025393")),
                            )
                          ],
                        ),
                      ),
                      margin: EdgeInsets.only(top: 20, left: 30, right: 30),
                    )
                  ],
                ),
                margin: EdgeInsets.only(top: 30),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Text(
                        "6. KTP Saksi II",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Container(
                      child: FlatButton(
                        onPressed: (){},
                        color: Colors.transparent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                            side: BorderSide(color: HexColor("#025393"))
                        ),
                        padding: EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: Text(
                                "Unggah Berkas",
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 15,
                                    color: HexColor("#025393"),
                                    fontWeight: FontWeight.w700
                                ),
                              ),
                              margin: EdgeInsets.only(right: 5),
                            ),
                            Container(
                              child: Icon(Icons.arrow_forward, color: HexColor("#025393")),
                            )
                          ],
                        ),
                      ),
                      margin: EdgeInsets.only(top: 20, left: 30, right: 30),
                    )
                  ],
                ),
                margin: EdgeInsets.only(top: 30),
              ),
              Container(
                alignment: Alignment.center,
                child: FlatButton(
                  onPressed: (){
                    Navigator.push(context, CupertinoPageRoute(builder: (context) => pengajuanSKKelahiranBerhasil()));
                  },
                  child: Text(
                    "Ajukan Berkas Persyaratan",
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
        ),
      ),
    );
  }
}