import 'dart:convert';
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
  var apiURLShowListPrajuruDesaAdatAktif = "http://192.168.18.10:8000/api/data/staff/prajuru_desa_adat/aktif/${loginPage.desaId}";
  var apiURLShowListPrajuruDesaAdatTidakAktif = "http://192.168.18.10:8000/api/data/staff/prajuru_desa_adat/tidak_aktif/${loginPage.desaId}";
  var apiURLDeletePrajuruDesaAdat = "http://192.168.18.10:8000/api/admin/prajuru/desa_adat/delete";
  var apiURLSetPrajuruTidakAktif = "http://192.168.18.10:8000/api/admin/prajuru/desa_adat/set_tidak_aktif";

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
    refreshListPrajuruDesaAdatAktif();
    refreshListPrajuruDesaAdatTidakAktif();
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
          title: Text("Pegawai Desa Adat", style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w700,
            color: HexColor("#025393")
          )),
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
                    Navigator.push(context, CupertinoPageRoute(builder: (context) => tambahPrajuruDesaAdatAdmin())).then((value) {
                      refreshListPrajuruDesaAdatAktif();
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
                child: Text("Data Pegawai Desa Adat", style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14,
                  fontWeight: FontWeight.w700
                )),
                margin: EdgeInsets.only(top: 20, left: 15, bottom: 20),
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
                                      onRefresh: refreshListPrajuruDesaAdatAktif,
                                      child: ListView.builder(
                                          itemCount: prajuruDesaAdatIDAktif.length,
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
                                                                      value: 1,
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
                                            child: Text("Tidak ada Data Pegawai Desa Adat", style: TextStyle(
                                                fontFamily: "Poppins",
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black26
                                            ), textAlign: TextAlign.center),
                                            margin: EdgeInsets.only(top: 10),
                                            padding: EdgeInsets.symmetric(horizontal: 30),
                                          ),
                                          Container(
                                            child: Text("Tidak ada data pegawai Desa Adat. Anda bisa menambahkannya dengan cara menekan tombol Tambah Data Pegawai dan isi data nomor surat pada form yang telah disediakan", style: TextStyle(
                                                fontFamily: "Poppins",
                                                fontSize: 14,
                                                color: Colors.black26
                                            ), textAlign: TextAlign.center),
                                            padding: EdgeInsets.symmetric(horizontal: 30),
                                            margin: EdgeInsets.only(top: 10),
                                          )
                                        ]
                                    )
                                  ),
                                ),
                                Container(
                                  child: LoadingTidakAktif ? Center(
                                    child: Lottie.asset('assets/loading-circle.json')
                                  ) : availableDataTidakAktif ? RefreshIndicator(
                                      onRefresh: refreshListPrajuruDesaAdatTidakAktif,
                                      child: ListView.builder(
                                          itemCount: prajuruDesaAdatIDTidakAktif.length,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                                onTap: (){
                                                  setState(() {
                                                    detailPrajuruDesaAdatAdmin.prajuruDesaAdatId = prajuruDesaAdatIDTidakAktif[index];
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
                                                                    selectedIdPrajuruDesaAdat = prajuruDesaAdatIDTidakAktif[index];
                                                                    selectedIdPenduduk = pendudukIdTidakAktif[index];
                                                                  });
                                                                  onSelected(context, item);
                                                                },
                                                                itemBuilder: (context) => [
                                                                  PopupMenuItem<int>(
                                                                      value: 1,
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
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    )
                  ],
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
          editPrajuruDesaAdatAdmin.idPegawai = selectedIdPrajuruDesaAdat;
        });
        Navigator.push(context, CupertinoPageRoute(builder: (context) => editPrajuruDesaAdatAdmin())).then((value) {
          refreshListPrajuruDesaAdatAktif();
          refreshListPrajuruDesaAdatTidakAktif();
        });
        break;

      case 1:
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
                      child: Text("Hapus Data Pegawai", style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: HexColor("#025393")
                      ), textAlign: TextAlign.center),
                      margin: EdgeInsets.only(top: 10)
                    ),
                    Container(
                      child: Text("Apakah Anda yakin ingin menghapus data pegawai?", style: TextStyle(
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
                    http.post(Uri.parse(apiURLDeletePrajuruDesaAdat),
                      headers: {"Content-Type" : "application/json"},
                      body: body
                    ).then((http.Response response) {
                      var responseValue = response.statusCode;
                      if(responseValue == 200) {
                        refreshListPrajuruDesaAdatAktif();
                        refreshListPrajuruDesaAdatTidakAktif();
                        Fluttertoast.showToast(
                          msg: "Data pegawai berhasil dihapus",
                          fontSize: 14,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER
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
                            child: Text("Atur Staff Menjadi Tidak Aktif", style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: HexColor("#025393")
                            ), textAlign: TextAlign.center),
                            margin: EdgeInsets.only(top: 10)
                        ),
                        Container(
                          child: Text("Apakah Anda yakin ingin menonaktifkan staff ini? Setelah staff di non-aktifkan maka ia akan kehilangan hak akses login dan tindakan ini tidak dapat dikembalikan", style: TextStyle(
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
                          refreshListPrajuruDesaAdatAktif();
                          refreshListPrajuruDesaAdatTidakAktif();
                          Fluttertoast.showToast(
                            msg: "Pegawai berhasil dinonaktifkan!",
                            fontSize: 14,
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER
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