import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:surat/LoginAndRegistration/RegistrationPage.dart';
import 'package:surat/Penduduk/Dashboard.dart';

class loginPage extends StatefulWidget {
  const loginPage({Key key}) : super(key: key);

  @override
  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: new ThemeData(scaffoldBackgroundColor: HexColor("#FFFFFF")),
      home: Scaffold(
          appBar: AppBar(
            title: Text("Login", style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.w700,
                color: HexColor("#025393")
            )),
            backgroundColor: Colors.white,
            centerTitle: true,
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
                child: Image.asset(
                  'images/login2.jpg',
                  height: 200,
                  width: 200,
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              borderSide: BorderSide(color: HexColor("#025393")),
                            ),
                            hintText: "Email",
                            prefixIcon: Icon(Icons.email_rounded),
                          ),
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                        child: TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50.0),
                                borderSide: BorderSide(color: HexColor("#025393")),
                              ),
                              prefixIcon: Icon(Icons.lock_rounded),
                              hintText: "Password"
                          ),
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 14
                          ),
                          obscureText: true,
                        ),
                      ),
                      margin: EdgeInsets.only(top: 10),
                    )
                  ],
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: FlatButton(
                        onPressed: (){
                          Navigator.pushReplacement(context, createRoutePendudukDashboard());
                        },
                        child: Text('Login', style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w700
                        )),
                        color: HexColor("#025393"),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)
                        ),
                        padding: EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50),
                      ),
                    ),
                    Container(
                      child: FlatButton(
                        onPressed: (){
                          Navigator.push(context, CupertinoPageRoute(builder: (context) => registrationPage()));
                        },
                        child: Text('Daftar Akun', style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
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
                      margin: EdgeInsets.only(left: 20),
                    )
                  ],
                ),
                margin: EdgeInsets.only(top: 30),
              ),
              Container(
                child: TextButton(
                  child: Text(
                    "Lupa Password",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 14,
                      color: HexColor("#025393"),
                      fontWeight: FontWeight.w700
                    ),
                  ),
                  onPressed: (){},
                ),
                margin: EdgeInsets.only(top: 20),
              )
            ],
          ),
        )
      ),
    );
  }
}

Route createRoutePendudukDashboard() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const dashboardPenduduk(),
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