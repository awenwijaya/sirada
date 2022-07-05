import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:surat/AdminDesa/Dashboard.dart';
import 'package:surat/KramaPanitia/BottomNavigationBar.dart';
import 'package:surat/KramaPanitia/Dashboard.dart';
import 'package:surat/Penduduk/BottomNavigationBar.dart';
import 'package:surat/Penduduk/Dashboard.dart';
import 'package:surat/WelcomeScreen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surat/LoginAndRegistration/LoginPage.dart';
import 'package:page_transition/page_transition.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel',
  'High Importance Notifications',
  importance: Importance.high,
  playSound: true
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> main() async {
  runApp(new MaterialApp(
    home: new splashScreen()
  ));
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark
    )
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true
  );
  await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
                                      ?.createNotificationChannel(channel);
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]
  );
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up: ${message.messageId}');
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
  var kramaId;
  var kramaIdPanitia;

  Future getUserInfo() async {
    final SharedPreferences sharedpref = await SharedPreferences.getInstance();
    final SharedPreferences sharedprefadmin = await SharedPreferences.getInstance();
    final SharedPreferences sharedprefkrama = await SharedPreferences.getInstance();
    final SharedPreferences sharedprefpanitia = await SharedPreferences.getInstance();
    userEmail = sharedpref.getString('email');
    userId = sharedpref.getInt('userId');
    desaId = sharedpref.getString('desaId');
    pendudukId = sharedpref.getString('pendudukId');
    userStatus = sharedpref.getString('status');
    role = sharedpref.getString('role');
    if(role == "Admin" || role == "Bendesa") {
      prajuruId = sharedprefadmin.getString('prajuru_adat_id');
    }else if(role == "Krama") {
      kramaId = sharedprefkrama.getString('kramaId');
    }else if(role == "Panitia") {
      kramaIdPanitia = sharedprefpanitia.getString('kramaId');
    }
    setState(() {
      status = userStatus;
    });
  }

  getFirebaseFCMToken() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseMessaging.instance.getToken().then((value) {
      setState(() {
        loginPage.token = value;
      });
      print(loginPage.token);
    });
  }

  loadWidget() async {
    var duration = Duration(seconds: pageDelay);
    getUserInfo().whenComplete(() async{
      print(status);
      print(role);
      if(status == 'login'){
        if(role == "Admin" || role == "Bendesa" || role == "Penyarikan") {
          setState(() {
            loginPage.userId = userId;
            loginPage.userEmail = userEmail;
            loginPage.desaId = desaId;
            loginPage.pendudukId = pendudukId;
            loginPage.prajuruId = prajuruId;
            loginPage.role = role;
          });
        }else if(role == "Krama"){
          setState(() {
            loginPage.userId = userId;
            loginPage.userEmail = userEmail;
            loginPage.desaId = desaId;
            loginPage.pendudukId = pendudukId;
            loginPage.kramaId = kramaId;
            loginPage.role = role;
          });
        }else if(role == "Panitia") {
          setState(() {
            loginPage.userId = userId;
            loginPage.userEmail =  userEmail;
            loginPage.desaId = desaId;
            loginPage.pendudukId = pendudukId;
            loginPage.kramaId = kramaIdPanitia;
            loginPage.role = role;
          });
        }
        if(role == "Krama") {
          return Timer(duration, navigatorPendudukHomePage);
        }else if(role == "Admin" || role == "Bendesa" || role == "Penyarikan") {
          return Timer(duration, navigatorAdminDesaHomePage);
        }else if(role == "Panitia") {
          return Timer(duration, navigatorKramaPanitiaHomePage);
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

  void navigatorKramaPanitiaHomePage() {
    Navigator.pushAndRemoveUntil(context, PageTransition(child: dashboardKramaPanitia(), type: PageTransitionType.fade), (route) => false);
  }

  @override
  initState(){
    // TODO: implement initState
    super.initState();
    loadWidget();
    getFirebaseFCMToken();
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