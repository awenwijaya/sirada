import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class formSKDatangWNI extends StatefulWidget {
  const formSKDatangWNI({Key key}) : super(key: key);

  @override
  _formSKDatangWNIState createState() => _formSKDatangWNIState();
}

class _formSKDatangWNIState extends State<formSKDatangWNI> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("SK Datang WNI", style: TextStyle(
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
