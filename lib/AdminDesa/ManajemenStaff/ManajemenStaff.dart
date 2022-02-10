import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:surat/AdminDesa/ManajemenStaff/AddStaff.dart';
import 'package:surat/AdminDesa/ManajemenStaff/DetailStaff.dart';
import 'package:surat/LoginAndRegistration/LoginPage.dart';
import 'package:surat/shared/API/Models/Staff.dart';

class staffManagementAdmin extends StatefulWidget {
  const staffManagementAdmin({Key key}) : super(key: key);

  @override
  _staffManagementAdminState createState() => _staffManagementAdminState();
}

class _staffManagementAdminState extends State<staffManagementAdmin> {
  var apiURLDataStaffAktif = "http://192.168.18.10:8000/api/data/staff/aktif/${loginPage.desaId}";
  var apiURLDataStaffTidakAktif = "http://192.168.18.10:8000/api/data/staff/tidakaktif/${loginPage.desaId}";

  Future<Staff> Aktif() async {
    return http.get(Uri.parse(apiURLDataStaffAktif),
      headers: {"Content-Type" : "application/json"}
    ).then((http.Response response) {
      if(response.statusCode == 200) {
        final body = response.body;
        final staffData = staffFromJson(body);
        return staffData;
      }else{
        final body = response.body;
        final error = staffFromJson(body);
        return error;
      }
    });
  }

  Future<Staff> TidakAktif() async {
    return http.get(Uri.parse(apiURLDataStaffTidakAktif),
      headers: {"Content-Type" : "application/json"},
    ).then((http.Response response) {
      if(response.statusCode == 200) {
        final body = response.body;
        final staffData = staffFromJson(body);
        return staffData;
      }else{
        final body = response.body;
        final error = staffFromJson(body);
        return error;
      }
    });
  }

  Widget listStaffAktif() {
    return FutureBuilder<Staff>(
      future: Aktif(),
      builder: (context, snapshot) {
        final data = snapshot.data;
        if(snapshot.hasData) {
          final staffData = data.data;
          return ListView.builder(
            itemCount: staffData.length,
            itemBuilder: (context, index) {
              final staff = staffData[index];
              return GestureDetector(
                onTap: (){
                  setState(() {
                    detailStaffAdmin.status = staff.status;
                    detailStaffAdmin.namaLengkap = staff.namaLengkap;
                    detailStaffAdmin.tempatLahir = staff.tempatLahir;
                    detailStaffAdmin.tanggalLahir = staff.tanggalLahir;
                    detailStaffAdmin.alamat = staff.alamat;
                    detailStaffAdmin.agama = staff.agama;
                    detailStaffAdmin.jenisKelamin = staff.jenisKelamin;
                    detailStaffAdmin.pendidikanTerakhir = staff.pendidikanTerakhir;
                    detailStaffAdmin.namaUnit = staff.namaUnit;
                    detailStaffAdmin.jabatan = staff.namaJabatan;
                  });
                  Navigator.push(context, CupertinoPageRoute(builder: (context) => detailStaffAdmin()));
                },
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: Image.asset(
                            'images/person.png',
                            height: 40,
                            width: 40
                        ),
                      ),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Text(staff.namaLengkap.toString(), style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  color: Colors.black
                              )),
                              margin: EdgeInsets.only(left: 20),
                            ),
                            Container(
                              child: Text(staff.namaUnit.toString(), style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14,
                                color: Colors.black
                              )),
                              margin: EdgeInsets.only(left: 20),
                            )
                          ],
                        ),
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
          );
        }else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget listStaffTidakAktif() {
    return FutureBuilder<Staff>(
      future: TidakAktif(),
      builder: (context, snapshot) {
        final data = snapshot.data;
        if(snapshot.hasData) {
          final staffData = data.data;
          return ListView.builder(
            itemCount: staffData.length,
            itemBuilder: (context, index) {
              final staff = staffData[index];
              return GestureDetector(
                onTap: (){
                  setState(() {
                    detailStaffAdmin.status = staff.status;
                    detailStaffAdmin.namaLengkap = staff.namaLengkap;
                    detailStaffAdmin.tempatLahir = staff.tempatLahir;
                    detailStaffAdmin.tanggalLahir = staff.tanggalLahir;
                    detailStaffAdmin.alamat = staff.alamat;
                    detailStaffAdmin.agama = staff.agama;
                    detailStaffAdmin.jenisKelamin = staff.jenisKelamin;
                    detailStaffAdmin.pendidikanTerakhir = staff.pendidikanTerakhir;
                    detailStaffAdmin.namaUnit = staff.namaUnit;
                    detailStaffAdmin.jabatan = staff.namaJabatan;
                    detailStaffAdmin.masaBerakhir = staff.masaBerakhir;
                  });
                  Navigator.push(context, CupertinoPageRoute(builder: (context) => detailStaffAdmin()));
                },
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: Image.asset(
                          'images/person.png',
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
                              child: Text(staff.namaLengkap.toString(), style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black
                              )),
                            ),
                            Container(
                              child: Text(staff.namaUnit.toString(), style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14,
                                color: Colors.black
                              )),
                            ),
                            Container(
                              child: Text("Masa berakhir: ${staff.masaBerakhir.day.toString()}-${staff.masaBerakhir.month.toString()}-${staff.masaBerakhir.year.toString()}", style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14,
                                color: Colors.black26
                              )),
                            )
                          ],
                        ),
                        margin: EdgeInsets.only(left: 20),
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
          );
        }else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
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
          title: Text("Manajemen Staff", style: TextStyle(
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
                child: Image.asset('images/staff.png', height: 100, width: 100),
                margin: EdgeInsets.only(top: 20),
              ),
              Container(
                child: FlatButton(
                  onPressed: (){
                    Navigator.push(context, CupertinoPageRoute(builder: (context) => addStaffAdmin()));
                  },
                  child: Text("Tambah Data Staff", style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: HexColor("#025393")
                  )),
                  color: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                    side: BorderSide(color: HexColor("#025393"), width: 2)
                  ),
                  padding: EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50),
                ),
                margin: EdgeInsets.only(top: 20),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text("Data Staff Desa", style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14,
                  fontWeight: FontWeight.w700
                )),
                margin: EdgeInsets.only(top: 20, left: 15, bottom: 10),
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
                            ),
                            margin: EdgeInsets.only(bottom: 10),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height,
                            child: TabBarView(
                              children: <Widget>[
                                Container(
                                  child: listStaffAktif(),
                                ),
                                Container(
                                  child: listStaffTidakAktif(),
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
    );
  }
}