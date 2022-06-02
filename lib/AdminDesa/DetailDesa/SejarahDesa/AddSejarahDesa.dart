import 'dart:convert';
import 'package:surat/AdminDesa/Dashboard.dart';
import 'package:surat/LoginAndRegistration/LoginPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:surat/AdminDesa/DetailDesa/DetailDesa.dart';
import 'package:http/http.dart' as http;
import 'package:surat/shared/LoadingAnimation/loading.dart';
import 'package:fluttertoast/fluttertoast.dart';

class addSejarahDesaAdmin extends StatefulWidget {
  const addSejarahDesaAdmin({Key key}) : super(key: key);

  @override
  _addSejarahDesaAdminState createState() => _addSejarahDesaAdminState();
}

class _addSejarahDesaAdminState extends State<addSejarahDesaAdmin> {
  final controllerSejarahDesa = TextEditingController();
  var apiURLSejarahDesa = "http://siradaskripsi.my.id/api/admin/desa/up_sejarah_desa";
  bool Loading = false;
  FToast ftoast;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ftoast = FToast();
    ftoast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Loading ? loading() : Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: HexColor("#025393"),
            onPressed: (){
              Navigator.of(context).pop();
            },
          ),
          title: Text("Tambah Sejarah Desa", style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w700,
            color: HexColor("#025393")
          )),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
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
                                image: detailDesaAdmin.logoDesa == null ? AssetImage('images/noimage.png') : NetworkImage('http://storage.siradaskripsi.my.id/img/logo-desa/${detailDesaAdmin.logoDesa}')
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
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if(value.isEmpty) {
                          return "Data tidak boleh kosong";
                        }else {
                          return null;
                        }
                      },
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
                      if(formKey.currentState.validate()) {
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
                      }else {
                        ftoast.showToast(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.redAccent
                            ),
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.close),
                                Container(
                                  margin: EdgeInsets.only(left: 15),
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.65,
                                    child: Text("Masih terdapat data yang kosong. Silahkan diperiksa kembali", style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white
                                    )),
                                  ),
                                )
                              ],
                            ),
                          ),
                          toastDuration: Duration(seconds: 3)
                        );
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
            )
          ),
        ),
      ),
    );
  }
}