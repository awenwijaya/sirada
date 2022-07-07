import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:surat/AdminDesa/ManajemenSurat/SuratKeluar/SuratKeluarNonPanitia/DetailSurat.dart';
import 'package:surat/AdminDesa/ManajemenSurat/SuratKeluar/SuratKeluarNonPanitia/DetailSuratPanitia.dart';
import 'package:surat/LoginAndRegistration/LoginPage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_shimmer/flutter_shimmer.dart';

class permintaanVerifikasiSuratKeluarAdmin extends StatefulWidget {
  const permintaanVerifikasiSuratKeluarAdmin({Key key}) : super(key: key);

  @override
  State<permintaanVerifikasiSuratKeluarAdmin> createState() => _permintaanVerifikasiSuratKeluarAdminState();
}

class _permintaanVerifikasiSuratKeluarAdminState extends State<permintaanVerifikasiSuratKeluarAdmin> {
  var apiURLShowListVerifikasiSurat = "https://siradaskripsi.my.id/api/verifikasi/surat/prajuru/list/${loginPage.prajuruId}";
  List surat = List();
  bool availableSurat = false;
  bool LoadingSurat = true;

  Future getListVerifikasiSurat() async {
    http.get(Uri.parse(apiURLShowListVerifikasiSurat),
      headers: {"Content-Type" : "application/json"}
    ).then((http.Response response) {
      print(response.statusCode.toString());
      if(response.statusCode == 200) {
        var data = json.decode(response.body);
        setState(() {
          LoadingSurat = false;
          availableSurat = true;
          surat = data;
        });
      }else {
        LoadingSurat = false;
        availableSurat = false;
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getListVerifikasiSurat();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: HexColor("025393"),
            onPressed: (){
              Navigator.of(context).pop();
            },
          ),
          title: Text("Permintaan Verifikasi Surat Keluar", style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w700,
            color: HexColor("025393")
          )),
        ),
        body: Column(
          children: <Widget>[
            Container(
              child: Container(),
            ),
            Container(
              child: LoadingSurat ? ListTileShimmer() : availableSurat ? Expanded(
                flex: 1,
                child: RefreshIndicator(
                  onRefresh: getListVerifikasiSurat,
                  child: ListView.builder(
                    itemCount: surat.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: (){
                          if(surat[index]['tim_kegiatan'] == null) {
                            setState(() {
                              detailSuratKeluarPanitiaAdmin.suratKeluarId = surat[index]['surat_keluar_id'];
                            });
                            Navigator.push(context, CupertinoPageRoute(builder: (context) => detailSuratKeluarPanitiaAdmin()));
                          }else {
                            setState(() {
                              detailSuratKeluarNonPanitia.suratKeluarId = surat[index]['surat_keluar_id'];
                            });
                            Navigator.push(context, CupertinoPageRoute(builder: (context) => detailSuratKeluarNonPanitia()));
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
                                      child: Text(surat[index]['status'], style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white
                                      )),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(20)),
                                          color: HexColor("#025393")
                                      ),
                                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                    ),
                                    Container(
                                      child: SizedBox(
                                        width: MediaQuery.of(context).size.width * 0.55,
                                        child: Text(
                                          surat[index]['parindikan'].toString(),
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
                                      child: Text(
                                        surat[index]['nomor_surat'].toString(),style: TextStyle(
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
                          height: 90,
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
        )
      ),
    );
  }
}