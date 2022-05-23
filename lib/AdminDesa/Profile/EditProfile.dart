import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:surat/AdminDesa/Profile/AdminProfile.dart';
import 'package:http/http.dart' as http;
import 'package:surat/LoginAndRegistration/LoginPage.dart';
import 'package:surat/shared/LoadingAnimation/loading.dart';

class editProfileAdmin extends StatefulWidget {
  editProfileAdmin({Key key}) : super(key: key);

  @override
  State<editProfileAdmin> createState() => _editProfileAdminState();
}

class _editProfileAdminState extends State<editProfileAdmin> {
  TextEditingController controllerUsername;
  TextEditingController controllerPassword;
  TextEditingController controllerPasswordKonfirmasi;
  final picker = ImagePicker();
  File image;
  List<String> agama = ["Hindu", "Buddha", "Kristen Katolik", "Kristen Protestan", "Islam", "Konghucu"];
  List<String> statusPerkawinan = ["Belum Menikah", "Sudah Menikah"];
  List<String> pendidikanTerakhir = ["SD", "SMP", "SMA", "D1", "D2", "D3", "D4/S1", "S2", "S3"];
  String selectedAgama = adminProfile.agamaPenduduk;
  String selectedStatusPerkawinan = adminProfile.statusPerkawinan;
  String selectedPendidikanTerakhir = adminProfile.pendidikanTerakhir;
  bool Loading = false;
  var apiURLEditProfile = "http://192.168.18.10:8000/api/data/userdata/edit";

  Future<void> choiceImage(ImageSource source) async {
    var pickedImage = await picker.pickImage(source: source);
    setState(() {
      image = File(pickedImage.path);
    });
    cropImage();
  }

