import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:surat/LoginAndRegistration/LoginPage.dart';
import 'package:http/http.dart' as http;
import 'package:surat/main.dart';
import 'package:surat/shared/LoadingAnimation/loading.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';

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
  var selectedRole;
  var apiURLUpDataPrajuruDesaAdat = "http://siradaskripsi.my.id/api/admin/prajuru/desa_adat/up";
  var apiURLUploadFileSKPrajuru = "http://192.168.18.10/sirada-api/upload-file-sk-prajuru.php";
  bool Loading = false;
  final DateRangePickerController controllerMasaAktif = DateRangePickerController();
  File file;
  String namaFile;
  String filePath;
  FToast ftoast;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void selectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      selectMasaBerakhir = args.value.endDate;
      selectedMasaMulai = DateFormat("dd-MMM-yyyy").format(args.value.startDate).toString();
      selectedMasaMulaiValue = DateFormat("yyyy-MM-dd").format(args.value.startDate).toString();
      selectedMasaBerakhir = DateFormat("dd-MMM-yyyy").format(args.value.endDate ?? args.value.startDate).toString();
      selectedMasaBerakhirValue = DateFormat("yyyy-MM-dd").format(args.value.endDate ?? args.value.startDate).toString();
    });
  }

  Future pilihBerkas() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      allowMultiple: false
    );
    if(result != null) {
      setState(() {
        filePath = result.files.first.path;
        namaFile = result.files.first.name;
        file = File(result.files.single.path);
      });
      print(filePath);
      print(namaFile);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedMasaMulai = DateFormat("dd-MMM-yyyy").format(sekarang).toString();
    selectedMasaBerakhir = DateFormat("dd-MMM-yyyy").format(sekarang.add(Duration(days: 7))).toString();
    controllerMasaAktif.selectedRange = PickerDateRange(sekarang, sekarang.add(Duration(days: 7)));
    ftoast = FToast();
    ftoast.init(this.context);
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
            onPressed: (){Navigator.of(context).pop(true);},
          ),
          title: Text("Tambah Prajuru Desa Adat", style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w700,
            color: HexColor("#025393")
          ))
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
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
                      child: Text("1. Data Prajuru *", style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 14,
                          fontWeight: FontWeight.w700
                      )),
                      margin: EdgeInsets.only(top: 30, left: 20)
                  ),
                  Container(
                      alignment: Alignment.topLeft,
                      child: Text("Silahkan pilih data prajuru yang akan Anda tambahkan dengan menekan tombol Pilih Data Prajuru.", style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 14
                      )),
                      padding: EdgeInsets.only(left: 30, right: 30),
                      margin: EdgeInsets.only(top: 10)
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(namaPegawai == null ? "Data prajuru belum terpilih" : "${namaPegawai}",
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
                        child: Text("Pilih Data Prajuru", style: TextStyle(
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
                                        child: Text("Masa Menjabat *", style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 14
                                        )),
                                        margin: EdgeInsets.only(top: 20, left: 20),
                                      ),
                                      Container(
                                          child: Text(selectedMasaMulaiValue == null ? "Masa aktif belum terpilih" : selectedMasaBerakhirValue == null ? "$selectedMasaMulai - $selectedMasaMulai" : "$selectedMasaMulai - $selectedMasaBerakhir", style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700
                                          )),
                                          margin: EdgeInsets.only(top: 10)
                                      ),
                                      Container(
                                          child: Card(
                                              margin: EdgeInsets.fromLTRB(50, 40, 50, 10),
                                              child: SfDateRangePicker(
                                                controller: controllerMasaAktif,
                                                selectionMode: DateRangePickerSelectionMode.range,
                                                onSelectionChanged: selectionChanged,
                                                allowViewNavigation: false,
                                              )
                                          )
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
                              child: Text("Silahkan isi informasi email pada form dibawah. Data email ini nantinya akan digunakan oleh prajuru untuk melakukan proses login.", style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14
                              )),
                              padding: EdgeInsets.only(left: 30, right: 30),
                              margin: EdgeInsets.only(top: 10),
                            ),
                            Container(
                              child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                                  child: TextFormField(
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    validator: (value) {
                                      if(value.isNotEmpty && RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
                                        return null;
                                      }else if(value.isEmpty) {
                                        return "Data tidak boleh kosong";
                                      }else{
                                        return "Masukkan email yang valid";
                                      }
                                    },
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
                                          hintText: "Data prajuru belum terpilih",
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
                                alignment: Alignment.topLeft,
                                child: Text("4. File SK", style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700
                                )),
                                margin: EdgeInsets.only(top: 30, left: 20)
                            ),
                            Container(
                                child: Text("Silahkan unggah File SK (PDF) dari Prajuru yang akan Anda tambahkan.", style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 14
                                )),
                                padding: EdgeInsets.only(left: 30, right: 30),
                                margin: EdgeInsets.only(top: 10)
                            ),
                            Container(
                                child: namaFile == null ? Text("Berkas lampiran belum terpilih", style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700
                                )) : Text("Nama berkas: ${namaFile}", style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700
                                )),
                                margin: EdgeInsets.only(top: 10)
                            ),
                            Container(
                                child: FlatButton(
                                    onPressed: (){
                                      pilihBerkas();
                                    },
                                    child: Text("Unggah Berkas", style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white
                                    )),
                                    color: HexColor("#025393"),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                        side: BorderSide(color: HexColor("#025393"), width: 2)
                                    ),
                                    padding: EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50)
                                ),
                                margin: EdgeInsets.only(top: 20)
                            ),
                            Container(
                              child: FlatButton(
                                onPressed: () async {
                                  if(selectedStatus == null || selectedJabatan == null || selectedMasaBerakhirValue == null || selectedMasaMulaiValue == null || kramaMipilID == null || file == null) {
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
                                                child: Text("Masih terdapat data yang kosong. Silahkan diperiksa kembali", style: TextStyle(
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
                                  }else if(formKey.currentState.validate()) {
                                    if(selectedStatus == "Aktif") {
                                      if(selectMasaBerakhir.isBefore(sekarang)) {
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
                                                    child: Text("Masa jabatan tidak valid. Silahkan masukkan tanggal masa akhir setelah tanggal hari ini dan coba lagi", style: TextStyle(
                                                      fontFamily: "Poppins",
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w700,
                                                      color: Colors.white
                                                    )),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          toastDuration: Duration(seconds: 3)
                                        );
                                      }else{
                                        if(selectedJabatan == "bendesa") {
                                          setState(() {
                                            selectedRole = "Bendesa";
                                          });
                                        }else if(selectedJabatan == "penyarikan"){
                                          setState(() {
                                            selectedRole = "Penyarikan";
                                          });
                                        }else{
                                          setState(() {
                                            selectedRole = "Admin";
                                          });
                                        }
                                        setState(() {
                                          Loading = true;
                                          statusValue = "aktif";
                                        });
                                        var stream = http.ByteStream(DelegatingStream.typed(file.openRead()));
                                        var length = await file.length();
                                        var url = Uri.parse(apiURLUploadFileSKPrajuru);
                                        var request = http.MultipartRequest("POST", url);
                                        var multipartFile = http.MultipartFile("dokumen", stream, length, filename: basename(file.path));
                                        request.files.add(multipartFile);
                                        var response = await request.send();
                                        print(response.statusCode);
                                        if(response.statusCode == 200) {
                                          var body = jsonEncode({
                                            "krama_mipil_id" : kramaMipilID,
                                            "status" : statusValue,
                                            "tanggal_mulai_menjabat" : selectedMasaMulaiValue,
                                            "tanggal_akhir_menjabat" : selectedMasaBerakhirValue,
                                            "email" : controllerEmail.text,
                                            "password" : controllerPassword.text,
                                            "desa_adat_id" : loginPage.desaId,
                                            "jabatan" : selectedJabatan,
                                            "penduduk_id" : pegawaiID,
                                            "role" : selectedRole,
                                            "sk_prajuru" : namaFile
                                          });
                                          http.post(Uri.parse(apiURLUpDataPrajuruDesaAdat),
                                              headers : {"Content-Type" : "application/json"},
                                              body: body
                                          ).then((http.Response response) {
                                            var responseValue = response.statusCode;
                                            print(responseValue);
                                            if(responseValue == 501) {
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
                                                            child: Text("Prajuru sudah terdaftar", style: TextStyle(
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
                                            }else if(responseValue == 502) {
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
                                                          child: Text("Email sudah terdaftar. Silahkan gunakan email lain dan coba lagi", style: TextStyle(
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
                                            }else if(responseValue == 200){
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
                                                            child: Text("Prajuru Desa Adat berhasil terdaftar", style: TextStyle(
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
                                              Navigator.of(context).pop(true);
                                            }
                                          });
                                        }
                                      }
                                    }else{
                                      if(sekarang.isBefore(selectMasaBerakhir)) {
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
                                                      child: Text("Masa jabatan tidak valid. Silahkan masukkan tanggal masa akhir sebelum tanggal hari ini dan coba lagi", style: TextStyle(
                                                          fontFamily: "Poppins",
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w700,
                                                          color: Colors.white
                                                      )),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            toastDuration: Duration(seconds: 3)
                                        );
                                      }else{
                                        setState(() {
                                          statusValue = "tidak aktif";
                                          Loading = true;
                                        });
                                        if(selectedJabatan == "bendesa") {
                                          setState(() {
                                            selectedRole = "Bendesa";
                                          });
                                        }else if(selectedJabatan == "penyarikan"){
                                          setState(() {
                                            selectedRole = "Penyarikan";
                                          });
                                        }else{
                                          setState(() {
                                            selectedRole = "Admin";
                                          });
                                        }
                                        var stream = http.ByteStream(DelegatingStream.typed(file.openRead()));
                                        var length = await file.length();
                                        var url = Uri.parse(apiURLUploadFileSKPrajuru);
                                        var request = http.MultipartRequest("POST", url);
                                        var multipartFile = http.MultipartFile("dokumen", stream, length, filename: basename(file.path));
                                        request.files.add(multipartFile);
                                        var response = await request.send();
                                        print(response.statusCode);
                                        if(response.statusCode == 200) {
                                          var body = jsonEncode({
                                            "krama_mipil_id" : kramaMipilID,
                                            "status" : statusValue,
                                            "tanggal_mulai_menjabat" : selectedMasaMulaiValue,
                                            "tanggal_akhir_menjabat" : selectedMasaBerakhirValue,
                                            "email" : controllerEmail.text,
                                            "password" : controllerPassword.text,
                                            "desa_adat_id" : loginPage.desaId,
                                            "jabatan" : selectedJabatan,
                                            "penduduk_id" : pegawaiID,
                                            "role" : selectedRole,
                                            "sk_prajuru" : namaFile
                                          });
                                          http.post(Uri.parse(apiURLUpDataPrajuruDesaAdat),
                                              headers : {"Content-Type" : "application/json"},
                                              body: body
                                          ).then((http.Response response) {
                                            var responseValue = response.statusCode;
                                            print(responseValue);
                                            if(responseValue == 501) {
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
                                                            child: Text("Prajuru sudah terdaftar", style: TextStyle(
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
                                            }else if(responseValue == 502) {
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
                                                            child: Text("Email sudah terdaftar. Silahkan gunakan email lain dan coba lagi", style: TextStyle(
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
                                            }else if(responseValue == 200){
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
                                                            child: Text("Prajuru Desa Adat berhasil terdaftar", style: TextStyle(
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
                                              Navigator.of(context).pop(true);
                                            }
                                          });
                                        }
                                      }
                                    }
                                  }else{
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
                                                child: Text("Masih terdapat data yang kosong atau tidak valid. Silahkan diperiksa kembali", style: TextStyle(
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
                                },
                                child: Text("Simpan Prajuru", style: TextStyle(
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
            ),
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
          title: Text("Pilih Data Prajuru", style: TextStyle(
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