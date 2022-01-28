import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class detailTempatUsaha extends StatefulWidget {
  static var gambarLokasi;
  static var namaUsaha;
  static var jenisUsaha;
  static var alamatUsaha;
  static var status;
  static var namaDusun;
  static var namaDesa;
  static var tanggalPengajuan;
  static var tanggalPengesahan;
  static var skTempatUsahaId;
  static var tempatUsahaId;
  static var suratMasyarakatId;
  const detailTempatUsaha({Key key}) : super(key: key);

  @override
  _detailTempatUsahaState createState() => _detailTempatUsahaState();
}

class _detailTempatUsahaState extends State<detailTempatUsaha> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Detail Tempat Usaha", style: TextStyle(
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
                  'images/store.png',
                  height: 100,
                  width: 100,
                ),
                margin: EdgeInsets.only(top: 20),
              ),
              Container(
                child: Text(
                  detailTempatUsaha.status.toString(),
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
                child: Text("Detail Tempat Usaha", style: TextStyle(
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
                      child: Text("Nama Tempat Usaha", style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14,
                        fontWeight: FontWeight.w700
                      )),
                      margin: EdgeInsets.only(top: 15),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(detailTempatUsaha.namaUsaha.toString(), style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14,
                      )),
                      margin: EdgeInsets.only(top: 5),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text("Jenis Usaha", style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 14,
                          fontWeight: FontWeight.w700
                      )),
                      margin: EdgeInsets.only(top: 15),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(detailTempatUsaha.namaUsaha.toString(), style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 14,
                      )),
                      margin: EdgeInsets.only(top: 5),
                    ),
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
                      child: Text(detailTempatUsaha.alamatUsaha.toString(), style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14,
                      )),
                      margin: EdgeInsets.only(top: 5),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text("Dusun", style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 14,
                          fontWeight: FontWeight.w700
                      )),
                      margin: EdgeInsets.only(top: 15),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(detailTempatUsaha.namaDusun.toString(), style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14,
                      )),
                      margin: EdgeInsets.only(top: 5),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text("Desa", style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 14,
                          fontWeight: FontWeight.w700
                      )),
                      margin: EdgeInsets.only(top: 15),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(detailTempatUsaha.namaDesa.toString(), style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14,
                      )),
                      margin: EdgeInsets.only(top: 5),
                    ),
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
                      child: Text("${detailTempatUsaha.tanggalPengajuan.day.toString()} - ${detailTempatUsaha.tanggalPengajuan.month.toString()} - ${detailTempatUsaha.tanggalPengajuan.year.toString()}", style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14,
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
                      margin: EdgeInsets.only(top: 15),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: detailTempatUsaha.tanggalPengesahan == null ? Text("Data belum disahkan oleh Kepala Desa", style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14
                      )) : Text("Tanggal Pengesahan", style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14,
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
                margin: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
              ),
              Container(
                child: FlatButton(
                  onPressed: (){
                    Navigator.of(context).push(CupertinoPageRoute(builder: (context) => gambarLokasiUsaha()));
                  },
                  child: Text("Gambar Lokasi Usaha", style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14,
                    color: HexColor("#025393"),
                    fontWeight: FontWeight.w700
                  )),
                  color: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                    side: BorderSide(color: HexColor("#025393"))
                  ),
                  padding: EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50),
                ),
                margin: EdgeInsets.only(top: 10),
              ),
              Container(
                child: FlatButton(
                  onPressed: (){},
                  child: Text("Batalkan Pengajuan SK", style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 14,
                      color: HexColor("#c33124"),
                      fontWeight: FontWeight.w700
                  )),
                  color: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                      side: BorderSide(color: HexColor("#c33124"))
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

class gambarLokasiUsaha extends StatefulWidget {
  const gambarLokasiUsaha({Key key}) : super(key: key);

  @override
  _gambarLokasiUsahaState createState() => _gambarLokasiUsahaState();
}

class _gambarLokasiUsahaState extends State<gambarLokasiUsaha> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(detailTempatUsaha.namaUsaha, style: TextStyle(
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
      ),
    );
  }
}
