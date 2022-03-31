import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;

class detailSuratKeluarPanitia extends StatefulWidget {
  static var suratKeluarId;
  const detailSuratKeluarPanitia({Key key}) : super(key: key);

  @override
  State<detailSuratKeluarPanitia> createState() => _detailSuratKeluarPanitiaState();
}

class _detailSuratKeluarPanitiaState extends State<detailSuratKeluarPanitia> {
  var tanggalSurat;
  var nomorSurat;
  var lepihan;
  var parindikan;
  var pemahbah;
  var daging;
  var pamuput;
  var pihakPenerima;
  var namaDesa;
  var namaKecamatan;
  var namaKabupaten;
  var alamat;
  var kontakWa1;
  var kontakWa2;
  var logoDesa;
  var timKegiatan;
  var apiURLShowDetailSuratKeluar = "http://192.168.18.10:8000/api/data/surat/keluar/view/${detailSuratKeluarPanitia.suratKeluarId}";
  bool LoadData = true;

  getSuratKeluarInfo() async {
    http.get(Uri.parse(apiURLShowDetailSuratKeluar),
      headers: {"Content-Type" : "application/json"}
    ).then((http.Response response) {
      var responseValue = response.statusCode;
      if(responseValue == 200) {
        var jsonData = response.body;
        var parsedJson = json.decode(jsonData);
        setState(() {
          tanggalSurat = parsedJson['tanggal_surat'];
          nomorSurat = parsedJson['nomor_surat'];
          lepihan = parsedJson['lepihan'];
          parindikan = parsedJson['parindikan'];
          pemahbah = parsedJson['pemahbah_surat'];
          daging = parsedJson['daging_surat'];
          pamuput = parsedJson['pamuput_surat'];
          pihakPenerima = parsedJson['pihak_penerima'];
          namaDesa =  parsedJson['desadat_nama'];
          namaKecamatan = parsedJson['nama_kecamatan'];
          namaKabupaten = parsedJson['name'];
          alamat = parsedJson['desadat_alamat_kantor'];
          kontakWa1 = parsedJson['desadat_wa_kontak_1'];
          kontakWa2 = parsedJson['desadat_wa_kontak_2'];
          logoDesa = parsedJson['desadat_logo'];
          timKegiatan = parsedJson['tim_kegiatan'];
          LoadData = false;
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSuratKeluarInfo();
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
          title: Text(parindikan == null ? "" : parindikan, style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w700,
            color: HexColor("#025393")
          ))
        ),
        body: LoadData ? ProfilePageShimmer() : SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage('https://picsum.photos/250?image=9'),
                                fit: BoxFit.fill
                            )
                        ),
                        margin: EdgeInsets.only(left: 20)
                      ),
                      Container(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.82,
                          child: Column(
                            children: <Widget>[
                              Container(
                                  child: Text("DESA ADAT ${namaDesa}".toUpperCase(), style: TextStyle(
                                      fontFamily: "Times New Roman",
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700
                                  ))
                              ),
                              Container(
                                  child: Text("KECAMATAN ${namaKecamatan} ${namaKabupaten}".toUpperCase(), style: TextStyle(
                                      fontFamily: "Times New Roman",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700
                                  ), textAlign: TextAlign.center),
                                  margin: EdgeInsets.only(top: 5),
                                  padding: EdgeInsets.symmetric(horizontal: 10)
                              ),
                              Container(
                                  child: Text("${alamat}${kontakWa1 == null ? "" : ", $kontakWa1"}${kontakWa2 == null ? "" : ",$kontakWa2"}", style: TextStyle(
                                      fontFamily: "Times New Roman",
                                      fontSize: 16
                                  ), textAlign: TextAlign.center),
                                  margin: EdgeInsets.only(top: 5),
                                  padding: EdgeInsets.symmetric(horizontal: 10)
                              )
                            ],
                          ),
                        )
                      )
                    ]
                  ),
                margin: EdgeInsets.only(top: 20)
              ),
              Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 2.0, color: Colors.black)
                      )
                  ),
                margin: EdgeInsets.only(top: 10, left: 15, right: 15),
              ),
              Container(
                alignment: Alignment.topRight,
                child: Text("${namaDesa}, ${tanggalSurat}", style: TextStyle(
                  fontFamily: "Times New Roman",
                  fontSize: 16
                )),
                margin: EdgeInsets.only(right: 15, top: 15)
              ),
              Container(
                  alignment: Alignment.topRight,
                  child: Text("Katur Majeng Ring : ${pihakPenerima}", style: TextStyle(
                      fontFamily: "Times New Roman",
                      fontSize: 16
                  ), textAlign: TextAlign.center),
                  margin: EdgeInsets.only(top: 10, right: 15)
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text("Nomor: ${nomorSurat}", style: TextStyle(
                        fontFamily: "Times New Roman",
                        fontSize: 16
                      )),
                      margin: EdgeInsets.only(top: 5)
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(lepihan.toString() == "0" ? "Lepihan: -" : "Lepihan: ${lepihan.toString} lepih", style: TextStyle(
                        fontFamily: "Times New Roman",
                        fontSize: 16
                      )),
                      margin: EdgeInsets.only(top: 5)
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text("Parindikan: ${parindikan}", style: TextStyle(
                        fontFamily: "Times New Roman",
                        fontSize: 16
                      )),
                      margin: EdgeInsets.only(top: 5)
                    ),
                  ]
                ),
                margin: EdgeInsets.only(left: 15, top: 20)
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text("Om Swastiyastu", style: TextStyle(
                  fontFamily: "Times New Roman",
                  fontSize: 16,
                  fontWeight: FontWeight.w700
                )),
                margin: EdgeInsets.only(top: 20, left: 15)
              ),
              Container(
                child: Text("\t\t\t${pemahbah}", style: TextStyle(
                  fontFamily: "Times New Roman",
                  fontSize: 16
                ), textAlign: TextAlign.justify),
                padding: EdgeInsets.only(left: 15, right: 15)
              ),
              Container(
                child: Text(daging == null ? "" : "\t\t\t${daging}", style: TextStyle(
                  fontFamily: "Times New Roman",
                  fontSize: 16
                ), textAlign: TextAlign.justify),
                padding: EdgeInsets.only(left: 15, right: 15)
              ),
              Container(
                child: Text(pamuput == null ? "" : "\t\t\t${pamuput}", style: TextStyle(
                  fontFamily: "Times New Roman",
                  fontSize: 16
                ), textAlign: TextAlign.justify),
                padding: EdgeInsets.only(left: 15, right: 15)
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text("Om Santih, Santih, Santih Om", style: TextStyle(
                  fontFamily: "Times New Roman",
                  fontSize: 16,
                  fontWeight: FontWeight.w700
                )),
                margin: EdgeInsets.only(top: 5, left: 15)
              ),
              Container(
                alignment: Alignment.topLeft,
                child: timKegiatan == null ? Container() : Text(timKegiatan, style: TextStyle(
                  fontFamily: "Times New Roman",
                  fontSize: 16,
                  fontWeight: FontWeight.w700
                )),
                margin: EdgeInsets.only(top: 10, bottom: 10, left: 15),
                  padding: EdgeInsets.only(right: 15)
              ),
              Container(
                child: Text("Status Surat", style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                )),
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(top: 15, left: 25)
              ),
              Container(
                  child: Row(
                      children: <Widget>[
                        Container(
                            child: Icon(
                                Icons.info,
                                color: Colors.white
                            )
                        ),
                        Container(
                          child: Flexible(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                        child: Text(tanggalSurat, style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          color: Colors.white
                                        ))
                                    ),
                                    Container(
                                        child: Text("Data surat ditambahkan", style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 14,
                                          color: Colors.white
                                        ))
                                    )
                                  ]
                              )
                          ),
                          margin: EdgeInsets.only(left: 15)
                        )
                      ]
                  ),
                  decoration: BoxDecoration(
                      color: HexColor("019267"),
                      borderRadius: BorderRadius.circular(25)
                  ),
                  padding: EdgeInsets.only(top: 10, bottom: 10, left: 30, right: 30),
                  margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 5)
              ),
            ]
          )
        ),
      )
    );
  }
}
