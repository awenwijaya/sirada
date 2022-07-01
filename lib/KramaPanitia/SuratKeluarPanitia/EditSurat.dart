import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:simple_time_range_picker/simple_time_range_picker.dart';
import 'package:surat/LoginAndRegistration/LoginPage.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:surat/shared/LoadingAnimation/loading.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:surat/KramaPanitia/Dashboard.dart';
import 'package:surat/KramaPanitia/SuratKeluarPanitia/DetailSurat.dart';

class editSuratKeluarPanitia extends StatefulWidget {
  static var idSuratKeluar;
  const editSuratKeluarPanitia({Key key}) : super(key: key);

  @override
  State<editSuratKeluarPanitia> createState() => _editSuratKeluarPanitiaState();
}

class _editSuratKeluarPanitiaState extends State<editSuratKeluarPanitia> {
  var apiURLShowDataEditSuratKeluar = "https://siradaskripsi.my.id/api/admin/surat/keluar/panitia/edit/${editSuratKeluarPanitia.idSuratKeluar}";
  var apiURLShowKodeSurat = "https://siradaskripsi.my.id/api/data/admin/surat/non-panitia/kode/${loginPage.desaId}";
  var apiURLShowKomponenNomorSurat = "https://siradaskripsi.my.id/api/data/admin/surat/nomor_surat/${loginPage.desaId}";
  var apiURLGetDataBendesaAdat = "https://siradaskripsi.my.id/api/data/staff/prajuru/desa_adat/bendesa/${loginPage.desaId}";
  var apiURLGetKelihanAdat = "https://siradaskripsi.my.id/api/data/staff/prajuru_banjar_adat/kelihan_adat";
  var apiURLGetBendesa = "https://siradaskripsi.my.id/api/data/staff/prajuru_desa_adat/bendesa";
  var apiURLGetPanitiaAcara = "https://siradaskripsi.my.id/api/panitia/get/${loginPage.kramaId}";
  var apiURLGetPanitia = "https://siradaskripsi.my.id/api/panitia/get";
  var apiURLShowPrajuru = "https://siradaskripsi.my.id/api/data/admin/surat/keluar/prajuru/${editSuratKeluarPanitia.idSuratKeluar}";
  var apiURLGetLampiran = "https://siradaskripsi.my.id/api/data/admin/surat/keluar/lampiran/${editSuratKeluarPanitia.idSuratKeluar}";
  var apiURLGetTetujonPrajuruDesa = "https://siradaskripsi.my.id/api/data/surat/keluar/tetujon/prajuru/desa/${editSuratKeluarPanitia.idSuratKeluar}";
  var apiURLGetTetujonPrajuruBanjar = "https://siradaskripsi.my.id/api/data/surat/keluar/tetujon/prajuru/banjar/${editSuratKeluarPanitia.idSuratKeluar}";
  var apiURLGetTetujonPihakLain = "https://siradaskripsi.my.id/api/data/surat/keluar/tetujon/pihak-lain/${editSuratKeluarPanitia.idSuratKeluar}";
  var apiURLGetTumusanPrajuruDesa = "https://siradaskripsi.my.id/api/data/surat/keluar/tumusan/prajuru/desa/${editSuratKeluarPanitia.idSuratKeluar}";
  var apiURLGetTumusanPrajuruBanjar = "https://siradaskripsi.my.id/api/data/surat/keluar/tumusan/prajuru/banjar/${editSuratKeluarPanitia.idSuratKeluar}";
  var apiURLGetTumusanPihakLain = "https://siradaskripsi.my.id/api/data/surat/keluar/tumusan/pihak-lain/${editSuratKeluarPanitia.idSuratKeluar}";
  var apiURLSimpanEdit = "https://siradaskripsi.my.id/api/admin/surat/keluar/panitia/edit/panitia/up";

  //loading indicator
  bool LoadingData = true;
  bool KodeSuratLoading = true;
  bool Loading = false;
  bool LoadingBendesa = true;
  bool NomorSuratLoading = false;
  bool availableKetua = false;
  bool availableSekretaris = false;
  bool LoadingKetua = true;
  bool LoadingSekretaris = true;
  bool isSendToKrama = false;
  bool isVisible = true;
  List<String> arguments = [];
  //selected
  var selectedKodeSurat;
  var selectedBendesaAdat;
  var selectedPenyarikan;
  var selectedIdKetuaPanitia;
  var selectedIdSekretarisPanitia;
  var selectedIdPanitiaAcara;
  File file;
  String namaFile;
  String filePath;

  //list
  List kodeSuratList = List();
  List bendesaList = List();
  List lampiran = [];
  List fileName = [];
  List lampiranUploadName = [];
  List prajuruDesaList = List();
  List prajuruBanjarList = [];
  List selectedKelihanAdat = [];
  List selectedBendesa = [];
  List selectedKelihanAdatTumusan = [];
  List selectedBendesaTumusan = [];
  List panitiaAcaraList = List();
  List sekretarisList = List();
  List ketuaList = List();
  List pihakLain = [];
  List pihakLainTumusan = [];

  //kodesurat
  var nomorUrutSurat;
  var kodeDesa;
  var bulan;
  var tahun;
  var statusSurat;

