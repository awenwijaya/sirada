import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:surat/AdminDesa/ManajemenSurat/SuratKeluar/SuratKeluarNonPanitia/EditSuratKeluarNonPanitia.dart';
import 'package:surat/AdminDesa/ManajemenSurat/SuratKeluar/ViewLampiran.dart';

class detailSuratKeluarNonPanitia extends StatefulWidget {
  static var suratKeluarId;
  const detailSuratKeluarNonPanitia({Key key}) : super(key: key);

  @override
  State<detailSuratKeluarNonPanitia> createState() => _detailSuratKeluarNonPanitiaState();
}

class _detailSuratKeluarNonPanitiaState extends State<detailSuratKeluarNonPanitia> {
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
  var namaPenyarikan;
  var namaBendesa;
  var lampiran;
  var tumusan;
  bool LoadData = true;
  var apiURLShowDetailSuratKeluar = "http://192.168.239.149:8000/api/data/surat/keluar/view/${detailSuratKeluarNonPanitia.suratKeluarId}";
  var apiURLShowPrajuru = "http://192.168.239.149:8000/api/data/admin/surat/keluar/prajuru/${detailSuratKeluarNonPanitia.suratKeluarId}";

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
          pemahbah = parsedJson['pamahbah_surat'];
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
          lampiran = parsedJson['lampiran'];
          tumusan = parsedJson['tumusan'];
          LoadData = false;
        });
      }
    });
  }

  getBendesaInfo() async {
    var body = jsonEncode({
      "jabatan" : "Bendesa"
    });
    http.post(Uri.parse(apiURLShowPrajuru),
        headers: {"Content-Type" : "application/json"},
        body: body
    ).then((http.Response response) {
      if(response.statusCode == 200) {
        var jsonData = response.body;
        var parsedJson = json.decode(jsonData);
        setState(() {
          namaBendesa = parsedJson['nama'];
        });
      }
    });
  }

  getPenyarikanInfo() async {
    var body = jsonEncode({
      "jabatan" : "penyarikan"
    });
    http.post(Uri.parse(apiURLShowPrajuru),
        headers: {"Content-Type" : "application/json"},
        body: body
    ).then((http.Response response) {
      if(response.statusCode == 200) {
        var jsonData = response.body;
        var parsedJson = json.decode(jsonData);
        setState(() {
          namaPenyarikan = parsedJson['nama'];
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSuratKeluarInfo();
    getBendesaInfo();
    getPenyarikanInfo();
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
            )),
          actions: <Widget>[
            IconButton(
              onPressed: (){
                setState(() {
                  setState(() {
                    editSuratKeluarNonPanitia.idSuratKeluar = detailSuratKeluarNonPanitia.suratKeluarId;
                  });
                  Navigator.push(context, CupertinoPageRoute(builder: (context) => editSuratKeluarNonPanitia())).then((value) {
                    getSuratKeluarInfo();
                    getBendesaInfo();
                    getPenyarikanInfo();
                  });
                });
              },
              icon: Icon(Icons.edit),
              color: HexColor("#025393")
            )
          ]
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
                            child: Text(lepihan == "0" ? "Lepihan: -" : "Lepihan: ${lepihan} lepih", style: TextStyle(
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
                        Container(
                            alignment: Alignment.topLeft,
                            child: Text(tumusan == null ? "Tumusan: -" : "Tumusan: ${tumusan}", style: TextStyle(
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
                  alignment: Alignment.topLeft,
                  child: Text("\t\t\t${pemahbah}", style: TextStyle(
                      fontFamily: "Times New Roman",
                      fontSize: 16
                  ), textAlign: TextAlign.justify),
                  padding: EdgeInsets.only(left: 15, right: 15)
              ),
              Container(
                  alignment: Alignment.topLeft,
                  child: Text(daging == null ? "" : "\t\t\t${daging}", style: TextStyle(
                      fontFamily: "Times New Roman",
                      fontSize: 16
                  ), textAlign: TextAlign.justify),
                  padding: EdgeInsets.only(left: 15, right: 15)
              ),
              Container(
                  alignment: Alignment.topLeft,
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
                  child: Stack(
                      children: <Widget>[
                        Container(
                            alignment: Alignment.topLeft,
                            child: namaBendesa == null ? Container() : Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                    child: Text("Bandesa", style: TextStyle(
                                        fontFamily: "Times New Roman",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700
                                    ))
                                ),
                                Container(
                                    child: Text(namaBendesa, style: TextStyle(
                                        fontFamily: "Times New Roman",
                                        fontSize: 16
                                    )),
                                    margin: EdgeInsets.only(top: 25)
                                )
                              ],
                            ),
                            margin: EdgeInsets.only(left: 10, top: 10)
                        ),
                        Container(
                            alignment: Alignment.topRight,
                            child: namaPenyarikan == null ? Container() : Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                    child: Text("Penyarikan", style: TextStyle(
                                        fontFamily: "Times New Roman",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700
                                    ))
                                ),
                                Container(
                                    child: Text(namaPenyarikan, style: TextStyle(
                                        fontFamily: "Times New Roman",
                                        fontSize: 16
                                    )),
                                    margin: EdgeInsets.only(top: 25)
                                )
                              ],
                            ),
                            margin: EdgeInsets.only(right: 10, top: 10)
                        ),
                      ]
                  )
              ),
              Container(
                child: lampiran == null ? Container() : Container(
                  child: FlatButton(
                    onPressed: (){
                      setState(() {
                        viewLampiranSuratKeluarAdmin.namaFile = lampiran;
                      });
                      Navigator.push(context, CupertinoPageRoute(builder: (context) => viewLampiranSuratKeluarAdmin()));
                    },
                    child: Text("Lihat Lampiran", style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: HexColor("#025393")
                    )),
                    color: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                      side: BorderSide(color: HexColor("#025393"), width: 2)
                    ),
                    padding: EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50),
                  ),
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                ),
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
                                    mainAxisAlignment: MainAxisAlignment.start,
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
            ],
          ),
        )
      )
    );
  }
}
