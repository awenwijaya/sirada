import 'dart:convert';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:surat/AdminDesa/ManajemenStaff/ManajemenPrajuruDesaAdat/EditPrajuruDesaAdat.dart';
import 'package:surat/AdminDesa/ManajemenStaff/ManajemenPrajuruDesaAdat/TambahPrajuruDesaAdat.dart';
import 'package:surat/LoginAndRegistration/LoginPage.dart';
import 'package:surat/AdminDesa/ManajemenStaff/ManajemenPrajuruDesaAdat/DetailPrajuruDesaAdat.dart';

class prajuruDesaAdatAdmin extends StatefulWidget {
  const prajuruDesaAdatAdmin({Key key}) : super(key: key);

  @override
  _prajuruDesaAdatAdminState createState() => _prajuruDesaAdatAdminState();
}

class _prajuruDesaAdatAdminState extends State<prajuruDesaAdatAdmin> {
  var prajuruDesaAdatIDAktif = [];
  var jabatanAktif = [];
  var namaPrajuruAktif = [];
  var pendudukIdAktif = [];
  var prajuruDesaAdatIDTidakAktif = [];
  var jabatanTidakAktif = [];
  var namaPrajuruTidakAktif = [];
  var pendudukIdTidakAktif = [];
  bool LoadingAktif = true;
  bool LoadingTidakAktif = true;
  bool LoadingProses = false;
  bool availableDataAktif = false;
  bool availableDataTidakAktif = false;
  var selectedIdPrajuruDesaAdat;
  var selectedIdPenduduk;
  var apiURLShowListPrajuruDesaAdatAktif = "https://siradaskripsi.my.id/api/data/staff/prajuru_desa_adat/aktif/${loginPage.desaId}";
  var apiURLShowListPrajuruDesaAdatTidakAktif = "https://siradaskripsi.my.id/api/data/staff/prajuru_desa_adat/tidak_aktif/${loginPage.desaId}";
  var apiURLDeletePrajuruDesaAdat = "https://siradaskripsi.my.id/api/admin/prajuru/desa_adat/delete";
  var apiURLSetPrajuruTidakAktif = "https://siradaskripsi.my.id/api/admin/prajuru/desa_adat/set_tidak_aktif";
  FToast ftoast;
  final controllerSearchAktif = TextEditingController();
  final controllerSearchTidakAktif = TextEditingController();

  //search
  bool isSearch = false;
  var apiURLSearchAktif = "https://siradaskripsi.my.id/api/admin/staff/prajuru_desa_adat/aktif/${loginPage.desaId}/search";

  //search tidak aktif
  bool isSearchTidakAktif = false;
  var apiURLSearchTidakAktif = "https://siradaskripsi.my.id/api/admin/staff/prajuru_desa_adat/tidak_aktif/${loginPage.desaId}/search";

  Future refreshListPrajuruDesaAdatAktif() async {
    Uri uri = Uri.parse(apiURLShowListPrajuruDesaAdatAktif);
    final response = await http.get(uri);
    if(response.statusCode == 200) {
      var data = json.decode(response.body);
      this.prajuruDesaAdatIDAktif = [];
      this.jabatanAktif = [];
      this.namaPrajuruAktif = [];
      this.pendudukIdAktif = [];
      setState(() {
        LoadingAktif = false;
        availableDataAktif = true;
        for(var i = 0; i < data.length; i++) {
          this.prajuruDesaAdatIDAktif.add(data[i]['prajuru_desa_adat_id']);
          this.jabatanAktif.add(data[i]['jabatan']);
          this.namaPrajuruAktif.add(data[i]['nama']);
          this.pendudukIdAktif.add(data[i]['penduduk_id']);
        }
      });
    }else{
      setState(() {
        LoadingAktif = false;
        availableDataAktif = false;
      });
    }
  }

