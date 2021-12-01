import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:surat/Penduduk/Profile/UserProfile.dart';
import 'package:surat/Penduduk/Surat/ListPengajuanSurat.dart';
import 'package:surat/WelcomeScreen.dart';

class dashboardPenduduk extends StatefulWidget {
  const dashboardPenduduk({Key key}) : super(key: key);

  @override
  _dashboardPendudukState createState() => _dashboardPendudukState();
}

class _dashboardPendudukState extends State<dashboardPenduduk> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("SiRaja", style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w700,
            color: HexColor("#025393")
          )),
          backgroundColor: Colors.white,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.person_outline_rounded),
              color: HexColor("#025393"),
              onPressed: (){
                Navigator.push(context, CupertinoPageRoute(builder: (context) => userProfile()));
              },
            ),
            IconButton(
              icon: Icon(Icons.logout),
              color: HexColor("#025393"),
              onPressed: (){
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Logout'),
                      content: Text('Apakah Anda ingin logout?'),
                      actions: <Widget>[
                        TextButton(
                          child: Text('Ya'),
                          onPressed: (){
                            Navigator.pushReplacement(context, createRouteWelcomeScreen());
                          },
                        ),
                        TextButton(
                          child: Text('Tidak'),
                          onPressed: (){
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    );
                  }
                );
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "Layanan Administrasi Surat",
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w700
                  ),
                  textAlign: TextAlign.left,
                ),
                margin: EdgeInsets.only(top: 20, left: 15),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: IconButton(
                              icon: Image.asset('images/baby.png'),
                              iconSize: 40,
                              onPressed: (){
                                Navigator.push(context, createRoutePengajuanSurat());
                              }
                            ),
                          ),
                          Container(
                            child: Text(
                              "Akta Kelahiran",
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 13,
                                color: Colors.black
                              ),
                            ),
                            margin: EdgeInsets.only(top: 5),
                          )
                        ],
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 10),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: IconButton(
                                icon: Image.asset('images/thumb.png'),
                                iconSize: 40,
                                onPressed: (){
                                  Navigator.push(context, createRoutePengajuanSurat());
                                }
                            ),
                          ),
                          Container(
                            child: Text(
                              "Berkelakuan Baik",
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 13,
                                  color: Colors.black
                              ),
                            ),
                            margin: EdgeInsets.only(top: 5),
                          )
                        ],
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 10),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: IconButton(
                                icon: Image.asset('images/person.png'),
                                iconSize: 40,
                                onPressed: (){
                                  Navigator.push(context, createRoutePengajuanSurat());
                                }
                            ),
                          ),
                          Container(
                            child: Text(
                              "Belum Menikah",
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 13,
                                  color: Colors.black
                              ),
                            ),
                            margin: EdgeInsets.only(top: 5),
                          )
                        ],
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 10),
                    )
                  ],
                ),
                margin: EdgeInsets.only(top: 20),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: IconButton(
                                icon: Image.asset('images/baby.png'),
                                iconSize: 40,
                                onPressed: (){
                                  Navigator.push(context, createRoutePengajuanSurat());
                                }
                            ),
                          ),
                          Container(
                            child: Text(
                              "Akta Kelahiran",
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 13,
                                  color: Colors.black
                              ),
                            ),
                            margin: EdgeInsets.only(top: 5),
                          )
                        ],
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 10),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: IconButton(
                                icon: Image.asset('images/thumb.png'),
                                iconSize: 40,
                                onPressed: (){
                                  Navigator.push(context, createRoutePengajuanSurat());
                                }
                            ),
                          ),
                          Container(
                            child: Text(
                              "Berkelakuan Baik",
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 13,
                                  color: Colors.black
                              ),
                            ),
                            margin: EdgeInsets.only(top: 5),
                          )
                        ],
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 10),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: IconButton(
                                icon: Image.asset('images/person.png'),
                                iconSize: 40,
                                onPressed: (){
                                  Navigator.push(context, createRoutePengajuanSurat());
                                }
                            ),
                          ),
                          Container(
                            child: Text(
                              "Belum Menikah",
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 13,
                                  color: Colors.black
                              ),
                            ),
                            margin: EdgeInsets.only(top: 5),
                          )
                        ],
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 10),
                    )
                  ],
                ),
                margin: EdgeInsets.only(top: 20),
              ),
              Container(
                child: FlatButton(
                  onPressed: (){
                    Navigator.push(context, CupertinoPageRoute(builder: (context) => listPengajuanSuratUser()));
                  },
                  color: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                    side: BorderSide(color: HexColor("#025393"))
                  ),
                  padding: EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Text(
                          "Layanan surat lainnya",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 15,
                            color: HexColor("#025393"),
                            fontWeight: FontWeight.w700
                          ),
                        ),
                        margin: EdgeInsets.only(right: 10),
                      ),
                      Container(
                        child: Icon(Icons.arrow_forward, color: HexColor("#025393")),
                      )
                    ],
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 30),
                margin: EdgeInsets.only(top: 25),
              ),
              Container(
                child: Text(
                  "Status Surat Saya",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w700
                  ),
                  textAlign: TextAlign.left,
                ),
                margin: EdgeInsets.only(top: 35, left: 15),
                alignment: Alignment.topLeft,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: Text("0", style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 25,
                              color: HexColor("#ff6d69"),
                              fontWeight: FontWeight.w700
                            )),
                          ),
                          Container(
                            child: Text("Menunggu", style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 15,
                                color: Colors.black
                            ))
                          )
                        ],
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 10),
                    ),
                    Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: Text("0", style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 25,
                                  color: HexColor("#fecc50"),
                                  fontWeight: FontWeight.w700
                              )),
                            ),
                            Container(
                              child: Text("Diproses", style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 15,
                                  color: Colors.black
                              )),
                            )
                          ],
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 10)
                    ),
                    Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: Text("0", style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 25,
                                  color: HexColor("#528c83"),
                                  fontWeight: FontWeight.w700
                              )),
                            ),
                            Container(
                              child: Text("Sudah Verifikasi", style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 15,
                                  color: Colors.black
                              )),
                            )
                          ],
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 10)
                    )
                  ],
                ),
                margin: EdgeInsets.only(top: 25),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    DefaultTabController(
                      length: 2,
                      initialIndex: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            child: TabBar(
                              labelColor: HexColor("#074F78"),
                              unselectedLabelColor: Colors.black,
                              tabs: [
                                Tab(child: Text("Sedang Diproses", style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w700
                                ))),
                                Tab(child: Text("Selesai", style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w700
                                )))
                              ],
                            ),
                          ),
                          Container(
                            height: 400,
                            decoration: BoxDecoration(
                              border: Border(top: BorderSide(color: Colors.black26, width: 0.5))
                            ),
                            child: TabBarView(
                              children: <Widget>[
                                Container(
                                  child: Center(
                                    child: Text("Sedang Diproses"),
                                  ),
                                ),
                                Container(
                                  child: Center(
                                    child: Text("Selesai"),
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
                margin: EdgeInsets.only(top: 20),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Route createRouteWelcomeScreen() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const welcomeScreen(),
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