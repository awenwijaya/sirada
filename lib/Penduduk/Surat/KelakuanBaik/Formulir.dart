import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class formSKKelakuanBaik extends StatefulWidget {
  const formSKKelakuanBaik({Key key}) : super(key: key);

  @override
  _formSKKelakuanBaikState createState() => _formSKKelakuanBaikState();
}

class _formSKKelakuanBaikState extends State<formSKKelakuanBaik> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Formulir SK Kelakuan Baik", style: TextStyle(
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
