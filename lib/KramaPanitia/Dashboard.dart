import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:surat/KramaPanitia/DetailDesa/DetailDesa.dart';
import 'package:surat/LoginAndRegistration/LoginPage.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:surat/main.dart';

class dashboardKramaPanitia extends StatefulWidget {
  static var logoDesa;
  const dashboardKramaPanitia({Key key}) : super(key: key);

  @override
  State<dashboardKramaPanitia> createState() => _dashboardKramaPanitiaState();
}

class _dashboardKramaPanitiaState extends State<dashboardKramaPanitia> {
  var profilePicture;
  var nama;
  var namaDesa;
  var apiURLGetDataUser = "http://192.168.18.10:8000/api/data/userdata/${loginPage.userId}";
  var apiURLGetDetailDesaById = "http://192.168.18.10:8000/api/data/userdata/desa/${loginPage.desaId}";

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
          profilePicture = parsedJson['foto'];
        });
      }
    });
  }

  getDesaInfo() async {
    http.get(Uri.parse(apiURLGetDetailDesaById),
        headers: {"Content-Type" : "application/json"}
    ).then((http.Response response) {
      var responseValue = response.statusCode;
      if(responseValue == 200) {
        var jsonData = response.body;
        var parsedJson = json.decode(jsonData);
        setState(() {
          namaDesa = parsedJson['desadat_nama'];
          dashboardKramaPanitia.logoDesa = parsedJson['desadat_logo'].toString();
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserInfo();
    getDesaInfo();
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
                    color: Colors.white,
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
              title: Row(
                children: <Widget>[
                  Text("SiRada", style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w700,
                    color: Colors.white
                  )),
                  Container(
                    child: Text("PANITIA", style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w700,
                      color: HexColor("#025393"),
                      fontSize: 14
                    )),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.white
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    margin: EdgeInsets.only(left: 10),
                  )
                ],
              ),
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
                            image: profilePicture == null ? AssetImage('images/profilepic.png') : NetworkImage('http://192.168.18.10/SirajaProject/public/assets/img/profile/${profilePicture}'),
                            fit: BoxFit.fill
                          )
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Text("Halo 👋", style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        )),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Text(nama == null ? "" : nama, style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 16,
                          color: Colors.white
                        )),
                      )
                    ],
                  ),
                ),
              ),
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
                    alignment: Alignment.topLeft,
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
                              image: dashboardKramaPanitia.logoDesa == null ? AssetImage('images/noimage.png') : NetworkImage('http://192.168.18.10/SirajaProject/public/assets/img/logo-desa/${dashboardKramaPanitia.logoDesa}'),
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
                                    Navigator.push(context, CupertinoPageRoute(builder: (context) => detailDesaKramaPanitia()));
                                  },
                                ),
                                margin: EdgeInsets.only(left: 15)
                              )
                            ],
                          ),
                        )
                      ],
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
                    alignment: Alignment.topLeft,
                    child: Text("Status Surat", style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 14,
                      fontWeight: FontWeight.bold
                    )),
                    margin: EdgeInsets.only(top: 20, left: 15)
                  ),
                  Container(
                    child: FlatButton(
                      onPressed: (){},
                      child: Text("Tambah Surat Keluar", style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: HexColor("#025393")
                      )),
                      color: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                        side: BorderSide(color: HexColor("#025393"), width: 2)
                      ),
                      padding: EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50),
                    ),
                    margin: EdgeInsets.only(top: 15),
                  ),
                  Container(
                    child: SafeArea(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            DefaultTabController(
                              length: 3,
                              initialIndex: 0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Container(
                                    child: TabBar(
                                      labelColor: HexColor("#025393"),
                                      unselectedLabelColor: Colors.black,
                                      tabs: [
                                        Tab(
                                          child: Column(
                                            children: <Widget>[
                                              Icon(CupertinoIcons.hourglass_bottomhalf_fill),
                                              SizedBox(
                                                width: MediaQuery.of(context).size.width * 0.55,
                                                child: Text(
                                                  "Menunggu", style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.w700
                                                ),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.fade,
                                                  softWrap: false,
                                                  textAlign: TextAlign.center,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Tab(
                                          child: Column(
                                            children: <Widget>[
                                              Icon(CupertinoIcons.archivebox_fill),
                                              SizedBox(
                                                width: MediaQuery.of(context).size.width * 0.55,
                                                child: Text(
                                                  "Perlu Dikonfirmasi", style: TextStyle(
                                                    fontFamily: "Poppins",
                                                    fontWeight: FontWeight.w700
                                                ),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.fade,
                                                  softWrap: false,
                                                  textAlign: TextAlign.center,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Tab(
                                          child: Column(
                                            children: <Widget>[
                                              Icon(Icons.done),
                                              SizedBox(
                                                width: MediaQuery.of(context).size.width * 0.55,
                                                child: Text(
                                                  "Dikonfirmasi", style: TextStyle(
                                                    fontFamily: "Poppins",
                                                    fontWeight: FontWeight.w700
                                                ),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.fade,
                                                  softWrap: false,
                                                  textAlign: TextAlign.center,
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}