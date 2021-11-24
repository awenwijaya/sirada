import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:surat/Penduduk/Profile/EditProfile.dart';

class userProfile extends StatefulWidget {
  const userProfile({Key key}) : super(key: key);

  @override
  _userProfileState createState() => _userProfileState();
}

class _userProfileState extends State<userProfile> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Profil Saya", style: TextStyle(
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
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              color: HexColor("#025393"),
              onPressed: (){
                Navigator.push(context, CupertinoPageRoute(builder: (context) => editProfileUser()));
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: Image.asset(
                  'images/userprof.png',
                  height: 100,
                  width: 100,
                ),
                margin: EdgeInsets.only(top: 50),
              ),
              Container(
                child: Text(
                  "Awen Hariwijaya",
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
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text("NIK",
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w700,
                            fontSize: 15
                          ),
                        textAlign: TextAlign.left,
                      ),
                      margin: EdgeInsets.only(top: 30, left: 30),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "12345",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 15
                        ),
                      ),
                      margin: EdgeInsets.only(top: 15, left: 30),
                    )
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text("Alamat",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w700,
                            fontSize: 15
                        ),
                        textAlign: TextAlign.left,
                      ),
                      margin: EdgeInsets.only(top: 30, left: 30),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Jl. Lembusora",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 15
                        ),
                      ),
                      margin: EdgeInsets.only(top: 15, left: 30),
                    )
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text("Jenis Kelamin",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w700,
                            fontSize: 15
                        ),
                        textAlign: TextAlign.left,
                      ),
                      margin: EdgeInsets.only(top: 30, left: 30),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Laki-Laki",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 15
                        ),
                      ),
                      margin: EdgeInsets.only(top: 15, left: 30),
                    )
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text("Golongan Darah",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w700,
                            fontSize: 15
                        ),
                        textAlign: TextAlign.left,
                      ),
                      margin: EdgeInsets.only(top: 30, left: 30),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "A",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 15
                        ),
                      ),
                      margin: EdgeInsets.only(top: 15, left: 30),
                    )
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text("Kewarganegaraan",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w700,
                            fontSize: 15
                        ),
                        textAlign: TextAlign.left,
                      ),
                      margin: EdgeInsets.only(top: 30, left: 30),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "WNI",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 15
                        ),
                      ),
                      margin: EdgeInsets.only(top: 15, left: 30),
                    )
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text("Asal Desa",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w700,
                            fontSize: 15
                        ),
                        textAlign: TextAlign.left,
                      ),
                      margin: EdgeInsets.only(top: 30, left: 30),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Ubung Kaja",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 15
                        ),
                      ),
                      margin: EdgeInsets.only(top: 15, left: 30),
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
