import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class formSKTempatUsaha extends StatefulWidget {
  const formSKTempatUsaha({Key key}) : super(key: key);

  @override
  _formSKTempatUsahaState createState() => _formSKTempatUsahaState();
}

class _formSKTempatUsahaState extends State<formSKTempatUsaha> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Formulir SK Tempat Usaha", style: TextStyle(
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
