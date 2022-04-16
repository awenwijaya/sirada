import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:surat/AdminDesa/Dashboard.dart';
import 'package:surat/KepalaDesa/Dashboard.dart';
import 'package:surat/KepalaDusun/Dashboard.dart';
import 'package:surat/Penduduk/Dashboard.dart';
import 'package:surat/WelcomeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surat/LoginAndRegistration/LoginPage.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() {
  runApp(new MaterialApp(
    home: new splashScreen()
  ));
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark
    )
  );
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]
  );
}

class splashScreen extends StatefulWidget {
  const splashScreen({Key key}) : super(key: key);

  @override
  _splashScreenState createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  final pageDelay = 1;
  String status;
  var userStatus;
  var userEmail;
  var userId;
  var desaId;
  var role;
  var pendudukId;
  var prajuruId;

  Future getUserInfo() async {
    final SharedPreferences sharedpref = await SharedPreferences.getInstance();
    final SharedPreferences sharedprefadmin = await SharedPreferences.getInstance();
    userEmail = sharedpref.getString('email');
    userId = sharedpref.getInt('userId');
    desaId = sharedpref.getString('desaId');
    pendudukId = sharedpref.getInt('pendudukId');
    userStatus = sharedpref.getString('status');
    role = sharedpref.getString('role');
    if(role == "Admin" || role == "Bendesa") {
      prajuruId = sharedprefadmin.getInt('prajuru_adat_id');
    }
    setState(() {
      status = userStatus;
    });
  }

  loadWidget() async {
    var duration = Duration(seconds: pageDelay);
    getUserInfo().whenComplete(() async{
      print(status);
      print(role);
      if(status == 'login'){
        if(role == "Admin" || role == "Bendesa") {
          setState(() {
            loginPage.userId = userId;
            loginPage.userEmail = userEmail;
            loginPage.desaId = desaId;
            loginPage.pendudukId = pendudukId;
            loginPage.prajuruId = prajuruId;
          });
        }else{
          setState(() {
            loginPage.userId = userId;
            loginPage.userEmail = userEmail;
            loginPage.desaId = desaId;
            loginPage.pendudukId = pendudukId;
          });
        }
        if(role == "Krama") {
          return Timer(duration, navigatorPendudukHomePage);
        }else if(role == "Admin" || role == "Bendesa") {
          return Timer(duration, navigatorAdminDesaHomePage);
        }
      }else{
        return Timer(duration, navigatorWelcomeScreen);
      }
    });
  }

  void navigatorPendudukHomePage() {
    Navigator.pushAndRemoveUntil(context, PageTransition(child: dashboardPenduduk(), type: PageTransitionType.fade), (route) => false);
  }

  void navigatorWelcomeScreen() {
    Navigator.pushAndRemoveUntil(context, PageTransition(child: welcomeScreen(), type: PageTransitionType.fade), (route) => false);
  }

  void navigatorAdminDesaHomePage() {
    Navigator.pushAndRemoveUntil(context, PageTransition(child: dashboardAdminDesa(), type: PageTransitionType.fade), (route) => false);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadWidget();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: Image(
            image: AssetImage('images/logo.png'),
            height: 250,
            width: 250,
          ),
        ),
      ),
    );
  }
}