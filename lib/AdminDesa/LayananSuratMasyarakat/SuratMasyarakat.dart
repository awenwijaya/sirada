import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:surat/AdminDesa/Dashboard.dart';

class layananSuratMasyarakatAdmin extends StatefulWidget {
  const layananSuratMasyarakatAdmin({Key key}) : super(key: key);

  @override
  _layananSuratMasyarakatAdminState createState() => _layananSuratMasyarakatAdminState();
}

class _layananSuratMasyarakatAdminState extends State<layananSuratMasyarakatAdmin> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Surat Layanan Masyarakat", style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w700,
            color: HexColor("#025393")
          )),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: HexColor("#025393"),
            onPressed: (){Navigator.of(context).pop();},
          ),
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: dashboardAdminDesa.logoDesa == null ? AssetImage('images/noimage.png') : NetworkImage('http://192.168.18.10/siraja-api-skripsi/${dashboardAdminDesa.logoDesa}')
                      )
                  ),
                ),
                margin: EdgeInsets.only(top: 20),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text("Surat Layanan Masyarakat", style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14,
                  fontWeight: FontWeight.w700
                )),
                margin: EdgeInsets.only(top: 25, left: 25),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: GestureDetector(
                        onTap: (){},
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Image.asset(
                                'images/person.png',
                                height: 40,
                                width: 40
                              ),
                            ),
                            Container(
                              child: Text("SK Belum Menikah", style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14,
                                fontWeight: FontWeight.w700
                              )),
                              margin: EdgeInsets.only(left: 20),
                            )
                          ],
                        ),
                      ),
                      margin: EdgeInsets.only(top: 15, left: 20, right: 20),
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
                    )
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: GestureDetector(
                        onTap: (){},
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Image.asset(
                                  'images/airplane.png',
                                  height: 40,
                                  width: 40
                              ),
                            ),
                            Container(
                              child: Text("SK Berpergian", style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700
                              )),
                              margin: EdgeInsets.only(left: 20),
                            )
                          ],
                        ),
                      ),
                      margin: EdgeInsets.only(top: 15, left: 20, right: 20),
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
                    )
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: GestureDetector(
                        onTap: (){},
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Image.asset(
                                  'images/scull.png',
                                  height: 40,
                                  width: 40
                              ),
                            ),
                            Container(
                              child: Text("SK Kematian", style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700
                              )),
                              margin: EdgeInsets.only(left: 20),
                            )
                          ],
                        ),
                      ),
                      margin: EdgeInsets.only(top: 15, left: 20, right: 20),
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
                    )
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: GestureDetector(
                        onTap: (){},
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Image.asset(
                                  'images/gear.png',
                                  height: 40,
                                  width: 40
                              ),
                            ),
                            Container(
                              child: Text("SK Lain-Lain", style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700
                              )),
                              margin: EdgeInsets.only(left: 20),
                            )
                          ],
                        ),
                      ),
                      margin: EdgeInsets.only(top: 15, left: 20, right: 20),
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
                    )
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: GestureDetector(
                        onTap: (){},
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Image.asset(
                                  'images/money.png',
                                  height: 40,
                                  width: 40
                              ),
                            ),
                            Container(
                              child: Text("SK Tidak Mampu", style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700
                              )),
                              margin: EdgeInsets.only(left: 20),
                            )
                          ],
                        ),
                      ),
                      margin: EdgeInsets.only(top: 15, left: 20, right: 20),
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
                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: GestureDetector(
                              onTap: (){},
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    child: Image.asset(
                                        'images/store.png',
                                        height: 40,
                                        width: 40
                                    ),
                                  ),
                                  Container(
                                    child: Text("SK Tempat Usaha", style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700
                                    )),
                                    margin: EdgeInsets.only(left: 20),
                                  )
                                ],
                              ),
                            ),
                            margin: EdgeInsets.only(top: 15, left: 20, right: 20),
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
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: GestureDetector(
                              onTap: (){},
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    child: Image.asset(
                                        'images/store.png',
                                        height: 40,
                                        width: 40
                                    ),
                                  ),
                                  Container(
                                    child: Text("SK Usaha", style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700
                                    )),
                                    margin: EdgeInsets.only(left: 20),
                                  )
                                ],
                              ),
                            ),
                            margin: EdgeInsets.only(top: 15, left: 20, right: 20),
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
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: GestureDetector(
                              onTap: (){},
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    child: Image.asset(
                                        'images/paycheck.png',
                                        height: 40,
                                        width: 40
                                    ),
                                  ),
                                  Container(
                                    child: Text("SP Penghasilan Orang Tua", style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700
                                    )),
                                    margin: EdgeInsets.only(left: 20),
                                  )
                                ],
                              ),
                            ),
                            margin: EdgeInsets.only(top: 15, left: 20, right: 20),
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
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: GestureDetector(
                              onTap: (){},
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    child: Image.asset(
                                        'images/baby.png',
                                        height: 40,
                                        width: 40
                                    ),
                                  ),
                                  Container(
                                    child: Text("SK Kelahiran", style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700
                                    )),
                                    margin: EdgeInsets.only(left: 20),
                                  )
                                ],
                              ),
                            ),
                            margin: EdgeInsets.only(top: 15, left: 20, right: 20),
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
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: GestureDetector(
                              onTap: (){},
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    child: Image.asset(
                                        'images/flag.png',
                                        height: 40,
                                        width: 40
                                    ),
                                  ),
                                  Container(
                                    child: Text("SK Datang WNI", style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700
                                    )),
                                    margin: EdgeInsets.only(left: 20),
                                  )
                                ],
                              ),
                            ),
                            margin: EdgeInsets.only(top: 15, left: 20, right: 20),
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
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: GestureDetector(
                              onTap: (){},
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    child: Image.asset(
                                        'images/flag.png',
                                        height: 40,
                                        width: 40
                                    ),
                                  ),
                                  Container(
                                    child: Text("SK Pindah WNI", style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700
                                    )),
                                    margin: EdgeInsets.only(left: 20),
                                  )
                                ],
                              ),
                            ),
                            margin: EdgeInsets.only(top: 15, left: 20, right: 20),
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
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: GestureDetector(
                              onTap: (){},
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    child: Image.asset(
                                        'images/thumb.png',
                                        height: 40,
                                        width: 40
                                    ),
                                  ),
                                  Container(
                                    child: Text("SK Kelakuan Baik", style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700
                                    )),
                                    margin: EdgeInsets.only(left: 20),
                                  )
                                ],
                              ),
                            ),
                            margin: EdgeInsets.only(top: 15, left: 20, right: 20, bottom: 15),
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
                          )
                        ],
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
