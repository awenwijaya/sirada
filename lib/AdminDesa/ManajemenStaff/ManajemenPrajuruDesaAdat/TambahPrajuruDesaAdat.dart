import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:surat/LoginAndRegistration/LoginPage.dart';
import 'package:http/http.dart' as http;
import 'package:surat/shared/LoadingAnimation/loading.dart';

class tambahPrajuruDesaAdatAdmin extends StatefulWidget {
  const tambahPrajuruDesaAdatAdmin({Key key}) : super(key: key);

  @override
  State<tambahPrajuruDesaAdatAdmin> createState() => _tambahPrajuruDesaAdatAdminState();
}

class _tambahPrajuruDesaAdatAdminState extends State<tambahPrajuruDesaAdatAdmin> {
  List<String> jabatan = ["bendesa", "pangliman", "penyarikan", "patengen"];
  List<String> status = ["Aktif", "Tidak Aktif"];
  String selectedStatus;
  String statusValue;
  String selectedJabatan;
  String selectedMasaMulai;
  String selectedMasaMulaiValue;
  String selectedMasaBerakhir;
  String selectedMasaBerakhirValue;
  DateTime selectMasaMulai;
  DateTime selectMasaBerakhir;
  DateTime sekarang = DateTime.now();
  final controllerPassword = TextEditingController();
  final controllerEmail = TextEditingController();
  var namaPegawai;
  var kramaMipilID;
  var pegawaiID;
  var apiURLUpDataPrajuruDesaAdat = "http://192.168.18.10:8000/api/admin/prajuru/desa_adat/up";
  bool Loading = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Loading ? loading() : Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: HexColor("#025393"),
            onPressed: (){Navigator.of(context).pop(true);},
          ),
          title: Text("Tambah Pegawai Desa Adat", style: TextStyle(
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
                  'images/person.png',
                  height: 100,
                  width: 100
                ),
                margin: EdgeInsets.only(top: 30)
              ),
              Container(
                child: Text("* = diperlukan", style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14,
                  fontWeight: FontWeight.w700
                ), textAlign: TextAlign.center),
                margin: EdgeInsets.only(top: 20)
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text("1. Data Pegawai *", style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14,
                  fontWeight: FontWeight.w700
                )),
                margin: EdgeInsets.only(top: 30, left: 20)
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text("Silahkan pilih data pegawai yang akan Anda tambahkan dengan menekan tombol Pilih Data Pegawai.", style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14
                )),
                padding: EdgeInsets.only(left: 30, right: 30),
                margin: EdgeInsets.only(top: 10)
              ),
              Container(
                alignment: Alignment.center,
                child: Text(namaPegawai == null ? "Data pegawai belum terpilih" : "${namaPegawai}",
                    style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14,
                        fontWeight: FontWeight.bold
                    )),
                margin: EdgeInsets.only(top: 20),
              ),
              Container(
                child: FlatButton(
                  onPressed: (){
                    navigatePilihDataPegawai(context);
                  },
                  child: Text("Pilih Data Pegawai", style: TextStyle(
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
                margin: EdgeInsets.only(top: 10)
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text("2. Data Tambahan", style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14,
                  fontWeight: FontWeight.w700
                )),
                margin: EdgeInsets.only(top: 30, left: 20)
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text("Jabatan *", style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14
                      )),
                      margin: EdgeInsets.only(top: 20, left: 20),
                    ),
                    Container(
                      width: 300,
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                      decoration: BoxDecoration(
                        color: HexColor("#025393"),
                        borderRadius: BorderRadius.circular(30)
                      ),
                      child: DropdownButton<String>(
                        onChanged: (value) {
                          setState(() {
                            selectedJabatan = value;
                          });
                        },
                        value: selectedJabatan,
                        underline: Container(),
                        hint: Center(
                          child: Text("Pilih Jabatan", style: TextStyle(
                            fontFamily: "Poppins",
                            color: Colors.white,
                            fontSize: 14
                          ))
                        ),
                        icon: Icon(Icons.arrow_downward, color: Colors.white),
                        isExpanded: true,
                        items: jabatan.map((e) => DropdownMenuItem(
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: Text(e, style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 14
                            )),
                          ),
                          value: e,
                        )).toList(),
                        selectedItemBuilder: (BuildContext context) => jabatan.map((e) => Center(
                          child: Text(e, style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontFamily: "Poppins"
                          ))
                        )).toList(),
                      ),
                      margin: EdgeInsets.only(top: 20),
                    )
                  ]
                )
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text("Status *", style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14
                      )),
                      margin: EdgeInsets.only(top: 20, left: 20)
                    ),
                    Container(
                      width: 300,
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                      decoration: BoxDecoration(
                        color: HexColor("#025393"),
                        borderRadius: BorderRadius.circular(30)
                      ),
                      child: DropdownButton<String>(
                        onChanged: (value) {
                          setState(() {
                            selectedStatus = value;
                          });
                        },
                        value: selectedStatus,
                        underline: Container(),
                        hint: Center(
                          child: Text("Pilih Status", style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14,
                            color: Colors.white
                          ))
                        ),
                        icon: Icon(Icons.arrow_downward, color: Colors.white),
                        isExpanded: true,
                        items: status.map((e) => DropdownMenuItem(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text(e, style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 14
                            ))
                          ),
                          value: e,
                        )).toList(),
                        selectedItemBuilder: (BuildContext context) => status.map((e) => Center(
                          child: Text(e, style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14,
                            color: Colors.white
                          ))
                        )).toList(),
                      ),
                      margin: EdgeInsets.only(top: 20),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text("Masa Mulai Menjabat *", style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 14
                            )),
                            margin: EdgeInsets.only(top: 20, left: 20),
                          ),
                          Container(
                            child: Text(selectedMasaMulaiValue == null ? "Tanggal masa mulai menjabat belum dipilih" : selectedMasaMulai, style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 14,
                              fontWeight: FontWeight.w700
                            )),
                            margin: EdgeInsets.only(top: 10)
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
                                    selectMasaMulai = value;
                                    var tanggal = DateTime.parse(selectMasaMulai.toString());
                                    selectedMasaMulai = "${tanggal.day} - ${tanggal.month} - ${tanggal.year}";
                                    selectedMasaMulaiValue = "${tanggal.year}-${tanggal.month}-${tanggal.day}";
                                  });
                                });
                              },
                              child: Text("Pilih Tanggal", style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.white
                              )),
                              color: HexColor("#025393"),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)
                              ),
                              padding: EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50),
                            ),
                            margin: EdgeInsets.only(top: 10),
                          )
                        ]
                      )
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Text("Masa Berakhir Menjabat *", style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 14
                            )),
                            alignment: Alignment.topLeft,
                            margin: EdgeInsets.only(top: 20, left: 20)
                          ),
                          Container(
                            child: Text(selectedMasaBerakhirValue == null ? "Tanggal masa berakhir menjabat belum terpilih" : selectedMasaBerakhir, style: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w700,
                              fontSize: 14
                            )),
                            margin: EdgeInsets.only(top: 10)
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
                                    selectedMasaBerakhir = "${tanggal.day} - ${tanggal.month} - ${tanggal.year}";
                                    selectedMasaBerakhirValue = "${tanggal.year}-${tanggal.month}-${tanggal.day}";
                                  });
                                });
                              },
                              child: Text("Pilih Tanggal", style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.white
                              )),
                              color: HexColor("#025393"),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)
                              ),
                              padding: EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50),
                            ),
                            margin: EdgeInsets.only(top: 10),
                          )
                        ]
                      )
                    ),
                    Container(
                      child: Text("3. Data Akun", style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      )),
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(top: 30, left: 20),
                    ),
                    Container(
                      child: Text("Silahkan isi informasi email pada form dibawah. Data email ini nantinya akan digunakan oleh pegawai untuk melakukan proses login. \n\nApabila pegawai sudah tidak aktif, maka data ini tidak perlu diisi", style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14
                      )),
                      padding: EdgeInsets.only(left: 30, right: 30),
                      margin: EdgeInsets.only(top: 10),
                    ),
                    Container(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                        child: TextField(
                          controller: controllerEmail,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              borderSide: BorderSide(color: HexColor("#025393"))
                            ),
                            hintText: "Email *",
                            prefixIcon: Icon(Icons.alternate_email)
                          ),
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14
                          ),
                        )
                      ),
                      margin: EdgeInsets.only(top: 20),
                    ),
                    Container(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                        child: TextField(
                          controller: controllerPassword,
                          enabled: false,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              borderSide: BorderSide(color: HexColor("#025393"))
                            ),
                            hintText: "Data pegawai belum terpilih",
                            prefixIcon: Icon(Icons.lock_rounded)
                          ),
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14
                          )
                        ),
                      ),
                      margin: EdgeInsets.only(top: 10)
                    ),
                    Container(
                      child: FlatButton(
                        onPressed: (){
                          if(selectedStatus == null || selectedJabatan == null || selectedMasaBerakhirValue == null || selectedMasaMulaiValue == null || kramaMipilID == null) {
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
                                          )
                                        ),
                                        Container(
                                          child: Text("Masih ada data yang kosong", style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: HexColor("#025393")
                                          ), textAlign: TextAlign.center),
                                          margin: EdgeInsets.only(top: 10)
                                        ),
                                        Container(
                                          child: Text("Masih ada data yang kosong. Silahkan lengkapi form yang telah disediakan dan coba lagi", style: TextStyle(
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
                          }else if(selectMasaBerakhir.isBefore(selectMasaMulai)) {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context){
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
                                          )
                                        ),
                                        Container(
                                          child: Text("Tanggal masa berakhir tidak valid", style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: HexColor("#025393")
                                          ), textAlign: TextAlign.center),
                                          margin: EdgeInsets.only(top: 10)
                                        ),
                                        Container(
                                          child: Text("Tanggal masa berakhir tidak valid. Silahkan masukkan tanggal masa berakhir karyawan di hari setelah masa mulai karyawan dan coba lagi", style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 14
                                          ), textAlign: TextAlign.center),
                                          margin: EdgeInsets.only(top: 10)
                                        )
                                      ]
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
                                  ]
                                );
                              }
                            );
                          }else if(selectedStatus == "Aktif"){
                            if(controllerEmail.text == "") {
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
                                                  )
                                              ),
                                              Container(
                                                  child: Text("Masih ada data yang kosong", style: TextStyle(
                                                      fontFamily: "Poppins",
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w700,
                                                      color: HexColor("#025393")
                                                  ), textAlign: TextAlign.center),
                                                  margin: EdgeInsets.only(top: 10)
                                              ),
                                              Container(
                                                child: Text("Masih ada data yang kosong. Silahkan lengkapi form yang telah disediakan dan coba lagi", style: TextStyle(
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
                            }else if(selectMasaBerakhir.isBefore(sekarang)) {
                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context){
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
                                                    )
                                                ),
                                                Container(
                                                    child: Text("Tanggal masa berakhir tidak valid", style: TextStyle(
                                                        fontFamily: "Poppins",
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w700,
                                                        color: HexColor("#025393")
                                                    ), textAlign: TextAlign.center),
                                                    margin: EdgeInsets.only(top: 10)
                                                ),
                                                Container(
                                                    child: Text("Tanggal masa berakhir tidak valid. Silahkan masukkan tanggal masa berakhir karyawan di hari setelah tanggal hari ini dan coba lagi", style: TextStyle(
                                                        fontFamily: "Poppins",
                                                        fontSize: 14
                                                    ), textAlign: TextAlign.center),
                                                    margin: EdgeInsets.only(top: 10)
                                                )
                                              ]
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
                                        ]
                                    );
                                  }
                              );
                            }else{
                              setState(() {
                                Loading = true;
                                statusValue = "1";
                              });
                              var body = jsonEncode({
                                "krama_mipil_id" : kramaMipilID,
                                "status" : statusValue,
                                "tanggal_mulai_menjabat" : selectedMasaMulaiValue,
                                "tanggal_akhir_menjabat" : selectedMasaBerakhirValue,
                                "email" : controllerEmail.text,
                                "password" : controllerPassword.text,
                                "desa_adat_id" : loginPage.desaId,
                                "jabatan" : selectedJabatan,
                                "penduduk_id" : pegawaiID
                              });
                              http.post(Uri.parse(apiURLUpDataPrajuruDesaAdat),
                                  headers : {"Content-Type" : "application/json"},
                                  body: body
                              ).then((http.Response response) {
                                var responseValue = response.statusCode;
                                if(responseValue == 501) {
                                  setState(() {
                                    Loading = false;
                                  });
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
                                                        )
                                                    ),
                                                    Container(
                                                        child: Text("Pegawai telah terdaftar", style: TextStyle(
                                                            fontFamily: "Poppins",
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.w700,
                                                            color: HexColor("#025393")
                                                        ), textAlign: TextAlign.center),
                                                        margin: EdgeInsets.only(top: 10)
                                                    ),
                                                    Container(
                                                        child: Text("Pegawai telah terdaftar sebelumnya. Silahkan masukkan data pegawai yang lain dengan cara menekan tombol Pilih Data Pegawai dan coba lagi", style: TextStyle(
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
                                                child: Text("OK", style: TextStyle(
                                                    fontFamily: "Poppins",
                                                    fontWeight: FontWeight.w700,
                                                    color: HexColor("#025393")
                                                )),
                                                onPressed: (){Navigator.of(context).pop();},
                                              )
                                            ]
                                        );
                                      }
                                  );
                                }else if(responseValue == 502) {
                                  setState(() {
                                    Loading = false;
                                  });
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
                                                        )
                                                    ),
                                                    Container(
                                                        child: Text("Email telah terdaftar", style: TextStyle(
                                                            fontFamily: "Poppins",
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.w700,
                                                            color: HexColor("#025393")
                                                        ), textAlign: TextAlign.center),
                                                        margin: EdgeInsets.only(top: 10)
                                                    ),
                                                    Container(
                                                        child: Text("Email yang Anda masukkan sudah terdaftar sebelumnya. Silahkan masukkan email yang lain dan coba lagi", style: TextStyle(
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
                                                child: Text("OK", style: TextStyle(
                                                    fontFamily: "Poppins",
                                                    fontWeight: FontWeight.w700,
                                                    color: HexColor("#025393")
                                                )),
                                                onPressed: (){Navigator.of(context).pop();},
                                              )
                                            ]
                                        );
                                      }
                                  );
                                }else if(responseValue == 200){
                                  setState(() {
                                    Loading = false;
                                  });
                                  Fluttertoast.showToast(
                                      msg: "Pegawai Desa Adat berhasil ditambahkan",
                                      fontSize: 14,
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER
                                  );
                                  Navigator.of(context).pop(true);
                                }
                              });
                            }
                          }else{
                            if(sekarang.isBefore(selectMasaBerakhir)) {
                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context){
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
                                                    )
                                                ),
                                                Container(
                                                    child: Text("Tanggal masa berakhir tidak valid", style: TextStyle(
                                                        fontFamily: "Poppins",
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w700,
                                                        color: HexColor("#025393")
                                                    ), textAlign: TextAlign.center),
                                                    margin: EdgeInsets.only(top: 10)
                                                ),
                                                Container(
                                                    child: Text("Tanggal masa berakhir tidak valid. Silahkan masukkan tanggal masa berakhir karyawan di hari sebelum tanggal hari ini dan coba lagi", style: TextStyle(
                                                        fontFamily: "Poppins",
                                                        fontSize: 14
                                                    ), textAlign: TextAlign.center),
                                                    margin: EdgeInsets.only(top: 10)
                                                )
                                              ]
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
                                        ]
                                    );
                                  }
                              );
                            }else{
                              setState(() {
                                Loading = true;
                                statusValue = "0";
                              });
                              var body = jsonEncode({
                                "krama_mipil_id" : kramaMipilID,
                                "status" : statusValue,
                                "tanggal_mulai_menjabat" : selectedMasaMulaiValue,
                                "tanggal_akhir_menjabat" : selectedMasaBerakhirValue,
                                "email" : "email",
                                "password" : controllerPassword.text,
                                "desa_adat_id" : loginPage.desaId,
                                "jabatan" : selectedJabatan,
                                "penduduk_id" : pegawaiID
                              });
                              http.post(Uri.parse(apiURLUpDataPrajuruDesaAdat),
                                  headers : {"Content-Type" : "application/json"},
                                  body: body
                              ).then((http.Response response) {
                                var responseValue = response.statusCode;
                                if(responseValue == 501) {
                                  setState(() {
                                    Loading = false;
                                  });
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
                                                        )
                                                    ),
                                                    Container(
                                                        child: Text("Pegawai telah terdaftar", style: TextStyle(
                                                            fontFamily: "Poppins",
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.w700,
                                                            color: HexColor("#025393")
                                                        ), textAlign: TextAlign.center),
                                                        margin: EdgeInsets.only(top: 10)
                                                    ),
                                                    Container(
                                                        child: Text("Pegawai telah terdaftar sebelumnya. Silahkan masukkan data pegawai yang lain dengan cara menekan tombol Pilih Data Pegawai dan coba lagi", style: TextStyle(
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
                                                child: Text("OK", style: TextStyle(
                                                    fontFamily: "Poppins",
                                                    fontWeight: FontWeight.w700,
                                                    color: HexColor("#025393")
                                                )),
                                                onPressed: (){Navigator.of(context).pop();},
                                              )
                                            ]
                                        );
                                      }
                                  );
                                }else if(responseValue == 200){
                                  setState(() {
                                    Loading = false;
                                  });
                                  Fluttertoast.showToast(
                                      msg: "Pegawai Desa Adat berhasil ditambahkan",
                                      fontSize: 14,
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER
                                  );
                                  Navigator.of(context).pop(true);
                                }
                              });
                            }
                          }
                        },
                        child: Text("Simpan Pegawai", style: TextStyle(
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
                      margin: EdgeInsets.only(top: 20, bottom: 20),
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

  void navigatePilihDataPegawai(BuildContext context) async {
    final result = await Navigator.push(context, CupertinoPageRoute(builder: (context) => pilihDataPegawai()));
    if(result == null) {
      namaPegawai = namaPegawai;
    }else{
      setState(() {
        namaPegawai = result;
        kramaMipilID = pilihDataPegawai.selectedId;
        pegawaiID = pilihDataPegawai.selectedPegawaiId;
        controllerPassword.text = pilihDataPegawai.selectedNIK;
      });
    }
  }
}

class pilihDataPegawai extends StatefulWidget {
  static var selectedNIK;
  static var selectedId;
  static var selectedPegawaiId;
  const pilihDataPegawai({Key key}) : super(key: key);

  @override
  State<pilihDataPegawai> createState() => _pilihDataPegawaiState();
}

class _pilihDataPegawaiState extends State<pilihDataPegawai> {
  var apiURLGetDataPenduduk = "http://192.168.18.10:8000/api/data/penduduk/desa_adat/${loginPage.desaId}";
  var nikPegawai = [];
  var namaPegawai = [];
  var kramaMipilID = [];
  var pegawaiID = [];
  bool Loading = true;

  Future getListPenduduk() async {
    Uri uri = Uri.parse(apiURLGetDataPenduduk);
    final response = await http.get(uri);
    if(response.statusCode == 200) {
      var data = json.decode(response.body);
      this.nikPegawai = [];
      this.namaPegawai = [];
      this.kramaMipilID = [];
      this.pegawaiID = [];
      setState(() {
        Loading = false;
        for(var i = 0; i < data.length; i++) {
          this.nikPegawai.add(data[i]['nik']);
          this.namaPegawai.add(data[i]['nama']);
          this.kramaMipilID.add(data[i]['krama_mipil_id']);
          this.pegawaiID.add(data[i]['penduduk_id']);
        }
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getListPenduduk();
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
            onPressed: (){Navigator.of(context).pop();},
          ),
          title: Text("Pilih Data Pegawai", style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w700,
            color: HexColor("#025393")
          )),
        ),
        body: Loading ? Center(
          child: Lottie.asset('assets/loading-circle.json')
        ) : RefreshIndicator(
          onRefresh: getListPenduduk,
          child: ListView.builder(
            itemCount: kramaMipilID.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: (){
                  setState(() {
                    pilihDataPegawai.selectedNIK = nikPegawai[index];
                    pilihDataPegawai.selectedId = kramaMipilID[index];
                    pilihDataPegawai.selectedPegawaiId = pegawaiID[index];
                  });
                  Navigator.of(context, rootNavigator: true).pop(namaPegawai[index]);
                },
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: Image.asset(
                          'images/person.png',
                          height: 40,
                          width: 40,
                        )
                      ),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: Text("${namaPegawai[index]}",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: HexColor("#025393"),
                                ))
                              )
                            ),
                            Container(
                              child: Text("${nikPegawai[index]}", style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14,
                                color: Colors.black26
                              ))
                            )
                          ],
                        ),
                        margin: EdgeInsets.only(left: 15),
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
            },
          )
        )
      )
    );
  }
}