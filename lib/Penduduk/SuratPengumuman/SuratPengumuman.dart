import 'dart:convert';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:surat/LoginAndRegistration/LoginPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:surat/Penduduk/SuratPengumuman/DetailSurat.dart';
import 'package:surat/Penduduk/SuratPengumuman/DetailSuratPanitia.dart';

class suratPengumumanKrama extends StatefulWidget {
  const suratPengumumanKrama({Key key}) : super(key: key);

  @override
  _suratPengumumanKramaState createState() => _suratPengumumanKramaState();
}

class _suratPengumumanKramaState extends State<suratPengumumanKrama> {
  List pengumuman = [];
  var apiURLShowAllPengumuman = "https://siradaskripsi.my.id/api/krama/view/surat/all/${loginPage.desaId}";
  bool availablePengumuman = false;
  bool LoadingPengumuman = true;
  bool isSearch = false;
  final controllerSearch = TextEditingController();
  var apiURLSearch = "https://siradaskripsi.my.id/api/krama/surat/${loginPage.desaId}/search";

  Future getAllPengumuman() async {
    http.get(Uri.parse(apiURLShowAllPengumuman),
      headers: {"Content-Type" : "application/json"},
    ).then((http.Response response) {
      var responseValue = response.statusCode;
      if(responseValue == 200) {
        var data = json.decode(response.body);
        setState(() {
          pengumuman = data;
          LoadingPengumuman = false;
          availablePengumuman = true;
        });
      }else {
        setState(() {
          LoadingPengumuman = false;
          availablePengumuman = false;
        });
      }
    });
  }

  Future refreshListSearch() async {
    setState(() {
      LoadingPengumuman = true;
      isSearch = true;
      this.pengumuman = [];
    });
    var body = jsonEncode({
      "search_query" : controllerSearch.text,
      "desa_adat_id" : loginPage.desaId
    });
    http.post(Uri.parse(apiURLSearch),
      headers: {"Content-Type" : "application/json"},
      body: body
    ).then((http.Response response) async {
      var statusCode = response.statusCode;
      if(statusCode == 200) {
        var data = json.decode(response.body);
        setState(() {
          pengumuman = data;
          LoadingPengumuman = false;
          availablePengumuman = true;
        });
      }else {
        setState(() {
          LoadingPengumuman = false;
          availablePengumuman = false;
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllPengumuman();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Pengumuman", style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w700,
            color: Colors.white
          )),
          backgroundColor: HexColor("#025393"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: (){Navigator.of(context).pop();},
          ),
        ),
        body: LoadingPengumuman ? ListTileShimmer() : availablePengumuman ? Container(
          child: Column(
            children: <Widget>[
              Container(
                child: TextField(
                  controller: controllerSearch,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      borderSide: BorderSide(color: HexColor("025393"))
                    ),
                    hintText: "Cari pengumuman...",
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: (){
                        if(controllerSearch.text != "") {
                          setState(() {
                            isSearch = true;
                          });
                          refreshListSearch();
                        }
                      },
                    )
                  ),
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14
                  ),
                ),
                margin: EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 20),
              ),
              Container(
                  child: Column(
                    children: [
                      if(isSearch == true) Container(
                        child: FlatButton(
                          onPressed: (){
                            setState(() {
                              controllerSearch.text = "";
                              isSearch = false;
                              LoadingPengumuman = true;
                              getAllPengumuman();
                            });
                          },
                          child: Text("Reset Pencarian", style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.white
                          )),
                          color: HexColor("025393"),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                              side: BorderSide(color: HexColor("025393"), width: 2)
                          ),
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 5),
                      )
                    ],
                  )
              ),
              Expanded(
                flex: 1,
                child: RefreshIndicator(
                  onRefresh: isSearch ? refreshListSearch : getAllPengumuman,
                  child: ListView.builder(
                    itemCount: pengumuman.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: (){
                          if(pengumuman[index]['tim_kegiatan'] == null) {
                            setState(() {
                              detailSuratPrajuruKrama.suratKeluarId = pengumuman[index]['surat_keluar_id'];
                            });
                            Navigator.push(context, CupertinoPageRoute(builder: (context) => detailSuratPrajuruKrama()));
                          }else {
                            setState(() {
                              detailSuratKeluarPanitiaKrama.suratKeluarId = pengumuman[index]['surat_keluar_id'];
                            });
                            Navigator.push(context, CupertinoPageRoute(builder: (context) => detailSuratKeluarPanitiaKrama()));
                          }
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
                                        child: Text(
                                          pengumuman[index]['parindikan'].toString(),
                                          style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: HexColor("025393")
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Text(pengumuman[index]['nomor_surat'].toString(), style: TextStyle(
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
              )
            ],
          ),
        ) : Container(
            alignment: Alignment.center,
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
                    child: Text("Tidak ada Pengumuman", style: TextStyle(
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
        )
      )
    );
  }
}