import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:page_transition/page_transition.dart';
import 'package:surat/WelcomeScreen.dart';

class emailConfirmation extends StatelessWidget {
  const emailConfirmation({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: new ThemeData(scaffoldBackgroundColor: HexColor("#FFFFFF")),
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: Text(
                  "Konfirmasi Email",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    color: HexColor("#025393")
                  ),
                ),
                margin: EdgeInsets.only(top: 70),
              ),
              Container(
                child: Image.asset(
                  'images/emailconfirm.png',
                  height: 200,
                  width: 200,
                ),
                margin: EdgeInsets.only(top: 50),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Text(
                        "Email konfirmasi sudah dikirim kepada email:",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 17,
                          fontWeight: FontWeight.w700
                        ),
                        textAlign: TextAlign.center,
                      ),
                      padding: EdgeInsets.only(left: 20, right: 20),
                      margin: EdgeInsets.only(top: 30),
                    ),
                    Container(
                      child: Text(
                        "hariwijayaawen@gmail.com",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 17
                        ),
                        textAlign: TextAlign.center,
                      ),
                      padding: EdgeInsets.only(left: 20, right: 20),
                      margin: EdgeInsets.only(top: 20),
                    ),
                    Container(
                      child: Text(
                        "Silahkan melakukan konfirmasi pada email yang sudah dikirimkan untuk menyelesaikan pendaftaran",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 17,
                            fontWeight: FontWeight.w700
                        ),
                        textAlign: TextAlign.center,
                      ),
                      padding: EdgeInsets.only(left: 20, right: 20),
                      margin: EdgeInsets.only(top: 30),
                    ),
                    Container(
                      child: FlatButton(
                        onPressed: (){
                          Navigator.of(context).push(createRouteWelcomePage());
                        },
                        child: Text('Kembali ke Halaman Utama', style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 15,
                          color: HexColor("#025393"),
                          fontWeight: FontWeight.w700
                        )),
                        color: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                          side: BorderSide(color: HexColor("#025393"), width: 2)
                        ),
                        padding: EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50),
                      ),
                      margin: EdgeInsets.only(top: 30),
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

Route createRouteWelcomePage() {
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