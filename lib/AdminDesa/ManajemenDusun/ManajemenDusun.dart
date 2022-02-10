import 'dart:convert';
import 'package:surat/AdminDesa/Dashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:surat/LoginAndRegistration/LoginPage.dart';
import 'package:surat/shared/API/Models/Dusun.dart';

class manajemenDusunAdmin extends StatefulWidget {
  const manajemenDusunAdmin({Key key}) : super(key: key);

  @override
  _manajemenDusunAdminState createState() => _manajemenDusunAdminState();
}

class _manajemenDusunAdminState extends State<manajemenDusunAdmin> {
  var apiURLGetDusun = "http://192.168.18.10:8000/api/dusun";

  Future<Dusun> dataDusun() async {
    var body = jsonEncode({
      "desa_id" : loginPage.desaId
    });
    return http.post(Uri.parse(apiURLGetDusun),
      headers: {"Content-Type" : "application/json"},
      body: body
    ).then((http.Response response) {
      if(response.statusCode == 200) {
        final body = response.body;
        final dusunData = dusunFromJson(body);
        return dusunData;
      }else{
        final body = response.body;
        final error = dusunFromJson(body);
        return error;
      }
    });
  }

  Widget listDusun() {
    return FutureBuilder<Dusun>(
      future: dataDusun(),
      builder: (context, snapshot) {
        final data = snapshot.data;
        if(snapshot.hasData) {
          final dusunData = data.data;
          return ListView.builder(
            itemCount: dusunData.length,
            itemBuilder: (context, index) {
              final dusun = dusunData[index];
              return GestureDetector(
                onTap: (){},
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: Image.asset(
                          'images/location.png',
                          height: 40,
                          width: 40,
                        ),
                      ),
                      Container(
                        child: Text(dusun.namaDusun.toString(), style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: Colors.black
                        )),
                        margin: EdgeInsets.only(left: 20),
                      )
                    ],
                  ),
                  margin: EdgeInsets.only(top: 10, left: 20, right: 20),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0,3)
                      )
                    ]
                  ),
                ),
              );
            },
          );
        }else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

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
          title: Text("Manajemen Dusun", style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w700,
            color: HexColor("#025393")
          )),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: (){},
              color: HexColor("#025393"),
            )
          ],
        ),
        body: listDusun()
      ),
    );
  }
}