  Future getKodeSurat() async {
    var response = await http.get(Uri.parse(apiURLShowKodeSurat));
    if(response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        kodeSuratList = jsonData;
        KodeSuratLoading = false;
      });
    }
  }

  //url tetujon, tumusan, lampiran
  var apiURLUpTetujonPihakLain = "https://siradaskripsi.my.id/api/admin/surat/keluar/tetujon/pihak-lain/up";
  var apiURLUpTumusanPihakLain = "https://siradaskripsi.my.id/api/admin/surat/keluar/tumusan/pihak-lain/up";
  var apiURLUpTetujonPrajuruBanjar = "https://siradaskripsi.my.id/api/admin/surat/keluar/tetujon/banjar/up";
  var apiURLUpTumusanPrajuruBanjar = "https://siradaskripsi.my.id/api/admin/surat/keluar/tumusan/banjar/up";
  var apiURLUpTetujonPrajuruDesa = "https://siradaskripsi.my.id/api/admin/surat/keluar/tetujon/desa/up";
  var apiURLUpTumusanPrajuruDesa = "https://siradaskripsi.my.id/api/admin/surat/keluar/tumusan/desa/up";
  var apiURLUpLampiran = "https://siradaskripsi.my.id/api/upload/lampiran";
  var apiURLSaveEditLampiran = "https://siradaskripsi.my.id/api/admin/surat/keluar/lampiran/edit/up";

  final controllerNomorSurat = TextEditingController();
  final controllerLepihan = TextEditingController();
  final controllerParindikan = TextEditingController();
  final controllerTetujon = TextEditingController();
  final controllerDagingSurat = TextEditingController();
  final controllerPemahbah = TextEditingController();
  final controllerPamuput = TextEditingController();
  final controllerTempatKegiatan = TextEditingController();
  final controllerBusanaKegiatan = TextEditingController();
  final controllerWaktuKegiatan = TextEditingController();
  final controllerTanggalKegiatanText = TextEditingController();
  final controllerPihakLainTetujon = TextEditingController();
  final controllerPihakLainTumusan = TextEditingController();
  final DateRangePickerController controllerTanggalKegiatan = DateRangePickerController();

  getTetujon() async {
    http.get(Uri.parse(apiURLGetTetujonPrajuruDesa),
        headers: {"Content-Type" : "application/json"}
    ).then((http.Response response) {
      var responseValue = response.statusCode;
      if(responseValue == 200) {
        var jsonData = json.decode(response.body);
        setState(() {
          selectedBendesa = jsonData;
        });
      }
    });
  }

  getTumusan() async {
    http.get(Uri.parse(apiURLGetTumusanPrajuruDesa),
        headers: {"Content-Type" : "application/json"}
    ).then((http.Response response) {
      var responseValue = response.statusCode;
      if(responseValue == 200) {
        var jsonData = json.decode(response.body);
        setState(() {
          selectedBendesaTumusan = jsonData;
        });
      }
    });
  }

  Future getDataSuratKeluar() async {
    var response  = await http.get(Uri.parse(apiURLShowDataEditSuratKeluar));
    if(response.statusCode == 200) {
      var jsonData = response.body;
      var parsedJson = json.decode(jsonData);
      setState(() {
        controllerNomorSurat.text = parsedJson['nomor_surat'];
        controllerLepihan.text = parsedJson['lepihan'].toString();
        controllerParindikan.text = parsedJson['parindikan'];
        controllerTetujon.text = parsedJson['pihak_penerima'];
        controllerPemahbah.text = parsedJson['pamahbah_surat'] == null ? "" : parsedJson['pamahbah_surat'];
        controllerDagingSurat.text = parsedJson['daging_surat'] == null ? "" : parsedJson['daging_surat'];
        controllerPamuput.text = parsedJson['pamuput_surat'] == null ? "" : parsedJson['pamuput_surat'];
        controllerTempatKegiatan.text = parsedJson['tempat_kegiatan'] == null ? "" : parsedJson['tempat_kegiatan'];
        controllerBusanaKegiatan.text = parsedJson['busana'] == null ? "" : parsedJson['busana'];
        selectedKodeSurat = parsedJson['kode_nomor_surat'];
        statusSurat = parsedJson['status'];
        tanggalAkhirKegiatan = parsedJson['tanggal_selesai'] == null ? null : DateTime.parse(parsedJson['tanggal_selesai']);
        tanggalMulaiKegiatan = parsedJson['tanggal_mulai'] == null ? null : DateTime.parse(parsedJson['tanggal_mulai']);
        if(tanggalAkhirKegiatan != null || tanggalMulaiKegiatan != null) {
          controllerTanggalKegiatan.selectedRange = PickerDateRange(tanggalMulaiKegiatan, tanggalAkhirKegiatan);
          tanggalMulai = DateFormat("dd-MMM-yyyy").format(tanggalMulaiKegiatan).toString();
          tanggalMulaiValue = DateFormat("yyyy-MM-dd").format(tanggalMulaiKegiatan).toString();
          tanggalBerakhir = DateFormat("dd-MMM-yyyy").format(tanggalAkhirKegiatan).toString();
          tanggalBerakhirValue = DateFormat("yyyy-MM-dd").format(tanggalAkhirKegiatan).toString();
          controllerTanggalKegiatanText.text = tanggalBerakhirValue == null ? "$tanggalMulai - $tanggalMulai" : "$tanggalMulai - $tanggalBerakhir";
        }
        startTime = parsedJson['waktu_mulai'] == null ? null : TimeOfDay(hour: int.parse(parsedJson['waktu_mulai'].split(":")[0]), minute: int.parse(parsedJson['waktu_mulai'].split(":")[1]));
        endTime = parsedJson['waktu_selesai'] == null ? null : TimeOfDay(hour: int.parse(parsedJson['waktu_selesai'].split(":")[0]), minute: int.parse(parsedJson['waktu_selesai'].split(":")[1]));
        if(startTime != null && endTime != null) {
          controllerWaktuKegiatan.text = "${startTime.hour}:${startTime.minute} - ${endTime.hour}:${endTime.minute}";
        }
        if(parsedJson['pihak_krama'] != null) {
          isSendToKrama = true;
          isVisible = false;
        }
        LoadingData = false;
      });
    }
  }

  Future getBendesaAdat() async {
    var response = await http.get(Uri.parse(apiURLGetDataBendesaAdat));
    if(response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        bendesaList = jsonData;
        LoadingBendesa = false;
      });
    }
  }

  getKelihanAdat() async {
    http.get(Uri.parse(apiURLGetKelihanAdat),
        headers: {"Content-Type" : "application/json"}
    ).then((http.Response response) {
      var responseValue = response.statusCode;
      if(responseValue == 200){
        var jsonData = json.decode(response.body);
        setState(() {
          prajuruBanjarList = jsonData;
        });
      }
    });
  }

  Future getBendesa() async {
    var response = await http.get(Uri.parse(apiURLGetBendesa));
    if(response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        prajuruDesaList = jsonData;
      });
    }
  }

  getBendesaInfo() async {
    var body = jsonEncode({
      "jabatan" : "Bendesa"
    });
    http.post(Uri.parse(apiURLShowPrajuru),
        headers: {"Content-Type" : "application/json"},
        body: body
    ).then((http.Response response) {
      if(response.statusCode == 200) {
        var jsonData = response.body;
        var parsedJson = json.decode(jsonData);
        setState(() {
          selectedBendesaAdat = int.parse(parsedJson['prajuru_desa_adat_id'].toString());
        });
      }
    });
  }

  getLampiran() async {
    http.get(Uri.parse(apiURLGetLampiran),
        headers: {"Content-Type" : "application/json"}
    ).then((http.Response response) {
      var responseValue = response.statusCode;
      if(responseValue == 200) {
        var jsonData = json.decode(response.body);
        this.fileName = [];
        for(var i = 0; i < jsonData.length; i++) {
          this.fileName.add(jsonData[i]['file']);
        }
      }
    });
  }

  Future getKomponenNomorSurat() async {
    setState(() {
      NomorSuratLoading = true;
    });
    var body = jsonEncode({
      "kode_surat" : selectedKodeSurat
    });
    http.post(Uri.parse(apiURLShowKomponenNomorSurat),
        headers: {"Content-Type" : "application/json"},
        body: body
    ).then((http.Response response) {
      var responseValue = response.statusCode;
      print(responseValue);
      if(responseValue == 200) {
        var jsonData = response.body;
        var parsedJson = json.decode(jsonData);
        setState(() {
          NomorSuratLoading = false;
          nomorUrutSurat = parsedJson['nomor_urut_surat'];
          kodeDesa = parsedJson['kode_desa'];
          bulan = parsedJson['bulan'];
          tahun = parsedJson['tahun'];
          controllerNomorSurat.text = "$nomorUrutSurat/$selectedKodeSurat-$kodeDesa/$bulan/$tahun";
        });
      }
    });
  }

  Future pilihBerkas() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        allowMultiple: false
    );
    if(result != null) {
      setState((){
        filePath = result.files.first.path;
        namaFile = result.files.first.name;
        file = File(result.files.single.path);
        lampiran.add(file);
        fileName.add(namaFile);
        lampiranUploadName.add(namaFile);
      });
      print(filePath);
      print(namaFile);
    }
  }

  Future getPanitiaAcaraData() async {
    var responsePanitia2 = await http.get(Uri.parse(apiURLGetPanitiaAcara));
    if(responsePanitia2.statusCode == 200) {
      var jsonData = json.decode(responsePanitia2.body);
      setState(() {
        panitiaAcaraList = jsonData;
        selectedIdPanitiaAcara = int.parse(panitiaAcaraList[0]['kegiatan_panitia_id'].toString());
        print(selectedIdPanitiaAcara);
      });
      getSekretarisPanitia();
      getKetuaPanitia();
    }
  }

  Future getSekretarisPanitia() async {
    var body = jsonEncode({
      "jabatan" : "Sekretaris Panitia",
      "id" : selectedIdPanitiaAcara
    });
    http.post(Uri.parse(apiURLGetPanitia),
        headers: {"Content-Type" : "application/json"},
        body: body
    ).then((http.Response response) {
      var responseValue = response.statusCode;
      print(responseValue);
      if(responseValue == 200) {
        var jsonData = json.decode(response.body);
        setState(() {
          availableSekretaris = true;
          LoadingSekretaris = false;
          sekretarisList = jsonData;
          selectedIdSekretarisPanitia = int.parse(sekretarisList[0]['panitia_desa_adat_id'].toString());
        });
      }else {
        setState(() {
          availableSekretaris = false;
          LoadingSekretaris = false;
        });
      }
    });
  }

  Future getKetuaPanitia() async {
    var body = jsonEncode({
      "jabatan" : "Ketua Panitia",
      "id" : selectedIdPanitiaAcara
    });
    http.post(Uri.parse(apiURLGetPanitia),
        headers: {"Content-Type" : "application/json"},
        body: body
    ).then((http.Response response) {
      var responseValue = response.statusCode;
      if(responseValue == 200) {
        var jsonData = json.decode(response.body);
        setState(() {
          ketuaList = jsonData;
          selectedIdKetuaPanitia = int.parse(ketuaList[0]['panitia_desa_adat_id'].toString());
          LoadingKetua = false;
          availableKetua = true;
        });
      }else {
        setState(() {
          LoadingKetua = false;
          availableKetua = false;
        });
      }
    });
  }

  getTetujonPrajuruBanjar() async {
    http.get(Uri.parse(apiURLGetTetujonPrajuruBanjar),
        headers: {"Content-Type" : "application/json"}
    ).then((http.Response response) {
      var responseValue = response.statusCode;
      print(responseValue.toString());
      if(responseValue == 200) {
        var jsonData = json.decode(response.body);
        setState(() {
          selectedKelihanAdat = jsonData;
        });
      }
    });
  }

  getTumusanPrajuruBanjar() async {
    http.get(Uri.parse(apiURLGetTumusanPrajuruBanjar),
        headers: {"Content-Type" : "application/json"}
    ).then((http.Response response) {
      var responseValue = response.statusCode;
      print(responseValue.toString());
      if(responseValue == 200) {
        var jsonData = json.decode(response.body);
        setState(() {
          selectedKelihanAdatTumusan = jsonData;
        });
      }
    });
  }

  getTetujonPihakLain() async {
    http.get(Uri.parse(apiURLGetTetujonPihakLain),
        headers: {"Content-Type" : "application/json"}
    ).then((http.Response response) {
      var responseValue = response.statusCode;
      if(responseValue == 200) {
        var jsonData = json.decode(response.body);
        this.pihakLain = [];
        for(var i = 0; i < jsonData.length; i++) {
          this.pihakLain.add(jsonData[i]['pihak_lain']);
        }
      }
    });
  }

  getTumusanPihakLain() async {
    http.get(Uri.parse(apiURLGetTumusanPihakLain),
        headers: {"Content-Type" : "application/json"}
    ).then((http.Response response) {
      var responseValue = response.statusCode;
      if(responseValue == 200) {
        var jsonData = json.decode(response.body);
        this.pihakLainTumusan = [];
        for(var i = 0; i < jsonData.length; i++) {
          this.pihakLainTumusan.add(jsonData[i]['pihak_lain']);
        }
      }
    });
  }

  void selectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      tanggalMulai = DateFormat("dd-MMM-yyyy").format(args.value.startDate).toString();
      tanggalMulaiValue = DateFormat("yyyy-MM-dd").format(args.value.startDate).toString();
      tanggalBerakhir = DateFormat("dd-MMM-yyyy").format(args.value.endDate ?? args.value.startDate).toString();
      tanggalBerakhirValue = DateFormat("yyyy-MM-dd").format(args.value.endDate ?? args.value.startDate).toString();
      controllerTanggalKegiatanText.text = tanggalBerakhirValue == null ? "$tanggalMulai - $tanggalMulai" : "$tanggalMulai - $tanggalBerakhir";
    });
  }

  TimeOfDay startTime;
  TimeOfDay endTime;
  String tanggalMulai;
  String tanggalMulaiValue;
  String tanggalBerakhir;
  String tanggalBerakhirValue;
  DateTime tanggalMulaiKegiatan;
  DateTime tanggalAkhirKegiatan;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  FToast ftoast;

  getPenerimaSurat() async {
    getLampiran();
    getTetujon();
    getTumusan();
    getTetujonPrajuruBanjar();
    getTumusanPrajuruBanjar();
    getTumusanPihakLain();
    getTetujonPihakLain();
  }

  getSuratData() async {
    getDataSuratKeluar();
    getBendesa();
    getBendesaInfo();
    getKelihanAdat();
    getBendesaAdat();
    getKodeSurat();
    getPanitiaAcaraData();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSuratData();
    getPenerimaSurat();
    ftoast = FToast();
    ftoast.init(this.context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Loading ? loading() : Scaffold(
        appBar: AppBar(
          backgroundColor: HexColor("#025393"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.of(context).pop(false);
            },
            color: Colors.white,
          ),
          title: Text("Edit Surat", style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w700,
            color: Colors.white
          )),
        ),
        body: LoadingData ? ProfilePageShimmer() : SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                        'images/email.png',
                        height: 100,
                        width: 100
                    ),
                    margin: EdgeInsets.only(top: 30)
                ),
                Container(
                    alignment: Alignment.topLeft,
                    child: Text("1. Kode Surat *", style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14,
                        fontWeight: FontWeight.w700
                    )),
                    margin: EdgeInsets.only(top: 30, left: 20)
                ),
                Container(
                    child: KodeSuratLoading ? ListTileShimmer() : Container(
                        width: 300,
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        decoration: BoxDecoration(
                            color: HexColor("#025393"),
                            borderRadius: BorderRadius.circular(30)
                        ),
                        child: DropdownButton(
                          isExpanded: true,
                          hint: Center(
                              child: Text("Pilih Kode Surat", style: TextStyle(
                                  fontFamily: "Poppins",
                                  color: Colors.white,
                                  fontSize: 14
                              ))
                          ),
                          value: selectedKodeSurat,
                          underline: Container(),
                          icon: Icon(Icons.arrow_downward, color: Colors.white),
                          items: kodeSuratList.map((kodeSurat) {
                            return DropdownMenuItem(
                                value: kodeSurat['kode_nomor_surat'],
                                child: Text("${kodeSurat['kode_nomor_surat']} - ${kodeSurat['keterangan']}", style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 14
                                ))
                            );
                          }).toList(),
                          selectedItemBuilder: (BuildContext context) => kodeSuratList.map((kodeSurat) => Center(
                              child: Text("${kodeSurat['kode_nomor_surat']}", style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14,
                                  color: Colors.white
                              ))
                          )).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedKodeSurat = value;
                            });
                            getKomponenNomorSurat();
                          },
                        ),
                        margin: EdgeInsets.only(top: 15)
                    )
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text("2. Atribut Surat", style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14,
                    fontWeight: FontWeight.w700
                  )),
                  margin: EdgeInsets.only(top: 30, left: 20),
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text("Nomor Surat *", style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 14
                        )),
                        margin: EdgeInsets.only(top: 20, left: 20),
                      ),
                      Container(
                        child: NomorSuratLoading ? ListTileShimmer() : Padding(
                            padding: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                            child: TextFormField(
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if(value.isEmpty) {
                                  return "Data tidak boleh kosong";
                                }else {
                                  return null;
                                }
                              },
                              controller: controllerNomorSurat,
                              enabled: false,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                    borderSide: BorderSide(color: HexColor("#025393"))
                                ),
                              ),
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14
                              ),
                            )
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
                            child: Text("Lepihan (Lampiran) *", style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14
                            )),
                            margin: EdgeInsets.only(top: 20, left: 20)
                        ),
                        Container(
                          child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                              child: TextFormField(
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if(value.isEmpty) {
                                    return "Data tidak boleh kosong";
                                  }else {
                                    return null;
                                  }
                                },
                                controller: controllerLepihan,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50.0),
                                      borderSide: BorderSide(color: HexColor("#025393"))
                                  ),
                                  hintText: "Lepihan",
                                ),
                                keyboardType: TextInputType.number,
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 14
                                ),
                              )
                          ),
                        )
                      ],
                    )
                ),
                Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                            alignment: Alignment.topLeft,
                            child: Text("Parindikan *", style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14
                            )),
                            margin: EdgeInsets.only(top: 20, left: 20)
                        ),
                        Container(
                          child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                              child: TextFormField(
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if(value.isEmpty) {
                                    return "Data tidak boleh kosong";
                                  }else {
                                    return null;
                                  }
                                },
                                controller: controllerParindikan,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50.0),
                                      borderSide: BorderSide(color: HexColor("#025393"))
                                  ),
                                  hintText: "Parindikan",
                                ),
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 14
                                ),
                              )
                          ),
                        )
                      ],
                    )
                ),
                Container(
                    child: Text("3. Daging Surat", style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14,
                        fontWeight: FontWeight.w700
                    )),
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(top: 30, left: 20)
                ),
                Container(
                    alignment: Alignment.topLeft,
                    child: Text("Pemahbah", style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14
                    )),
                    margin: EdgeInsets.only(top: 20, left: 20)
                ),
                Container(
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                      child: TextField(
                        controller: controllerPemahbah,
                        maxLines: 5,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(color: HexColor("#025393"))
                            ),
                            hintText: "Pemahbah (Pendahuluan)"
                        ),
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14
                        ),
                      )
                  ),
                ),
                Container(
                    alignment: Alignment.topLeft,
                    child: Text("Daging Surat", style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14
                    )),
                    margin: EdgeInsets.only(top: 20, left: 20)
                ),
                Container(
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                      child: TextField(
                        controller: controllerDagingSurat,
                        maxLines: 20,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(color: HexColor("#025393"))
                            ),
                            hintText: "Daging (Isi)"
                        ),
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14
                        ),
                      )
                  ),
                ),
                Container(
                    alignment: Alignment.topLeft,
                    child: Text("Pamuput Surat", style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14
                    )),
                    margin: EdgeInsets.only(top: 20, left: 20)
                ),
                Container(
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                      child: TextField(
                        controller: controllerPamuput,
                        maxLines: 5,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(color: HexColor("#025393"))
                            ),
                            hintText: "Pamuput (Penutup)"
                        ),
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14
                        ),
                      )
                  ),
                ),
                Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text("Tempat Kegiatan", style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 14
                          )),
                          margin: EdgeInsets.only(top: 20, left: 20),
                        ),
                        Container(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                            child: TextField(
                              controller: controllerTempatKegiatan,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50.0),
                                      borderSide: BorderSide(color: HexColor("#025393"))
                                  ),
                                  hintText: "Tempat Kegiatan"
                              ),
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                ),
                Container(
                    child: Column(
                        children: <Widget>[
                          Container(
                              alignment: Alignment.topLeft,
                              child: Text("Tanggal Kegiatan", style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14
                              )),
                              margin: EdgeInsets.only(top: 20, left: 20)
                          ),
                          Container(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                              child: GestureDetector(
                                  onTap: (){
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text("Pilih Tanggal Kegiatan", style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: HexColor("025393")
                                          )),
                                          content: Container(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.stretch,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Container(
                                                  height: 250,
                                                  width: 250,
                                                  child: SfDateRangePicker(
                                                    controller: controllerTanggalKegiatan,
                                                    selectionMode: DateRangePickerSelectionMode.range,
                                                    onSelectionChanged: selectionChanged,
                                                    allowViewNavigation: true,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              child: Text("Simpan", style: TextStyle(
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w700,
                                                color: HexColor("025393")
                                              )),
                                              onPressed: (){
                                                Navigator.of(context).pop();
                                              },
                                            )
                                          ],
                                        );
                                      }
                                    );
                                  },
                                  child: TextField(
                                    controller: controllerTanggalKegiatanText,
                                    enabled: false,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(50.0),
                                            borderSide: BorderSide(color: HexColor("#025393"))
                                        ),
                                        hintText: "Tanggal kegiatan belum terpilih",
                                        prefixIcon: Icon(CupertinoIcons.calendar)
                                    ),
                                    style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 14
                                    ),
                                  ),
                              )
                            ),
                            margin: EdgeInsets.only(top: 10),
                          ),
                        ]
                    )
                ),
                Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text("Waktu Kegiatan", style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 14
                          )),
                          margin: EdgeInsets.only(top: 20, left: 20),
                        ),
                        Container(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                            child: GestureDetector(
                                onTap: (){
                                  TimeRangePicker.show(
                                      context: context,
                                      unSelectedEmpty: true,
                                      headerDefaultStartLabel: "Waktu Mulai",
                                      headerDefaultEndLabel: "Waktu Selesai",
                                      onSubmitted: (TimeRangeValue value) {
                                        setState(() {
                                          startTime = value.startTime;
                                          endTime = value.endTime;
                                          controllerWaktuKegiatan.text = startTime == null ? "--:--" : endTime == null ? "${startTime.hour}:${startTime.minute} - ${startTime.hour}:${startTime.minute}": "${startTime.hour}:${startTime.minute} - ${endTime.hour}:${endTime.minute}";
                                        });
                                      }
                                  );
                                },
                              child: TextField(
                                controller: controllerWaktuKegiatan,
                                enabled: false,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(50.0),
                                        borderSide: BorderSide(color: HexColor("#025393"))
                                    ),
                                    hintText: "Waktu kegiatan belum terpilih",
                                    prefixIcon: Icon(CupertinoIcons.time_solid)
                                ),
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 14
                                ),
                              ),
                            ),
                          ),
                          margin: EdgeInsets.only(top: 10),
                        ),
                      ],
                    )
                ),
                Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text("Busana Kegiatan", style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 14
                          )),
                          margin: EdgeInsets.only(top: 20, left: 20),
                        ),
                        Container(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                            child: TextField(
                              controller: controllerBusanaKegiatan,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50.0),
                                      borderSide: BorderSide(color: HexColor("#025393"))
                                  ),
                                  hintText: "Busana Kegiatan"
                              ),
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                ),
                Container(
                    child: Column(
                        children: <Widget>[
                          Container(
                              alignment: Alignment.topLeft,
                              child: Text("Panitia Kegiatan", style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14
                              )),
                              margin: EdgeInsets.only(top: 10, left: 20)
                          ),
                          Container(
                              width: 300,
                              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                              decoration: BoxDecoration(
                                  color: HexColor("#025393"),
                                  borderRadius: BorderRadius.circular(30)
                              ),
                              child: DropdownButton(
                                isExpanded: true,
                                hint: Center(
                                    child: Text("Pilih Panitia Acara", style: TextStyle(
                                        fontFamily: "Poppins",
                                        color: Colors.white,
                                        fontSize: 14
                                    ))
                                ),
                                value: selectedIdPanitiaAcara,
                                underline: Container(),
                                icon: Icon(Icons.arrow_downward, color: Colors.white),
                                items: panitiaAcaraList.map((panitia) {
                                  return DropdownMenuItem(
                                      value: panitia['kegiatan_panitia_id'],
                                      child: Text(panitia['panitia'], style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 14
                                      ))
                                  );
                                }).toList(),
                                selectedItemBuilder: (BuildContext context) => panitiaAcaraList.map((panitia) => Center(
                                    child: Text(panitia['panitia'], style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 14,
                                        color: Colors.white
                                    ))
                                )).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedIdPanitiaAcara = value;
                                  });
                                  getKetuaPanitia();
                                  getSekretarisPanitia();
                                },
                              ),
                              margin: EdgeInsets.only(top: 15)
                          )
                        ]
                    )
                ),
                Container(
                  child: Text("4. Lingga Tangan Miwah Pesengan", style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14,
                    fontWeight: FontWeight.w700
                  )),
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(top: 30, left: 20),
                ),
                Container(
                    child: Column(
                        children: <Widget>[
                          Container(
                              alignment: Alignment.topLeft,
                              child: Text("Sekretaris Panitia *", style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14
                              )),
                              margin: EdgeInsets.only(top: 20, left: 20)
                          ),
                          Container(
                            child: LoadingSekretaris ? ListTileShimmer() : availableSekretaris ? Container(
                                width: 300,
                                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                decoration: BoxDecoration(
                                    color: HexColor("#025393"),
                                    borderRadius: BorderRadius.circular(30)
                                ),
                                child: DropdownButton(
                                    isExpanded: true,
                                    hint: Center(
                                        child: Text("Pilih Sekretaris", style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 14,
                                            color: Colors.white
                                        ))
                                    ),
                                    value: selectedIdSekretarisPanitia,
                                    underline: Container(),
                                    icon: Icon(Icons.arrow_downward, color: Colors.white),
                                    items: sekretarisList.map((sekretaris) {
                                      return DropdownMenuItem(
                                          value: sekretaris['panitia_desa_adat_id'],
                                          child: Text("${sekretaris['nik']} - ${sekretaris['nama']}", style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 14
                                          ))
                                      );
                                    }).toList(),
                                    selectedItemBuilder: (BuildContext context) => sekretarisList.map((sekretaris) => Center(
                                        child: Text("${sekretaris['nik']} - ${sekretaris['nama']}", style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 14,
                                            color: Colors.white
                                        ))
                                    )).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        selectedIdSekretarisPanitia = value;
                                      });
                                    }
                                ),
                                margin: EdgeInsets.only(top: 10)
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
                                              child: Text("Tidak ada Data Sekretaris Panitia", style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white
                                              )),
                                            ),
                                            Container(
                                              child: SizedBox(
                                                width: MediaQuery.of(context).size.width * 0.7,
                                                child: Text("Silahkan hubungi administrator dan tambahkan data sekretaris panitia sebelum melanjutkan", style: TextStyle(
                                                    fontFamily: "Poppins",
                                                    fontSize: 14,
                                                    color: Colors.white
                                                )),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      margin: EdgeInsets.only(left: 15)
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
                          )
                        ]
                    )
                ),
                Container(
                    child: Column(
                        children: <Widget>[
                          Container(
                              alignment: Alignment.topLeft,
                              child: Text("Ketua Panitia *", style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14
                              )),
                              margin: EdgeInsets.only(top: 10, left: 20)
                          ),
                          Container(
                            child: LoadingKetua ? ListTileShimmer() : availableKetua ? Container(
                                width: 300,
                                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                decoration: BoxDecoration(
                                    color: HexColor("#025393"),
                                    borderRadius: BorderRadius.circular(30)
                                ),
                                child: DropdownButton(
                                    isExpanded: true,
                                    hint: Center(
                                        child: Text("Pilih Ketua", style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 14,
                                            color: Colors.white
                                        ))
                                    ),
                                    value: selectedIdKetuaPanitia,
                                    underline: Container(),
                                    icon: Icon(Icons.arrow_downward, color: Colors.white),
                                    items: ketuaList.map((ketua) {
                                      return DropdownMenuItem(
                                          value: ketua['panitia_desa_adat_id'],
                                          child: Text("${ketua['nik']} - ${ketua['nama']}", style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 14
                                          ))
                                      );
                                    }).toList(),
                                    selectedItemBuilder: (BuildContext context) => ketuaList.map((ketua) => Center(
                                        child: Text("${ketua['nik']} - ${ketua['nama']}", style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 14,
                                            color: Colors.white
                                        ))
                                    )).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        selectedIdKetuaPanitia = value;
                                      });
                                    }
                                ),
                                margin: EdgeInsets.only(top: 10)
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
                                              child: Text("Tidak ada Data Ketua Panitia", style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white
                                              )),
                                            ),
                                            Container(
                                              child: SizedBox(
                                                width: MediaQuery.of(context).size.width * 0.7,
                                                child: Text("Silahkan hubungi administrator dan tambahkan data ketua panitia sebelum melanjutkan", style: TextStyle(
                                                    fontFamily: "Poppins",
                                                    fontSize: 14,
                                                    color: Colors.white
                                                )),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      margin: EdgeInsets.only(left: 15)
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
                          )
                        ]
                    )
                ),
                Container(
                    child: Column(
                        children: <Widget>[
                          Container(
                              alignment: Alignment.topLeft,
                              child: Text("Bendesa *", style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14
                              )),
                              margin: EdgeInsets.only(top: 20, left: 20)
                          ),
                          Container(
                              child: LoadingBendesa ? ListTileShimmer() : Container(
                                  width: 300,
                                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                  decoration: BoxDecoration(
                                      color: HexColor("#025393"),
                                      borderRadius: BorderRadius.circular(30)
                                  ),
                                  child: DropdownButton(
                                      isExpanded: true,
                                      hint: Center(
                                          child: Text("Pilih Bendesa Adat", style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 14,
                                              color: Colors.white
                                          ))
                                      ),
                                      value: selectedBendesaAdat,
                                      underline: Container(),
                                      icon: Icon(Icons.arrow_downward, color: Colors.white),
                                      items: bendesaList.map((bendesa) {
                                        return DropdownMenuItem(
                                            value: bendesa['prajuru_desa_adat_id'],
                                            child: Text("${bendesa['nik']} - ${bendesa['nama']}", style: TextStyle(
                                                fontFamily: "Poppins",
                                                fontSize: 14
                                            ))
                                        );
                                      }).toList(),
                                      selectedItemBuilder: (BuildContext context) => bendesaList.map((bendesa) => Center(
                                          child: Text("${bendesa['nik']} - ${bendesa['nama']}", style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 14,
                                              color: Colors.white
                                          ))
                                      )).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          selectedBendesaAdat = value;
                                        });
                                      }
                                  ),
                                  margin: EdgeInsets.only(top: 10)
                              )
                          )
                        ]
                    )
                ),
                Container(
                    child: Text("5. Lepihan Surat", style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14,
                        fontWeight: FontWeight.w700
                    )),
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(top: 30, left: 20)
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: MultiSelectChipDisplay(
                    items: fileName.map((e) => MultiSelectItem(e, e)).toList(),
                    onTap: (value) {
                      setState(() {
                        if(lampiran.isNotEmpty) {
                          for(var i = 0; i < fileName.length; i++) {
                            var index = 0;
                            if(lampiranUploadName[index] == value) {
                              setState(() {
                                lampiranUploadName.remove(lampiranUploadName[index]);
                                lampiran.remove(lampiran[index]);
                              });
                            }else{
                              setState(() {
                                index = index + 1;
                              });
                            }
                          }
                        }
                        setState(() {
                          fileName.remove(value);
                        });
                      });
                    },
                  )
                ),
                Container(
                  child: FlatButton(
                      onPressed: (){
                        if(controllerLepihan.text == "") {
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
                                                  child: Text("Data Lepihan Belum Terisi", style: TextStyle(
                                                      fontFamily: "Poppins",
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w700,
                                                      color: HexColor("#025393")
                                                  ), textAlign: TextAlign.center),
                                                  margin: EdgeInsets.only(top: 10)
                                              ),
                                              Container(
                                                  child: Text("Data lepihan belum terisi. Silahkan isi data lepihan terlebih dahulu dan coba lagi", style: TextStyle(
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
                                        onPressed: (){Navigator.of(context).pop();},
                                      )
                                    ]
                                );
                              }
                          );
                        }else if(controllerLepihan.text == "0" || controllerLepihan.text == "-") {
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
                                                  child: Text("Tidak Dapat Memilih Berkas Lepihan", style: TextStyle(
                                                      fontFamily: "Poppins",
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w700,
                                                      color: HexColor("#025393")
                                                  ), textAlign: TextAlign.center),
                                                  margin: EdgeInsets.only(top: 10)
                                              ),
                                              Container(
                                                  child: Text("Tidak dapat memilih berkas lepihan karena Anda menginputkan tidak ada berkas lepihan", style: TextStyle(
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
                                        onPressed: (){Navigator.of(context).pop();},
                                      )
                                    ]
                                );
                              }
                          );
                        }else{
                          pilihBerkas();
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
                          borderRadius: BorderRadius.circular(25),
                          side: BorderSide(color: HexColor("#025393"), width: 2)
                      ),
                      padding: EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50)
                  ),
                  margin: EdgeInsets.only(top: 20),
                ),
                Container(
                  child: Text("6. Tetujon Surat", style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 14,
                      fontWeight: FontWeight.w700
                  )),
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(top: 30, left: 20),
                ),
                Visibility(
                  visible: isVisible,
                  child: Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text("Prajuru Desa Adat", style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14,
                            fontWeight: FontWeight.w700
                        )),
                        margin: EdgeInsets.only(top: 15, left: 20),
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: MultiSelectDialogField(
                            title: Text("Tambah Penerima Prajuru Desa Adat"),
                            buttonText: Text("Tambah Penerima Prajuru Desa Adat", style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14
                            )),
                            buttonIcon: Icon(Icons.expand_more),
                            initialValue: selectedBendesa,
                            searchable: false,
                            selectedColor: HexColor("#025393"),
                            checkColor: Colors.white,
                            items: prajuruDesaList.map((item) => MultiSelectItem(item, "Desa ${item['desadat_nama']} - ${item['nama']}")).toList(),
                            listType: MultiSelectListType.LIST,
                            onConfirm: (values) {
                              setState(() {
                                selectedBendesa.addAll(values);
                                values.clear();
                              });
                            },
                          )
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: MultiSelectChipDisplay(
                          items: selectedBendesa.map((e) => MultiSelectItem(e, "Desa ${e['desadat_nama']} - ${e['nama']}")).toList(),
                          onTap: (value) {
                            setState(() {
                              selectedBendesa.remove(value);
                            });
                          },
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text("Prajuru Banjar Adat", style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14,
                            fontWeight: FontWeight.w700
                        )),
                        margin: EdgeInsets.only(top: 15, left: 20),
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: MultiSelectDialogField(
                            title: Text("Tambah Penerima Prajuru Banjar Adat"),
                            buttonText: Text("Tambah Penerima Prajuru Banjar Adat", style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14
                            )),
                            buttonIcon: Icon(Icons.expand_more),
                            searchable: false,
                            selectedColor: HexColor("#025393"),
                            checkColor: Colors.white,
                            items: prajuruBanjarList.map((item) => MultiSelectItem(item, "Banjar ${item['nama_banjar_adat']} - ${item['nama']}")).toList(),
                            listType: MultiSelectListType.LIST,
                            onConfirm: (values) {
                              setState(() {
                                selectedKelihanAdat.addAll(values);
                                values.clear();
                              });
                            },
                          )
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: MultiSelectChipDisplay(
                            items: selectedKelihanAdat.map((e) => MultiSelectItem(e, "Banjar ${e['nama_banjar_adat']} - ${e['nama']}")).toList(),
                            onTap: (value) {
                              setState(() {
                                selectedKelihanAdat.remove(value);
                              });
                            },
                          )
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text("Pihak Lain", style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14,
                            fontWeight: FontWeight.w700
                        )),
                        margin: EdgeInsets.only(top: 15, left: 20),
                      ),
                      Container(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                          child: TextField(
                            controller: controllerPihakLainTetujon,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                    borderSide: BorderSide(color: HexColor("#025393"))
                                ),
                                hintText: "Nama Penerima Pihak Lain",
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.add),
                                  onPressed: (){
                                    if(controllerPihakLainTetujon.text != "") {
                                      setState(() {
                                        pihakLain.add(controllerPihakLainTetujon.text);
                                      });
                                    }
                                  },
                                )
                            ),
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: MultiSelectChipDisplay(
                          items: pihakLain.map((e) => MultiSelectItem(e, e)).toList(),
                          onTap: (value) {
                            setState(() {
                              pihakLain.remove(value);
                            });
                          },
                        ),
                      ),
                    ],
                  )
                ),
                Container(
                    child: CheckboxListTile(
                      title: Text("Kirimkan surat ini ke Krama Desa ${dashboardKramaPanitia.namaDesaAdat}", style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14,
                        color: Colors.black
                      )),
                      value: isSendToKrama,
                      controlAffinity: ListTileControlAffinity.leading,
                      onChanged: (bool value) {
                        setState(() {
                          isSendToKrama = value;
                          isVisible = !isVisible;
                        });
                      },
                    )
                ),
                Container(
                  child: Text("7. Tumusan Surat", style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 14,
                      fontWeight: FontWeight.w700
                  )),
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(top: 10, left: 20),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text("Prajuru Desa Adat", style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 14,
                      fontWeight: FontWeight.w700
                  )),
                  margin: EdgeInsets.only(top: 15, left: 20),
                ),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: MultiSelectDialogField(
                      title: Text("Tambah Tumusan Prajuru Desa Adat"),
                      buttonText: Text("Tambah Tumusan Prajuru Desa Adat", style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 14
                      )),
                      buttonIcon: Icon(Icons.expand_more),
                      initialValue: selectedBendesa,
                      searchable: false,
                      selectedColor: HexColor("#025393"),
                      checkColor: Colors.white,
                      items: prajuruDesaList.map((item) => MultiSelectItem(item, "Desa ${item['desadat_nama']} - ${item['nama']}")).toList(),
                      listType: MultiSelectListType.LIST,
                      onConfirm: (values) {
                        setState(() {
                          selectedBendesaTumusan.addAll(values);
                          values.clear();
                        });
                      },
                    )
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: MultiSelectChipDisplay(
                    items: selectedBendesaTumusan.map((e) => MultiSelectItem(e, "Desa ${e['desadat_nama']} - ${e['nama']}")).toList(),
                    onTap: (value) {
                      setState(() {
                        selectedBendesaTumusan.remove(value);
                      });
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text("Prajuru Banjar Adat", style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 14,
                      fontWeight: FontWeight.w700
                  )),
                  margin: EdgeInsets.only(top: 15, left: 20),
                ),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: MultiSelectDialogField(
                      title: Text("Tambah Tumusan Prajuru Banjar Adat"),
                      buttonText: Text("Tambah Tumusan Prajuru Banjar Adat", style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 14
                      )),
                      buttonIcon: Icon(Icons.expand_more),
                      searchable: false,
                      selectedColor: HexColor("#025393"),
                      checkColor: Colors.white,
                      items: prajuruBanjarList.map((item) => MultiSelectItem(item, "Banjar ${item['nama_banjar_adat']} - ${item['nama']}")).toList(),
                      listType: MultiSelectListType.LIST,
                      onConfirm: (values) {
                        setState(() {
                          selectedKelihanAdatTumusan.addAll(values);
                          values.clear();
                        });
                      },
                    )
                ),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: MultiSelectChipDisplay(
                      items: selectedKelihanAdatTumusan.map((e) => MultiSelectItem(e, "Banjar ${e['nama_banjar_adat']} - ${e['nama']}")).toList(),
                      onTap: (value) {
                        setState(() {
                          selectedKelihanAdatTumusan.remove(value);
                        });
                      },
                    )
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text("Pihak Lain", style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 14,
                      fontWeight: FontWeight.w700
                  )),
                  margin: EdgeInsets.only(top: 15, left: 20),
                ),
                Container(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                    child: TextField(
                      controller: controllerPihakLainTumusan,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              borderSide: BorderSide(color: HexColor("#025393"))
                          ),
                          hintText: "Nama Tumusan Pihak Lain",
                          suffixIcon: IconButton(
                            icon: Icon(Icons.add),
                            onPressed: (){
                              if(controllerPihakLainTumusan.text != "") {
                                setState(() {
                                  pihakLainTumusan.add(controllerPihakLainTumusan.text);
                                });
                              }
                            },
                          )
                      ),
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 14
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: MultiSelectChipDisplay(
                    items: pihakLainTumusan.map((e) => MultiSelectItem(e, e)).toList(),
                    onTap: (value) {
                      setState(() {
                        pihakLainTumusan.remove(value);
                      });
                    },
                  ),
                ),
                Container(
                  child: FlatButton(
                    onPressed: () {
                      if(controllerLepihan.text != "0" && fileName.isEmpty) {
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
                                      child: Text("Silahkan unggah berkas lampiran", style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white
                                      )),
                                    ),
                                  )
                                ],
                              ),
                            )
                        );
                      }else if(controllerLepihan.text == "0" && fileName.isNotEmpty) {
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
                                      child: Text("Silahkan kosongkan lampiran sebelum melanjutkan", style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white
                                      )),
                                    ),
                                  )
                                ],
                              ),
                            )
                        );
                      }else if(selectedBendesa.isEmpty && selectedKelihanAdat.isEmpty && pihakLain.isEmpty && isSendToKrama == false) {
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
                                      child: Text("Silahkan masukkan penerima surat", style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white
                                      )),
                                    ),
                                  )
                                ],
                              ),
                            )
                        );
                      }else if(formKey.currentState.validate()) {
                        setState(() {
                          Loading = true;
                        });
                        var body = jsonEncode({
                          "master_surat" : selectedKodeSurat,
                          "desa_adat_id" : loginPage.desaId,
                          "lepihan" : controllerLepihan.text,
                          "parindikan" : controllerParindikan.text,
                          "pemahbah_surat" : controllerPemahbah.text,
                          "daging_surat" : controllerDagingSurat.text,
                          "pamuput_surat" : controllerPamuput.text,
                          "nomor_surat" : controllerNomorSurat.text,
                          "user_id" : loginPage.userId,
                          "status_surat" : statusSurat,
                          "surat_keluar_id" : editSuratKeluarPanitia.idSuratKeluar,
                          "nomor_urut_surat" : nomorUrutSurat == null ? null : nomorUrutSurat,
                          "pihak_krama" : isSendToKrama ? "Desa Adat ${dashboardKramaPanitia.namaDesaAdat}" : null
                        });
                        http.post(Uri.parse(apiURLSimpanEdit),
                          headers: {"Content-Type" : "application/json"},
                          body: body
                        ).then((http.Response response) async {
                          var responseValue = response.statusCode;
                          print("status upload edit surat keluar panitia: ${response.statusCode}");
                          if(responseValue == 200) {
                            await uploadLampiran();
                            await uploadPihakLain();
                            await uploadPrajuruBanjar();
                            await uploadPrajuruDesa();
                            await uploadLampiranBerkas();
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
                                          child: Text("Surat keluar berhasil diperbaharui", style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white
                                          )),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                            );
                            Navigator.of(context).pop(true);
                          }
                        });
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
            ),
          ),
        ),
      ),
    );
  }

  Future uploadLampiran() async {
    Map<String, String> headers = {
      'Content-Type' : 'multipart/form-data'
    };
    Map<String, String> body = {
      "surat_keluar_id" : editSuratKeluarPanitia.idSuratKeluar.toString()
    };
    var request_delete = http.MultipartRequest("POST", Uri.parse("https://siradaskripsi.my.id/api/admin/surat/keluar/lampiran/delete"))
      ..fields.addAll(body)
      ..headers.addAll(headers);
    await request_delete.send().then((response) {
      print("delete lampiran status code : ${response.statusCode.toString()}");
    });
    if(lampiran.isNotEmpty) {
      for(var i = 0; i < fileName.length; i++) {
        Map<String, String> body = {
          "surat_keluar_id" : editSuratKeluarPanitia.idSuratKeluar.toString(),
          "file_name" : fileName[i].toString()
        };
        var request = http.MultipartRequest("POST", Uri.parse(apiURLSaveEditLampiran))
          ..fields.addAll(body)
          ..headers.addAll(headers);
        await request.send().then((response) {
          print("upload lampiran status code (save edit): ${response.statusCode.toString()}");
        });
      }
    }
  }

  Future uploadLampiranBerkas() async {
    Map<String, String> headers = {
      'Content-Type' : 'multipart/form-data'
    };
    for(var i = 0; i < lampiran.length; i++) {
      var request = http.MultipartRequest('POST', Uri.parse(apiURLUpLampiran))
        ..headers.addAll(headers)
        ..files.add(await http.MultipartFile.fromPath('lampiran', lampiran[i].path));
      request.send().then((response) =>  {
        print("upload lampiran status code: ${response.statusCode.toString()}")
      });
    }
  }

  Future uploadPrajuruBanjar() async {
    Map<String, String> body = {
      "surat_keluar_id" : editSuratKeluarPanitia.idSuratKeluar.toString()
    };
    Map<String, String> headers = {
      'Content-Type' : 'multipart/form-data'
    };
    var request_delete = http.MultipartRequest("POST", Uri.parse("https://siradaskripsi.my.id/api/admin/surat/keluar/tetujon/banjar/delete"))
      ..fields.addAll(body)
      ..headers.addAll(headers);
    await request_delete.send().then((response) {
      print("delete tetujon prajuru banjar status code : ${response.statusCode.toString()}");
    });
    var request_delete_tumusan = http.MultipartRequest("POST", Uri.parse("https://siradaskripsi.my.id/api/admin/surat/keluar/tumusan/banjar/delete"))
      ..fields.addAll(body)
      ..headers.addAll(headers);
    await request_delete_tumusan.send().then((response) async {
      print("delete tetujon prajuru banjar status code : ${response.statusCode.toString()}");
      if(selectedKelihanAdat.isNotEmpty) {
        if(isSendToKrama == false) {
          for(var i = 0; i < selectedKelihanAdat.length; i++) {
            Map<String, String> body = {
              "surat_keluar_id" : editSuratKeluarPanitia.idSuratKeluar.toString(),
              "prajuru_banjar_adat_id" : selectedKelihanAdat[i]['prajuru_banjar_adat_id'].toString()
            };
            var request = http.MultipartRequest("POST", Uri.parse(apiURLUpTetujonPrajuruBanjar))
              ..fields.addAll(body)
              ..headers.addAll(headers);
            await request.send().then((response) {
              print("upload tetujon prajuru banjar status code: ${response.statusCode.toString()}");
            });
          }
        }else{
          print("Surat terkirim ke krama");
        }
      }
      if(selectedKelihanAdatTumusan.isNotEmpty) {
        for(var i = 0; i < selectedKelihanAdatTumusan.length; i++) {
          Map<String, String> bodyTumusan = {
            "surat_keluar_id" : editSuratKeluarPanitia.idSuratKeluar.toString(),
            "prajuru_banjar_adat_id" : selectedKelihanAdatTumusan[i]['prajuru_banjar_adat_id'].toString()
          };
          var requestTumusan = http.MultipartRequest("POST", Uri.parse(apiURLUpTumusanPrajuruBanjar))
            ..fields.addAll(bodyTumusan)
            ..headers.addAll(headers);
          await requestTumusan.send().then((response) {
            print("upload tumusan prajuru banjar status code: ${response.statusCode.toString()}");
          });
        }
      }
    });
  }

  Future uploadPrajuruDesa() async {
    Map<String, String> body = {
      "surat_keluar_id" : editSuratKeluarPanitia.idSuratKeluar.toString()
    };
    Map<String, String> headers = {
      'Content-Type' : 'multipart/form-data'
    };
    var request_delete = http.MultipartRequest("POST", Uri.parse("https://siradaskripsi.my.id/api/admin/surat/keluar/tetujon/desa/delete"))
      ..fields.addAll(body)
      ..headers.addAll(headers);
    await request_delete.send().then((response) {
      print("delete tetujon prajuru desa status code : ${response.statusCode.toString()}");
    });
    var request_delete_tumusan = http.MultipartRequest("POST", Uri.parse("https://siradaskripsi.my.id/api/admin/surat/keluar/tumusan/desa/delete"))
      ..fields.addAll(body)
      ..headers.addAll(headers);
    await request_delete_tumusan.send().then((response) async {
      print("delete tumusan prajuru desa status code : ${response.statusCode.toString()}");
      if(selectedBendesa.isNotEmpty) {
        if(isSendToKrama == false) {
          for(var i = 0; i < selectedBendesa.length; i++) {
            Map<String, String> body = {
              "surat_keluar_id" : editSuratKeluarPanitia.idSuratKeluar.toString(),
              "prajuru_desa_adat_id" : selectedBendesa[i]['prajuru_desa_adat_id'].toString()
            };
            var request = http.MultipartRequest("POST", Uri.parse(apiURLUpTetujonPrajuruDesa))
              ..fields.addAll(body)
              ..headers.addAll(headers);
            await request.send().then((response) {
              print("upload tetujon prajuru desa status code: ${response.statusCode.toString()}");
            });
          }
        }else {
          print("Surat terkirim ke krama");
        }
      }
      if(selectedBendesaTumusan.isNotEmpty) {
        for(var i = 0; i < selectedBendesaTumusan.length; i++) {
          Map<String, String> bodyTumusan = {
            "surat_keluar_id" : editSuratKeluarPanitia.idSuratKeluar.toString(),
            "prajuru_desa_adat_id" : selectedBendesaTumusan[i]['prajuru_desa_adat_id'].toString()
          };
          var requestTumusan = http.MultipartRequest("POST", Uri.parse(apiURLUpTumusanPrajuruDesa))
            ..fields.addAll(bodyTumusan)
            ..headers.addAll(headers);
          await requestTumusan.send().then((response) {
            print("upload tumusan prajuru desa status code: ${response.statusCode.toString()}");
          });
        }
      }
    });
  }

  Future uploadPihakLain() async {

    Map<String, String> body = {
      "surat_keluar_id" : editSuratKeluarPanitia.idSuratKeluar.toString()
    };
    Map<String, String> headers = {
      'Content-Type' : 'multipart/form-data'
    };
    var request_delete = http.MultipartRequest("POST", Uri.parse("https://siradaskripsi.my.id/api/admin/surat/keluar/tetujon/pihak-lain/delete"))
      ..fields.addAll(body)
      ..headers.addAll(headers);
    await request_delete.send().then((response) {
      print("delete tetujon pihak lain status code : ${response.statusCode.toString()}");
    });
    var request_delete_tumusan = http.MultipartRequest("POST", Uri.parse("https://siradaskripsi.my.id/api/admin/surat/keluar/tumusan/pihak-lain/delete"))
      ..fields.addAll(body)
      ..headers.addAll(headers);
    request_delete_tumusan.send().then((response) async {
      print("delete tumusan pihak lain status code : ${response.statusCode.toString()}");
      if(pihakLain.isNotEmpty) {
        if(isSendToKrama == false) {
          for(var i = 0; i < pihakLain.length; i++) {
            Map<String, String> body = {
              "surat_keluar_id" : editSuratKeluarPanitia.idSuratKeluar.toString(),
              "pihak_lain" : pihakLain[i].toString()
            };
            var request = http.MultipartRequest("POST", Uri.parse(apiURLUpTetujonPihakLain))
              ..fields.addAll(body)
              ..headers.addAll(headers);
            await request.send().then((response) {
              print("upload tetujon pihak lain status code: ${response.statusCode.toString()}");
            });
          }
        }else {
          print("Surat terkirim ke krama");
        }
      }
      if(pihakLainTumusan.isNotEmpty) {
        for(var i = 0; i < pihakLainTumusan.length; i++) {
          Map<String, String> bodyTumusan = {
            "surat_keluar_id" : editSuratKeluarPanitia.idSuratKeluar.toString(),
            "pihak_lain" : pihakLainTumusan[i].toString()
          };
          var requestTumusan = http.MultipartRequest("POST", Uri.parse(apiURLUpTumusanPihakLain))
            ..fields.addAll(bodyTumusan)
            ..headers.addAll(headers);
          requestTumusan.send().then((response) {
            print("upload tumusan pihak lain status code: ${response.statusCode.toString()}");
          });
        }
      }
    });
  }
}