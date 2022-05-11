import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:surat/LoginAndRegistration/LoginPage.dart';
import 'package:surat/Penduduk/DetailDesa/DetailDesa.dart';
import 'package:surat/Penduduk/SuratPengumuman/SuratPengumuman.dart';
import 'package:surat/Penduduk/ValidasiSuratPanitia/ValidasiSurat.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:surat/main.dart';

class dashboardPenduduk extends StatefulWidget {
  static var logoDesa;
  const dashboardPenduduk({Key key}) : super(key: key);

  @override
  State<dashboardPenduduk> createState() => _dashboardPendudukState();
}

class _dashboardPendudukState extends State<dashboardPenduduk> {
  var profilePicture;
  var nama;
  var namaDesa;
  var suratPengumuman = ['Test Pengumuman I', 'Test Pengumuman II'];
  var isiPengumuman = ['Ini hanyalah test 1', 'Ini hanyalah test 2'];
  bool availableSuratPanitia = false;
  bool LoadingSuratPanitia = true;
  var countSuratPanitia;
  final CarouselController controller = CarouselController();
  int current = 0;
  var apiURLGetDataUser = "http://192.168.18.10:8000/api/data/userdata/${loginPage.userId}";
  var apiURLGetSuratPanitia = "http://192.168.18.10:8000/api/krama/surat/${loginPage.kramaId}";
  var apiURLCountSuratPanitia = "http://192.168.18.10:8000/api/krama/surat/count/${loginPage.kramaId}";

  getUserInfo() async {
    http.get(Uri.parse(apiURLGetDataUser),
      headers: {"Content-Type" : "application/json"}
    ).then((http.Response response) {
      var responseValue = response.statusCode;
      if(responseValue == 200) {
        var jsonData = response.body;
        var parsedJson = json.decode(jsonData);
        setState(() {
          nama = parsedJson['nama'];
          namaDesa = parsedJson['desadat_nama'];
          profilePicture = parsedJson['foto'];
        });
      }
    });
  }

