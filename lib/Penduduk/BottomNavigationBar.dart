import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:surat/Penduduk/Dashboard.dart';
import 'package:surat/Penduduk/Profile/UserProfile.dart';

class bottomNavigationBarPenduduk extends StatefulWidget {
  const bottomNavigationBarPenduduk({Key key}) : super(key: key);

  @override
  State<bottomNavigationBarPenduduk> createState() => _bottomNavigationBarPendudukState();
}

class _bottomNavigationBarPendudukState extends State<bottomNavigationBarPenduduk> {
  int currentPage = 0;
  GlobalKey bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getPage(currentPage),
      bottomNavigationBar: FancyBottomNavigation(
        tabs: [
          TabData(
            iconData: Icons.home,
            title: "Beranda",
          ),
          TabData(
              iconData: Icons.person,
              title: "Profil"
          )
        ],
        initialSelection: 0,
        key: bottomNavigationKey,
        onTabChangedListener: (position) {
          setState(() {
            currentPage = position;
          });
        },
        circleColor: HexColor("#025393"),
        inactiveIconColor: HexColor("#025393"),
      )
    );
  }

  getPage(int page) {
    switch (page) {
      case 0 :
        return dashboardPenduduk();

      case 1:
        return kramaProfile();
    }
  }
}
