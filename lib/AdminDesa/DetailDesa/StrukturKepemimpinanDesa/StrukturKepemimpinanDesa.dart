import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:surat/AdminDesa/DetailDesa/StrukturKepemimpinanDesa/AddStrukturKepemimpinanDesa.dart';
import 'package:surat/AdminDesa/DetailDesa/StrukturKepemimpinanDesa/EditStrukturKepemimpinanDesa.dart';

class strukturKepemimpinanDesaAdmin extends StatefulWidget {
  static var strukturKepemimpinan;
  const strukturKepemimpinanDesaAdmin({Key key}) : super(key: key);

  @override
  _strukturKepemimpinanDesaAdminState createState() => _strukturKepemimpinanDesaAdminState();
}

class _strukturKepemimpinanDesaAdminState extends State<strukturKepemimpinanDesaAdmin> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Struktur Kepemimpinan Desa", style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w700,
            color: HexColor("#025393")
          )),
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: HexColor("#025393"),
            onPressed: (){
              Navigator.of(context).pop();
            },
          ),
          actions: <Widget>[
            strukturKepemimpinanDesaAdmin.strukturKepemimpinan == null ? IconButton(
              icon: Icon(Icons.add),
              onPressed: (){
                Navigator.push(context, CupertinoPageRoute(builder: (context) => addStrukturKepemimpinanDesa()));
              },
              color: HexColor("#025393"),
            ) : IconButton(
              icon: Icon(Icons.edit),
              onPressed: (){
                Navigator.push(context, CupertinoPageRoute(builder: (context) => editStrukturKepemimpinanDesaAdmin()));
              },
              color: HexColor("#025393"),
            )
          ],
        ),
        body: strukturKepemimpinanDesaAdmin.strukturKepemimpinan == null ? Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Icon(
                    CupertinoIcons.person_2_alt,
                    size: 50,
                    color: Colors.black26,
                  ),
                ),
                Container(
                  child: Text("Data Struktur Kepemimpinan Desa Tidak Ditemukan", style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black26
                  ), textAlign: TextAlign.center),
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.symmetric(horizontal: 30),
                ),
                Container(
                  child: Text("Data struktur kepemimpinan desa tidak ditemukan. Anda bisa menambahkannya dengan menekan tombol +", style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 14,
                      color: Colors.black26
                  ), textAlign: TextAlign.center,),
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  margin: EdgeInsets.only(top: 10),
                )
              ],
            ),
          ),
          alignment: Alignment(0.0, 0.0),
        ) : Container(
          child: Center(
            child: InteractiveViewer(
              clipBehavior: Clip.none,
              child: ClipRRect(
                child: Image.network(
                  'https://storage.siradaskripsi.my.id/img/struktur-desa/${strukturKepemimpinanDesaAdmin.strukturKepemimpinan}',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
