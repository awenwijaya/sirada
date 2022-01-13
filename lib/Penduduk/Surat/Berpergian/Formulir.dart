import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class formSKBerpergian extends StatefulWidget {
  const formSKBerpergian({Key key}) : super(key: key);

  @override
  _formSKBerpergianState createState() => _formSKBerpergianState();
}

class _formSKBerpergianState extends State<formSKBerpergian> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("SK Berpergian", style: TextStyle(
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
