import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:surat/Penduduk/Surat/PengajuanBerhasil.dart';
import 'package:surat/shared/API/Models/Dusun.dart';
import 'package:surat/LoginAndRegistration/LoginPage.dart';
import 'package:surat/shared/LoadingAnimation/loading.dart';

class formDataTempatUsaha extends StatefulWidget {
  const formDataTempatUsaha({Key key}) : super(key: key);

  @override
  _formDataTempatUsahaState createState() => _formDataTempatUsahaState();
}

class _formDataTempatUsahaState extends State<formDataTempatUsaha> {
  File image;
  final picker = ImagePicker();
  var namaDusun = "Data dusun belum terpilih";
  var apiURLSKTempatUsaha = "http://192.168.18.10:8000/api/sk/tempatusaha/up";
  final controllerNamaUsaha = TextEditingController();
  final controllerJenisUsaha = TextEditingController();
  final controllerAlamat = TextEditingController();
  bool Loading = false;
  int index = 0;

  Future choiceImage() async {
    var pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      image = File(pickedImage.path);
    });
  }

  Future uploadImage() async {
    final uri = Uri.parse("http://192.168.18.10/siraja-api-skripsi/upload-image-php/gambarsktempatusaha.php");
    var request = http.MultipartRequest('POST', uri);
    request.fields['nama_tempat_usaha'] = controllerNamaUsaha.text;
    var pic = await http.MultipartFile.fromPath("image", image.path);
    request.files.add(pic);
    var response = await request.send();
    if(response.statusCode == 200) {
      setState(() {
        Loading = false;
      });
      Navigator.push(context, CupertinoPageRoute(builder: (context) => pengajuanSKKelahiranBerhasil()));
    }else{
      print("Gambar gagal diupload");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Loading ? loading() : Scaffold(
        appBar: AppBar(
          title: Text("Pengajuan SK", style: TextStyle(
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
                  'images/store.png',
                  height: 100,
                  width: 100,
                ),
                margin: EdgeInsets.only(top: 20),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "1. Data Tempat Usaha",
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 14,
                      fontWeight: FontWeight.w700
                  ),
                ),
                margin: EdgeInsets.only(top: 30, left: 20),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "Silahkan isi data tempat usaha pada form dibawah selengkap mungkin dan sebenar-benarnya.",
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 14
                  ),
                ),
                padding: EdgeInsets.only(left: 30, right: 30),
                margin: EdgeInsets.only(top: 10),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Nama Tempat Usaha *",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14
                        ),
                      ),
                      margin: EdgeInsets.only(top: 20, left: 20),
                    ),
                    Container(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                        child: TextField(
                          controller: controllerNamaUsaha,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                  borderSide: BorderSide(color: HexColor("#025393"))
                              ),
                              hintText: "Nama Tempat Usaha"
                          ),
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 14
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Jenis Nama Tempat Usaha *",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14
                        ),
                      ),
                      margin: EdgeInsets.only(top: 20, left: 20),
                    ),
                    Container(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                        child: TextField(
                          controller: controllerJenisUsaha,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                  borderSide: BorderSide(color: HexColor("#025393"))
                              ),
                              hintText: "Jenis Usaha"
                          ),
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 14
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Alamat Tempat Usaha *",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14
                        ),
                      ),
                      margin: EdgeInsets.only(top: 20, left: 20),
                    ),
                    Container(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                        child: TextField(
                          controller: controllerAlamat,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                  borderSide: BorderSide(color: HexColor("#025393"))
                              ),
                              hintText: "Alamat Tempat Usaha"
                          ),
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 14
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Dusun Tempat Usaha *",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14
                        ),
                      ),
                      margin: EdgeInsets.only(top: 20, left: 20),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        namaDusun,
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14,
                            fontWeight: FontWeight.w700
                        ),
                      ),
                      margin: EdgeInsets.only(top: 20),
                    ),
                    Container(
                      child: FlatButton(
                        onPressed: (){
                          navigatePilihDataDusun(context);
                        },
                        child: Text(
                          "Pilih Dusun Tempat Usaha",
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 14,
                              color: HexColor("#025393"),
                              fontWeight: FontWeight.w700
                          ),
                        ),
                        color: Colors.transparent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                            side: BorderSide(color: HexColor("#025393"), width: 2)
                        ),
                        padding: EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50),
                      ),
                      margin: EdgeInsets.only(top: 10),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "2. Gambar Lokasi Tempat Usaha",
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 14,
                      fontWeight: FontWeight.w700
                  ),
                ),
                margin: EdgeInsets.only(top: 30, left: 20),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "Silahkan lakukan upload gambar tempat usaha Anda. Usahakan gambar yang Anda unggah jelas dan tidak blur untuk mempermudah proses verifikasi",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14,
                  ),
                ),
                padding: EdgeInsets.only(left: 30, right: 30),
                margin: EdgeInsets.only(top: 10),
              ),
              Container(
                child: image == null ? Text('Gambar tempat usaha belum terpilih', style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14,
                    fontWeight: FontWeight.w700
                ),) : Image.file(image, height: 100, width: 100),
                margin: EdgeInsets.only(top: 20),
              ),
              Container(
                child: FlatButton(
                  onPressed: () async{
                    await choiceImage();
                  },
                  child: Text(
                    "Unggah Gambar Lokasi Usaha",
                    style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14,
                        color: HexColor("#025393"),
                        fontWeight: FontWeight.w700
                    ),
                  ),
                  color: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                      side: BorderSide(color: HexColor("#025393"), width: 2)
                  ),
                  padding: EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50),
                ),
                margin: EdgeInsets.only(top: 10, bottom: 30),
              ),
              Container(
                child: FlatButton(
                  onPressed: (){
                    if(namaDusun == "Data dusun belum terpilih" || controllerAlamat.text == "" || controllerNamaUsaha.text == "" || controllerJenisUsaha.text == "" || image == null) {
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
                                    child: Text(
                                      "Data ada yang belum terisi",
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: HexColor("#025393")
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    margin: EdgeInsets.only(top: 10),
                                  ),
                                  Container(
                                    child: Text(
                                      "Isikanlah semua data yang ada sebelum melanjutkan",
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 14
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
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
                        "nama_tempat_usaha" : controllerNamaUsaha.text,
                        "alamat" : controllerAlamat.text,
                        "jenis_usaha" : controllerJenisUsaha.text,
                        "nama_dusun" : namaDusun,
                        "penduduk_id" : loginPage.pendudukId,
                        "desa_id" : loginPage.desaId
                      });
                      http.post(Uri.parse(apiURLSKTempatUsaha),
                        headers: {"Content-Type" : "application/json"},
                        body: body
                      ).then((http.Response response) {
                        var responseValue = response.statusCode;
                        if(responseValue == 200) {
                          uploadImage();
                        }
                      });
                    }
                  },
                  child: Text("Ajukan SK Tempat Usaha", style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w700
                  )),
                  color: HexColor("#025393"),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)
                  ),
                  padding: EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50),
                ),
                margin: EdgeInsets.only(top: 20, bottom: 30),
              )
            ],
          ),
        ),
      ),
    );
  }

  void navigatePilihDataDusun(BuildContext context) async {
    final result = await Navigator.push(context, CupertinoPageRoute(builder: (context) => pilihDataDusun()));
    if(result == null) {
      namaDusun = namaDusun;
    }else{
      setState(() {
        namaDusun = result;
      });
    }
  }
}

