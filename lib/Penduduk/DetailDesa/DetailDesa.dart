import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;

class detailDesaPenduduk extends StatefulWidget {
  const detailDesaPenduduk({Key key}) : super(key: key);

  @override
  _detailDesaPendudukState createState() => _detailDesaPendudukState();
}

class _detailDesaPendudukState extends State<detailDesaPenduduk> {
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
          title: Text("Detail Desa", style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w700,
            color: HexColor("#025393")
          )),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage('https://googleflutter.com/sample_image.jpg'),
                          fit: BoxFit.fill
                        )
                      ),
                    ),
                    Container(
                      child: Text("Ubung Kaja", style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 16,
                        color: HexColor("#025393"),
                        fontWeight: FontWeight.w700
                      )),
                      margin: EdgeInsets.only(top: 15),
                    )
                  ],
                ),
                margin: EdgeInsets.only(top: 20),
              )
            ],
          ),
        ),
      ),
    );
  }
}