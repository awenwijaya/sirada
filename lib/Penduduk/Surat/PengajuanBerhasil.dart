import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:surat/Penduduk/Dashboard.dart';

class pengajuanSKKelahiranBerhasil extends StatelessWidget {
  const pengajuanSKKelahiranBerhasil({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: Image.asset(
                  'images/done.png',
                  height: 50,
                  width: 50,
                ),
                margin: EdgeInsets.only(top: 100),
              ),
              Container(
                child: Text(
                  "Pengajuan Berhasil",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: HexColor("#025393")
                  ),
                ),
                margin: EdgeInsets.only(top: 20),
              ),
              Container(
                child: Text(
                  "Proses pengajuan SK telah selesai dan berada pada proses verifikasi berkas. \n\nSilahkan cek bot telegram kami untuk mendapatkan notifikasi mengenai status surat atau dapat dilihat pada halaman Dashboard",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14
                  ),
                  textAlign: TextAlign.center,
                ),
                padding: EdgeInsets.symmetric(horizontal: 20),
                margin: EdgeInsets.only(top: 30),
              ),
              Container(
                child: FlatButton(
                  onPressed: (){
                    Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(builder: (context) => dashboardPenduduk()), (route) => false);
                  },
                  color: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                    side: BorderSide(color: HexColor("#025393"))
                  ),
                  padding: EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50),
                  child: Container(
                    child: Text(
                      "Kembali ke Halaman Utama",
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 15,
                          color: HexColor("#025393"),
                          fontWeight: FontWeight.w700
                      ),
                    ),
                  ),
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
