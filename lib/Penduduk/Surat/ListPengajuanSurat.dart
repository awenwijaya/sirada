import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:surat/Penduduk/Surat/PengajuanSurat.dart';

class listPengajuanSuratUser extends StatefulWidget {
  const listPengajuanSuratUser({Key key}) : super(key: key);

  @override
  _listPengajuanSuratUserState createState() => _listPengajuanSuratUserState();
}

class _listPengajuanSuratUserState extends State<listPengajuanSuratUser> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Pengajuan Surat Lainnya", style: TextStyle(
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
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      child: Image.asset(
                        'images/email.png',
                        height: 100,
                        width: 100,
                      ),
                      margin: EdgeInsets.only(top: 50),
                    ),
                    Container(
                      child: Text(
                        "Pengajuan Surat",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 20,
                            fontWeight: FontWeight.w700
                        ),
                        textAlign: TextAlign.center,
                      ),
                      margin: EdgeInsets.only(top: 30),
                    ),
                    Container(
                      child: Text(
                        "Pilihlah salah satu dari list pengajuan surat dibawah ini",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 15
                        ),
                        textAlign: TextAlign.center,
                      ),
                      margin: EdgeInsets.only(top: 20),
                      padding: EdgeInsets.symmetric(horizontal: 20),
                    )
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: FlatButton(
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Image.asset(
                                'images/baby.png',
                                height: 40,
                                width: 40,
                              ),
                              margin: EdgeInsets.only(right: 20),
                            ),
                            Container(
                              child: Text(
                                "Akta Kelahiran",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700
                                ),
                              ),
                            )
                          ],
                        ),
                        color: HexColor("d3dbdc"),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        padding: EdgeInsets.only(top: 10, bottom: 10, left: 30, right: 30),
                        onPressed: (){
                          Navigator.push(context, createRoutePengajuanSurat());
                        },
                      ),
                      margin: EdgeInsets.only(top: 30, left: 20, right: 20),
                    ),
                    Container(
                      child: FlatButton(
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Image.asset(
                                'images/baby.png',
                                height: 40,
                                width: 40,
                              ),
                              margin: EdgeInsets.only(right: 20),
                            ),
                            Container(
                              child: Text(
                                "Akta Kelahiran",
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700
                                ),
                              ),
                            )
                          ],
                        ),
                        color: HexColor("d3dbdc"),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        padding: EdgeInsets.only(top: 10, bottom: 10, left: 30, right: 30),
                        onPressed: (){},
                      ),
                      margin: EdgeInsets.only(top: 30, left: 20, right: 20),
                    ),
                    Container(
                      child: FlatButton(
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Image.asset(
                                'images/baby.png',
                                height: 40,
                                width: 40,
                              ),
                              margin: EdgeInsets.only(right: 20),
                            ),
                            Container(
                              child: Text(
                                "Akta Kelahiran",
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700
                                ),
                              ),
                            )
                          ],
                        ),
                        color: HexColor("d3dbdc"),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        padding: EdgeInsets.only(top: 10, bottom: 10, left: 30, right: 30),
                        onPressed: (){
                          Navigator.push(context, createRoutePengajuanSurat());
                        },
                      ),
                      margin: EdgeInsets.only(top: 30, left: 20, right: 20),
                    ),
                    Container(
                      child: FlatButton(
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Image.asset(
                                'images/baby.png',
                                height: 40,
                                width: 40,
                              ),
                              margin: EdgeInsets.only(right: 20),
                            ),
                            Container(
                              child: Text(
                                "Akta Kelahiran",
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700
                                ),
                              ),
                            )
                          ],
                        ),
                        color: HexColor("d3dbdc"),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        padding: EdgeInsets.only(top: 10, bottom: 10, left: 30, right: 30),
                        onPressed: (){
                          Navigator.push(context, createRoutePengajuanSurat());
                        },
                      ),
                      margin: EdgeInsets.only(top: 30, left: 20, right: 20),
                    ),
                    Container(
                      child: FlatButton(
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Image.asset(
                                'images/baby.png',
                                height: 40,
                                width: 40,
                              ),
                              margin: EdgeInsets.only(right: 20),
                            ),
                            Container(
                              child: Text(
                                "Akta Kelahiran",
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700
                                ),
                              ),
                            )
                          ],
                        ),
                        color: HexColor("d3dbdc"),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        padding: EdgeInsets.only(top: 10, bottom: 10, left: 30, right: 30),
                        onPressed: (){
                          Navigator.push(context, createRoutePengajuanSurat());
                        },
                      ),
                      margin: EdgeInsets.only(top: 30, left: 20, right: 20),
                    ),
                    Container(
                      child: FlatButton(
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Image.asset(
                                'images/baby.png',
                                height: 40,
                                width: 40,
                              ),
                              margin: EdgeInsets.only(right: 20),
                            ),
                            Container(
                              child: Text(
                                "Akta Kelahiran",
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700
                                ),
                              ),
                            )
                          ],
                        ),
                        color: HexColor("d3dbdc"),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        padding: EdgeInsets.only(top: 10, bottom: 10, left: 30, right: 30),
                        onPressed: (){
                          Navigator.push(context, createRoutePengajuanSurat());
                        },
                      ),
                      margin: EdgeInsets.only(top: 30, left: 20, right: 20),
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

Route createRoutePengajuanSurat() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const pengajuanSurat(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    }
  );
}