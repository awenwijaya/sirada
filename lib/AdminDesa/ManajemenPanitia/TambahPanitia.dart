import 'dart:convert';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class tambahPanitiaKegiatanAdmin extends StatefulWidget {
  const tambahPanitiaKegiatanAdmin({Key key}) : super(key: key);

  @override
  State<tambahPanitiaKegiatanAdmin> createState() => _tambahPanitiaKegiatanAdminState();
}

class _tambahPanitiaKegiatanAdminState extends State<tambahPanitiaKegiatanAdmin> {
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
          title: Text("Tambah Panitia Kegiatan", style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w700,
            color: HexColor("#025393")
          )),
        ),
      ),
    );
  }
}
