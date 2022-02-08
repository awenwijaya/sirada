import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:surat/LoginAndRegistration/LoginPage.dart';

class detailDesaPenduduk extends StatefulWidget {
  const detailDesaPenduduk({Key key}) : super(key: key);

  @override
  _detailDesaPendudukState createState() => _detailDesaPendudukState();
}

class _detailDesaPendudukState extends State<detailDesaPenduduk> {
  var namaDesa = "Desa";
  var logoDesa;
  var kodePos = "00000";
  var alamatKantorDesa = "Alamat";
  var teleponKantorDesa = "Telepon";
  var emailDesa = "Email";
  var webDesa = "Web";
  var luasDesa = "Luas Desa";
  var kontakWADesa = "Kontak WA";
  var namaKecamatan = "Kecamatan";
  var apiURLGetDetailDesaById = "http://192.168.18.10:8000/api/data/desa/${loginPage.desaId}";

  getDesaInfo() async {
    http.post(Uri.parse(apiURLGetDetailDesaById),
      headers: {"Content-Type" : "application/json"},
    ).then((http.Response response) {
      var responseValue = response.statusCode;
      if(responseValue == 200) {
        var jsonData = response.body;
        var parsedJson = json.decode(jsonData);
        setState(() {
          namaDesa = parsedJson['nama_desa'];
          kodePos = parsedJson['kode_pos'];
          logoDesa = parsedJson['logo_desa'];
          alamatKantorDesa = parsedJson['alamat_kantor_desa'];
          teleponKantorDesa = parsedJson['telepon_kantor_desa'];
          emailDesa = parsedJson['email_desa'];
          webDesa = parsedJson['web_desa'];
          luasDesa = parsedJson['luas_desa'].toString();
          kontakWADesa = parsedJson['kontak_wa_desa'];
          namaKecamatan = parsedJson['nama_kecamatan'];
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDesaInfo();
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
                      child: Text(namaDesa.toString(), style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 16,
                        color: HexColor("#025393"),
                        fontWeight: FontWeight.w700
                      )),
                      margin: EdgeInsets.only(top: 15),
                    ),
                    Container(
                      child: Text("Kode Pos : ${kodePos.toString()}", style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.white
                      )),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: HexColor("#1e8cb0")
                      ),
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      margin: EdgeInsets.only(top: 10),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text("Kontak Desa", style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 14,
                              fontWeight: FontWeight.w700
                            )),
                            margin: EdgeInsets.only(top: 15, left: 25)
                          ),
                          Container(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        child: Icon(
                                          Icons.phone,
                                          color: HexColor("#025393"),
                                          size: 30,
                                        ),
                                        margin: EdgeInsets.only(left: 20),
                                      ),
                                      Container(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(child: Text("Nomor Telepon", style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                  color: HexColor("#025393")
                                              )),
                                              ),
                                              Container(
                                                child: Text(teleponKantorDesa.toString(), style: TextStyle(
                                                    fontFamily: "Poppins",
                                                    fontSize: 14
                                                )),
                                              )
                                            ],
                                          ), margin: EdgeInsets.only(left: 15))
                                    ],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  child: TextButton(
                                    onPressed: () async {
                                      final url = 'tel:$teleponKantorDesa';
                                      if(await canLaunch(url)) {
                                        await launch(url);
                                      }
                                    },
                                    child: Text("Hubungi Kantor Desa", style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: HexColor("#025393")
                                    )),
                                  ),
                                )
                              ],
                            ),
                            margin: EdgeInsets.only(top: 15, left: 20, right: 20),
                            padding: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0,3)
                                )
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                          ),
                          Container(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        child: Icon(
                                          Icons.phone,
                                          color: HexColor("#025393"),
                                          size: 30,
                                        ),
                                        margin: EdgeInsets.only(left: 20),
                                      ),
                                      Container(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(child: Text("Kontak WhatsApp", style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                  color: HexColor("#025393")
                                              ))),
                                              Container(
                                                child: Text(kontakWADesa.toString(), style: TextStyle(
                                                    fontFamily: "Poppins",
                                                    fontSize: 14
                                                )),
                                              )
                                            ],
                                          ), margin: EdgeInsets.only(left: 15))
                                    ],
                                  ),
                                ),
                                Container(
                                  child: TextButton(
                                    onPressed: () async{
                                      String url = "whatsapp://send?phone=$kontakWADesa";
                                      await canLaunch(url) ? launch(url) : print("Can't open WhatsApp");
                                    },
                                    child: Text("Hubungin Kantor Desa", style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: HexColor("#025393")
                                    )),
                                  ),
                                )
                              ],
                            ),
                            margin: EdgeInsets.only(top: 15, left: 20, right: 20),
                            padding: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(0,3)
                                  )
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                          ),
                          Container(
                            child: Row(
                              children: <Widget>[
                                Container(
                                  child: Icon(
                                    Icons.location_on_outlined,
                                    color: HexColor("#025393"),
                                    size: 30,
                                  ),
                                  margin: EdgeInsets.only(left: 20),
                                ),
                                Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(child: Text("Alamat Kantor", style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: HexColor("#025393")
                                      )),
                                    ),
                                    Container(
                                      child: SizedBox(
                                        width: MediaQuery.of(context).size.width * 0.7,
                                        child: Text(alamatKantorDesa.toString(), style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 14
                                        )),
                                      ),
                                    )
                                  ],
                                ), margin: EdgeInsets.only(left: 15))
                              ],
                            ),
                            margin: EdgeInsets.only(top: 15, left: 20, right: 20),
                            padding: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0,3)
                                )
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                          ),
                          Container(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        child: Icon(
                                          Icons.email,
                                          color: HexColor("#025393"),
                                          size: 30,
                                        ),
                                        margin: EdgeInsets.only(left: 20),
                                      ),
                                      Container(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(child: Text("Email", style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                  color: HexColor("#025393")
                                              )),
                                              ),
                                              Container(
                                                child: Text(emailDesa.toString(), style: TextStyle(
                                                    fontFamily: "Poppins",
                                                    fontSize: 14
                                                )),
                                              )
                                            ],
                                          ), margin: EdgeInsets.only(left: 15))
                                    ],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  child: TextButton(
                                    onPressed: () async {
                                      final url = 'mailto:$emailDesa';

                                      if(await canLaunch(url)) {
                                        await launch(url);
                                      }
                                    },
                                    child: Text("Hubungi Kantor Desa", style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: HexColor("#025393")
                                    )),
                                  ),
                                )
                              ],
                            ),
                            margin: EdgeInsets.only(top: 15, left: 20, right: 20),
                            padding: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0,3)
                                )
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                          ),
                          Container(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        child: Icon(
                                          Icons.web,
                                          color: HexColor("#025393"),
                                          size: 30,
                                        ),
                                        margin: EdgeInsets.only(left: 20),
                                      ),
                                      Container(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(child: Text("Website", style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                  color: HexColor("#025393")
                                              )),
                                              ),
                                              Container(
                                                child: Text(webDesa.toString(), style: TextStyle(
                                                    fontFamily: "Poppins",
                                                    fontSize: 14
                                                )),
                                              )
                                            ],
                                          ), margin: EdgeInsets.only(left: 15))
                                    ],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  child: TextButton(
                                    onPressed: () async {
                                      final url = webDesa;

                                      if (await canLaunch(url)) {
                                        await launch(url);
                                      }
                                    },
                                    child: Text("Buka Website Desa", style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: HexColor("#025393")
                                    )),
                                  ),
                                )
                              ],
                            ),
                            margin: EdgeInsets.only(top: 15, left: 20, right: 20),
                            padding: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0,3)
                                )
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                margin: EdgeInsets.only(top: 20),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text("Detail Desa Lainnya", style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14,
                        fontWeight: FontWeight.w700
                        )),
                        margin: EdgeInsets.only(top: 20, left: 25),
                      ),
                      Container(
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Icon(
                                Icons.location_on_rounded,
                                color: HexColor("#025393"),
                                size: 30,
                              ),
                              margin: EdgeInsets.only(left: 20),
                            ),
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    child: Text("Luas Desa", style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: HexColor("#025393")
                                    )),
                                  ),
                                  Container(
                                    child: Text("${luasDesa.toString()} km", style: TextStyle(
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
                        margin: EdgeInsets.only(top: 15, left: 20, right: 20),
                        padding: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0,3)
                              )
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                      ),
                      Container(
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Icon(
                                Icons.location_on_rounded,
                                color: HexColor("#025393"),
                                size: 30,
                              ),
                              margin: EdgeInsets.only(left: 20),
                            ),
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    child: Text("Kecamatan", style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: HexColor("#025393")
                                    )),
                                  ),
                                  Container(
                                    child: Text(namaKecamatan.toString(), style: TextStyle(
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
                        margin: EdgeInsets.only(top: 15, left: 20, right: 20, bottom: 15),
                        padding: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0,3)
                              )
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                      )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}