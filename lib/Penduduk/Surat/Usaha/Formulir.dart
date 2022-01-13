import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class formSKUsaha extends StatefulWidget {
  const formSKUsaha({Key key}) : super(key: key);

  @override
  _formSKUsahaState createState() => _formSKUsahaState();
}

class _formSKUsahaState extends State<formSKUsaha> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("SK Usaha", style: TextStyle(
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
