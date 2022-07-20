import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:surat/LoginAndRegistration/LoginPage.dart';
import 'dart:convert';

import 'package:surat/Penduduk/SuratPengumuman/DetailSurat.dart';

class suratDiterimaPrajuruBanjar extends StatefulWidget {
  static var prajuruId;
  const suratDiterimaPrajuruBanjar({Key key}) : super(key: key);

  @override
  State<suratDiterimaPrajuruBanjar> createState() => _suratDiterimaPrajuruBanjarState();
}

class _suratDiterimaPrajuruBanjarState extends State<suratDiterimaPrajuruBanjar> {
  var apiURLGetSuratDiterima = "https://siradaskripsi.my.id/api/surat/tetujon/prajuru-banjar/${suratDiterimaPrajuruBanjar.prajuruId}";
  List suratDiterima = List();
  bool availableSurat = false;
  bool LoadingSurat = true;

  Future refreshListSuratDiterima() async {
    Uri uri = Uri.parse(apiURLGetSuratDiterima);
    final response = await http.get(uri);
    if(response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        suratDiterima = jsonData;
        LoadingSurat = false;
        availableSurat = true;
      });
    }else {
      setState(() {
        LoadingSurat = false;
        availableSurat = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    refreshListSuratDiterima();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: HexColor("025393"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: (){
              Navigator.of(context).pop();
            },
          ),
          title: Text("Surat Diterima", style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w700,
            color: Colors.white
          )),
        ),
        body: Column(
          children: <Widget>[
            Container(),
            Container(
              child: LoadingSurat ? ListTileShimmer() : availableSurat ? Expanded(
                flex: 1,
                child: RefreshIndicator(
                  onRefresh: refreshListSuratDiterima,
                  child: ListView.builder(
                    itemCount: suratDiterima.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: (){
                          setState(() {
                            detailSuratPrajuruKrama.isTetujon = true;
                            detailSuratPrajuruKrama.suratKeluarId = suratDiterima[index]['surat_keluar_id'];
                          });
                          Navigator.push(context, CupertinoPageRoute(builder: (context) => detailSuratPrajuruKrama()));
                        },
                        child: Container(
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
                                        child: Text(suratDiterima[index]['parindikan'].toString(), style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: HexColor("025393")
                                        ), maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Text(suratDiterima[index]['nomor_surat'].toString(), style: TextStyle(
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
                ),
              ) : Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          child: Icon(
                              CupertinoIcons.mail_solid,
                              size: 50,
                              color: Colors.black26
                          )
                      ),
                      Container(
                          child: Text("Tidak ada Data Surat", style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black26
                          ), textAlign: TextAlign.center),
                          margin: EdgeInsets.only(top: 10),
                          padding: EdgeInsets.symmetric(horizontal: 30)
                      ),
                    ],
                  )
              ),
            )
          ],
        ),
      ),
    );
  }
}
