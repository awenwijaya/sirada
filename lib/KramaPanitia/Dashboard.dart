import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:surat/KramaPanitia/AgendaAcara/AgendaAcara.dart';
import 'package:surat/KramaPanitia/DetailDesa/DetailDesa.dart';
import 'package:surat/KramaPanitia/Profile/UserProfile.dart';
import 'package:surat/KramaPanitia/SuratDiterima/SuratDiterima.dart';
import 'package:surat/KramaPanitia/SuratKeluarPanitia/DetailSurat.dart';
import 'package:surat/KramaPanitia/SuratKeluarPanitia/PermintaanVerifikasiSuratKeluar.dart';
import 'package:surat/KramaPanitia/SuratKeluarPanitia/SuratKeluarPanitia.dart';
import 'package:surat/KramaPanitia/SuratKeluarPanitia/TambahSuratKeluarPanitia.dart';
import 'package:surat/LoginAndRegistration/LoginPage.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:surat/main.dart';

class dashboardKramaPanitia extends StatefulWidget {
  static var logoDesa;
  static var namaDesaAdat;
  const dashboardKramaPanitia({Key key}) : super(key: key);

  @override
  State<dashboardKramaPanitia> createState() => _dashboardKramaPanitiaState();
}

class _dashboardKramaPanitiaState extends State<dashboardKramaPanitia> {
  var profilePicture;
  var nama;
  var namaDesa;
  var countBelumDivalidasi = 0;
  var apiURLGetDataUser = "https://siradaskripsi.my.id/api/data/userdata/${loginPage.userId}";
  var apiURLGetDetailDesaById = "https://siradaskripsi.my.id/api/data/userdata/desa/${loginPage.desaId}";
  var apiURLGetDataSurat = "https://siradaskripsi.my.id/api/data/admin/surat/panitia/${loginPage.kramaId}";
  var apiURLCountBelumDivalidasi = "https://siradaskripsi.my.id/api/data/admin/surat/validasi/panitia/count/${loginPage.kramaId}";

  //list
  List MenungguRespons = [];
  List SedangDiproses = [];
  List TelahDikonfirmasi = [];
  List Dibatalkan = [];

  //bool
  bool LoadingMenungguRespons = true;
  bool LoadingSedangDiproses = true;
  bool LoadingTelahDikonfirmasi = true;
  bool LoadingDibatalkan = true;
  bool availableMenungguRespons = false;
  bool availableSedangDiproses = false;
  bool availableTelahDikonfirmasi = false;
  bool availableDibatalkan = false;

  Future refreshListMenungguRespons() async {
    var body = jsonEncode({
      "status" : "Menunggu Respon"
    });
    http.post(Uri.parse(apiURLGetDataSurat),
      headers: {"Content-Type" : "application/json"},
      body: body
    ).then((http.Response response) async {
      print(response.statusCode);
      if(response.statusCode == 200) {
        var data = json.decode(response.body);
        setState(() {
          LoadingMenungguRespons = false;
          availableMenungguRespons = true;
          MenungguRespons = data;
        });
      }else {
        LoadingMenungguRespons = false;
        availableMenungguRespons = false;
      }
    });
  }

  Future refreshListSedangDiproses() async {
    var body = jsonEncode({
      "status" : "Sedang Diproses"
    });
    http.post(Uri.parse(apiURLGetDataSurat),
        headers: {"Content-Type" : "application/json"},
        body: body
    ).then((http.Response response) async {
      if(response.statusCode == 200) {
        var data = json.decode(response.body);
        setState(() {
          LoadingSedangDiproses = false;
          availableSedangDiproses = true;
          SedangDiproses = data;
        });
      }else {
        LoadingSedangDiproses = false;
        availableSedangDiproses = false;
      }
    });
  }

