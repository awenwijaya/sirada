import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:surat/AdminDesa/Dashboard.dart';
import 'package:surat/AdminDesa/DetailDesa/DetailDesa.dart';
import 'package:surat/LoginAndRegistration/LoginPage.dart';
import 'package:surat/shared/LoadingAnimation/loading.dart';

class addStrukturKepemimpinanDesa extends StatefulWidget {
  const addStrukturKepemimpinanDesa({Key key}) : super(key: key);

  @override
  _addStrukturKepemimpinanDesaState createState() => _addStrukturKepemimpinanDesaState();
}

class _addStrukturKepemimpinanDesaState extends State<addStrukturKepemimpinanDesa> {
  File image;
  final picker = ImagePicker();
  bool Loading = false;

  Future choiceImage() async {
    var pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      image = File(pickedImage.path);
    });
  }

  Future uploadImage() async {
    final uri = Uri.parse("http://192.168.18.10/siraja-api-skripsi/upload-struktur-desa.php");
    var request = http.MultipartRequest('POST', uri);
    request.fields['desa_id'] = loginPage.desaId.toString();
    var pic = await http.MultipartFile.fromPath("image", image.path);
    request.files.add(pic);
    var response = await request.send();
    if(response.statusCode == 200) {
      setState(() {
        Loading = false;
      });
      Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) => dashboardAdminDesa()), (route) => false);
    }else{
      print("Gambar gagal diupload");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Loading ? loading() : Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: HexColor("#025393"),
            onPressed: (){
              Navigator.of(context).pop();
            },
          ),
          title: Text("Tambah Struktur Kepemimpinan Desa", style: TextStyle(
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
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: detailDesaAdmin.logoDesa == null ? AssetImage('images/noimage.png') : NetworkImage('http://192.168.18.10/siraja-api-skripsi/${detailDesaAdmin.logoDesa}')
                        )
                      ),
                      margin: EdgeInsets.only(top: 20),
                    ),
                    Container(
                      child: Text("Struktur Kepemimpinan Desa", style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: HexColor("#025393")
                      )),
                      margin: EdgeInsets.only(top: 15),
                    )
                  ],
                ),
              ),
              Container(
                child: Text("Silahkan unggah berkas struktur kepemimpinan desa yang berupa gambar. Usahakan gambar yang Anda unggah terlihat jelas dan jernih", style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14
                ), textAlign: TextAlign.center),
                padding: EdgeInsets.symmetric(horizontal: 30),
                margin: EdgeInsets.only(top: 15),
              ),
              Container(
                child: image == null ? Text("Berkas belum terpilih", style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14,
                  fontWeight: FontWeight.w700
                )) : Image.file(image, height: MediaQuery.of(context).size.width * 0.9, width: MediaQuery.of(context).size.width * 0.9),
                margin: EdgeInsets.only(top: 20),
              ),
              Container(
                child: FlatButton(
                  onPressed: () async {
                    await choiceImage();
                  },
                  child: Text("Pilih Berkas", style: TextStyle(
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
                margin: EdgeInsets.only(top: 15, bottom: 30),
              ),
              Container(
                child: FlatButton(
                  onPressed: (){
                    if(image == null) {
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
                                    child: Text("Berkas belum terpilih", style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: HexColor("#025393")
                                    ), textAlign: TextAlign.center),
                                    margin: EdgeInsets.only(top: 10),
                                  ),
                                  Container(
                                    child: Text("Berkas struktur kepemimpinan desa belum terpilih. Silahkan pilih berkas terlebih dahulu sebelum melanjutkan", style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 14,
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
                      uploadImage();
                    }
                  },
                  child: Text("Unggah Berkas", style: TextStyle(
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
                margin: EdgeInsets.only(top: 20, bottom: 30),
              )
            ],
          ),
        ),
      ),
    );
  }
}