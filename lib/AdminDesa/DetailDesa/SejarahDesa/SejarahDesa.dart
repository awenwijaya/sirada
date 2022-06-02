import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:surat/AdminDesa/DetailDesa/SejarahDesa/AddSejarahDesa.dart';
import 'package:surat/AdminDesa/DetailDesa/SejarahDesa/EditSejarahDesa.dart';
import 'package:surat/AdminDesa/DetailDesa/DetailDesa.dart';

class sejarahDesaAdmin extends StatefulWidget {
  static var sejarahDesa;
  const sejarahDesaAdmin({Key key}) : super(key: key);

  @override
  _sejarahDesaAdminState createState() => _sejarahDesaAdminState();
}

class _sejarahDesaAdminState extends State<sejarahDesaAdmin> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: HexColor("#025393"),
            onPressed: (){
              Navigator.of(context).pop();
            },
          ),
          title: Text("Sejarah Desa", style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w700,
            color: HexColor("#025393")
          )),
          actions: <Widget>[
            sejarahDesaAdmin.sejarahDesa == null ? IconButton(
              icon: Icon(Icons.add),
              onPressed: (){
                Navigator.push(context, CupertinoPageRoute(builder: (context) => addSejarahDesaAdmin()));
              },
              color: HexColor("#025393"),
            ) : IconButton(
              icon: Icon(Icons.edit),
              onPressed: (){
                Navigator.push(context, CupertinoPageRoute(builder: (context) => editSejarahDesaAdmin()));
              },
              color: HexColor("#025393"),
            )
          ],
        ),
        body: sejarahDesaAdmin.sejarahDesa == null ? Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Icon(
                    CupertinoIcons.news_solid,
                    size: 50,
                    color: Colors.black26,
                  ),
                ),
                Container(
                  child: Text("Data Sejarah Desa Tidak Ditemukan", style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black26
                  ), textAlign: TextAlign.center),
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.symmetric(horizontal: 30),
                ),
                Container(
                  child: Text("Data sejarah desa tidak ditemukan. Anda bisa menambahkannya dengan menekan tombol +", style: TextStyle(
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
        ) : SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: detailDesaAdmin.logoDesa == null ? AssetImage('images/noimage.png') : NetworkImage('http://storage.siradaskripsi.my.id/img/logo-desa/${detailDesaAdmin.logoDesa}')
                      )
                  ),
                ),
                margin: EdgeInsets.only(top: 30),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text("Sejarah Desa", style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14,
                  fontWeight: FontWeight.w700
                )),
                margin: EdgeInsets.only(top: 15, left: 25),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text(sejarahDesaAdmin.sejarahDesa.toString(), style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14
                )),
                margin: EdgeInsets.only(top: 10, bottom: 10),
                padding: EdgeInsets.symmetric(horizontal: 30),
              )
            ],
          ),
        )
      ),
    );
  }
}