  Future<void> cropImage() async {
    final cropped = await ImageCropper().cropImage(
        sourcePath: image.path,
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1)
    );
    setState(() {
      image = File(cropped.path);
    });
  }

  Future uploadImage() async {
    final uri = Uri.parse("http://192.168.18.10/siraja-api-skripsi-new/upload-profile-picture.php");
    var request = http.MultipartRequest('POST', uri);
    request.fields['user_id'] = loginPage.userId.toString();
    var pic = await http.MultipartFile.fromPath("image", image.path);
    request.files.add(pic);
    var response = await request.send();
    if(response.statusCode == 200) {
      setState(() {
        Loading = false;
      });
      Navigator.pop(context, true);
    }else{
      print("Gambar gagal diupload");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controllerUsername = new TextEditingController(text: adminProfile.usernamePenduduk);
    controllerPassword = new TextEditingController();
    controllerPasswordKonfirmasi = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Loading ? loading() : Scaffold(
        appBar: AppBar(
          title: Text("Edit Profil", style: TextStyle(
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
                child: image == null ? Container(
                  child: adminProfile.profilePicture == null ? Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage('images/profilepic.png'),
                            fit: BoxFit.fill
                        )
                    ),
                  ) : Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage('http://192.168.18.10/siraja-api-skripsi-new/${adminProfile.profilePicture}')
                        )
                    ),
                  ),
                ) : Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: FileImage(image)
                    )
                  ),
                ),
                margin: EdgeInsets.only(top: 30),
              ),
              Container(
                child: Text("Edit Profil", style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: HexColor("#025393")
                ), textAlign: TextAlign.center),
                margin: EdgeInsets.only(top: 20),
              ),
              Container(
                child: Text("* = diperlukan", style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14,
                  fontWeight: FontWeight.w700
                ), textAlign: TextAlign.center),
                margin: EdgeInsets.only(top: 10)
              ),
              Container(
                alignment: Alignment.center,
                child: FlatButton(
                  onPressed: () async {
                    await choiceImage(ImageSource.gallery);
                  },
                  child: Text("Ubah foto profil", style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 14,
                      color: HexColor("#025393"),
                      fontWeight: FontWeight.w700
                  )),
                  color: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                      side: BorderSide(color: HexColor("#025393"))
                  ),
                  padding: EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50),
                ),
                margin: EdgeInsets.only(top: 30),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Username *",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 14
                        ),
                      ),
                      margin: EdgeInsets.only(top: 30, left: 20),
                    ),
                    Container(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                        child: TextField(
                          controller: controllerUsername,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              borderSide: BorderSide(color: HexColor("#025393"))
                            ),
                            prefixIcon: Icon(Icons.person_outline_rounded),
                            hintText: "Username"
                          ),
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Password Baru (kosongkan jika tidak ingin diubah)",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14
                        ),
                      ),
                      margin: EdgeInsets.only(top: 15, left: 20),
                    ),
                    Container(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                        child: TextField(
                          controller: controllerPassword,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                  borderSide: BorderSide(color: HexColor("#025393"))
                              ),
                              prefixIcon: Icon(Icons.lock),
                              hintText: "Password",
                          ),
                          obscureText: true,
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 14
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text("Password Anda *", style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14
                      )),
                      margin: EdgeInsets.only(top: 15, left: 20)
                    ),
                    Container(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                        child: TextField(
                          controller: controllerPasswordKonfirmasi,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              borderSide: BorderSide(color: HexColor("#025393"))
                            ),
                            prefixIcon: Icon(Icons.lock),
                            hintText: "Password Anda"
                          ),
                          obscureText: true,
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14
                          )
                        )
                      )
                    )
                  ]
                )
              ),
              Container(
                child: FlatButton(
                  onPressed: (){
                    if(controllerUsername.text == "" || controllerPasswordKonfirmasi.text == "") {
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
                                        "Masih terdapat data yang kosong",
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
                                        "Masih terdapat data yang kosong. Silahkan isi semua data yang ditampilkan pada form ini dan silahkan coba lagi",
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
                        "user_id" : loginPage.userId,
                        "username" : controllerUsername.text,
                        "password_sekarang" : controllerPasswordKonfirmasi.text,
                        "password" : controllerPassword.text == "" ? controllerPasswordKonfirmasi.text : controllerPassword.text
                      });
                      http.post(Uri.parse(apiURLEditProfile),
                          headers: {"Content-Type" : "application/json"},
                          body: body
                      ).then((http.Response response) {
                        var responseValue = response.statusCode;
                        if(responseValue == 200) {
                          if(image == null) {
                            setState(() {
                              Loading = false;
                            });
                            Navigator.pop(context, true);
                          }else{
                            uploadImage();
                          }
                        }else if(responseValue == 501){
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
                                        ),
                                      ),
                                      Container(
                                        child: Text("Username telah dipakai", style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: HexColor("#025393")
                                        ), textAlign: TextAlign.center),
                                        margin: EdgeInsets.only(top: 10),
                                      ),
                                      Container(
                                        child: Text("Username yang Anda masukkan sudah terdaftar sebelumnya. Silahkan gunakan username yang lain", style: TextStyle(
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
                        }else if(responseValue == 502){
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
                                          width: 50
                                        )
                                      ),
                                      Container(
                                        child: Text("Password Anda salah", style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: HexColor("#025393")
                                        ), textAlign: TextAlign.center),
                                        margin: EdgeInsets.only(top: 10)
                                      ),
                                      Container(
                                        child: Text("Password Anda salah. Silahkan inputkan ulang password Anda sebelum dapat melakukan proses edit profil", style: TextStyle(
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
                        }
                      });
                    }
                  },
                  child: Text("Simpan", style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 14,
                      color: HexColor("#025393"),
                      fontWeight: FontWeight.w700
                  )),
                  color: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                      side: BorderSide(color: HexColor("#025393"), width: 2)
                  ),
                  padding: EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50),
                ),
                margin: EdgeInsets.only(bottom: 20, top: 30),
              )
            ],
          ),
        ),
      ),
    );
  }
}