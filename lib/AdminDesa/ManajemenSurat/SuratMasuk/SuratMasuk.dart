import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class suratMasukAdmin extends StatefulWidget {
  const suratMasukAdmin({Key key}) : super(key: key);

  @override
  State<suratMasukAdmin> createState() => _suratMasukAdminState();
}

class _suratMasukAdminState extends State<suratMasukAdmin> {
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
          title: Text("Surat Masuk", style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w700,
            color: HexColor("#025393")
          )),
        )
      )
    );
  }
}