class pilihDataDusun extends StatefulWidget {
  const pilihDataDusun({Key key}) : super(key: key);

  @override
  _pilihDataDusunState createState() => _pilihDataDusunState();
}

class _pilihDataDusunState extends State<pilihDataDusun> {
  var apiURLGetDataDusunByDesaId = "http://192.168.18.10:8000/api/dusun";

  Future<Dusun> functionListDusun() async {
    var body = jsonEncode({
      "desa_id" : loginPage.desaId
    });
    return http.post(Uri.parse(apiURLGetDataDusunByDesaId),
      headers: {"Content-Type" : "application/json"},
      body: body
    ).then((http.Response response) {
      if(response.statusCode == 200) {
        final body = response.body;
        final dusunData = dusunFromJson(body);
        return dusunData;
      }else{
        final body = response.body;
        final error = dusunFromJson(body);
        return error;
      }
    });
  }

  Widget listDusun() {
    return FutureBuilder<Dusun>(
      future: functionListDusun(),
      builder: (context, snapshot) {
        final data = snapshot.data;
        if(snapshot.hasData) {
          final dusunData = data.data;
          return ListView.builder(
            itemCount: dusunData.length,
            itemBuilder: (context, index) {
              final dusun = dusunData[index];
              return TextButton(
                onPressed: (){
                  Navigator.of(context, rootNavigator: true).pop(dusun.namaDusun);
                },
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          Container(
                            child: Image.asset(
                              'images/location.png',
                              height: 50,
                              width: 50,
                            ),
                          ),
                          Container(
                            child: Text(
                              dusun.namaDusun.toString(),
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w700,
                                color: Colors.black
                              ),
                            ),
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(left: 10),
                          )
                        ],
                      ),
                      padding: EdgeInsets.symmetric(vertical: 10),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.black26, width: 1))
                      ),
                    )
                  ],
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
          title: Text("Pilih Data Dusun", style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w700,
            color: HexColor("#025393")
          )),
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: HexColor("#025393"),
            onPressed: (){Navigator.of(context, rootNavigator: true).pop();},
          ),
        ),
        body: listDusun(),
      ),
    );
  }
}