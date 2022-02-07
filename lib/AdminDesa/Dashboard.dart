import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surat/AdminDesa/Profile/AdminProfile.dart';
import 'package:surat/WelcomeScreen.dart';

class dashboardAdminDesa extends StatefulWidget {
  const dashboardAdminDesa({Key key}) : super(key: key);

  @override
  _dashboardAdminDesaState createState() => _dashboardAdminDesaState();
}

class _dashboardAdminDesaState extends State<dashboardAdminDesa> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            children: <Widget>[
              Text("SiRaja", style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.w700,
                color: HexColor("#025393")
              )),
              Container(
                child: Text("ADMIN", style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  fontSize: 14
                )),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: HexColor("#025393")
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                margin: EdgeInsets.only(left: 10),
              )
            ],
          ),
          backgroundColor: Colors.white,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.person_outline_rounded),
              color: HexColor("#025393"),
              onPressed: (){
                Navigator.push(context, CupertinoPageRoute(builder: (context) => adminProfile()));
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
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40.0))
                      ),
                      content: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              child: Image.asset(
                                'images/logout.png',
                                height: 50,
                                width: 50,
                              ),
                            ),
                            Container(
                              child: Text("Logout?", style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: HexColor("#025393")
                              ), textAlign: TextAlign.center),
                              margin: EdgeInsets.only(top: 10),
                            ),
                            Container(
                              child: Text("Apakah Anda yakin ingin logout?", style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14
                              ), textAlign: TextAlign.center),
                              margin: EdgeInsets.only(top: 10),
                            )
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () async {
                            final SharedPreferences sharedpref = await SharedPreferences.getInstance();
                            sharedpref.remove('userId');
                            sharedpref.remove('pendudukId');
                            sharedpref.remove('desaId');
                            sharedpref.remove('email');
                            sharedpref.remove('role');
                            sharedpref.remove('status');
                            Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(builder: (context) => welcomeScreen()), (route) => false);
                          },
                          child: Text("Ya", style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w700,
                            color: HexColor("#025393")
                          )),
                        ),
                        TextButton(
                          onPressed: (){Navigator.of(context).pop();},
                          child: Text("Tidak", style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w700,
                            color: HexColor("#025393")
                          )),
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      child: Text("Selamat datang kembali", style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                      )),
                    ),
                    Container(
                      child: Text("Admin Desa !", style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 16
                      )),
                    )
                  ],
                ),
                margin: EdgeInsets.only(top: 20, left: 15),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text("Desa Anda", style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14,
                  fontWeight: FontWeight.bold
                )),
                margin: EdgeInsets.only(top: 20, left: 15),
              ),
              Container(
                alignment: Alignment.topLeft,
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage('https://googleflutter.com/sample_image.jpg'),
                                fit: BoxFit.fill
                              )
                            ),
                            margin: EdgeInsets.only(left: 20)
                          ),
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  child: Text("Ubung Kaja", style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700
                                  )),
                                  margin: EdgeInsets.only(left: 20),
                                ),
                                Container(
                                  child: TextButton(
                                    child: Text("Lihat Detail Desa", style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: HexColor("#025393")
                                    )),
                                    onPressed: (){},
                                  ),
                                  margin: EdgeInsets.only(left: 15),
                                )
                              ],
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
                alignment: Alignment.topLeft,
                child: Text("Manajemen Data Desa", style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14,
                  fontWeight: FontWeight.bold
                )),
                margin: EdgeInsets.only(top: 20, left: 15),
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
                                'images/staff.png',
                                height: 40,
                                width: 40,
                              ),
                            ),
                            Container(
                              child: Text("Data Staff", style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14,
                                fontWeight: FontWeight.w700
                              )),
                              margin: EdgeInsets.only(left: 20),
                            ),
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
                      child: GestureDetector(
                        onTap: (){},
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Image.asset(
                                'images/location.png',
                                height: 40,
                                width: 40,
                              ),
                            ),
                            Container(
                              child: Text("Data Dusun", style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14,
                                fontWeight: FontWeight.w700
                              )),
                              margin: EdgeInsets.only(left: 20),
                            )
                          ],
                        ),
                      ),
                      margin: EdgeInsets.only(top: 15, left: 20,right: 20),
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
                alignment: Alignment.topLeft,
                child: Text("Manajemen Surat", style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14,
                  fontWeight: FontWeight.w700
                )),
                margin: EdgeInsets.only(top: 20, left: 15),
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
                                'images/email.png',
                                height: 40,
                                width: 40,
                              ),
                            ),
                            Container(
                              child: Text("Surat Masuk", style: TextStyle(
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
                      child: GestureDetector(
                        onTap: (){},
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
                              child: Text("Surat Keluar", style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14,
                                fontWeight: FontWeight.w700
                              )),
                              margin: EdgeInsets.only(left: 20),
                            )
                          ],
                        ),
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
                      )
                    ),
                    Container(
                      child: GestureDetector(
                        onTap: (){},
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Image.asset(
                                'images/archive.png',
                                height: 40,
                                width: 40,
                              ),
                            ),
                            Container(
                              child: Text("Arsip Surat", style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14,
                                fontWeight: FontWeight.w700
                              )),
                              margin: EdgeInsets.only(left: 20),
                            )
                          ],
                        ),
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
                    Container(
                      child: GestureDetector(
                        onTap: (){},
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Image.asset(
                                'images/paper.png',
                                height: 40,
                                width: 40,
                              ),
                            ),
                            Container(
                              child: Text("Nomor Surat", style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14,
                                fontWeight: FontWeight.w700
                              )),
                              margin: EdgeInsets.only(left: 20),
                            )
                          ],
                        ),
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
                  ],
                ),
              ),
              Container(
                child: GestureDetector(
                  onTap: (){},
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: Image.asset(
                          'images/paper.png',
                          height: 40,
                          width: 40,
                        ),
                      ),
                      Container(
                        child: Text("Surat Layanan Masyarakat", style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14,
                            fontWeight: FontWeight.w700
                        )),
                        margin: EdgeInsets.only(left: 20),
                      )
                    ],
                  ),
                ),
                margin: EdgeInsets.only(top: 25, left: 20, right: 20),
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
                child: GestureDetector(
                  onTap: (){},
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: Image.asset(
                          'images/kalendar.png',
                          height: 40,
                          width: 40,
                        ),
                      ),
                      Container(
                        child: Text("Agenda Acara", style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 14,
                          fontWeight: FontWeight.w700
                        )),
                        margin: EdgeInsets.only(left: 20),
                      )
                    ],
                  ),
                ),
                margin: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
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
      ),
    );
  }
}