  getSuratPanitia() async {
    http.get(Uri.parse(apiURLGetSuratPanitia),
      headers: {"Content-Type" : "application/json"}
    ).then((http.Response response) {
      var responseValue = response.statusCode;
      if(responseValue == 200) {
        setState(() {
          availableSuratPanitia = true;
        });
        http.get(Uri.parse(apiURLCountSuratPanitia),
          headers: {"Content-Type" : "application/json"}
        ).then((http.Response responseCount) {
          var statusCode = responseCount.statusCode;
          var jsonData = responseCount.body;
          var parsedJson = json.decode(jsonData);
          if(statusCode == 200) {
            setState(() {
              countSuratPanitia = parsedJson;
              LoadingSuratPanitia = false;
            });
          }
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserInfo();
    getSuratPanitia();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if(notification!=null && android!=null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              color: Colors.blue,
              playSound: true,
              icon: '@mipmap/ic_launcher'
            )
          )
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if(notification!=null && android != null) {
        showDialog(
          context: context,
          builder: (_){
            return AlertDialog(
              title: Text(notification.title),
              content: SingleChildScrollView(child: Column(
                children: <Widget>[
                  Text(notification.body)
                ],
              )),
            );
          }
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery
        .of(context)
        .padding
        .top;
    return MaterialApp(
      home: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Text("SiRada", style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.w700,
              )),
              backgroundColor: HexColor("#025393"),
              expandedHeight: 180.0,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  padding: EdgeInsets.only(top: statusBarHeight),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: AssetImage('images/profilepic.png'),
                                    fit: BoxFit.fill
                                )
                            )
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Text("Halo 👋", style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          ))
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Text(nama == null ? "" : nama, style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 16,
                            color: Colors.white
                          ))
                        )
                      ]
                  )
                )
              ),
              centerTitle: true,
            ),
            SliverToBoxAdapter(
              child: Column(
                children: <Widget>[
                  Container(
                    child: Text("Desa Anda", style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 14,
                      fontWeight: FontWeight.bold
                    )),
                    margin: EdgeInsets.only(top: 20, left: 15),
                    alignment: Alignment.topLeft
                  ),
                  Container(
                    child: namaDesa == null ? ProfileShimmer() : Row(
                      children: <Widget>[
                        Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: AssetImage('images/noimage.png'),
                                    fit: BoxFit.fill
                                )
                            ),
                          margin: EdgeInsets.only(left: 20)
                        ),
                        Container(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                      child: Text(namaDesa, style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700
                                      )),
                                      margin: EdgeInsets.only(left: 20)
                                  ),
                                  Container(
                                      child: TextButton(
                                          child: Text("Lihat Detail Desa", style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: HexColor("#025393")
                                          )),
                                        onPressed: (){
                                            Navigator.push(context, CupertinoPageRoute(builder: (context) => detailDesaKrama()));
                                        },
                                      ),
                                      margin: EdgeInsets.only(left: 15)
                                  )
                                ]
                            )
                        )
                      ]
                    ),
                    margin: EdgeInsets.only(top: 10, left: 20, right: 20),
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0,3)
                          )
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                  ),
                  Container(
                      child: availableSuratPanitia == true ? LoadingSuratPanitia == true ? ProfileShimmer() : Container(
                        child: GestureDetector(
                            onTap: (){
                              Navigator.push(context, CupertinoPageRoute(builder: (context) => validasiKrama()));
                            },
                            child: Stack(
                              alignment: Alignment.centerLeft,
                              children: <Widget>[
                                Container(
                                    child: Row(
                                        children: <Widget>[
                                          Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  borderRadius: BorderRadius.all(Radius.circular(20))
                                              ),
                                              child: Wrap(
                                                children: <Widget>[
                                                  Container(
                                                    child: Text(countSuratPanitia.toString(), style: TextStyle(
                                                        fontFamily: "Poppins",
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w700,
                                                        color: Colors.white
                                                    ), textAlign: TextAlign.center),
                                                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                                  )
                                                ],
                                              )
                                          ),
                                          Container(
                                              child: Image.asset(
                                                'images/email.png',
                                                height: 40,
                                                width: 40,
                                              ),
                                              margin: EdgeInsets.only(left: 15)
                                          ),
                                          Container(
                                              child: Text("Validasi Surat", style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700
                                              )),
                                              margin: EdgeInsets.only(left: 20)
                                          )
                                        ]
                                    )
                                ),
                                Container(
                                    alignment: Alignment.centerRight,
                                    child: Icon(
                                        CupertinoIcons.right_chevron,
                                        color: HexColor("#025393")
                                    ),
                                    margin: EdgeInsets.only(right: 10)
                                )
                              ],
                            )
                        ),
                        margin: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 15),
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        height: 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0,3)
                              )
                            ]
                        ),
                      ) : Container()
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text("Pengumuman", style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 14,
                      fontWeight: FontWeight.bold
                    )),
                    margin: EdgeInsets.only(top: 10, left: 15)
                  ),
                  Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                            child: CarouselSlider(
                              items: suratPengumuman.map((i) {
                                return Builder(
                                    builder: (BuildContext context) {
                                      return Container(
                                        width: MediaQuery.of(context).size.width,
                                        margin: EdgeInsets.symmetric(horizontal: 5),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(20)),
                                          color: HexColor("#025393"),
                                        ),
                                        child: GestureDetector(
                                          onTap: (){},
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                child: Expanded(
                                                  flex: 1,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                                      color: Colors.white,
                                                    ),
                                                    child: Center(
                                                      child: Image.asset(
                                                        'images/email.png',
                                                        height: 50,
                                                        width: 50,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                child: Expanded(
                                                  flex: 3,
                                                  child: Column(
                                                    children: <Widget>[
                                                      Container(
                                                        child: Text(i, style: TextStyle(
                                                          fontFamily: "Poppins",
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.w700,
                                                          color: Colors.white
                                                        )),
                                                        margin: EdgeInsets.only(top: 15),
                                                      ),
                                                      Container(
                                                        child: Text(isiPengumuman[current], style: TextStyle(
                                                            fontFamily: "Poppins",
                                                            fontSize: 14,
                                                            color: Colors.white
                                                        )),
                                                        margin: EdgeInsets.only(top: 10),
                                                      ),
                                                      Container(
                                                        child: Text("Tekan untuk informasi lebih lanjut", style: TextStyle(
                                                            fontFamily: "Poppins",
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.w700,
                                                            color: Colors.white
                                                        )),
                                                        margin: EdgeInsets.only(top: 20),
                                                      )
                                                    ],
                                                  )
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    }
                                );
                              }).toList(),
                              carouselController: controller,
                              options: CarouselOptions(
                                  autoPlay: true,
                                  enlargeCenterPage: true,
                                  aspectRatio: 2.0,
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      current = index;
                                    });
                                  }
                              ),
                            ),
                            margin: EdgeInsets.only(top: 15, bottom: 10)
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: TextButton(
                            child: Text("Lihat Pengumuman Lainnya", style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: HexColor("#025393")
                            )),
                            onPressed: (){
                              Navigator.push(context, CupertinoPageRoute(builder: (context) => suratPengumumanKrama()));
                            },
                          ),
                        )
                      ]
                    )
                  ),
                ]
              )
            )
          ]
        ),
      ),
    );
  }
}