  Future refreshListSearchPrajuruDesaAdatAktif() async {
    setState(() {
      LoadingAktif = true;
      isSearch = true;
    });
    var body = jsonEncode({
      "search_query" : controllerSearchAktif.text
    });
    http.post(Uri.parse(apiURLSearchAktif),
        headers: {"Content-Type" : "application/json"},
        body: body
    ).then((http.Response response) async {
      var statusCode = response.statusCode;
      if(statusCode == 200) {
        var data = json.decode(response.body);
        this.prajuruDesaAdatIDAktif = [];
        this.jabatanAktif = [];
        this.namaPrajuruAktif = [];
        this.pendudukIdAktif = [];
        setState(() {
          LoadingAktif = false;
          availableDataAktif = true;
          for(var i = 0; i < data.length; i++) {
            this.prajuruDesaAdatIDAktif.add(data[i]['prajuru_desa_adat_id']);
            this.jabatanAktif.add(data[i]['jabatan']);
            this.namaPrajuruAktif.add(data[i]['nama']);
            this.pendudukIdAktif.add(data[i]['penduduk_id']);
          }
        });
      }else {
        setState(() {
          LoadingAktif = false;
          availableDataAktif = false;
        });
      }
    });
  }

  Future refreshListSearchPrajuruDesaAdatTidakAktif() async {
    setState(() {
      LoadingTidakAktif = true;
      isSearchTidakAktif = true;
    });
    var body = jsonEncode({
      "search_query" : controllerSearchTidakAktif.text
    });
    http.post(Uri.parse(apiURLSearchTidakAktif),
        headers: {"Content-Type" : "application/json"},
        body: body
    ).then((http.Response response) async {
      var statusCode = response.statusCode;
      if(statusCode == 200) {
        var data = json.decode(response.body);
        this.prajuruDesaAdatIDTidakAktif = [];
        this.jabatanTidakAktif = [];
        this.namaPrajuruTidakAktif = [];
        this.pendudukIdTidakAktif = [];
        setState(() {
          LoadingTidakAktif = false;
          availableDataTidakAktif = true;
          for(var i = 0; i < data.length; i++) {
            this.prajuruDesaAdatIDTidakAktif.add(data[i]['prajuru_desa_adat_id']);
            this.jabatanTidakAktif.add(data[i]['jabatan']);
            this.namaPrajuruTidakAktif.add(data[i]['nama']);
            this.pendudukIdTidakAktif.add(data[i]['penduduk_id']);
          }
        });
      }else {
        setState(() {
          LoadingTidakAktif = false;
          availableDataTidakAktif = false;
        });
      }
    });
  }

