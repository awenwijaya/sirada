import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:surat/AdminDesa/Dashboard.dart';
import 'package:surat/AdminDesa/ManajemenStaff/EditStaff.dart';
import 'package:http/http.dart' as http;
import 'package:surat/shared/LoadingAnimation/loading.dart';

class detailStaffAdmin extends StatefulWidget {
  static var status;
  static var masaBerakhir;
  static var namaLengkap;
  static var tempatLahir;
  static var tanggalLahir;
  static var alamat;
  static var agama;
  static var jenisKelamin;
  static var pendidikanTerakhir;
  static var namaUnit;
  static var jabatan;
  static var staffId;
  static var masaMulai;
  static var fileSK;
  const detailStaffAdmin({Key key}) : super(key: key);

  @override
  _detailStaffAdminState createState() => _detailStaffAdminState();
}

class _detailStaffAdminState extends State<detailStaffAdmin> {
  DateTime selectMasaBerakhir;
  String tanggalMasaBerakhir;
  String valueMasaBerakhir;

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
          title: Text("Detail Staff", style: TextStyle(
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
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Image.asset(
                          'images/person.png',
                        height: 100,
                        width: 100,
                      ),
                    ),
                    Container(
                      child: Text(detailStaffAdmin.namaLengkap.toString(), style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 16,
                        color: HexColor("#025393"),
                        fontWeight: FontWeight.w700
                      )),
                      margin: EdgeInsets.only(top: 15),
                    ),
                    Container(
                      child: Text(detailStaffAdmin.status.toString().toUpperCase(), style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.white
                      )),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: HexColor("#fab73d")
                      ),
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      margin: EdgeInsets.only(top: 10),
                    )
                  ],
                ),
                margin: EdgeInsets.only(top: 20),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text("Data Staff", style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.black
                )),
                margin: EdgeInsets.only(top: 15, left: 25),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text("Tempat Lahir", style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 14,
                              fontWeight: FontWeight.w700
                            )),
                            margin: EdgeInsets.only(top: 15),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(detailStaffAdmin.tempatLahir.toString(), style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 14
                            )),
                            margin: EdgeInsets.only(top: 5),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text("Tanggal Lahir", style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14,
                                fontWeight: FontWeight.w700
                            )),
                            margin: EdgeInsets.only(top: 15),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text("${detailStaffAdmin.tanggalLahir.toString()}", style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14
                            )),
                            margin: EdgeInsets.only(top: 5),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text("Alamat", style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14,
                                fontWeight: FontWeight.w700
                            )),
                            margin: EdgeInsets.only(top: 15),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(detailStaffAdmin.alamat, style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14
                            )),
                            margin: EdgeInsets.only(top: 5),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text("Agama", style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14,
                                fontWeight: FontWeight.w700
                            )),
                            margin: EdgeInsets.only(top: 15),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(detailStaffAdmin.agama.toString(), style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14
                            )),
                            margin: EdgeInsets.only(top: 5),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text("Jenis Kelamin", style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14,
                                fontWeight: FontWeight.w700
                            )),
                            margin: EdgeInsets.only(top: 15),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(detailStaffAdmin.jenisKelamin.toString(), style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14
                            )),
                            margin: EdgeInsets.only(top: 5),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text("Pendidikan Terakhir", style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14,
                                fontWeight: FontWeight.w700
                            )),
                            margin: EdgeInsets.only(top: 15),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(detailStaffAdmin.pendidikanTerakhir.toString(), style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14
                            )),
                            margin: EdgeInsets.only(top: 5),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text("Masa Mulai", style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 14,
                              fontWeight: FontWeight.w700
                            )),
                            margin: EdgeInsets.only(top: 15),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text("${detailStaffAdmin.masaMulai.toString()}", style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 14
                            )),
                            margin: EdgeInsets.only(top: 5),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: detailStaffAdmin.masaBerakhir == null ? Container() : Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text("Masa Berakhir", style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14,
                                fontWeight: FontWeight.w700
                              )),
                              margin: EdgeInsets.only(top: 15),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text("${detailStaffAdmin.masaBerakhir.toString()}", style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14
                              )),
                              margin: EdgeInsets.only(top: 5),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text("Nama Unit", style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14,
                                fontWeight: FontWeight.w700
                            )),
                            margin: EdgeInsets.only(top: 15),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(detailStaffAdmin.namaUnit.toString(), style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14
                            )),
                            margin: EdgeInsets.only(top: 5),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text("Jabatan", style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14,
                                fontWeight: FontWeight.w700
                            )),
                            margin: EdgeInsets.only(top: 15),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(detailStaffAdmin.jabatan.toString(), style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14
                            )),
                            margin: EdgeInsets.only(top: 5, bottom: 15),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                decoration: BoxDecoration(
                    color: HexColor("EEEEEE"),
                    borderRadius: BorderRadius.circular(25)
                ),
                padding: EdgeInsets.only(top: 10, bottom: 10, left: 30, right: 30),
                margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
              ),
              Container(
                child: FlatButton(
                  onPressed: (){
                    Navigator.push(context, CupertinoPageRoute(builder: (context) => editStaffAdmin()));
                  },
                  child: Text("Edit Staff", style: TextStyle(
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
                margin: EdgeInsets.only(bottom: 10),
              ),
              Container(
                child: FlatButton(
                  onPressed: (){
                    Navigator.push(context, CupertinoPageRoute(builder: (context) => liatFileSKPegawaiAdmin()));
                  },
                  child: Text("Lihat File SK Staff", style: TextStyle(
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
                margin: EdgeInsets.only(bottom: 10),
              ),
              Container(
                child: detailStaffAdmin.status == "Aktif" ? FlatButton(
                  onPressed: (){
                    Navigator.push(context, CupertinoPageRoute(builder: (context) => setNonAktifPegawai()));
                  },
                  child: Text("Ubah Status Staff menjadi Tidak Aktif", style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: HexColor("B33030")
                  )),
                  color: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                    side: BorderSide(color: HexColor("B33030"), width: 2)
                  ),
                  padding: EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50),
                ) : Container(),
                margin: EdgeInsets.only(bottom: 20),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class liatFileSKPegawaiAdmin extends StatefulWidget {
  const liatFileSKPegawaiAdmin({Key key}) : super(key: key);

  @override
  _liatFileSKPegawaiAdminState createState() => _liatFileSKPegawaiAdminState();
}

class _liatFileSKPegawaiAdminState extends State<liatFileSKPegawaiAdmin> {
  static final String PDF_URL = "http://192.168.18.10/siraja-api-skripsi/sk/${detailStaffAdmin.fileSK}";
  String localFile;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("File SK Pegawai", style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w700,
            color: HexColor("#025393")
          )),
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: HexColor("#025393"),
            onPressed: (){Navigator.of(context).pop();},
          ),
        ),
      ),
    );
  }
}

