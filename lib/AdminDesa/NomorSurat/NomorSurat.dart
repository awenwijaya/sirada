import 'dart:async';
import 'dart:convert';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:surat/LoginAndRegistration/LoginPage.dart';

class nomorSuratAdmin extends StatefulWidget {
  const nomorSuratAdmin({Key key}) : super(key: key);

  @override
  _nomorSuratAdminState createState() => _nomorSuratAdminState();
}

class _nomorSuratAdminState extends State<nomorSuratAdmin> {
  var idNomorSurat = [];
  var nomorSurat = [];
  var keteranganSurat = [];
  var selectedIdNomorSurat;
  bool Loading = true;
  bool LoadingProses = false;
  bool availableData = false;
  final controllerKodeSurat = TextEditingController();
  var controllerKodeSuratEdit = TextEditingController();
  final controllerKeterangan = TextEditingController();
  var controllerKeteranganEdit = TextEditingController();
  var apiURLUpNomorSurat = "http://192.168.239.149:8000/api/admin/nomor_surat/up_nomor_surat";
  var apiURLEditNomorSurat = "http://192.168.239.149:8000/api/admin/nomor_surat/edit_nomor_surat";
  var apiURLDeleteNomorSurat = "http://192.168.239.149:8000/api/admin/nomor_surat/delete_nomor_surat";

