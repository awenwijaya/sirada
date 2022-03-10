import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:surat/AdminDesa/Dashboard.dart';
import 'package:surat/AdminDesa/DetailDesa/SejarahDesa/SejarahDesa.dart';
import 'package:surat/shared/LoadingAnimation/loading.dart';
import 'package:surat/AdminDesa/DetailDesa/DetailDesa.dart';
import 'package:http/http.dart' as http;
import 'package:surat/LoginAndRegistration/LoginPage.dart';

class editSejarahDesaAdmin extends StatefulWidget {
  const editSejarahDesaAdmin({Key key}) : super(key: key);

  @override
  _editSejarahDesaAdminState createState() => _editSejarahDesaAdminState();
}

class _editSejarahDesaAdminState extends State<editSejarahDesaAdmin> {
  TextEditingController controllerSejarahDesa;
  var apiURLSejarahDesa = "http://192.168.18.10:8000/api/admin/desa/up_sejarah_desa";
  bool Loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controllerSejarahDesa = new TextEditingController(text: sejarahDesaAdmin.sejarahDesa);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Loading ? loading() : Scaffold(
        appBar: AppBar(
          title: Text("Edit Sejarah Desa", style: TextStyle(
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
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: detailDesaAdmin.logoDesa == null ? AssetImage('images/noimage.png') : NetworkImage('http://192.168.18.10/siraja-api-skripsi/${detailDesaAdmin.logoDesa}')
                        )
                      ),
                      margin: EdgeInsets.only(top: 20),
                    ),
                    Container(
                      child: Text("Sejarah Desa", style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w700,
                        color: HexColor("#025393"),
                        fontSize: 16
                      )),
                      margin: EdgeInsets.only(top: 15),
                    )
                  ],
                ),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                  child: TextField(
                    controller: controllerSejarahDesa,
                    maxLines: 20,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: HexColor("#025393"))
                      ),
                      hintText: "Sejarah Desa"
                    ),
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 14
                    ),
                  ),
                ),
                margin: EdgeInsets.only(top: 15),
              ),
              Container(
                child: FlatButton(
                  onPressed: (){
                    if(controllerSejarahDesa.text == "") {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(40.0))
                            ),
                            content: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Container(
                                    child: Image.asset(
                                      'images/warning.png',
                                      height: 50,
                                      width: 50,
                                    ),
                                  ),
                                  Container(
                                    child: Text("Data sejarah desa belum diisi", style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: HexColor("#025393")
                                    ), textAlign: TextAlign.center),
                                    margin: EdgeInsets.only(top: 10),
                                  ),
                                  Container(
                                    child: Text("Data sejarah desa masih kosong. Silahkan isi data sejarah desa terlebih dahulu sebelum melanjutkan", style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 14
                                    ), textAlign: TextAlign.center),
                                  )
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: Text("OK", style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w700,
                                  color: HexColor("#025393")
                                )),
                                onPressed: (){Navigator.of(context).pop();},
                              )
                            ],
                          );
                        }
                      );
                    }else{
                      setState(() {
                        Loading = true;
                      });
                      var body = jsonEncode({
                        "sejarah_desa" : controllerSejarahDesa.text,
                        "desa_id" : loginPage.desaId
                      });
                      http.post(Uri.parse(apiURLSejarahDesa),
                        headers: {"Content-Type" : "application/json"},
                        body: body
                      ).then((http.Response response) {
                        var responseValue = response.statusCode;
                        if(responseValue == 200) {
                          setState(() {
                            Loading = false;
                          });
                          Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) => dashboardAdminDesa()), (route) => false);
                        }
                      });
                    }
                  },
                  child: Text("Simpan Sejarah Desa", style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.white
                  )),
                  color: HexColor("#025393"),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)
                  ),
                  padding: EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50),
                ),
                margin: EdgeInsets.only(top: 20, bottom: 30),
              )
            ],
          ),
        ),
      ),
    );
  }
}