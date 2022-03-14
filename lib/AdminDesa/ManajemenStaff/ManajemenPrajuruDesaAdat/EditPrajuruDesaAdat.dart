import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class editPrajuruDesaAdatAdmin extends StatefulWidget {
  const editPrajuruDesaAdatAdmin({Key key}) : super(key: key);

  @override
  State<editPrajuruDesaAdatAdmin> createState() => _editPrajuruDesaAdatAdminState();
}

class _editPrajuruDesaAdatAdminState extends State<editPrajuruDesaAdatAdmin> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Edit Pegawai Desa Adat", style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w700,
            color: HexColor("#025393")
          )),
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: HexColor("#025393"),
            onPressed: (){Navigator.of(context).pop(true);},
          ),
        )
      )
    );
  }
}
