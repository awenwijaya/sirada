import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:surat/AdminDesa/ManajemenSurat/SuratMasuk/DetailSuratMasuk.dart';
import 'package:surat/AdminDesa/ManajemenSurat/SuratMasuk/EditSuratMasuk.dart';
import 'package:surat/AdminDesa/ManajemenSurat/SuratMasuk/TambahSuratMasuk.dart';
import 'package:surat/LoginAndRegistration/LoginPage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_shimmer/flutter_shimmer.dart';

class suratMasukAdmin extends StatefulWidget {
  const suratMasukAdmin({Key key}) : super(key: key);

  @override
  State<suratMasukAdmin> createState() => _suratMasukAdminState();
}

class _suratMasukAdminState extends State<suratMasukAdmin> {
  var apiURLShowListSuratMasuk = "http://192.168.239.149:8000/api/data/admin/surat/masuk/${loginPage.desaId}";
  var apiURLDeleteSuratMasuk = "http://192.168.239.149:8000/api/admin/surat/masuk/delete";
  var idSuratMasuk = [];
  var perihalSuratMasuk = [];
  var asalSuratMasuk = [];
  var selectedIdSuratMasuk;
  bool LoadingSuratMasuk = true;
  bool availableSuratMasuk = false;

  Future refreshListSuratMasuk() async {
    var response = await http.get(Uri.parse(apiURLShowListSuratMasuk));
    if(response.statusCode == 200) {
      var data = json.decode(response.body);
      this.idSuratMasuk = [];
      this.perihalSuratMasuk = [];
      this.asalSuratMasuk = [];
      setState(() {
        LoadingSuratMasuk = false;
        availableSuratMasuk = true;
        for(var i = 0; i < data.length; i++) {
          this.idSuratMasuk.add(data[i]['surat_masuk_id']);
          this.perihalSuratMasuk.add(data[i]['perihal']);
          this.asalSuratMasuk.add(data[i]['asal_surat']);
        }
      });
    }else{
      setState(() {
        LoadingSuratMasuk = false;
        availableSuratMasuk = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    refreshListSuratMasuk();
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
          title: Text("Surat Masuk", style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w700,
            color: HexColor("#025393")
          )),
        ),
        body: LoadingSuratMasuk ? ListTileShimmer() : availableSuratMasuk ? RefreshIndicator(
          onRefresh: refreshListSuratMasuk,
          child: ListView.builder(
            itemCount: idSuratMasuk.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: (){
                  setState(() {
                    detailSuratMasukAdmin.idSurat = idSuratMasuk[index];
                  });
                  Navigator.push(context, CupertinoPageRoute(builder: (context) => detailSuratMasukAdmin()));
                },
                child: Container(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Image.asset(
                                'images/email.png',
                                height: 40,
                                width: 40,
                              ),
                            ),
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.55,
                                      child: Text(perihalSuratMasuk[index], style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: HexColor("#025393")
                                      ), maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Text(asalSuratMasuk[index], style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 14
                                    )),
                                  )
                                ],
                              ),
                              margin: EdgeInsets.only(left: 15),
                            )
                          ],
                        ),
                      ),
                      Container(
                          alignment: Alignment.centerRight,
                          child: PopupMenuButton<int>(
                              onSelected: (item) {
                                setState(() {
                                  selectedIdSuratMasuk = idSuratMasuk[index];
                                });
                                onSelected(context, item);
                              },
                              itemBuilder: (context) => [
                                PopupMenuItem<int>(
                                    value: 0,
                                    child: Row(
                                        children: <Widget>[
                                          Container(
                                              child: Icon(
                                                  Icons.edit,
                                                  color: HexColor("#025393")
                                              )
                                          ),
                                          Container(
                                              child: Text("Edit", style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontSize: 14
                                              )),
                                              margin: EdgeInsets.only(left: 10)
                                          )
                                        ]
                                    )
                                ),
                                PopupMenuItem<int>(
                                    value: 1,
                                    child: Row(
                                        children: <Widget>[
                                          Container(
                                              child: Icon(
                                                  Icons.delete,
                                                  color: HexColor("#025393")
                                              )
                                          ),
                                          Container(
                                              child: Text("Hapus", style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontSize: 14
                                              )),
                                              margin: EdgeInsets.only(left: 10)
                                          )
                                        ]
                                    )
                                )
                              ]
                          )
                      )
                    ]
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
          ),
        ) : Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Icon(
                    CupertinoIcons.mail_solid,
                    size: 50,
                    color: Colors.black26,
                  ),
                ),
                Container(
                  child: Text("Tidak ada Data Surat Masuk", style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black26
                  ), textAlign: TextAlign.center),
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.symmetric(horizontal: 30),
                ),
                Container(
                  child: Text("Tidak ada data surat masuk. Anda bisa menambahkannya dengan cara menekan tombol Tambah Data Surat dan isi data surat pada form yang telah disediakan", style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 14,
                      color: Colors.black26
                  ), textAlign: TextAlign.center),
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  margin: EdgeInsets.only(top: 10),
                )
              ],
            ),
            margin: EdgeInsets.only(top: 80)
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.push(context, CupertinoPageRoute(builder: (context) => tambahSuratMasukAdmin())).then((value) {
              refreshListSuratMasuk();
            });
          },
          child: Icon(Icons.add),
          backgroundColor: HexColor("#025393")
        )
      )
    );
  }

  void onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        setState(() {
          editSuratMasukAdmin.idSuratMasuk = selectedIdSuratMasuk;
        });
        Navigator.push(context, CupertinoPageRoute(builder: (context) => editSuratMasukAdmin())).then((value) {
          refreshListSuratMasuk();
        });
        break;

      case 1:
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
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                                child: Image.asset(
                                    'images/question.png',
                                    height: 50,
                                    width: 50
                                )
                            ),
                            Container(
                                child: Text("Hapus Surat Masuk", style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: HexColor("#025393")
                                ), textAlign: TextAlign.center),
                                margin: EdgeInsets.only(top: 10)
                            ),
                            Container(
                                child: Text("Apakah Anda yakin ingin menghapus surat ini?", style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 14
                                ), textAlign: TextAlign.center),
                                margin: EdgeInsets.only(top: 10)
                            )
                          ]
                      )
                  ),
                  actions: <Widget>[
                    TextButton(
                        onPressed: (){
                          var body = jsonEncode({
                            "surat_masuk_id" : selectedIdSuratMasuk
                          });
                          http.post(Uri.parse(apiURLDeleteSuratMasuk),
                              headers: {"Content-Type" : "application/json"},
                              body: body
                          ).then((http.Response response) {
                            var responseValue = response.statusCode;
                            if(responseValue == 200) {
                              refreshListSuratMasuk();
                              Fluttertoast.showToast(
                                  msg: "Surat berhasil dihapus",
                                  fontSize: 14,
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER
                              );
                              Navigator.of(context).pop();
                            }
                          });
                        },
                        child: Text("Ya", style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w700,
                            color: HexColor("#025393")
                        ))
                    ),
                    TextButton(
                        onPressed: (){Navigator.of(context).pop();},
                        child: Text("Tidak", style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w700,
                            color: HexColor("#025393")
                        ))
                    )
                  ]
              );
            }
        );
        break;
    }
  }
}