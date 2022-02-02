import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;

class detailDesaPenduduk extends StatefulWidget {
  const detailDesaPenduduk({Key key}) : super(key: key);

  @override
  _detailDesaPendudukState createState() => _detailDesaPendudukState();
}

class _detailDesaPendudukState extends State<detailDesaPenduduk> {
  var namaDesa;
  var logoDesa;
  var kodePos;
  var alamatKantorDesa;
  var teleponKantorDesa;
  var emailDesa;
  var webDesa;
  var luasDesa;
  var kontakWADesa;
  var namaKecamatan;

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
                      child: Text("Ubung Kaja", style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 16,
                        color: HexColor("#025393"),
                        fontWeight: FontWeight.w700
                      )),
                      margin: EdgeInsets.only(top: 15),
                    ),
                    Container(
                      child: Text("Kode Pos : 8116", style: TextStyle(
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
                                      child: Text("08970146781", style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 14
                                      )),
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
                                      child: Text("08970146781", style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 14
                                      )),
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
                                      child: Text("08970146781", style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 14
                                      )),
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
                                      child: Text("08970146781", style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 14
                                      )),
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
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700
                                    )),
                                  ),
                                  Container(
                                    child: Text("1250 km", style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 14
                                    )),
                                  )
                                ],
                              ),
                              margin: EdgeInsets.only(left: 10),
                            )
                          ],
                        ),
                        margin: EdgeInsets.only(top: 10)
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
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700
                                    )),
                                  ),
                                  Container(
                                    child: Text("1250 km", style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 14
                                    )),
                                  )
                                ],
                              ),
                              margin: EdgeInsets.only(left: 10),
                            )
                          ],
                        ),
                        margin: EdgeInsets.only(top: 10)
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