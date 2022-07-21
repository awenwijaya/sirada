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
import 'package:surat/Penduduk/SuratDiterima/SuratDiterima.dart';
import 'package:surat/Penduduk/SuratPengumuman/DetailSurat.dart';
import 'package:surat/Penduduk/SuratPengumuman/DetailSuratPanitia.dart';
import 'package:surat/Penduduk/SuratPengumuman/SuratPengumuman.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surat/WelcomeScreen.dart';
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
  bool LoadingFilter = true;
  bool isFilter = false;
  var countSuratPanitia;
  final CarouselController controller = CarouselController();
  final controllerSearch = TextEditingController();
  int current = 0;
  var apiURLRemoveFCMToken = "https://siradaskripsi.my.id/api/autentikasi/login/token/remove";
  var apiURLGetDataUser = "https://siradaskripsi.my.id/api/data/userdata/${loginPage.userId}";
  var apiURLGetDetailDesaById = "https://siradaskripsi.my.id/api/data/userdata/desa/${loginPage.desaId}";
  var apiURLShowAllPengumuman = "https://siradaskripsi.my.id/api/krama/view/surat/all";
  var apiURLShowFilter = "https://siradaskripsi.my.id/api/admin/surat/keluar/filter/tahun_terbit/krama";
  var apiURLShowFilterResult = "https://siradaskripsi.my.id/api/krama/surat/filter/result";
  var apiURLShowPrajuruBanjarAdatId = "https://siradaskripsi.my.id/api/data/staff/prajuru/banjar/get/${loginPage.kramaId}";
  var selectedBulan;
  var selectedTahun;
  var prajuruId;

  List bulan = [
    {
      "value" : 1,
      "bulan" : "Januari"
    },
    {
      "value" : 2,
      "bulan" : "Februari"
    },
    {
      "value" : 3,
      "bulan" : "Maret"
    },
    {
      "value" : 4,
      "bulan" : "April"
    },
    {
      "value" : 5,
      "bulan" : "Mei"
    },
    {
      "value" : 6,
      "bulan" : "Juni"
    },
    {
      "value" : 7,
      "bulan" : "Juli"
    },
    {
      "value" : 8,
      "bulan" : "Agustus"
    },
    {
      "value" : 9,
      "bulan" : "September"
    },
    {
      "value" : 10,
      "bulan" : "Oktober"
    },
    {
      "value" : 11,
      "bulan" : "November"
    },
    {
      "value" : 12,
      "bulan" : "Desember"
    }
  ];
  List tahun = [];

  Future showFilterTahunTerbit() async {
    var body = jsonEncode({
      "desa_adat_id" : loginPage.desaId.toString()
    });
    http.post(Uri.parse(apiURLShowFilter),
      headers: {"Content-Type" : "application/json"},
      body: body
    ).then((http.Response response) {
      var responseValue = response.statusCode;
      if(responseValue == 200) {
        var jsonData = json.decode(response.body);
        this.tahun = [];
        setState(() {
          LoadingFilter = false;
          for(var i = 0; i < jsonData.length; i++) {
            this.tahun.add(jsonData[i]['tahun_terbit']);
          }
        });
      }
    });
  }

  Future getPrajuruBanjarAdatInfo() async {
    http.get(Uri.parse(apiURLShowPrajuruBanjarAdatId),
      headers: {"Content-Type" : "application/json"},
    ).then((http.Response response) {
      if(response.statusCode == 200) {
        var data = json.decode(response.body);
        setState(() {
          prajuruId = data['prajuru_banjar_adat_id'];
        });
        print(prajuruId.toString());
      }
    });
  }

  Future getFilterResult() async {
    setState(() {
      LoadingPengumuman = true;
      availablePengumuman = false;
      isFilter = true;
    });
    var body = jsonEncode({
      "bulan_filter" : selectedBulan == null ? null : selectedBulan,
      "tahun_filter" : selectedTahun == null ? null : selectedTahun,
      "search_query" : controllerSearch.text == "" ? null : controllerSearch.text,
      "user_id" : loginPage.userId,
      "desa_adat_id" : loginPage.desaId
    });
    http.post(Uri.parse(apiURLShowFilterResult),
      headers: {"Content-Type" : "application/json"},
      body: body
    ).then((http.Response response) async {
      var responseValue = response.statusCode;
      if(responseValue == 200) {
        var data = json.decode(response.body);
        print(data);
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
    showFilterTahunTerbit();
    getPrajuruBanjarAdatInfo();
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
                    onPressed: (){},
                  ),
                  IconButton(
                    icon: Icon(Icons.logout),
                    color: Colors.white,
                    onPressed: (){
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(40.0))
                              ),
                              content: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Container(
                                        child: Image.asset(
                                          'images/logout.png',
                                          height: 50,
                                          width: 50,
                                        ),
                                      ),
                                      Container(
                                          child: Text("Logout?", style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: HexColor("#025393")
                                          ), textAlign: TextAlign.center),
                                          margin: EdgeInsets.only(top: 10)
                                      ),
                                      Container(
                                          child: Text("Apakah Anda yakin ingin logout?", style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 14
                                          ), textAlign: TextAlign.center),
                                          margin: EdgeInsets.only(top: 10)
                                      )
                                    ],
                                  )
                              ),
                              actions: <Widget>[
                                TextButton(
                                    onPressed: () async {
                                      var body = jsonEncode({
                                        "token" : loginPage.token
                                      });
                                      http.post(Uri.parse(apiURLRemoveFCMToken),
                                          headers: {"Content-Type" : "application/json"},
                                          body: body
                                      ).then((http.Response response) async {
                                        var data = response.statusCode;
                                        if(data == 200) {
                                          final SharedPreferences sharedpref = await SharedPreferences.getInstance();
                                          sharedpref.remove('userId');
                                          sharedpref.remove('pendudukId');
                                          sharedpref.remove('desaId');
                                          sharedpref.remove('email');
                                          sharedpref.remove('role');
                                          sharedpref.remove('status');
                                          Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(builder: (context) => welcomeScreen()), (route) => false);
                                        }
                                      });
                                    },
                                    child: Text("Ya", style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w700,
                                        color: HexColor("#025393")
                                    ))
                                ),
                                TextButton(
                                  onPressed: (){Navigator.of(context).pop();},
                                  child: Text("Tidak", style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w700,
                                      color: HexColor("#025393")
                                  )),
                                )
                              ],
                            );
                          }
                      );
                    },
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
                          child: prajuruId == null ? Container() : Container(
                            child: GestureDetector(
                              onTap: (){
                                setState(() {
                                  suratDiterimaPrajuruBanjar.prajuruId = prajuruId;
                                });
                                Navigator.push(context, CupertinoPageRoute(builder: (context) => suratDiterimaPrajuruBanjar()));
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
                          )
                        ),
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
                            alignment: Alignment.topLeft,
                            child: Text("Agenda Acara", style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14,
                                fontWeight: FontWeight.bold
                            )),
                            margin: EdgeInsets.only(top: 10, left: 15)
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
                          child: TextField(
                            controller: controllerSearch,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50.0),
                                borderSide: BorderSide(color: HexColor("025393"))
                              ),
                              hintText: "Cari pengumuman...",
                              suffixIcon: IconButton(
                                icon: Icon(Icons.search),
                                onPressed: (){
                                  if(controllerSearch.text != "") {
                                    getFilterResult();
                                  }
                                },
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
                          child: LoadingFilter ? ListTileShimmer() : Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Flexible(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        border: Border.all(width: 1, color: Colors.black38)
                                    ),
                                    child: DropdownButton(
                                      isExpanded: true,
                                      hint: Center(
                                        child: Text("Semua Bulan", style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 14
                                        )),
                                      ),
                                      value: selectedBulan,
                                      underline: Container(),
                                      items: bulan.map((e) {
                                        return DropdownMenuItem(
                                          value: e['value'],
                                          child: Text(e['bulan'], style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 14
                                          )),
                                        );
                                      }).toList(),
                                      selectedItemBuilder: (BuildContext context) => bulan.map((e) => Center(
                                        child: Text(e['bulan'], style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 14
                                        )),
                                      )).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          selectedBulan = value;
                                        });
                                        getFilterResult();
                                      },
                                    ),
                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                  ),
                                ),
                                Flexible(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        border: Border.all(width: 1, color: Colors.black38)
                                    ),
                                    child: DropdownButton(
                                      isExpanded: true,
                                      hint: Center(
                                        child: Text("Semua Tahun", style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 14
                                        )),
                                      ),
                                      value: selectedTahun,
                                      underline: Container(),
                                      items: tahun.map((e) {
                                        return DropdownMenuItem(
                                          value: e,
                                          child: Text(e, style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 14
                                          )),
                                        );
                                      }).toList(),
                                      selectedItemBuilder: (BuildContext context) => tahun.map((e) => Center(
                                        child: Text(e, style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 14
                                        )),
                                      )).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          selectedTahun = value;
                                        });
                                        getFilterResult();
                                      },
                                    ),
                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                  ),
                                )
                              ],
                            ),
                          ),
                          margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                        ),
                        Container(
                          child: Column(
                            children: <Widget>[
                              if(isFilter == true) Container(
                                child: FlatButton(
                                  onPressed: (){
                                    setState(() {
                                      isFilter = false;
                                      selectedTahun = null;
                                      selectedBulan = null;
                                      controllerSearch.text = "";
                                      LoadingPengumuman = true;
                                    });
                                    getAllPengumuman();
                                  },
                                  child: Text("Hapus Filter", style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white
                                  )),
                                  color: HexColor("025393"),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                      side: BorderSide(color: HexColor("#025393"), width: 2)
                                  ),
                                ),
                                margin: EdgeInsets.only(top: 10),
                              )
                            ],
                          ),
                        ),
                        Container(
                            child: LoadingPengumuman ? ListTileShimmer() : availablePengumuman ? Wrap(
                              direction: Axis.horizontal,
                              children: <Widget>[
                                RefreshIndicator(
                                  onRefresh: isFilter ? getFilterResult : getAllPengumuman,
                                  child: ListView.builder(
                                    itemCount: pengumuman.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: (){
                                          if(pengumuman[index]['tim_kegiatan'] == null) {
                                            setState(() {
                                              detailSuratPrajuruKrama.suratKeluarId = pengumuman[index]['surat_keluar_id'];
                                              detailSuratPrajuruKrama.status = pengumuman[index]['status'];
                                              detailSuratPrajuruKrama.isTetujon = false;
                                            });
                                            Navigator.push(context, CupertinoPageRoute(builder: (context) => detailSuratPrajuruKrama())).then((value) {
                                              getAllPengumuman();
                                            });
                                          }else {
                                            setState(() {
                                              detailSuratKeluarPanitiaKrama.suratKeluarId = pengumuman[index]['surat_keluar_id'];
                                              detailSuratKeluarPanitiaKrama.status = pengumuman[index]['status'];
                                              detailSuratKeluarPanitiaKrama.isTetujon = false;
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
                                                  pengumuman[index]['status'] == "Belum Terbaca" ? "images/letter-closed.png" : "images/letter-open.png",
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
                              ],
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