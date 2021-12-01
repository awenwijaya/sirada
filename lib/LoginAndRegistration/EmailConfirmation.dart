import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:page_transition/page_transition.dart';
import 'package:surat/WelcomeScreen.dart';

class emailConfirmation extends StatefulWidget {
  static var userEmail;
  const emailConfirmation({Key key}) : super(key: key);

  @override
  _emailConfirmationState createState() => _emailConfirmationState();
}

class _emailConfirmationState extends State<emailConfirmation> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: HexColor("#FFFFFF")),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Konfirmasi Email", style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w700,
            color: HexColor("#025393")
          )),
          backgroundColor: Colors.white,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                child: Image.asset(
                  'images/emailconfirm.png',
                  height: 100,
                  width: 100,
                ),
                margin: EdgeInsets.only(top: 50),
              ),
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
                  emailConfirmation.userEmail,
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
                    Navigator.of(context).pushReplacement(createRouteWelcomePage());
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