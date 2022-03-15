import 'dart:convert';
import 'package:surat/AdminDesa/ManajemenStaff/ManajemenPrajuruBanjarAdat/DetailPrajuruBanjarAdat.dart';
import 'package:surat/AdminDesa/ManajemenStaff/ManajemenPrajuruBanjarAdat/EditPrajuruBanjarAdat.dart';
import 'package:surat/AdminDesa/ManajemenStaff/ManajemenPrajuruBanjarAdat/TambahPrajuruBanjarAdat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:surat/LoginAndRegistration/LoginPage.dart';

class prajuruBanjarAdatAdmin extends StatefulWidget {
  const prajuruBanjarAdatAdmin({Key key}) : super(key: key);

  @override
  _prajuruBanjarAdatAdminState createState() => _prajuruBanjarAdatAdminState();
}

class _prajuruBanjarAdatAdminState extends State<prajuruBanjarAdatAdmin> {
  var prajuruBanjarAdatIDAktif = [];
  var namaPrajuruAktif = [];
  var namaBanjarAktif = [];
  var jabatanAktif = [];
  var pendudukIdAktif = [];
  var prajuruBanjarAdatIDTidakAktif = [];
  var namaPrajuruTidakAktif = [];
  var namaBanjarTidakAktif = [];
  var jabatanTidakAktif = [];
  var pendudukIdTidakAktif = [];
  bool LoadingAktif = true;
  bool LoadingTidakAktif = true;
  bool LoadingProses = false;
  bool availableDataTidakAktif = false;
  bool availableDataAktif = false;
  var selectedIdPrajuruBanjarAdat;
  var selectedIdPenduduk;
  var apiURLShowListPrajuruBanjarAdatAktif = "http://192.168.18.10:8000/api/data/staff/prajuru_banjar_adat/aktif/${loginPage.desaId}";
  var apiURLShowListPrajuruBanjarAdatTidakAktif = "http://192.168.18.10:8000/api/data/staff/prajuru_banjar_adat/tidak_aktif/${loginPage.desaId}";