  Future refreshListNomorSurat() async {
    Uri uri = Uri.parse('http://192.168.239.149:8000/api/data/nomorsurat/${loginPage.desaId}');
    final response = await http.get(uri);
    if(response.statusCode == 200) {
      var data = json.decode(response.body);
      this.idNomorSurat = [];
      this.nomorSurat = [];
      this.keteranganSurat = [];
      setState(() {
        Loading = false;
        availableData = true;
        for(var i = 0; i < data.length; i++) {
          this.idNomorSurat.add(data[i]['master_surat_id']);
          this.nomorSurat.add(data[i]['kode_nomor_surat']);
          this.keteranganSurat.add(data[i]['keterangan']);
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
    refreshListNomorSurat();
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
          title: Text("Nomor Surat", style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w700,
            color: HexColor("#025393")
          )),
        ),
        body: Loading ? ListTileShimmer() : availableData ? RefreshIndicator(
          onRefresh: refreshListNomorSurat,
          child: ListView.builder(
            itemCount: idNomorSurat.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: (){},
                child: Container(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            Container(
                                child: Image.asset(
                                    'images/paper.png',
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
                                        child: Text("${nomorSurat[index]}", style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: HexColor("#025393")
                                        )),
                                      ),
                                      Container(
                                          child: SizedBox(
                                            width: MediaQuery.of(context).size.width * 0.55,
                                            child: Text("${keteranganSurat[index]}", style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 14,
                                            ))
                                          )
                                      )
                                    ]
                                ),
                                margin: EdgeInsets.only(left: 15)
                            )
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: PopupMenuButton<int>(
                            onSelected: (item) {
                              setState(() {
                                selectedIdNomorSurat = idNomorSurat[index];
                                controllerKodeSuratEdit.text = nomorSurat[index];
                                controllerKeteranganEdit.text = keteranganSurat[index];
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
                            )
                          ]
                        )
                      )
                    ]
                  ),
                  margin: EdgeInsets.only(top: 10, left: 20, right: 20),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
                          CupertinoIcons.number,
                          size: 50,
                          color: Colors.black26,
                        )
                    ),
                    Container(
                      child: Text("Tidak ada Data Nomor Surat", style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black26
                      ), textAlign: TextAlign.center),
                      margin: EdgeInsets.only(top: 10),
                      padding: EdgeInsets.symmetric(horizontal: 30),
                    ),
                    Container(
                      child: Text("Tidak ada data nomor surat. Anda bisa menambahkannya dengan cara menekan tombol + dan isi data nomor surat pada form yang telah disediakan", style: TextStyle(
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
          alignment: Alignment(0.0, 0.0),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  scrollable: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40.0))
                  ),
                  content: Container(
                    child: LoadingProses ? Container(
                      child: Lottie.asset('assets/loading-circle.json'),
                    ) : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          child: Image.asset(
                            'images/paper.png',
                            height: 50,
                            width: 50,
                          )
                        ),
                        Container(
                          child: Text("Tambah Nomor Surat", style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: HexColor("#025393")
                          ), textAlign: TextAlign.center),
                          margin: EdgeInsets.only(top: 10),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Column(
                            children: <Widget>[
                              Container(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                  child: TextField(
                                    controller: controllerKodeSurat,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(50.0),
                                        borderSide: BorderSide(color: HexColor("#025393"))
                                      ),
                                      prefixIcon: Icon(CupertinoIcons.number),
                                      hintText: "Kode Surat"
                                    ),
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 14
                                    ),
                                  ),
                                )
                              ),
                              Container(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                  child: TextField(
                                    controller: controllerKeterangan,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(50.0),
                                        borderSide: BorderSide(color: HexColor("#025393"))
                                      ),
                                      prefixIcon: Icon(Icons.text_snippet),
                                      hintText: "Keterangan"
                                    ),
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 14
                                    ),
                                  ),
                                )
                              )
                            ],
                          ),
                          margin: EdgeInsets.only(top: 15),
                        )
                      ],
                    )
                  ),
                  actions: <Widget>[
                    LoadingProses ? Container() : TextButton(
                      child: Text("Simpan", style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w700,
                        color: HexColor("#025393")
                      )),
                      onPressed: (){
                        if(controllerKodeSurat.text == "" || controllerKeterangan.text == "") {
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
                                        margin: EdgeInsets.only(top: 10),
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
                        }else{
                          setState(() {
                            LoadingProses = true;
                          });
                          var body = jsonEncode({
                            "kode_nomor_surat" : controllerKodeSurat.text,
                            "keterangan" : controllerKeterangan.text,
                            "desa_adat_id" : loginPage.desaId
                          });
                          http.post(Uri.parse(apiURLUpNomorSurat),
                            headers: {"Content-Type" : "application/json"},
                            body: body
                          ).then((http.Response response) {
                            var responseValue = response.statusCode;
                            if(responseValue == 200) {
                              setState(() {
                                LoadingProses = false;
                                controllerKodeSurat.text = "";
                                controllerKeterangan.text = "";
                              });
                              Fluttertoast.showToast(
                                msg: "Nomor surat berhasil ditambahkan!",
                                fontSize: 14,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER
                              );
                              refreshListNomorSurat();
                              Navigator.of(context).pop();
                            }else if(responseValue == 501) {
                              setState(() {
                                LoadingProses = false;
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
                                            ),
                                          ),
                                          Container(
                                            child: Text("Nomor Surat atau Keterangan Tidak Tersedia", style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: HexColor("#025393")
                                            ), textAlign: TextAlign.center),
                                            margin: EdgeInsets.only(top: 10),
                                          ),
                                          Container(
                                            child: Text("Data nomor surat atau keterangan yang Anda inputkan sudah diinputkan sebelumnya. Silahkan input data nomor surat yang lain dan coba lagi", style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 14
                                            ), textAlign: TextAlign.center),
                                            margin: EdgeInsets.only(top: 10),
                                          )
                                        ]
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
                            }
                          });
                        }
                      },
                    ),
                    LoadingProses ? Container() : TextButton(
                      child: Text("Batal", style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w700,
                        color: HexColor("#025393")
                      )),
                      onPressed: (){
                        setState(() {
                          controllerKodeSurat.text = "";
                          controllerKeterangan.text = "";
                        });
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                );
              }
            );
          },
          child: Icon(Icons.add),
          backgroundColor: HexColor("#025393"),
        ),
      ),
    );
  }

  void onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              scrollable: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(40.0))
              ),
              content: Container(
                child: LoadingProses ? Container(
                  child: Lottie.asset('assets/loading-circle.json')
                ) : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      child: Image.asset(
                        'images/paper.png',
                        height: 50,
                        width: 50
                      )
                    ),
                    Container(
                      child: Text("Edit Nomor Surat", style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: HexColor("#025393")
                      ), textAlign: TextAlign.center),
                      margin: EdgeInsets.only(top: 10)
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Column(
                        children: <Widget>[
                          Container(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                child: TextField(
                                    controller: controllerKodeSuratEdit,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(50.0),
                                            borderSide: BorderSide(color: HexColor("#025393"))
                                        ),
                                        prefixIcon: Icon(CupertinoIcons.number),
                                        hintText: "Kode Surat"
                                    ),
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 14
                                    )
                                ),
                              )
                          ),
                          Container(
                              child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                  child: TextField(
                                      controller: controllerKeteranganEdit,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(50.0),
                                              borderSide: BorderSide(color: HexColor("#025393"))
                                          ),
                                          prefixIcon: Icon(Icons.text_snippet),
                                          hintText: "Keterangan"
                                      ),
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 14
                                      )
                                  )
                              )
                          )
                        ]
                      ),
                      margin: EdgeInsets.only(top: 15)
                    )
                  ]
                )
              ),
              actions: <Widget>[
                TextButton(
                  child: LoadingProses ? CircularProgressIndicator(color: HexColor("#025393")) : Text("Simpan", style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w700,
                    color: HexColor("#025393")
                  )),
                  onPressed: (){
                    if(controllerKodeSuratEdit.text == "" || controllerKeteranganEdit.text == "") {
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
                                      width: 50
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
                                    child: Text("Masih terdapat data yang kosong. Silahkan lengkapi form yang telah disediakan dan coba lagi", style: TextStyle(
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
                                onPressed: (){Navigator.of(context).pop();}
                              )
                            ]
                          );
                        }
                      );
                    }else{
                      setState(() {
                        LoadingProses = true;
                      });
                      var body = jsonEncode({
                        "kode_nomor_surat" : controllerKodeSuratEdit.text,
                        "keterangan" : controllerKeteranganEdit.text,
                        "id" : selectedIdNomorSurat,
                      });
                      http.post(Uri.parse(apiURLEditNomorSurat),
                        headers: {"Content-Type" : "application/json"},
                        body: body
                      ).then((http.Response response) {
                        var responseValue = response.statusCode;
                        if(responseValue == 200) {
                          setState(() {
                            LoadingProses = false;
                          });
                          refreshListNomorSurat();
                          Fluttertoast.showToast(
                            msg: "Kode surat berhasil diperbaharui",
                            fontSize: 14,
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER
                          );
                          Navigator.of(context).pop();
                        }else if(responseValue == 501) {
                          setState(() {
                            LoadingProses = false;
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
                                              ),
                                            ),
                                            Container(
                                              child: Text("Nomor Surat atau Keterangan Tidak Tersedia", style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                  color: HexColor("#025393")
                                              ), textAlign: TextAlign.center),
                                              margin: EdgeInsets.only(top: 10),
                                            ),
                                            Container(
                                              child: Text("Data nomor surat atau keterangan yang Anda inputkan sudah diinputkan sebelumnya. Silahkan input data nomor surat yang lain dan coba lagi", style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontSize: 14
                                              ), textAlign: TextAlign.center),
                                              margin: EdgeInsets.only(top: 10),
                                            )
                                          ]
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
                        }
                      });
                    }
                  }
                ),
                LoadingProses ? Container() : TextButton(
                  child: Text("Batal", style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w700,
                    color: HexColor("#025393")
                  )),
                  onPressed: (){Navigator.of(context).pop();}
                )
              ]
            );
          }
        );
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
                        width: 50
                      )
                    ),
                    Container(
                      child: Text("Hapus Kode Surat", style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: HexColor("#025393")
                      ), textAlign: TextAlign.center),
                      margin: EdgeInsets.only(top: 10)
                    ),
                    Container(
                      child: Text("Apakah Anda yakin ingin menghapus kode surat ini?", style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14
                      ), textAlign: TextAlign.center),
                      margin: EdgeInsets.only(top: 10)
                    )
                  ]
                )
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: (){
                    setState(() {
                      LoadingProses = true;
                    });
                    var body = jsonEncode({
                      "id" : selectedIdNomorSurat
                    });
                    http.post(Uri.parse(apiURLDeleteNomorSurat),
                      headers: {"Content-Type" : "application/json"},
                      body: body
                    ).then((http.Response response) {
                      var responseValue = response.statusCode;
                      if(responseValue == 200) {
                        setState(() {
                          LoadingProses = false;
                        });
                        refreshListNomorSurat();
                        Fluttertoast.showToast(
                          msg: "Kode surat berhasil dihapus",
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
                  ))
                ),
                TextButton(
                  onPressed: (){Navigator.of(context).pop();},
                  child: Text("Tidak", style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w700,
                    color: HexColor("#025393")
                  ))
                )
              ]
            );
          }
        );
    }
  }
}