  Future refreshListTelahDikonfirmasi() async {
    var body = jsonEncode({
      "status" : "Telah Dikonfirmasi"
    });
    http.post(Uri.parse(apiURLGetDataSurat),
        headers: {"Content-Type" : "application/json"},
        body: body
    ).then((http.Response response) async {
      if(response.statusCode == 200) {
        var data = json.decode(response.body);
        setState(() {
          LoadingTelahDikonfirmasi = false;
          availableTelahDikonfirmasi = true;
          TelahDikonfirmasi = data;
        });
      }else {
        LoadingTelahDikonfirmasi = false;
        availableTelahDikonfirmasi = false;
      }
    });
  }

  Future refreshListDibatalkan() async {
    var body = jsonEncode({
      "status" : "Dibatalkan"
    });
    http.post(Uri.parse(apiURLGetDataSurat),
        headers: {"Content-Type" : "application/json"},
        body: body
    ).then((http.Response response) async {
      if(response.statusCode == 200) {
        var data = json.decode(response.body);
        setState(() {
          LoadingDibatalkan = false;
          availableDibatalkan = true;
          Dibatalkan = data;
        });
      }else {
        LoadingDibatalkan = false;
        availableDibatalkan = false;
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

  getCountBelumDivalidasi() async {
    http.get(Uri.parse(apiURLCountBelumDivalidasi),
        headers: {"Content-Type" : "application/json"}
    ).then((http.Response response) {
      if(response.statusCode == 200) {
        var data = json.decode(response.body);
        setState(() {
          countBelumDivalidasi = data;
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
          dashboardKramaPanitia.namaDesaAdat = parsedJson['desadat_nama'];
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
    getCountBelumDivalidasi();
    refreshListDibatalkan();
    refreshListMenungguRespons();
    refreshListSedangDiproses();
    refreshListTelahDikonfirmasi();
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
                  color: Colors.white
              )),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.person_outline_rounded),
                  color: Colors.white,
                  onPressed: (){Navigator.push(context, CupertinoPageRoute(builder: (context) => kramaPanitiaProfile())).then((value) {
                    getUserInfo();
                  });},
                )
              ],
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
                            image: profilePicture == null ? AssetImage('images/profilepic.png') : NetworkImage('https://storage.siradaskripsi.my.id/img/profile/${profilePicture}'),
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
                                    image: dashboardKramaPanitia.logoDesa == null ? AssetImage('images/noimage.png') : NetworkImage('http://storage.siradaskripsi.my.id/img/logo-desa/${dashboardKramaPanitia.logoDesa}'),
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
                    child: Text("Manajemen Surat & Agenda", style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14,
                        fontWeight: FontWeight.w700
                    )),
                    margin: EdgeInsets.only(top: 20, left: 15),
                  ),
                  Container(
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(context, CupertinoPageRoute(builder: (context) => agendaAcaraPanitia()));
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
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(context, CupertinoPageRoute(builder: (context) => suratKeluarPanitiaKramaPanitia()));
                      },
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
                            child: Text("Manajemen Surat", style: TextStyle(
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
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, CupertinoPageRoute(builder: (context) => suratDiterimaPanitia()));
                        },
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Image.asset(
                                'images/penerima.png',
                                height: 40,
                                width: 40,
                              ),
                            ),
                            Container(
                              child: Text("Surat Diterima", style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700
                              )),
                              margin: EdgeInsets.only(left: 20),
                            )
                          ],
                        ),
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
                      )
                  ),
                  Container(
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, CupertinoPageRoute(builder: (context) => permintaanVerifikasiSuratKeluarPanitia()));
                        },
                        child: Stack(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    child: Image.asset(
                                      'images/validation.png',
                                      height: 40,
                                      width: 40,
                                    ),
                                  ),
                                  Container(
                                    child: Text("Permintaan Verifikasi Surat", style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700
                                    )),
                                    margin: EdgeInsets.only(left: 20),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              child: countBelumDivalidasi == 0 ? Container() : Container(
                                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(50)
                                ),
                                constraints: BoxConstraints(
                                    minWidth: 12,
                                    minHeight: 12
                                ),
                                child: Text(countBelumDivalidasi.toString(), style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold
                                )),
                              ),
                            )
                          ]
                        )
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
                      )
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}