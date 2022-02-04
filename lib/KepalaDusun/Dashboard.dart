import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surat/WelcomeScreen.dart';

class dashboardKepalaDusun extends StatefulWidget {
  const dashboardKepalaDusun({Key key}) : super(key: key);

  @override
  _dashboardKepalaDusunState createState() => _dashboardKepalaDusunState();
}

class _dashboardKepalaDusunState extends State<dashboardKepalaDusun> {
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
              onPressed: (){},
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
                                fontSize: 14,
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
                        )
                      ],
                    );
                  }
                );
              },
            )
          ],
        ),
      ),
    );
  }
}