class setNonAktifPegawai extends StatefulWidget {
  const setNonAktifPegawai({Key key}) : super(key: key);

  @override
  _setNonAktifPegawaiState createState() => _setNonAktifPegawaiState();
}

class _setNonAktifPegawaiState extends State<setNonAktifPegawai> {
  DateTime masaMulaiKaryawan;
  var tanggalMasaMulai;
  DateTime selectMasaBerakhir;
  String tanggalMasaBerakhir;
  String valueMasaBerakhir;
  var apiURLSetTidakAktifKaryawan = "http://192.168.18.10:8000/api/admin/staff/set_tidak_aktif";
  bool Loading = false;

  Future getMasaMulaiKaryawan() async {
    var url = "http://192.168.18.10:8000/api/admin/staff/show_masa_mulai/${detailStaffAdmin.staffId}";
    var response = await http.get(Uri.parse(url));
    if(response.statusCode == 200) {
      var jsonData = response.body;
      var parsedJson = json.decode(jsonData);
      setState(() {
        tanggalMasaMulai = parsedJson['masa_mulai'];
        masaMulaiKaryawan = new DateFormat("yyy-MM-dd").parse(tanggalMasaMulai);
      });
    }
    print(masaMulaiKaryawan.toString());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMasaMulaiKaryawan();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Loading ? loading() : Scaffold(
        appBar: AppBar(
          title: Text("Non-Aktifkan Staff", style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w700,
            color: HexColor("#025393")
          )),
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: HexColor("#025393"),
            onPressed: (){Navigator.of(context).pop();},
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: Image.asset(
                  'images/person.png',
                  height: 100,
                  width: 100,
                ),
                margin: EdgeInsets.only(top: 30),
              ),
              Container(
                child: Text("Masa Berakhir Staff", style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14,
                  fontWeight: FontWeight.w700
                )),
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(top: 30, left: 20),
              ),
              Container(
                child: Text("Silahkan masukkan tanggal masa berakhirnya staff pada form dibawah sebelum melanjutkan", style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14
                )),
                padding: EdgeInsets.only(left: 30, right: 30),
                margin: EdgeInsets.only(top: 10),
              ),
              Container(
                child: tanggalMasaBerakhir == null ? Container() : Text(tanggalMasaBerakhir.toString(), style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14
                )),
                margin: EdgeInsets.only(top: 10),
              ),
              Container(
                child: FlatButton(
                  onPressed: (){
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2900)
                    ).then((value) {
                      setState(() {
                        selectMasaBerakhir = value;
                        var tanggal = DateTime.parse(selectMasaBerakhir.toString());
                        tanggalMasaBerakhir = "${tanggal.day}-${tanggal.month}-${tanggal.year}";
                        valueMasaBerakhir = "${tanggal.year}-${tanggal.month}-${tanggal.day}";
                      });
                    });
                  },
                  child: Text("Pilih Masa Berakhir", style: TextStyle(
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
                margin: EdgeInsets.only(top: 10),
              ),
              Container(
                child: Text("Silahkan tekan tombol Atur Staff menjadi Tidak Aktif jika Anda benar-benar yakin ingin mengatur status staff menjadi tidak aktif. Tindakan ini tidak dapat diubah kembali", style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ), textAlign: TextAlign.center),
                padding: EdgeInsets.only(left: 30, right: 30),
                margin: EdgeInsets.only(top: 30),
                alignment: Alignment.topCenter,
              ),
              Container(
                child: FlatButton(
                  onPressed: (){
                    if(valueMasaBerakhir == null) {
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
                                      'images/warning.png',
                                      height: 50,
                                      width: 50,
                                    ),
                                  ),
                                  Container(
                                    child: Text("Data masa berakhir staff belum diisi", style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: HexColor("#025393")
                                    ), textAlign: TextAlign.center),
                                    margin: EdgeInsets.only(top: 10),
                                  ),
                                  Container(
                                    child: Text("Data masa berakhir staff masih kosong. Silahkan isi data masa berakhir staff dan coba lagi", style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 14
                                    ), textAlign: TextAlign.center),
                                    margin: EdgeInsets.only(top: 10),
                                  )
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: Text("OK", style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w700,
                                  color: HexColor("#025393")
                                )),
                                onPressed: (){Navigator.of(context).pop();},
                              )
                            ],
                          );
                        }
                      );
                    }else if(selectMasaBerakhir.isBefore(masaMulaiKaryawan)) {
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
                                      'images/alert.png',
                                      height: 50,
                                      width: 50,
                                    ),
                                  ),
                                  Container(
                                    child: Text("Tanggal masa berakhir tidak valid", style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: HexColor("#025393")
                                    ), textAlign: TextAlign.center),
                                    margin: EdgeInsets.only(top: 10),
                                  ),
                                  Container(
                                    child: Text("Tanggal masa berakhir karyawan tidak valid. Silahkan masukkan tanggal masa berakhir karyawan di hari setelah masa mulai karyawan dan coba lagi", style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 14
                                    ), textAlign: TextAlign.center),
                                    margin: EdgeInsets.only(top: 10),
                                  )
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: Text("OK", style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w700,
                                  color: HexColor("#025393")
                                )),
                                onPressed: (){Navigator.of(context).pop();},
                              )
                            ],
                          );
                        }
                      );
                    }else{
                      setState(() {
                        Loading = true;
                      });
                      var body = jsonEncode({
                        "staff_id" : detailStaffAdmin.staffId,
                        "masa_berakhir" : valueMasaBerakhir
                      });
                      http.post(Uri.parse(apiURLSetTidakAktifKaryawan),
                        headers: {"Content-Type" : "application/json"},
                        body: body
                      ).then((http.Response response) {
                        var responseValue = response.statusCode;
                        if(responseValue == 200) {
                          setState(() {
                            Loading = false;
                          });
                          Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) => dashboardAdminDesa()), (route) => false);
                        }
                      });
                    }
                  },
                  child: Text("Atur Staff menjadi Tidak Aktif", style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: HexColor("B33030")
                  )),
                  color: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                    side: BorderSide(color: HexColor("B33030"), width: 2)
                  ),
                  padding: EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50),
                ),
                margin: EdgeInsets.only(top: 30),
              )
            ],
          ),
        ),
      ),
    );
  }
}