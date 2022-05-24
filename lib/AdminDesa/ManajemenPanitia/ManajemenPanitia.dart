import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class manajemenPanitiaDesaAdatAdmin extends StatefulWidget {
  const manajemenPanitiaDesaAdatAdmin({Key key}) : super(key: key);

  @override
  State<manajemenPanitiaDesaAdatAdmin> createState() => _manajemenPanitiaDesaAdatAdminState();
}

class _manajemenPanitiaDesaAdatAdminState extends State<manajemenPanitiaDesaAdatAdmin> {
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
          title: Text("Panitia Desa Adat", style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w700,
            color: HexColor("#025393")
          )),
        ),
      ),
    );
  }
}
