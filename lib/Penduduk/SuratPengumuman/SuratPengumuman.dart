import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class suratPengumumanKrama extends StatefulWidget {
  const suratPengumumanKrama({Key key}) : super(key: key);

  @override
  _suratPengumumanKramaState createState() => _suratPengumumanKramaState();
}

class _suratPengumumanKramaState extends State<suratPengumumanKrama> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Pengumuman", style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w700,
            color: Colors.white
          )),
          backgroundColor: HexColor("#025393"),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: (){Navigator.of(context).pop();},
          ),
        ),
        body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Icon(
                  CupertinoIcons.mail_solid,
                  size: 50,
                  color: Colors.black26
                )
              ),
              Container(
                child: Text("Tidak ada Pengumuman", style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black26
                ), textAlign: TextAlign.center),
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.symmetric(horizontal: 30)
              ),
            ],
          )
        )
      )
    );
  }
}