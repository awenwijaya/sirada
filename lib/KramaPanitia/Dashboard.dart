import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:surat/KramaPanitia/DetailDesa/DetailDesa.dart';
import 'package:surat/KramaPanitia/SuratKeluarPanitia/TambahSuratKeluarPanitia.dart';
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
  var apiURLGetDataUser = "https://siradaskripsi.my.id/api/data/userdata/${loginPage.userId}";
  var apiURLGetDetailDesaById = "https://siradaskripsi.my.id/api/data/userdata/desa/${loginPage.desaId}";
  var apiURLGetDataSurat = "https://siradaskripsi.my.id/api/data/admin/surat/panitia/${loginPage.desaId}";

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
                    child: Text("Status Surat", style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 14,
                      fontWeight: FontWeight.bold
                    )),
                    margin: EdgeInsets.only(top: 20, left: 15)
                  ),
                  Container(
                    child: FlatButton(
                      onPressed: (){
                        Navigator.push(context, CupertinoPageRoute(builder: (context) => tambahSuratKeluarPanitia())).then((value) {
                          refreshListDibatalkan();
                          refreshListMenungguRespons();
                          refreshListSedangDiproses();
                          refreshListTelahDikonfirmasi();
                        });
                      },
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
                              length: 4,
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
                                              Icon(CupertinoIcons.time_solid),
                                              SizedBox(
                                                width: MediaQuery.of(context).size.width * 0.55,
                                                child: Text(
                                                  "Sedang Diproses", style: TextStyle(
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
                                                  "Telah Dikonfirmasi", style: TextStyle(
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
                                              Icon(Icons.close),
                                              SizedBox(
                                                width: MediaQuery.of(context).size.width * 0.55,
                                                child: Text(
                                                  "Dibatalkan", style: TextStyle(
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
                                  ),
                                  Container(
                                    height: MediaQuery.of(context).size.height * 0.56,
                                    decoration: BoxDecoration(
                                      border: Border(top: BorderSide(color: Colors.black26, width: 0.5))
                                    ),
                                    child: TabBarView(
                                      children: <Widget>[
                                        Container(
                                          child: Column(
                                            children: <Widget>[
                                              Container(
                                                child: TextField(
                                                  decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(50.0),
                                                      borderSide: BorderSide(color: HexColor("#025393"))
                                                    ),
                                                    hintText: "Cari surat keluar...",
                                                    suffixIcon: IconButton(
                                                      icon: Icon(Icons.search),
                                                      onPressed: (){},
                                                    )
                                                  ),
                                                  style: TextStyle(
                                                    fontFamily: "Poppins",
                                                    fontSize: 14
                                                  ),
                                                ),
                                                margin: EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 20),
                                              ),
                                              Container(
                                                child: LoadingMenungguRespons ? ListTileShimmer() : availableMenungguRespons ? SizedBox(
                                                  height: MediaQuery.of(context).size.height * 0.442,
                                                  child: RefreshIndicator(
                                                    onRefresh: refreshListMenungguRespons,
                                                    child: ListView.builder(
                                                      itemCount: MenungguRespons.length,
                                                      itemBuilder: (context, index) {
                                                        return GestureDetector(
                                                          onTap: (){},
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
                                                                            MenungguRespons[index]['parindikan'].toString(),
                                                                            style: TextStyle(
                                                                              fontFamily: "Poppins",
                                                                              fontSize: 16,
                                                                              fontWeight: FontWeight.w700,
                                                                              color: HexColor("#025393"),
                                                                            ),
                                                                            maxLines: 1,
                                                                            overflow: TextOverflow.ellipsis,
                                                                            softWrap: false,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        child: Text(MenungguRespons[index]['nomor_surat'].toString(), style: TextStyle(
                                                                          fontFamily: "Poppins",
                                                                          fontSize: 14
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
                                                  )
                                                ) : Container(
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: <Widget>[
                                                        Container(
                                                            child: Icon(
                                                                CupertinoIcons.mail_solid,
                                                                size: 50,
                                                                color: Colors.black26
                                                            )
                                                        ),
                                                        Container(
                                                            child: Text("Tidak ada Data Surat", style: TextStyle(
                                                                fontFamily: "Poppins",
                                                                fontSize: 18,
                                                                fontWeight: FontWeight.bold,
                                                                color: Colors.black26
                                                            ), textAlign: TextAlign.center),
                                                            margin: EdgeInsets.only(top: 10),
                                                            padding: EdgeInsets.symmetric(horizontal: 30)
                                                        ),
                                                        Container(
                                                            child: Text("Tidak ada data surat. Anda bisa menambahkannya dengan cara menekan tombol Tambah Data Surat dan isi data surat pada form yang telah disediakan", style: TextStyle(
                                                                fontFamily: "Poppins",
                                                                fontSize: 14,
                                                                color: Colors.black26
                                                            ), textAlign: TextAlign.center),
                                                            padding: EdgeInsets.symmetric(horizontal: 30),
                                                            margin: EdgeInsets.only(top: 10)
                                                        )
                                                      ],
                                                    )
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          child: Column(
                                            children: <Widget>[
                                              Container(
                                                child: TextField(
                                                  decoration: InputDecoration(
                                                      border: OutlineInputBorder(
                                                          borderRadius: BorderRadius.circular(50.0),
                                                          borderSide: BorderSide(color: HexColor("#025393"))
                                                      ),
                                                      hintText: "Cari surat keluar...",
                                                      suffixIcon: IconButton(
                                                        icon: Icon(Icons.search),
                                                        onPressed: (){},
                                                      )
                                                  ),
                                                  style: TextStyle(
                                                      fontFamily: "Poppins",
                                                      fontSize: 14
                                                  ),
                                                ),
                                                margin: EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 20),
                                              ),
                                              Container(
                                                child: LoadingSedangDiproses ? ListTileShimmer() : availableSedangDiproses ? SizedBox(
                                                    height: MediaQuery.of(context).size.height * 0.442,
                                                    child: RefreshIndicator(
                                                      onRefresh: refreshListSedangDiproses,
                                                      child: ListView.builder(
                                                        itemCount: SedangDiproses.length,
                                                        itemBuilder: (context, index) {
                                                          return GestureDetector(
                                                            onTap: (){},
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
                                                                              SedangDiproses[index]['parindikan'].toString(),
                                                                              style: TextStyle(
                                                                                fontFamily: "Poppins",
                                                                                fontSize: 16,
                                                                                fontWeight: FontWeight.w700,
                                                                                color: HexColor("#025393"),
                                                                              ),
                                                                              maxLines: 1,
                                                                              overflow: TextOverflow.ellipsis,
                                                                              softWrap: false,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          child: Text(SedangDiproses[index]['nomor_surat'].toString(), style: TextStyle(
                                                                              fontFamily: "Poppins",
                                                                              fontSize: 14
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
                                                    )
                                                ) : Container(
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: <Widget>[
                                                        Container(
                                                            child: Icon(
                                                                CupertinoIcons.mail_solid,
                                                                size: 50,
                                                                color: Colors.black26
                                                            )
                                                        ),
                                                        Container(
                                                            child: Text("Tidak ada Data Surat", style: TextStyle(
                                                                fontFamily: "Poppins",
                                                                fontSize: 18,
                                                                fontWeight: FontWeight.bold,
                                                                color: Colors.black26
                                                            ), textAlign: TextAlign.center),
                                                            margin: EdgeInsets.only(top: 10),
                                                            padding: EdgeInsets.symmetric(horizontal: 30)
                                                        ),
                                                      ],
                                                    )
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          child: Column(
                                            children: <Widget>[
                                              Container(
                                                child: TextField(
                                                  decoration: InputDecoration(
                                                      border: OutlineInputBorder(
                                                          borderRadius: BorderRadius.circular(50.0),
                                                          borderSide: BorderSide(color: HexColor("#025393"))
                                                      ),
                                                      hintText: "Cari surat keluar...",
                                                      suffixIcon: IconButton(
                                                        icon: Icon(Icons.search),
                                                        onPressed: (){},
                                                      )
                                                  ),
                                                  style: TextStyle(
                                                      fontFamily: "Poppins",
                                                      fontSize: 14
                                                  ),
                                                ),
                                                margin: EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 20),
                                              ),
                                              Container(
                                                child: LoadingTelahDikonfirmasi ? ListTileShimmer() : availableTelahDikonfirmasi ? SizedBox(
                                                    height: MediaQuery.of(context).size.height * 0.442,
                                                    child: RefreshIndicator(
                                                      onRefresh: refreshListTelahDikonfirmasi,
                                                      child: ListView.builder(
                                                        itemCount: TelahDikonfirmasi.length,
                                                        itemBuilder: (context, index) {
                                                          return GestureDetector(
                                                            onTap: (){},
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
                                                                              TelahDikonfirmasi[index]['parindikan'].toString(),
                                                                              style: TextStyle(
                                                                                fontFamily: "Poppins",
                                                                                fontSize: 16,
                                                                                fontWeight: FontWeight.w700,
                                                                                color: HexColor("#025393"),
                                                                              ),
                                                                              maxLines: 1,
                                                                              overflow: TextOverflow.ellipsis,
                                                                              softWrap: false,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          child: Text(TelahDikonfirmasi[index]['nomor_surat'].toString(), style: TextStyle(
                                                                              fontFamily: "Poppins",
                                                                              fontSize: 14
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
                                                    )
                                                ) : Container(
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: <Widget>[
                                                        Container(
                                                            child: Icon(
                                                                CupertinoIcons.mail_solid,
                                                                size: 50,
                                                                color: Colors.black26
                                                            )
                                                        ),
                                                        Container(
                                                            child: Text("Tidak ada Data Surat", style: TextStyle(
                                                                fontFamily: "Poppins",
                                                                fontSize: 18,
                                                                fontWeight: FontWeight.bold,
                                                                color: Colors.black26
                                                            ), textAlign: TextAlign.center),
                                                            margin: EdgeInsets.only(top: 10),
                                                            padding: EdgeInsets.symmetric(horizontal: 30)
                                                        ),
                                                      ],
                                                    )
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          child: Column(
                                            children: <Widget>[
                                              Container(
                                                child: TextField(
                                                  decoration: InputDecoration(
                                                      border: OutlineInputBorder(
                                                          borderRadius: BorderRadius.circular(50.0),
                                                          borderSide: BorderSide(color: HexColor("#025393"))
                                                      ),
                                                      hintText: "Cari surat keluar...",
                                                      suffixIcon: IconButton(
                                                        icon: Icon(Icons.search),
                                                        onPressed: (){},
                                                      )
                                                  ),
                                                  style: TextStyle(
                                                      fontFamily: "Poppins",
                                                      fontSize: 14
                                                  ),
                                                ),
                                                margin: EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 20),
                                              ),
                                              Container(
                                                child: LoadingDibatalkan ? ListTileShimmer() : availableDibatalkan ? SizedBox(
                                                    height: MediaQuery.of(context).size.height * 0.442,
                                                    child: RefreshIndicator(
                                                      onRefresh: refreshListDibatalkan,
                                                      child: ListView.builder(
                                                        itemCount: Dibatalkan.length,
                                                        itemBuilder: (context, index) {
                                                          return GestureDetector(
                                                            onTap: (){},
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
                                                                              Dibatalkan[index]['parindikan'].toString(),
                                                                              style: TextStyle(
                                                                                fontFamily: "Poppins",
                                                                                fontSize: 16,
                                                                                fontWeight: FontWeight.w700,
                                                                                color: HexColor("#025393"),
                                                                              ),
                                                                              maxLines: 1,
                                                                              overflow: TextOverflow.ellipsis,
                                                                              softWrap: false,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          child: Text(Dibatalkan[index]['nomor_surat'].toString(), style: TextStyle(
                                                                              fontFamily: "Poppins",
                                                                              fontSize: 14
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
                                                    )
                                                ) : Container(
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: <Widget>[
                                                        Container(
                                                            child: Icon(
                                                                CupertinoIcons.mail_solid,
                                                                size: 50,
                                                                color: Colors.black26
                                                            )
                                                        ),
                                                        Container(
                                                            child: Text("Tidak ada Data Surat", style: TextStyle(
                                                                fontFamily: "Poppins",
                                                                fontSize: 18,
                                                                fontWeight: FontWeight.bold,
                                                                color: Colors.black26
                                                            ), textAlign: TextAlign.center),
                                                            margin: EdgeInsets.only(top: 10),
                                                            padding: EdgeInsets.symmetric(horizontal: 30)
                                                        ),
                                                      ],
                                                    )
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