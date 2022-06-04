import 'dart:convert';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:surat/shared/LoadingAnimation/loading.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:surat/LoginAndRegistration/LoginPage.dart';

class tambahPanitiaKegiatanAdmin extends StatefulWidget {
  const tambahPanitiaKegiatanAdmin({Key key}) : super(key: key);

  @override
  State<tambahPanitiaKegiatanAdmin> createState() => _tambahPanitiaKegiatanAdminState();
}

class _tambahPanitiaKegiatanAdminState extends State<tambahPanitiaKegiatanAdmin> {
  //List
  List panitiaKegiatanList = List();
  List<String> jabatan = ['Ketua Panitia', 'Wakil Panitia', 'Sekretaris Panitia', 'Bendahara Panitia'];
  List<String> status = ['aktif', 'tidak aktif'];

  //Selected
  var selectedIdPanitiaKegiatan;
  var selectedIdKrama;
  var selectedJabatan;
  String selectedPeriodeMulai;
  String selectedPeriodeMulaiValue;
  String selectedPeriodeBerakhir;
  String selectedPeriodeBerakhirValue;
  String selectedStatus;
  var namaPanitia;
  var kramaMipilId;
  var pendudukId;
  var nikPanitia;

  //DateTime
  DateTime selectPeriodeMulai;
  DateTime selectPeriodeSelesai;
  DateTime sekarang = DateTime.now();

  //URL
  var apiURLGetPanitiaKegiatan = "https://siradaskripsi.my.id/api/panitia/kegiatan/view";
  var apiURLSimpanPanitiaKegiatan = "https://192.168.18.10:8000/api/panitia/save";

  //Bool
  bool availablePanitiaKegiatan = false;
  bool LoadingPanitiaKegiatan = true;
  bool Loading = false;

  //Toast & Form Key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  FToast ftoast;

  //Controller
  final controllerNamaTimKegiatan = TextEditingController();
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  final DateRangePickerController controllerPeriode = DateRangePickerController();
  final controllerNamaPanitia = TextEditingController();

