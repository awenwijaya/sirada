import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class detailDesa extends StatefulWidget {
  static var namaKecamatan = "Nama Kecamatan";
  static var nomorTelepon = "Nomor Telepon";
  static var alamat = "Alamat";
  static var kodePos = "Kode Pos";
  static var idKecamatan;
  const detailDesa({Key key}) : super(key: key);

  @override
  _detailDesaState createState() => _detailDesaState();
}

class _detailDesaState extends State<detailDesa> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Detail Desa", style: TextStyle(
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
                      width: 75,
                      height: 75,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage('https://googleflutter.com/sample_image.jpg'),
                          fit: BoxFit.fill
                        )
                      ),
                    ),
                    Container(
                      child: Text(
                        "Peguyangan Kaja",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 16,
                          color: HexColor("#025393"),
                          fontWeight: FontWeight.w700
                        ),
                      ),
                      margin: EdgeInsets.only(top: 15),
                    )
                  ],
                ),
                margin: EdgeInsets.only(top: 30, bottom: 30),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            child: Image.asset(
                                'images/person.png',
                              height: 40,
                              width: 40,
                            ),
                          ),
                          Container(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    "100",
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: HexColor("#025393")
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    "Penduduk",
                                    style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 14,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            margin: EdgeInsets.only(left: 20),
                          )
                        ],
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                    Container(
                      child: Row(
                        children: <Widget>[
                          Container(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Container(
                                  child: Image.asset(
                                    'images/location.png',
                                    height: 40,
                                    width: 40,
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        child: Text(
                                          "100",
                                          style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: HexColor("#025393")
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          "Dusun",
                                          style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 14
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  margin: EdgeInsets.only(left: 20),
                                )
                              ],
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                            margin: EdgeInsets.only(left: 30),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Kecamatan",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w700,
                          fontSize: 14
                        ),
                        textAlign: TextAlign.left,
                      ),
                      margin: EdgeInsets.only(top: 30, left: 20),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        detailDesa.namaKecamatan.toString(),
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 14
                        ),
                      ),
                      margin: EdgeInsets.only(top: 5, left: 20),
                    )
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Nomor Telepon",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w700,
                            fontSize: 14
                        ),
                        textAlign: TextAlign.left,
                      ),
                      margin: EdgeInsets.only(top: 20, left: 20),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        detailDesa.nomorTelepon.toString(),
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14
                        ),
                      ),
                      margin: EdgeInsets.only(top: 5, left: 20),
                    )
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Alamat",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w700,
                            fontSize: 14
                        ),
                        textAlign: TextAlign.left,
                      ),
                      margin: EdgeInsets.only(top: 20, left: 20),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        detailDesa.alamat.toString(),
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14
                        ),
                      ),
                      margin: EdgeInsets.only(top: 5, left: 20),
                    )
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Kode Pos",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w700,
                            fontSize: 14
                        ),
                        textAlign: TextAlign.left,
                      ),
                      margin: EdgeInsets.only(top: 20, left: 20),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        detailDesa.kodePos.toString(),
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14
                        ),
                      ),
                      margin: EdgeInsets.only(top: 5, left: 20),
                    )
                  ],
                ),
              )
            ],
          )
        ),
      ),
    );
  }
}
