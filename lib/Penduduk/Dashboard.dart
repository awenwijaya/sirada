import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:surat/LoginAndRegistration/LoginPage.dart';
import 'package:surat/Penduduk/AgendaAcara/AgendaAcara.dart';
import 'package:surat/Penduduk/DetailDesa/DetailDesa.dart';
import 'package:surat/Penduduk/Profile/UserProfile.dart';
import 'package:surat/Penduduk/SuratPengumuman/DetailSurat.dart';
import 'package:surat/Penduduk/SuratPengumuman/DetailSuratPanitia.dart';
import 'package:surat/Penduduk/SuratPengumuman/SuratPengumuman.dart';
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
  List pengumuman = [];
  bool LoadingPengumuman = true;
  bool availablePengumuman = false;
  var suratPengumuman = ['Test Pengumuman I', 'Test Pengumuman II'];
  var isiPengumuman = ['Ini hanyalah test 1', 'Ini hanyalah test 2'];
  bool availableSuratPanitia = false;
  bool LoadingSuratPanitia = true;
  var countSuratPanitia;
  final CarouselController controller = CarouselController();
  int current = 0;
  var apiURLGetDataUser = "https://siradaskripsi.my.id/api/data/userdata/${loginPage.userId}";
  var apiURLGetDetailDesaById = "https://siradaskripsi.my.id/api/data/userdata/desa/${loginPage.desaId}";
  var apiURLShowAllPengumuman = "https://siradaskripsi.my.id/api/krama/view/surat/all";

  Future getAllPengumuman() async {
    var body = jsonEncode({
      "desa_adat_id" : loginPage.desaId.toString(),
      "user_id" : loginPage.userId.toString()
    });
    http.post(Uri.parse(apiURLShowAllPengumuman),
      headers: {"Content-Type" : "application/json"},
      body: body
    ).then((http.Response response) {
      var responseValue = response.statusCode;
      if(responseValue == 200) {
        var data = json.decode(response.body);
        setState(() {
          pengumuman = data;
          LoadingPengumuman = false;
          availablePengumuman = true;
        });
      }else {
        setState(() {
          LoadingPengumuman = false;
          availablePengumuman = false;
        });
      }
    });
  }

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
          dashboardPenduduk.logoDesa = parsedJson['desadat_logo'].toString();
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
    getAllPengumuman();
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
              title: Text("SiRada", style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.w700,
              )),
              backgroundColor: HexColor("#025393"),
              expandedHeight: 180.0,
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.person_outline_rounded),
                  color: Colors.white,
                  onPressed: (){Navigator.push(context, CupertinoPageRoute(builder: (context) => kramaProfile())).then((value) {
                    getUserInfo();
                  });},
                )
              ],
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
                                    image: profilePicture == null ? AssetImage('images/profilepic.png') : NetworkImage('https://storage.siradaskripsi.my.id/img/profile/${profilePicture}'),
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
                                    image: dashboardPenduduk.logoDesa == null ? AssetImage('images/noimage.png') : NetworkImage('https://storage.siradaskripsi.my.id/img/logo-desa/${dashboardPenduduk.logoDesa}'),
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
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(context, CupertinoPageRoute(builder: (context) => agendaAcaraKrama()));
                      },
                      child: Row(
                        children: <Widget>[
                          Container(
                            child: Image.asset(
                              'images/kalendar.png',
                              height: 40,
                              width: 40,
                            ),
                          ),
                          Container(
                            child: Text("Agenda Acara", style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14,
                                fontWeight: FontWeight.w700
                            )),
                            margin: EdgeInsets.only(left: 20),
                          ),
                        ],
                      ),
                    ),
                    margin: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
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
                    child: LoadingPengumuman ? ListTileShimmer() : availablePengumuman ? SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: RefreshIndicator(
                        onRefresh: getAllPengumuman,
                        child: ListView.builder(
                          itemCount: pengumuman.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: (){
                                if(pengumuman[index]['tim_kegiatan'] == null) {
                                  setState(() {
                                    detailSuratPrajuruKrama.suratKeluarId = pengumuman[index]['surat_keluar_id'];
                                  });
                                  Navigator.push(context, CupertinoPageRoute(builder: (context) => detailSuratPrajuruKrama())).then((value) {
                                    getAllPengumuman();
                                  });
                                }else {
                                  setState(() {
                                    detailSuratKeluarPanitiaKrama.suratKeluarId = pengumuman[index]['surat_keluar_id'];
                                  });
                                  Navigator.push(context, CupertinoPageRoute(builder: (context) => detailSuratKeluarPanitiaKrama())).then((value) {
                                    getAllPengumuman();
                                  });
                                }
                              },
                              child: Container(
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      child: Image.asset(
                                        'images/email.png',
                                        height: 40,
                                        width: 40,
                                      ),
                                    ),
                                    Container(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            child: SizedBox(
                                              width: MediaQuery.of(context).size.width * 0.55,
                                              child: Text(
                                                pengumuman[index]['parindikan'].toString(),
                                                style: TextStyle(
                                                    fontFamily: "Poppins",
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w700,
                                                    color: pengumuman[index]['status'] == "Belum Terbaca" ? HexColor("025393") : Colors.black26
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: false,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child: Text(pengumuman[index]['nomor_surat'].toString(), style: TextStyle(
                                                fontFamily: "Poppins",
                                                fontSize: 14,
                                              color: pengumuman[index]['status'] == "Belum Terbaca" ? Colors.black : Colors.black26
                                            )),
                                          )
                                        ],
                                      ),
                                      margin: EdgeInsets.only(left: 15),
                                    )
                                  ],
                                ),
                                margin: EdgeInsets.only(top: 10, left: 20, right: 20),
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
                              ),
                            );
                          },
                        ),
                      ),
                    ) : Container()
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