  Future getPanitiaKegiatan() async {
    Uri uri = Uri.parse(apiURLGetPanitiaKegiatan);
    final response = await http.get(uri);
    if(response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        panitiaKegiatanList = jsonData;
        LoadingPanitiaKegiatan = false;
        availablePanitiaKegiatan = true;
      });
    }else {
      setState(() {
        setState(() {
          availablePanitiaKegiatan = false;
          LoadingPanitiaKegiatan = false;
        });
      });
    }
  }

  void SelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      selectPeriodeSelesai = args.value.endDate;
      selectedPeriodeMulai = DateFormat("dd-MMM-yyyy").format(args.value.startDate).toString();
      selectedPeriodeMulaiValue = DateFormat("yyyy-MM-dd").format(args.value.startDate).toString();
      selectedPeriodeBerakhir = DateFormat("dd-MMM-yyyy").format(args.value.endDate?? args.value.startDate).toString();
      selectedPeriodeBerakhirValue = DateFormat("dd-MMM-yyyy").format(args.value.endDate ?? args.value.startDate).toString();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ftoast = FToast();
    ftoast.init(this.context);
    getPanitiaKegiatan();
    selectedPeriodeMulai = DateFormat("dd-MMM-yyyy").format(sekarang).toString();
    selectedPeriodeBerakhir = DateFormat("dd-MMM-yyyy").format(sekarang.add(Duration(days: 7)));
    controllerPeriode.selectedRange = PickerDateRange(sekarang, sekarang.add(Duration(days: 7)));
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
          title: Text("Tambah Panitia Kegiatan", style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w700,
            color: HexColor("#025393")
          )),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'images/panitia.png',
                    height: 100,
                    width: 100,
                  ),
                  margin: EdgeInsets.only(top: 30)
                ),
                Container(
                  child: Text("* = diperlukan", style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14,
                    fontWeight: FontWeight.w700
                  ), textAlign: TextAlign.center),
                  margin: EdgeInsets.only(top: 20),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text("1. Data Tim Kegiatan Kepanitiaan *", style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14,
                    fontWeight: FontWeight.w700
                  )),
                  margin: EdgeInsets.only(top: 30, left: 20),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text("Silahkan pilih tim kegiatan kepanitiaan terlebih dahulu.", style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14
                  )),
                  padding: EdgeInsets.only(left: 30, right: 30),
                  margin: EdgeInsets.only(top: 10),
                ),
                Container(
                  alignment: Alignment.center,
                  child: LoadingPanitiaKegiatan ? ListTileShimmer() : availablePanitiaKegiatan ? Container(
                    width: 300,
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    decoration: BoxDecoration(
                      color: HexColor("#025393"),
                      borderRadius: BorderRadius.circular(30)
                    ),
                    child: DropdownButton(
                      isExpanded: true,
                      hint: Center(
                        child: Text("Pilih Panitia Kegiatan", style: TextStyle(
                          fontFamily: "Poppins",
                          color: Colors.white,
                          fontSize: 14
                        )),
                      ),
                      value: selectedIdPanitiaKegiatan,
                      underline: Container(),
                      icon: Icon(Icons.arrow_downward, color: Colors.white),
                      items: panitiaKegiatanList.map((panitiaKegiatan) {
                        return DropdownMenuItem(
                          value: panitiaKegiatan['kegiatan_panitia_id'],
                          child: Text(panitiaKegiatan['panitia'], style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14
                          )),
                        );
                      }).toList(),
                      selectedItemBuilder: (BuildContext context) => panitiaKegiatanList.map((panitiaKegiatan) => Center(
                        child: Text(panitiaKegiatan['panitia'], style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 14,
                          color: Colors.white
                        )),
                      )).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedIdPanitiaKegiatan = value;
                        });
                      },
                    ),
                    margin: EdgeInsets.only(top: 15),
                  ) : Container(
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          child: Flexible(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  child: Text("Tidak ada Data Tim Kegiatan Kepanitiaan", style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white
                                  )),
                                ),
                                Container(
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.7,
                                    child: Text("Silahkan inputkan nama tim kegiatan kepanitiaan pada Text Box dibawah", style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 14,
                                      color: Colors.white
                                    )),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: HexColor("B20600"),
                      borderRadius: BorderRadius.circular(25)
                    ),
                    padding: EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
                    margin: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 5),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text("Jika tim kegiatan kepanitiaan tidak terdaftar di dalam list, silahkan masukkan nama tim kegiatan kepanitiaan secara manual.", style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 14
                  )),
                  padding: EdgeInsets.only(left: 30, right: 30),
                  margin: EdgeInsets.only(top: 15),
                ),
                Container(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if(value.isEmpty && selectedIdPanitiaKegiatan == null) {
                          return "Data tim kegiatan kepanitiaan tidak boleh kosong";
                        }else if(value.isNotEmpty && selectedIdPanitiaKegiatan != null) {
                          return "Data tidak perlu diisi";
                        }else {
                          return null;
                        }
                      },
                      controller: controllerNamaTimKegiatan,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          borderSide: BorderSide(color: HexColor("#025393"))
                        ),
                        hintText: "Tim Kegiatan Kepanitiaan"
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
                  child: Text("2. Data Diri", style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14,
                    fontWeight: FontWeight.w700
                  )),
                  margin: EdgeInsets.only(top: 30, left: 20)
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text("Silahkan isi data diri panitia kegiatan sebenar-benarnya. Data ini akan digunakan pada saat proses pembuatan surat keluar panitia", style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14
                  )),
                  padding: EdgeInsets.only(left: 30, right: 30),
                  margin: EdgeInsets.only(top: 10),
                ),
                Container(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 28,vertical: 8),
                    child: TextField(
                      controller: controllerNamaPanitia,
                      enabled: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          borderSide: BorderSide(color: HexColor("#025393"))
                        ),
                        hintText: "Data Panitia belum terpilih",
                        prefixIcon: Icon(CupertinoIcons.person_alt)
                      ),
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14
                      ),
                    ),
                  ),
                  margin: EdgeInsets.only(top: 10),
                ),
                Container(
                  child: FlatButton(
                    onPressed: (){
                      navigatePilihDataPegawai(context);
                    },
                    child: Text("Pilih Panitia", style: TextStyle(
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
                            )),
                          ),
                          icon: Icon(Icons.arrow_downward, color: Colors.white),
                          isExpanded: true,
                          items: jabatan.map((e) {
                            return DropdownMenuItem(
                              value: e,
                              child: Text(e, style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14
                              )),
                            );
                          }).toList(),
                          selectedItemBuilder: (BuildContext context) => jabatan.map((e) => Center(
                            child: Text(e, style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontFamily: "Poppins"
                            )),
                          )).toList(),
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
                        alignment: Alignment.topLeft,
                        child: Text("Status *", style: TextStyle(
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
                              selectedStatus = value;
                            });
                          },
                          value: selectedStatus,
                          underline: Container(),
                          hint: Center(
                            child: Text("Pilih Status", style: TextStyle(
                              fontFamily: "Poppins",
                              color: Colors.white,
                              fontSize: 14
                            )),
                          ),
                          icon: Icon(Icons.arrow_downward, color: Colors.white),
                          isExpanded: true,
                          items: status.map((e) {
                            return DropdownMenuItem(
                              value: e,
                              child: Text(e, style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14
                              )),
                            );
                          }).toList(),
                          selectedItemBuilder: (BuildContext context) => status.map((e) => Center(
                            child: Text(e, style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontFamily: "Poppins",
                            )),
                          )).toList(),
                        ),
                        margin: EdgeInsets.only(top: 10),
                      )
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text("Periode Menjabat *", style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 14
                        )),
                        margin: EdgeInsets.only(top: 20, left: 20),
                      ),
                      Container(
                        child: Text(selectedPeriodeMulaiValue == null ? "Masa periode menjabat belum terpilih" : selectedPeriodeBerakhirValue == null ? "$selectedPeriodeMulai - $selectedPeriodeMulai" : "$selectedPeriodeMulai - $selectedPeriodeBerakhir", style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 14,
                          fontWeight: FontWeight.w700
                        )),
                        margin: EdgeInsets.only(top: 10),
                      ),
                      Container(
                        child: Card(
                          margin: EdgeInsets.fromLTRB(50, 10, 50, 10),
                          child: SfDateRangePicker(
                            controller: controllerPeriode,
                            selectionMode: DateRangePickerSelectionMode.range,
                            onSelectionChanged: SelectionChanged,
                            allowViewNavigation: true,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text("3. Data Akun", style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14,
                    fontWeight: FontWeight.w700
                  )),
                  margin: EdgeInsets.only(top: 30, left: 20)
                ),
                Container(
                  child: Text("Silahkan isi informasi email pada form dibawah. Data email ini nantinya akan digunakan oleh panitia untuk melakukan login.", style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14
                  )),
                  padding: EdgeInsets.only(left: 30, right: 30),
                  margin: EdgeInsets.only(top: 10)
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
                    ),
                  ),
                  margin: EdgeInsets.only(top: 10),
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
                        hintText: "Data panitia belum terpilih",
                        prefixIcon: Icon(Icons.lock_rounded)
                      ),
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14
                      ),
                    ),
                  ),
                ),
                Container(
                  child: FlatButton(
                    onPressed: (){
                      if(kramaMipilId == null || selectedJabatan == null || selectedStatus == null || selectedPeriodeMulaiValue == null) {
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
                        if(selectedStatus == "aktif" && selectPeriodeSelesai.isBefore(sekarang)) {
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
                                        child: Text("Periode selesai tidak valid. Silahkan masukkan tanggal periode selesai setelah tanggal hari ini dan coba lagi", style: TextStyle(
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
                        }else if(selectedStatus == "tidak aktif" && sekarang.isBefore(selectPeriodeSelesai)) {
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
                                        child: Text("Periode selesai tidak valid. Silahkan masukkan tanggal periode selesai sebelum tanggal hari ini dan coba lagi", style: TextStyle(
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
                        }else {
                          setState(() {
                            Loading = true;
                          });
                          var body = jsonEncode({
                            "kegiatan_panitia": controllerNamaTimKegiatan.text == "" ? null : controllerNamaTimKegiatan.text,
                            "desa_adat_id" : loginPage.desaId,
                            "krama_mipil_id" : kramaMipilId,
                            "jabatan" : selectedJabatan,
                            "status_panitia_desa_adat" : selectedStatus,
                            "tanggal_mulai_menjabat" : selectedPeriodeMulaiValue.toString(),
                            "tanggal_akhir_menjabat" : selectedPeriodeBerakhirValue.toString(),
                            "email" : controllerEmail.text,
                            "password" : controllerPassword.text,
                            "kegiatan_panitia_id" : selectedIdPanitiaKegiatan == null ? null : selectedIdPanitiaKegiatan,
                            "penduduk_id" : pendudukId
                          });
                          http.post(Uri.parse(apiURLSimpanPanitiaKegiatan),
                            headers: {"Content-Type" : "application/json"},
                            body: body
                          ).then((http.Response response) {
                            var responseValue = response.statusCode;
                            print(responseValue.toString());
                            if(responseValue == 502) {
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
                            }else if(response.statusCode == 200) {
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
                                            child: Text("Panitia kegiatan berhasil terdaftar", style: TextStyle(
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
                    },
                    child: Text("Simpan", style: TextStyle(
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
              ],
            )
          )
        ),
      ),
    );
  }

  void navigatePilihDataPegawai(BuildContext context) async {
    final result = await Navigator.push(context, CupertinoPageRoute(builder: (context) => pilihDataPanitia()));
    if(result == null) {
      namaPanitia = namaPanitia;
    }else {
      setState(() {
        namaPanitia = result;
        kramaMipilId = pilihDataPanitia.selectedKramaMipilId;
        pendudukId = pilihDataPanitia.selectedPendudukId;
        controllerNamaPanitia.text = "${pilihDataPanitia.selectedNIK} - ${namaPanitia}";
        controllerPassword.text = pilihDataPanitia.selectedNIK;
      });
    }
  }
}

class pilihDataPanitia extends StatefulWidget {
  static var selectedKramaMipilId;
  static var selectedPendudukId;
  static var selectedNIK;
  const pilihDataPanitia({Key key}) : super(key: key);

  @override
  State<pilihDataPanitia> createState() => _pilihDataPanitiaState();
}

class _pilihDataPanitiaState extends State<pilihDataPanitia> {
  var apiURLGetDataPenduduk = "https://siradaskripsi.my.id/api/data/penduduk/desa_adat/${loginPage.desaId}";
  var nikPenduduk = [];
  var namaPenduduk = [];
  var kramaMipilID = [];
  var pendudukID = [];
  bool Loading = true;

  Future getListPenduduk() async {
    Uri uri = Uri.parse(apiURLGetDataPenduduk);
    final response = await http.get(uri);
    if(response.statusCode == 200) {
      var data = json.decode(response.body);
      this.nikPenduduk = [];
      this.namaPenduduk = [];
      this.kramaMipilID = [];
      this.pendudukID = [];
      setState(() {
        Loading = false;
        for(var i = 0; i < data.length; i++) {
          this.nikPenduduk.add(data[i]['nik']);
          this.namaPenduduk.add(data[i]['nama']);
          this.kramaMipilID.add(data[i]['krama_mipil_id']);
          this.pendudukID.add(data[i]['penduduk_id']);
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
          title: Text("Pilih Panitia", style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w700,
            color: HexColor("#025393")
          )),
        ),
        body: Loading ? Center(
          child: Lottie.asset('assets/loading-circle.json'),
        ) : RefreshIndicator(
          onRefresh: getListPenduduk,
          child: ListView.builder(
            itemCount: kramaMipilID.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: (){
                  setState(() {
                    pilihDataPanitia.selectedNIK = nikPenduduk[index];
                    pilihDataPanitia.selectedKramaMipilId = kramaMipilID[index];
                    pilihDataPanitia.selectedPendudukId = pendudukID[index];
                  });
                  Navigator.of(context, rootNavigator: true).pop(namaPenduduk[index]);
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
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: Text("${namaPenduduk[index]}",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: HexColor("#025393")
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              child: Text("${nikPenduduk[index]}", style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14,
                                color: Colors.black26
                              )),
                            )
                          ],
                        ),
                        margin: EdgeInsets.only(left: 15),
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
          ),
        ),
      ),
    );
  }
}