  Future refreshListPrajuruDesaAdatTidakAktif() async {
    Uri uri = Uri.parse(apiURLShowListPrajuruDesaAdatTidakAktif);
    final response = await http.get(uri);
    if(response.statusCode == 200) {
      var data = json.decode(response.body);
      this.prajuruDesaAdatIDTidakAktif = [];
      this.jabatanTidakAktif = [];
      this.namaPrajuruTidakAktif = [];
      this.pendudukIdTidakAktif = [];
      setState(() {
        LoadingTidakAktif = false;
        availableDataTidakAktif = true;
        for(var i = 0; i < data.length; i++) {
          this.prajuruDesaAdatIDTidakAktif.add(data[i]['prajuru_desa_adat_id']);
          this.jabatanTidakAktif.add(data[i]['jabatan']);
          this.namaPrajuruTidakAktif.add(data[i]['nama']);
          this.pendudukIdTidakAktif.add(data[i]['penduduk_id']);
        }
      });
    }else{
      setState(() {
        LoadingTidakAktif = false;
        availableDataTidakAktif = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ftoast = FToast();
    ftoast.init(context);
    refreshListPrajuruDesaAdatAktif();
    refreshListPrajuruDesaAdatTidakAktif();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              color: HexColor("#025393"),
              onPressed: (){
                Navigator.of(context).pop();
              },
            ),
            title: Text("Prajuru Desa Adat", style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.w700,
                color: HexColor("#025393")
            )),
            bottom: TabBar(
              labelColor: HexColor("#025393"),
              unselectedLabelColor: Colors.black,
              tabs: [
                Tab(child: Column(
                  children: <Widget>[
                    Icon(Icons.done, color: HexColor("228B22")),
                    Text("Aktif", style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w700
                    ))
                  ],
                )),
                Tab(child: Column(
                  children: <Widget>[
                    Icon(Icons.close, color: HexColor("990000")),
                    Text("Tidak Aktif", style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w700
                    ))
                  ],
                ))
              ],
            )
          ),
            body: TabBarView(
              children: <Widget>[
                Expanded(
                    child: Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                                child: TextField(
                                  controller: controllerSearchAktif,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(50.0),
                                          borderSide: BorderSide(color: HexColor("#025393"))
                                      ),
                                      hintText: "Cari nama atau jabatan Prajuru Desa Adat...",
                                      suffixIcon: isSearch ? IconButton(
                                        icon: Icon(Icons.close),
                                        onPressed: (){
                                          setState(() {
                                            LoadingAktif = true;
                                            controllerSearchAktif.text = "";
                                            isSearch = false;
                                            refreshListPrajuruDesaAdatAktif();
                                          });
                                        },
                                      ) : IconButton(
                                        icon: Icon(Icons.search),
                                        onPressed: (){
                                          if(controllerSearchAktif.text != "") {
                                            setState(() {
                                              isSearch = true;
                                            });
                                            refreshListSearchPrajuruDesaAdatAktif();
                                          }
                                        },
                                      )
                                  ),
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 14
                                  ),
                                ),
                                margin: EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 20)
                            ),
                            Container(
                                child: LoadingAktif ? ListTileShimmer() : availableDataAktif ? Expanded(
                                    flex: 1,
                                    child: RefreshIndicator(
                                        onRefresh: isSearch ? refreshListSearchPrajuruDesaAdatAktif : refreshListPrajuruDesaAdatAktif,
                                        child: ListView.builder(
                                            itemCount: prajuruDesaAdatIDAktif.length,
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                  onTap: (){
                                                    setState(() {
                                                      detailPrajuruDesaAdatAdmin.prajuruDesaAdatId = prajuruDesaAdatIDAktif[index];
                                                    });
                                                    Navigator.push(context, CupertinoPageRoute(builder: (context) => detailPrajuruDesaAdatAdmin()));
                                                  },
                                                  child: Container(
                                                    child: Stack(
                                                        children: <Widget>[
                                                          Container(
                                                              child: Row(
                                                                  children: <Widget>[
                                                                    Container(
                                                                        child: Image.asset(
                                                                            'images/person.png',
                                                                            height: 40,
                                                                            width: 40
                                                                        )
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
                                                                                          "${namaPrajuruAktif[index]}",
                                                                                          style: TextStyle(
                                                                                              fontFamily: "Poppins",
                                                                                              fontSize: 16,
                                                                                              fontWeight: FontWeight.w700,
                                                                                              color: HexColor("#025393")
                                                                                          ),
                                                                                          maxLines: 1,
                                                                                          overflow: TextOverflow.ellipsis,
                                                                                          softWrap: false
                                                                                      )
                                                                                  )
                                                                              ),
                                                                              Container(
                                                                                  child: Text("${jabatanAktif[index]}", style: TextStyle(
                                                                                      fontFamily: "Poppins",
                                                                                      fontSize: 14
                                                                                  ))
                                                                              )
                                                                            ]
                                                                        ),
                                                                        margin: EdgeInsets.only(left: 15)
                                                                    )
                                                                  ]
                                                              )
                                                          ),
                                                          Container(
                                                              alignment: Alignment.centerRight,
                                                              child: PopupMenuButton<int>(
                                                                  onSelected: (item) {
                                                                    setState(() {
                                                                      selectedIdPrajuruDesaAdat = prajuruDesaAdatIDAktif[index];
                                                                      selectedIdPenduduk = pendudukIdAktif[index];
                                                                    });
                                                                    onSelected(context, item);
                                                                  },
                                                                  itemBuilder: (context) => [
                                                                    PopupMenuItem<int>(
                                                                        value: 0,
                                                                        child: Row(
                                                                            children: <Widget>[
                                                                              Container(
                                                                                  child: Icon(
                                                                                      Icons.edit,
                                                                                      color: HexColor("#025393")
                                                                                  )
                                                                              ),
                                                                              Container(
                                                                                  child: Text("Edit", style: TextStyle(
                                                                                      fontFamily: "Poppins",
                                                                                      fontSize: 14
                                                                                  )),
                                                                                  margin: EdgeInsets.only(left: 10)
                                                                              )
                                                                            ]
                                                                        )
                                                                    ),
                                                                    PopupMenuItem<int>(
                                                                        value: 2,
                                                                        child: Row(
                                                                            children: <Widget>[
                                                                              Container(
                                                                                  child: Icon(
                                                                                      Icons.close,
                                                                                      color: HexColor("#025393")
                                                                                  )
                                                                              ),
                                                                              Container(
                                                                                  child: Text("Atur Menjadi Tidak Aktif", style: TextStyle(
                                                                                      fontFamily: "Poppins",
                                                                                      fontSize: 14
                                                                                  )),
                                                                                  margin: EdgeInsets.only(left: 10)
                                                                              )
                                                                            ]
                                                                        )
                                                                    )
                                                                  ]
                                                              )
                                                          )
                                                        ]
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
                                                  )
                                              );
                                            }
                                        )
                                    )
                                ) : Container(
                                    child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                              child: Icon(
                                                CupertinoIcons.person_alt,
                                                size: 50,
                                                color: Colors.black26,
                                              )
                                          ),
                                          Container(
                                            child: Text("Tidak ada Data Prajuru Desa Adat", style: TextStyle(
                                                fontFamily: "Poppins",
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black26
                                            ), textAlign: TextAlign.center),
                                            margin: EdgeInsets.only(top: 10),
                                            padding: EdgeInsets.symmetric(horizontal: 30),
                                          ),
                                          Container(
                                            child: Text("Tidak ada data prajuru desa adat. Anda bisa menambahkannya dengan cara menekan tombol Tambah Data Prajuru dan isi data pada form yang telah disediakan", style: TextStyle(
                                                fontFamily: "Poppins",
                                                fontSize: 14,
                                                color: Colors.black26
                                            ), textAlign: TextAlign.center),
                                            padding: EdgeInsets.symmetric(horizontal: 30),
                                            margin: EdgeInsets.only(top: 10),
                                          )
                                        ]
                                    )
                                )
                            )
                          ],
                        )
                    )
                ),
                Expanded(
                    child: Column(
                        children: <Widget>[
                          Container(
                            child: TextField(
                              controller: controllerSearchTidakAktif,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50.0),
                                      borderSide: BorderSide(color: HexColor("#025393"))
                                  ),
                                  hintText: "Cari nama atau jabatan Prajuru Desa Adat...",
                                  suffixIcon: isSearchTidakAktif ? IconButton(
                                    icon: Icon(Icons.close),
                                    onPressed: (){
                                      setState(() {
                                        LoadingTidakAktif = true;
                                        controllerSearchTidakAktif.text = "";
                                        isSearchTidakAktif = false;
                                        refreshListPrajuruDesaAdatTidakAktif();
                                      });
                                    },
                                  ) : IconButton(
                                      icon: Icon(Icons.search),
                                      onPressed: (){
                                        if(controllerSearchTidakAktif.text != "") {
                                          setState(() {
                                            isSearchTidakAktif = true;
                                          });
                                          refreshListSearchPrajuruDesaAdatTidakAktif();
                                        }
                                      }
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
                              child: LoadingTidakAktif ? ListTileShimmer() : availableDataTidakAktif ? Expanded(
                                  flex: 1,
                                  child: RefreshIndicator(
                                      onRefresh: isSearchTidakAktif ? refreshListSearchPrajuruDesaAdatTidakAktif : refreshListPrajuruDesaAdatTidakAktif,
                                      child: ListView.builder(
                                          itemCount: prajuruDesaAdatIDTidakAktif.length,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                                onTap: (){
                                                  setState(() {
                                                    detailPrajuruDesaAdatAdmin.prajuruDesaAdatId = prajuruDesaAdatIDTidakAktif[index];
                                                  });
                                                  Navigator.push(context, CupertinoPageRoute(builder: (context) => detailPrajuruDesaAdatAdmin()));
                                                },
                                                child: Container(
                                                  child: Row(
                                                      children: <Widget>[
                                                        Container(
                                                            child: Image.asset(
                                                                'images/person.png',
                                                                height: 40,
                                                                width: 40
                                                            )
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
                                                                              "${namaPrajuruTidakAktif[index]}",
                                                                              style: TextStyle(
                                                                                  fontFamily: "Poppins",
                                                                                  fontSize: 16,
                                                                                  fontWeight: FontWeight.w700,
                                                                                  color: HexColor("#025393")
                                                                              ),
                                                                              maxLines: 1,
                                                                              overflow: TextOverflow.ellipsis,
                                                                              softWrap: false
                                                                          )
                                                                      )
                                                                  ),
                                                                  Container(
                                                                      child: Text("${jabatanTidakAktif[index]}", style: TextStyle(
                                                                          fontFamily: "Poppins",
                                                                          fontSize: 14
                                                                      ))
                                                                  )
                                                                ]
                                                            ),
                                                            margin: EdgeInsets.only(left: 15)
                                                        )
                                                      ]
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
                                                )
                                            );
                                          }
                                      )
                                  )
                              ) : Container(
                                  child: Center(
                                      child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                                child: Icon(
                                                    CupertinoIcons.person_alt,
                                                    size: 50,
                                                    color: Colors.black26
                                                )
                                            ),
                                            Container(
                                                child: Text("Tidak ada Data", style: TextStyle(
                                                    fontFamily: "Poppins",
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.black26
                                                ), textAlign: TextAlign.center),
                                                margin: EdgeInsets.only(top: 10),
                                                padding: EdgeInsets.symmetric(horizontal: 30)
                                            )
                                          ]
                                      )
                                  )
                              )
                          )
                        ]
                    )
                )
              ],
            ),
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              Navigator.push(context, CupertinoPageRoute(builder: (context) => tambahPrajuruDesaAdatAdmin())).then((value) {
                refreshListPrajuruDesaAdatAktif();
              });
            },
            child: Icon(Icons.add),
            backgroundColor: HexColor("#025393"),
          ),
        ),
      )
    );
  }

  void onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        setState(() {
          isSearch = false;
          isSearchTidakAktif = false;
          controllerSearchAktif.text = "";
          controllerSearchTidakAktif.text = "";
          editPrajuruDesaAdatAdmin.idPegawai = selectedIdPrajuruDesaAdat;
        });
        Navigator.push(context, CupertinoPageRoute(builder: (context) => editPrajuruDesaAdatAdmin())).then((value) {
          refreshListPrajuruDesaAdatAktif();
          refreshListPrajuruDesaAdatTidakAktif();
        });
        break;

      case 2:
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
                              'images/question.png',
                              height: 50,
                              width: 50,
                            )
                        ),
                        Container(
                            child: Text("Atur Prajuru Menjadi Tidak Aktif", style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: HexColor("#025393")
                            ), textAlign: TextAlign.center),
                            margin: EdgeInsets.only(top: 10)
                        ),
                        Container(
                          child: Text("Apakah Anda yakin ingin menonaktifkan prajuru ini? Setelah prajuru di non-aktifkan maka ia akan kehilangan hak akses login dan tindakan ini tidak dapat dikembalikan", style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 14
                          ), textAlign: TextAlign.center),
                          margin: EdgeInsets.only(top: 10),
                        )
                      ],
                    )
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: (){
                      var body = jsonEncode({
                        "prajuru_desa_adat_id" : selectedIdPrajuruDesaAdat,
                        "penduduk_id" : selectedIdPenduduk
                      });
                      http.post(Uri.parse(apiURLSetPrajuruTidakAktif),
                        headers: {"Content-Type" : "application/json"},
                        body: body
                      ).then((http.Response response) {
                        var responseValue = response.statusCode;
                        if(responseValue == 200) {
                          isSearch = false;
                          isSearchTidakAktif = false;
                          controllerSearchAktif.text = "";
                          controllerSearchTidakAktif.text = "";
                          refreshListPrajuruDesaAdatAktif();
                          refreshListPrajuruDesaAdatTidakAktif();
                          ftoast.showToast(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Colors.green
                              ),
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.done),
                                  Container(
                                    margin: EdgeInsets.only(left: 15),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.65,
                                      child: Text("Prajuru Desa Adat berhasil dinonaktifkan", style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white
                                      )),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            toastDuration: Duration(seconds: 3)
                          );
                          Navigator.of(context).pop();
                        }
                      });
                    },
                    child: Text("Ya", style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w700,
                        color: HexColor("#025393")
                    )),
                  ),
                  TextButton(
                      onPressed: (){Navigator.of(context).pop();},
                      child: Text("Tidak", style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w700,
                          color: HexColor("#025393")
                      ))
                  )
                ],
              );
            }
        );
        break;
    }
  }
}