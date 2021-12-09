import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:surat/WelcomeScreen.dart';

void main() {
  runApp(new MaterialApp(
    home: new welcomeScreen()
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