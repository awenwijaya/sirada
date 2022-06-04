import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  var apiURLEditProfile = "https://siradaskripsi.my.id/api/data/userdata/edit";
  var apiURLUploadProfilePicture = "https://siradaskripsi.my.id/api/upload/profile-picture";
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  FToast ftoast;

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
    if(cropped == null) {
      setState(() {
        image = null;
      });
    }else{
      setState(() {
        image = File(cropped.path);
      });
    }
  }

  Future uploadImage() async {
    Map<String, String> headers = {
      'Content-Type' : 'multipart/form-data'
    };
    Map<String, String> body = {
      'user_id' : loginPage.userId.toString()
    };
    var request = http.MultipartRequest('POST', Uri.parse(apiURLUploadProfilePicture))
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
                  child: Text("Profil berhasil diperbaharui", style: TextStyle(
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controllerUsername = new TextEditingController(text: adminProfile.usernamePenduduk);
    controllerPassword = new TextEditingController();
    controllerPasswordKonfirmasi = new TextEditingController();
    ftoast = FToast();
    ftoast.init(context);
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
          child: Form(
            key: formKey,
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
                              image: NetworkImage('https://storage.siradaskripsi.my.id/img/profile/${adminProfile.profilePicture}')
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
                          child: TextFormField(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if(value.isEmpty) {
                                return "Username tidak boleh kosong";
                              }else {
                                return null;
                              }
                            },
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
                          child: TextFormField(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if(value.isNotEmpty && value.length > 8) {
                                return "Password tidak boleh kurang dari 8 karakter";
                              }else {
                                return null;
                              }
                            },
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
                                  child: TextFormField(
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                      validator: (value) {
                                        if(value.isEmpty) {
                                          return "Password tidak boleh kosong";
                                        }else {
                                          return null;
                                        }
                                      },
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
                      if(formKey.currentState.validate()) {
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
                                            child: Text("Profil berhasil diperbaharui", style: TextStyle(
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
                            }else{
                              uploadImage();
                            }
                          }else if(responseValue == 501){
                            setState(() {
                              Loading = false;
                            });
                            ftoast.showToast(
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: Colors.redAccent
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      Icon(Icons.close),
                                      Container(
                                        margin: EdgeInsets.only(left: 15),
                                        child: SizedBox(
                                          width: MediaQuery.of(context).size.width * 0.65,
                                          child: Text("Username telah digunakan", style: TextStyle(
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
                          }else if(responseValue == 502){
                            setState(() {
                              Loading = false;
                            });
                            ftoast.showToast(
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: Colors.redAccent
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      Icon(Icons.close),
                                      Container(
                                        margin: EdgeInsets.only(left: 15),
                                        child: SizedBox(
                                          width: MediaQuery.of(context).size.width * 0.65,
                                          child: Text("Password Anda salah", style: TextStyle(
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
                          }
                        });
                      }else {
                        ftoast.showToast(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Colors.redAccent
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.close),
                                  Container(
                                      margin: EdgeInsets.only(left: 15),
                                      child: SizedBox(
                                          width: MediaQuery.of(context).size.width * 0.65,
                                          child: Text("Masih terdapat data yang kosong atau tidak valid. Silahkan diperiksa kembali", style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white
                                          ))
                                      )
                                  )
                                ],
                              ),
                            ),
                            toastDuration: Duration(seconds: 3)
                        );
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
      ),
    );
  }
}