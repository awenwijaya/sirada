import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class formSPPenghasilanOrangTua extends StatefulWidget {
  const formSPPenghasilanOrangTua({Key key}) : super(key: key);

  @override
  _formSPPenghasilanOrangTuaState createState() => _formSPPenghasilanOrangTuaState();
}

class _formSPPenghasilanOrangTuaState extends State<formSPPenghasilanOrangTua> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Formulir SP Penghasilan Orang Tua", style: TextStyle(
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
