import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:surat/AdminDesa/ManajemenStaff/ManajemenPrajuruDesaAdat/TambahPrajuruDesaAdat.dart';
import 'package:surat/LoginAndRegistration/LoginPage.dart';
import 'package:surat/AdminDesa/ManajemenStaff/ManajemenPrajuruDesaAdat/DetailPrajuruDesaAdat.dart';

class prajuruDesaAdatAdmin extends StatefulWidget {
  const prajuruDesaAdatAdmin({Key key}) : super(key: key);

  @override
  _prajuruDesaAdatAdminState createState() => _prajuruDesaAdatAdminState();
}

class _prajuruDesaAdatAdminState extends State<prajuruDesaAdatAdmin> {
  var prajuruDesaAdatID = [];
  var jabatan = [];
  var namaPrajuru = [];
  bool Loading = true;
  bool LoadingProses = false;
  bool availableData = false;
  var apiURLShowListPrajuruDesaAdat = "http://192.168.18.10:8000/api/data/staff/prajuru_desa_adat/325";

  Future refreshListPrajuruDesaAdat() async {
    Uri uri = Uri.parse(apiURLShowListPrajuruDesaAdat);
    final response = await http.get(uri);
    if(response.statusCode == 200) {
      var data = json.decode(response.body);
      this.prajuruDesaAdatID = [];
      this.jabatan = [];
      this.namaPrajuru = [];
      setState(() {
        Loading = false;
        availableData = true;
        for(var i = 0; i < data.length; i++) {
          this.prajuruDesaAdatID.add(data[i]['prajuru_desa_adat_id']);
          this.jabatan.add(data[i]['jabatan']);
          this.namaPrajuru.add(data[i]['nama']);
        }
      });
    }else{
      setState(() {
        Loading = false;
        availableData = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    refreshListPrajuruDesaAdat();
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
        body: Loading ? Center(
          child: Lottie.asset('assets/loading-circle.json')
        ) : availableData ? RefreshIndicator(
          onRefresh: refreshListPrajuruDesaAdat,
          child: ListView.builder(
            itemCount: prajuruDesaAdatID.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: (){
                  setState(() {
                    detailPrajuruDesaAdatAdmin.prajuruDesaAdatId = prajuruDesaAdatID[index];
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
                                    child: Text("${namaPrajuru[index]}", style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: HexColor("#025393")
                                    ))
                                  ),
                                  Container(
                                    child: Text("${jabatan[index]}", style: TextStyle(
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
                          itemBuilder: (context) => [
                            PopupMenuItem(
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
                            PopupMenuItem(
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
                  child: Text("Tidak ada Data Pegawai Desa Adat", style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black26
                  ), textAlign: TextAlign.center),
                  margin: EdgeInsets.only(top: 10)
                ),
                Container(
                  child: Text("Tidak ada data pegawai Desa Adat. Anda bisa menambahkannya dengan cara menekan tombol + dan isi data pegawai Desa Adat pada form yang telah disediakan", style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14,
                    color: Colors.black26
                  ), textAlign: TextAlign.center),
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  margin: EdgeInsets.only(top: 10)
                )
              ]
            ),
          ),
            alignment: Alignment(0.0, 0.0)
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.push(context, CupertinoPageRoute(builder: (context) => tambahPrajuruDesaAdatAdmin()));
          },
          child: Icon(Icons.add),
          backgroundColor: HexColor("#025393")
        )
      )
    );
  }
}