  Future refreshListPrajuruBanjarAdatAktif() async {
    Uri uri = Uri.parse(apiURLShowListPrajuruBanjarAdatAktif);
    final response = await http.get(uri);
    if(response.statusCode == 200) {
      var data = json.decode(response.body);
      this.prajuruBanjarAdatIDAktif = [];
      this.namaPrajuruAktif = [];
      this.jabatanAktif = [];
      this.namaBanjarAktif = [];
      this.pendudukIdAktif = [];
      setState(() {
        LoadingAktif = false;
        availableDataAktif = true;
        for(var i = 0; i < data.length; i++) {
          this.prajuruBanjarAdatIDAktif.add(data[i]['prajuru_banjar_adat_id']);
          this.namaPrajuruAktif.add(data[i]['nama']);
          this.jabatanAktif.add(data[i]['jabatan']);
          this.namaBanjarAktif.add(data[i]['nama_banjar_adat']);
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

  Future refreshListPrajuruBanjarAdatTidakAktif() async {
    Uri uri = Uri.parse(apiURLShowListPrajuruBanjarAdatTidakAktif);
    final response = await http.get(uri);
    if(response.statusCode == 200) {
      var data = json.decode(response.body);
      this.prajuruBanjarAdatIDTidakAktif = [];
      this.namaPrajuruTidakAktif = [];
      this.jabatanTidakAktif = [];
      this.namaBanjarTidakAktif = [];
      this.pendudukIdTidakAktif = [];
      setState(() {
        LoadingAktif = false;
        availableDataAktif = true;
        for(var i = 0; i < data.length; i++) {
          this.prajuruBanjarAdatIDTidakAktif.add(data[i]['prajuru_banjar_adat_id']);
          this.namaPrajuruTidakAktif.add(data[i]['nama']);
          this.jabatanTidakAktif.add(data[i]['jabatan']);
          this.namaBanjarTidakAktif.add(data[i]['nama_banjar_adat']);
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
    refreshListPrajuruBanjarAdatAktif();
    refreshListPrajuruBanjarAdatTidakAktif();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: HexColor("#025393"),
            onPressed: (){
              Navigator.of(context).pop();
            },
          ),
          title: Text("Pegawai Banjar Adat", style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w700,
            color: HexColor("#025393")
          ))
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: Image.asset(
                  'images/staff.png',
                  height: 100,
                  width: 100
                ),
                margin: EdgeInsets.only(top: 20)
              ),
              Container(
                child: FlatButton(
                  onPressed: (){
                    Navigator.push(context, CupertinoPageRoute(builder: (context) => tambahPrajuruBanjarAdatAdmin())).then((value) {
                      refreshListPrajuruBanjarAdatAktif();
                      refreshListPrajuruBanjarAdatTidakAktif();
                    });
                  },
                  child: Text("Tambah Data Pegawai", style: TextStyle(
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
                  padding: EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50)
                ),
                margin: EdgeInsets.only(top: 20)
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text("Data Pegawai Banjar Adat", style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14,
                  fontWeight: FontWeight.w700
                )),
                margin: EdgeInsets.only(top: 20, left: 15, bottom: 20)
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    DefaultTabController(
                      length: 2,
                      initialIndex: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                              child: TabBar(
                                labelColor: HexColor("#025393"),
                                unselectedLabelColor: Colors.black,
                                tabs: [
                                  Tab(child: Text("Aktif", style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w700
                                  ))),
                                  Tab(child: Text("Tidak Aktif", style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w700
                                  )))
                                ],
                              )
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.5,
                            decoration: BoxDecoration(
                              border: Border(top: BorderSide(color: Colors.black26, width: 0.5))
                            ),
                            child: TabBarView(
                              children: <Widget>[
                                Container(
                                  child: LoadingAktif ? Center(
                                      child: Lottie.asset('assets/loading-circle.json')
                                  ) : availableDataAktif ? RefreshIndicator(
                                      onRefresh: refreshListPrajuruBanjarAdatAktif,
                                      child: ListView.builder(
                                          itemCount: prajuruBanjarAdatIDAktif.length,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                                onTap: (){
                                                  setState(() {
                                                    detailPrajuruBanjarAdatAdmin.prajuruBanjarAdatId = prajuruBanjarAdatIDAktif[index];
                                                  });
                                                  Navigator.push(context, CupertinoPageRoute(builder: (context) => detailPrajuruBanjarAdatAdmin()));
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
                                                                                  child: Text("${namaPrajuruAktif[index]}", style: TextStyle(
                                                                                      fontFamily: "Poppins",
                                                                                      fontSize: 16,
                                                                                      fontWeight: FontWeight.w700,
                                                                                      color: HexColor("#025393")
                                                                                  ))
                                                                              ),
                                                                              Container(
                                                                                  child: Text("${jabatanAktif[index]}", style: TextStyle(
                                                                                      fontFamily: "Poppins",
                                                                                      fontSize: 14,
                                                                                      fontWeight: FontWeight.w700
                                                                                  ))
                                                                              ),
                                                                              Container(
                                                                                  child: Text("Banjar: ${namaBanjarAktif[index]}", style: TextStyle(
                                                                                      fontFamily: "Poppins",
                                                                                      fontSize: 14,
                                                                                      fontWeight: FontWeight.w700
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
                                                                    selectedIdPrajuruBanjarAdat = prajuruBanjarAdatIDAktif[index];
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
                                                                      value: 0,
                                                                      child: Row(
                                                                          children: <Widget>[
                                                                            Container(
                                                                                child: Icon(
                                                                                    Icons.delete,
                                                                                    color: HexColor("#025393")
                                                                                )
                                                                            ),
                                                                            Container(
                                                                                child: Text("Hapus", style: TextStyle(
                                                                                    fontFamily: "Poppins",
                                                                                    fontSize: 14
                                                                                )),
                                                                                margin: EdgeInsets.only(left: 10)
                                                                            )
                                                                          ]
                                                                      )
                                                                  ),
                                                                  PopupMenuItem<int>(
                                                                      value: 0,
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
                                                                  ),
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
                                                    )
                                                )
                                            );
                                          }
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
                                                    child: Text("Tidak ada Data Pegawai Banjar Adat", style: TextStyle(
                                                        fontFamily: "Poppins",
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.w700,
                                                        color: Colors.black26
                                                    ), textAlign: TextAlign.center),
                                                    margin: EdgeInsets.only(top: 10)
                                                ),
                                                Container(
                                                    child: Text("Tidak ada data pegawai Banjar Adat. Anda bisa menambahkannya dengan cara menekan tombol + dan isi data pegawai Banjar Adat pada form yang telah disediakan", style: TextStyle(
                                                        fontFamily: "Poppins",
                                                        fontSize: 14,
                                                        color: Colors.black26
                                                    ), textAlign: TextAlign.center),
                                                    padding: EdgeInsets.symmetric(horizontal: 30),
                                                    margin: EdgeInsets.only(top: 10)
                                                )
                                              ]
                                          )
                                      ),
                                      alignment: Alignment(0.0, 0.0)
                                  ),
                                ),
                                Container(
                                  child: LoadingTidakAktif ? Center(
                                      child: Lottie.asset('assets/loading-circle.json')
                                  ) : availableDataTidakAktif ? RefreshIndicator(
                                      onRefresh: refreshListPrajuruBanjarAdatTidakAktif,
                                      child: ListView.builder(
                                          itemCount: prajuruBanjarAdatIDTidakAktif.length,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                                onTap: (){
                                                  setState(() {
                                                    detailPrajuruBanjarAdatAdmin.prajuruBanjarAdatId = prajuruBanjarAdatIDTidakAktif[index];
                                                  });
                                                  Navigator.push(context, CupertinoPageRoute(builder: (context) => detailPrajuruBanjarAdatAdmin()));
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
                                                                                  child: Text("${namaPrajuruTidakAktif[index]}", style: TextStyle(
                                                                                      fontFamily: "Poppins",
                                                                                      fontSize: 16,
                                                                                      fontWeight: FontWeight.w700,
                                                                                      color: HexColor("#025393")
                                                                                  ))
                                                                              ),
                                                                              Container(
                                                                                  child: Text("${jabatanTidakAktif[index]}", style: TextStyle(
                                                                                      fontFamily: "Poppins",
                                                                                      fontSize: 14,
                                                                                      fontWeight: FontWeight.w700
                                                                                  ))
                                                                              ),
                                                                              Container(
                                                                                  child: Text("Banjar: ${namaBanjarTidakAktif[index]}", style: TextStyle(
                                                                                      fontFamily: "Poppins",
                                                                                      fontSize: 14,
                                                                                      fontWeight: FontWeight.w700
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
                                                                      selectedIdPrajuruBanjarAdat = prajuruBanjarAdatIDAktif[index];
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
                                                                                      Icons.delete,
                                                                                      color: HexColor("#025393")
                                                                                  )
                                                                              ),
                                                                              Container(
                                                                                  child: Text("Hapus", style: TextStyle(
                                                                                      fontFamily: "Poppins",
                                                                                      fontSize: 14
                                                                                  )),
                                                                                  margin: EdgeInsets.only(left: 10)
                                                                              )
                                                                            ]
                                                                        )
                                                                    ),
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
                                                    )
                                                )
                                            );
                                          }
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
                                                    margin: EdgeInsets.only(top: 10)
                                                )
                                              ]
                                          )
                                      ),
                                      alignment: Alignment(0.0, 0.0)
                                  ),
                                )
                              ]
                            )
                          )
                        ]
                      )
                    )
                  ]
                )
              )
            ]
          )
        )
      )
    );
  }

  void onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        setState(() {
          editPrajuruBanjarAdatAdmin.idPegawai = selectedIdPrajuruBanjarAdat;
        });
        Navigator.push(context, CupertinoPageRoute(builder: (context) => editPrajuruBanjarAdatAdmin())).then((value) {
          refreshListPrajuruBanjarAdatAktif();
          refreshListPrajuruBanjarAdatTidakAktif();
        });
        break;
    }
  }
}