import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:surat/LoginAndRegistration/LoginPage.dart';
import 'package:surat/LoginAndRegistration/RegistrationPage.dart';

class welcomeScreen extends StatelessWidget {
  const welcomeScreen({Key key}) : super(key: key);

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
                child: Image.asset(
                  'images/welcome.jpg',
                  height: 350,
                  width: 350
                ),
                margin: EdgeInsets.only(top: 50),
              ),
              Container(
                child: Text(
                  "Selamat Datang di SiRaja!",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: HexColor("#025393")
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                child: Text(
                  "Kelola berkas administrasi Anda secara online dan mulus",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 16,
                    fontWeight: FontWeight.w700
                  ),
                  textAlign: TextAlign.center,
                ),
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.only(left: 20, right: 20),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: FlatButton(
                        onPressed: (){
                          Navigator.push(context, createRouteLoginPage());
                        },
                        child: Text('Login', style: TextStyle(
                          fontSize: 14,
                          fontFamily: "Poppins",
                          color: HexColor("#025393"),
                          fontWeight: FontWeight.w700
                        )),
                        color: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                          side: BorderSide(color: HexColor("#025393"))
                        ),
                        padding: EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50),
                      ),
                    ),
                    Container(
                      child: FlatButton(
                        onPressed: (){
                          Navigator.of(context).push(createRouteRegisterPage());
                        },
                        child: Text('Daftar Akun', style: TextStyle(
                          fontSize: 14,
                          fontFamily: "Poppins",
                          color: HexColor("#025393"),
                          fontWeight: FontWeight.w700
                        )),
                        color: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                          side: BorderSide(color: HexColor("#025393"))
                        ),
                        padding: EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50),
                      ),
                      margin: EdgeInsets.only(left: 20),
                    )
                  ],
                ),
                margin: EdgeInsets.only(top: 50),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Route createRouteLoginPage() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const loginPage(),
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

Route createRouteRegisterPage() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const registrationPage(),
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