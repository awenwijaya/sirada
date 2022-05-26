import 'dart:io';
import 'package:surat/AdminDesa/Dashboard.dart';
import 'package:surat/shared/LoadingAnimation/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:surat/AdminDesa/DetailDesa/DetailDesa.dart';
import 'package:surat/LoginAndRegistration/LoginPage.dart';
import 'package:fluttertoast/fluttertoast.dart';

class editLogoDesaAdmin extends StatefulWidget {
  const editLogoDesaAdmin({Key key}) : super(key: key);

  @override
  _editLogoDesaAdminState createState() => _editLogoDesaAdminState();
}

class _editLogoDesaAdminState extends State<editLogoDesaAdmin> {
  File image;
  final picker = ImagePicker();
  bool Loading = false;
  FToast ftoast;
  var apiURLUploadLogoDesa = "http://192.168.18.10:8000/api/upload/logo-desa";

  Future choiceImage() async {
    var pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      image = File(pickedImage.path);
    });
    cropImage();
  }

  Future uploadImage() async {
    Map<String, String> headers = {
      'Content-Type' : 'multipart/form-data'
    };
    Map<String, String> body = {
      'desa_id' : loginPage.desaId.toString()
    };
    var request = http.MultipartRequest('POST', Uri.parse(apiURLUploadLogoDesa))
      ..fields.addAll(body)
      ..headers.addAll(headers)
      ..files.add(await http.MultipartFile.fromPath('image', image.path));
    var response = await request.send();
    if(response.statusCode == 200) {
      setState(() {
        Loading = false;
      });
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
                    child: Text("Logo Desa berhasil diperbaharui", style: TextStyle(
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
      Navigator.pop(context, true);
    }else {
      print("Gambar gagal diupload");
    }
  }

  Future<void> cropImage() async {
    final cropped = await ImageCropper().cropImage(
      sourcePath: image.path,
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1)
    );
    if(cropped == null) {
      setState(() {
        image = null;
      });
    }else {
      setState(() {
        image = File(cropped.path);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ftoast = FToast();
    ftoast.init(context);
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
            onPressed: (){Navigator.of(context).pop();},
          ),
          title: Text("Edit Logo Desa", style: TextStyle(
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
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: image == null ? DecorationImage(
                        image: detailDesaAdmin.logoDesa == null ? AssetImage('images/noimage.png') : NetworkImage('http://192.168.18.10/SirajaProject/public/assets/img/logo-desa/${detailDesaAdmin.logoDesa}')
                    ) : DecorationImage(
                      image: FileImage(image)
                    )
                  ),
                ),
                margin: EdgeInsets.only(top: 30),
              ),
              Container(
                alignment: Alignment.center,
                child: Text("Silahkan unggah gambar logo desa yang baru, usahakan gambar logo desa yang akan diunggah terlihat jelas dan jernih", style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14
                ), textAlign: TextAlign.center),
                padding: EdgeInsets.symmetric(horizontal: 30),
                margin: EdgeInsets.only(top: 15),
              ),
              Container(
                child: FlatButton(
                  onPressed: () async {
                    await choiceImage();
                  },
                  child: Text("Pilih Logo Desa", style: TextStyle(
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
                                      child: Text("Logo desa belum terpilih", style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: HexColor("#025393")
                                      ), textAlign: TextAlign.center),
                                      margin: EdgeInsets.only(top: 10),
                                    ),
                                    Container(
                                      child: Text("Logo desa belum terpilih. Silahkan pilih logo desa terlebih dahulu sebelum melanjutkan", style: TextStyle(
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
                  child: Text("Unggah Logo Desa", style: TextStyle(
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