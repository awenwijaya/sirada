import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;

class dashboardPenduduk extends StatefulWidget {
  const dashboardPenduduk({Key key}) : super(key: key);

  @override
  State<dashboardPenduduk> createState() => _dashboardPendudukState();
}

class _dashboardPendudukState extends State<dashboardPenduduk> {
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
            }
          ),
          title: Text("SiRada", style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w700,
            color: Colors.white,
            fontSize: 14
          )),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.person_outline_rounded),
              color: HexColor("#025393"),
              onPressed: (){}
            ),
            IconButton(
              icon: Icon(Icons.logout),
              color: HexColor("#025393"),
              onPressed: (){},
            )
          ],
        )
      )
    );
  }
}