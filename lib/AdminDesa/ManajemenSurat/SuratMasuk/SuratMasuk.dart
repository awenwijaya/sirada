import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:surat/AdminDesa/ManajemenSurat/SuratMasuk/DetailSuratMasuk.dart';
import 'package:surat/AdminDesa/ManajemenSurat/SuratMasuk/EditSuratMasuk.dart';
import 'package:surat/AdminDesa/ManajemenSurat/SuratMasuk/TambahSuratMasuk.dart';
import 'package:surat/LoginAndRegistration/LoginPage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class suratMasukAdmin extends StatefulWidget {
  const suratMasukAdmin({Key key}) : super(key: key);

  @override
  State<suratMasukAdmin> createState() => _suratMasukAdminState();
}

class _suratMasukAdminState extends State<suratMasukAdmin> {
  var apiURLShowListSuratMasuk = "https://siradaskripsi.my.id/api/data/admin/surat/masuk/${loginPage.desaId}";
  var apiURLDeleteSuratMasuk = "https://siradaskripsi.my.id/api/admin/surat/masuk/delete";
  List<int> idSuratMasuk = [];
  var perihalSuratMasuk = [];
  var asalSuratMasuk = [];
  var selectedIdSuratMasuk;
  bool LoadingSuratMasuk = true;
  bool availableSuratMasuk = false;
  bool isSearchBar = false;
  bool isSearch = false;
  FToast ftoast;
  final controllerSearch = TextEditingController();

  //filter
  var apiURLShowFilterKodeSurat = "https://siradaskripsi.my.id/api/admin/surat/masuk/filter/kode_surat";
  var apiURLShowFilterPrajuru = "https://siradaskripsi.my.id/api/admin/surat/masuk/filter/prajuru";
  var apiURLShowFilterPengirimSurat = "https://siradaskripsi.my.id/api/admin/surat/masuk/filter/pengirim";
  var apiURLShowFilterResult = "https://siradaskripsi.my.id/api/admin/surat/masuk/filter/result";
  List kodeSuratFilter = List();
  List prajuruListFilter = List();
  List pengirimListFilter = List();
  var selectedKodeSuratFilter;
  var selectedPrajuruListFilter;
  var selectedPengirimListFilter;
  String selectedRangeAwal;
  String selectedRangeAwalValue;
  String selectedRangeAkhir;
  String selectedRangeAkhirValue;
  DateTime rangeAwal;
  DateTime rangeAkhir;
  bool LoadingFilter = true;
  bool isFilter = false;
  final controllerFilterTanggalMasuk = TextEditingController();
  final DateRangePickerController controllerFilterTanggal = DateRangePickerController();

  Future showFilterResult() async {
    setState(() {
      LoadingSuratMasuk = true;
      isFilter = true;
      isSearch = false;
    });
    var body = jsonEncode({
      "desa_adat_id" : loginPage.desaId,
      "kode_surat_filter" : selectedKodeSuratFilter == null ? null : selectedKodeSuratFilter,
      "pengirim_filter" : selectedPengirimListFilter == null ? null : selectedPengirimListFilter,
      "tanggal_awal" : selectedRangeAwalValue == null ? null : selectedRangeAwalValue,
      "search_query" : controllerSearch.text,
      "tanggal_akhir" : selectedRangeAkhirValue == null ? selectedRangeAwalValue == null ? null : selectedRangeAwalValue : selectedRangeAkhirValue
    });
    http.post(Uri.parse(apiURLShowFilterResult),
      headers: {"Content-Type" : "application/json"},
      body: body
    ).then((http.Response response) async {
      var statusCode = response.statusCode;
      if(statusCode == 200) {
        var data = json.decode(response.body);
        this.idSuratMasuk = [];
        this.perihalSuratMasuk = [];
        this.asalSuratMasuk = [];
        setState(() {
          LoadingSuratMasuk = false;
          availableSuratMasuk = true;
          for(var i = 0; i < data.length; i++) {
            this.idSuratMasuk.add(data[i]['surat_masuk_id']);
            this.perihalSuratMasuk.add(data[i]['perihal']);
            this.asalSuratMasuk.add(data[i]['asal_surat']);
          }
        });
      }
    });
  }

  Future getFilterKomponen() async{
    var body = jsonEncode({
      'desa_adat_id' : loginPage.desaId
    });
    http.post(Uri.parse(apiURLShowFilterKodeSurat),
      headers: {"Content-Type" : "application/json"},
      body: body
    ).then((http.Response response) {
      var responseValue = response.statusCode;
      if(responseValue == 200) {
        var jsonData = json.decode(response.body);
        setState(() {
          kodeSuratFilter = jsonData;
        });
      }
    });
    http.post(Uri.parse(apiURLShowFilterPrajuru),
      headers: {"Content-Type" : "application/json"},
      body: body
    ).then((http.Response response) {
      var responseValue = response.statusCode;
      if(responseValue == 200) {
        var jsonData = json.decode(response.body);
        setState(() {
          prajuruListFilter = jsonData;
        });
      }
    });
    http.post(Uri.parse(apiURLShowFilterPengirimSurat),
      headers: {"Content-Type" : "application/json"},
      body: body
    ).then((http.Response response) {
      var responseValue = response.statusCode;
      if(responseValue == 200) {
        var jsonData = json.decode(response.body);
        setState(() {
          pengirimListFilter = jsonData;
        });
      }
    });
    setState(() {
      LoadingFilter = false;
    });
  }

  Future refreshListSuratMasuk() async {
    var response = await http.get(Uri.parse(apiURLShowListSuratMasuk));
    if(response.statusCode == 200) {
      var data = json.decode(response.body);
      this.idSuratMasuk = [];
      this.perihalSuratMasuk = [];
      this.asalSuratMasuk = [];
      setState(() {
        LoadingSuratMasuk = false;
        availableSuratMasuk = true;
        for(var i = 0; i < data.length; i++) {
          this.idSuratMasuk.add(data[i]['surat_masuk_id']);
          this.perihalSuratMasuk.add(data[i]['perihal']);
          this.asalSuratMasuk.add(data[i]['asal_surat']);
        }
      });
    }else{
      setState(() {
        LoadingSuratMasuk = false;
        availableSuratMasuk = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    refreshListSuratMasuk();
    getFilterKomponen();
    ftoast = FToast();
    ftoast.init(this.context);
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
          title: Text("Surat Masuk", style: TextStyle(
              fontFamily: "Poppins",
              fontWeight: FontWeight.w700,
              color: HexColor("#025393")
          )),
        ),
        body: Column(
          children: <Widget>[
            Container(
              child: TextField(
                controller: controllerSearch,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        borderSide: BorderSide(color: HexColor("#025393"))
                    ),
                    hintText: "Cari surat masuk...",
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: (){
                        if(controllerSearch.text != "") {
                          setState(() {
                            isFilter = true;
                          });
                          showFilterResult();
                        }
                      },
                    )
                ),
                style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14
                ),
              ),
              margin: EdgeInsets.only(top: 15, bottom: 10, left: 20, right: 20),
            ),
            Container(
              child: LoadingFilter ? ListTileShimmer() : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(width: 1, color: Colors.black38)
                      ),
                      child: DropdownButton(
                        isExpanded: true,
                        hint: Center(
                          child: Text("Semua Kode", style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14
                          )),
                        ),
                        value: selectedKodeSuratFilter,
                        underline: Container(),
                        items: kodeSuratFilter.map((e) {
                          return DropdownMenuItem(
                            value: e['master_surat_id'],
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Text("${e['kode_nomor_surat']} - ${e['keterangan']}", style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14
                              ), maxLines: 2, overflow: TextOverflow.ellipsis, softWrap: false),
                            )
                          );
                        }).toList(),
                        selectedItemBuilder: (BuildContext context) => kodeSuratFilter.map((e) => Center(
                          child: Text(e['kode_nomor_surat'], style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14
                          )),
                        )).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedKodeSuratFilter = value;
                          });
                          showFilterResult();
                        },
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 5),
                    ),
                    Container(
                      width: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(width: 1, color: Colors.black38)
                      ),
                      child: DropdownButton(
                        isExpanded: true,
                        hint: Center(
                          child: Text("Semua Prajuru", style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 14
                          )),
                        ),
                        value: selectedPrajuruListFilter,
                        underline: Container(),
                        items: prajuruListFilter.map((e) {
                          return DropdownMenuItem(
                            value: e['prajuru_desa_adat_id'],
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Text(e['nama'], style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14
                              ), maxLines: 1, overflow: TextOverflow.ellipsis, softWrap: false),
                            )
                          );
                        }).toList(),
                        selectedItemBuilder: (BuildContext context) => prajuruListFilter.map((e) => Center(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Text(e['nama'], style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14
                            ), maxLines: 1, overflow: TextOverflow.ellipsis, softWrap: false),
                          )
                        )).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedPrajuruListFilter = value;
                          });
                          showFilterResult();
                        },
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 5),
                    ),
                    Container(
                      width: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(width: 1, color: Colors.black38)
                      ),
                      child: DropdownButton(
                        isExpanded: true,
                        hint: Center(
                          child: Text("Semua Pengirim", style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 14
                          )),
                        ),
                        value: selectedPengirimListFilter,
                        underline: Container(),
                        items: pengirimListFilter.map((e) {
                          return DropdownMenuItem(
                            value: e['asal_surat'],
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Text(e['asal_surat'], style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14
                              ), maxLines: 1, overflow: TextOverflow.ellipsis, softWrap: false),
                            ),
                          );
                        }).toList(),
                        selectedItemBuilder: (BuildContext context) => pengirimListFilter.map((e) => Center(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Text(e['asal_surat'], style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14
                            )),
                          ),
                        )).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedPengirimListFilter = value;
                          });
                          showFilterResult();
                        },
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 5),
                    )
                  ],
                ),
              ),
              margin: EdgeInsets.only(left: 20, right: 20),
            ),
            Container(
              child: GestureDetector(
                onTap: (){
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Pilih Tanggal", style: TextStyle(
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
                                  controller: controllerFilterTanggal,
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
                            child: Text("OK", style: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w700,
                              color: HexColor("025393")
                            )),
                            onPressed: (){
                              Navigator.of(context).pop();
                            },
                          )
                        ]
                      );
                    }
                  );
                },
                child: TextField(
                  enabled: false,
                  controller: controllerFilterTanggalMasuk,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        borderSide: BorderSide(color: HexColor("#025393"))
                    ),
                    hintText: "Semua Tanggal Masuk",
                  ),
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 14
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
                margin: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  if(isFilter == true) Container(
                    child: FlatButton(
                      onPressed: (){
                        setState(() {
                          selectedRangeAkhirValue = null;
                          selectedRangeAkhir = null;
                          selectedRangeAwalValue = null;
                          selectedRangeAwal = null;
                          selectedPengirimListFilter = null;
                          selectedPrajuruListFilter = null;
                          selectedKodeSuratFilter = null;
                          LoadingSuratMasuk = true;
                          isFilter = false;
                          controllerFilterTanggalMasuk.text = "";
                          controllerSearch.text = "";
                        });
                        refreshListSuratMasuk();
                      },
                      child: Text("Hapus Filter", style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.white
                      )),
                      color: HexColor("025393"),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                        side: BorderSide(color: HexColor("025393"), width: 2)
                      ),
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 5),
                  )
                ],
              ),
            ),
            Container(
              child: LoadingSuratMasuk ? ListTileShimmer() : availableSuratMasuk ? Expanded(
                flex: 1,
                child: RefreshIndicator(
                  onRefresh: isFilter ? showFilterResult : refreshListSuratMasuk,
                  child: ListView.builder(
                    itemCount: idSuratMasuk.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: (){
                          setState(() {
                            detailSuratMasukAdmin.idSuratStatic = idSuratMasuk[index];
                          });
                          Navigator.push(context, CupertinoPageRoute(builder: (context) => detailSuratMasukAdmin(idSuratMasuk[index])));
                        },
                        child: Container(
                          child: Stack(
                              children: <Widget>[
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        child: Image.asset(
                                          'images/email.png',
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
                                                width: MediaQuery.of(context).size.width * 0.55,
                                                child: Text(perihalSuratMasuk[index], style: TextStyle(
                                                    fontFamily: "Poppins",
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w700,
                                                    color: HexColor("#025393")
                                                ), maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  softWrap: false,
                                                ),
                                              ),
                                            ),
                                            Container(
                                                child: SizedBox(
                                                  width: MediaQuery.of(context).size.width * 0.55,
                                                  child: Text(asalSuratMasuk[index], style: TextStyle(
                                                      fontFamily: "Poppins",
                                                      fontSize: 14
                                                  ), maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    softWrap: false,
                                                  ),
                                                )
                                            )
                                          ],
                                        ),
                                        margin: EdgeInsets.only(left: 15),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                    alignment: Alignment.centerRight,
                                    child: PopupMenuButton<int>(
                                        onSelected: (item) {
                                          setState(() {
                                            selectedIdSuratMasuk = idSuratMasuk[index];
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
              ) : Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Icon(
                          CupertinoIcons.mail_solid,
                          size: 50,
                          color: Colors.black26,
                        ),
                      ),
                      Container(
                        child: Text("Tidak ada Data Surat Masuk", style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black26
                        ), textAlign: TextAlign.center),
                        margin: EdgeInsets.only(top: 10),
                        padding: EdgeInsets.symmetric(horizontal: 30),
                      ),
                      Container(
                        child: Text("Tidak ada data surat masuk. Anda bisa menambahkannya dengan cara menekan tombol Tambah Data Surat dan isi data surat pada form yang telah disediakan", style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14,
                            color: Colors.black26
                        ), textAlign: TextAlign.center),
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        margin: EdgeInsets.only(top: 10),
                      )
                    ],
                  ),
                  margin: EdgeInsets.only(top: 80)
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.push(context, CupertinoPageRoute(builder: (context) => tambahSuratMasukAdmin())).then((value) {
              refreshListSuratMasuk();
              selectedRangeAkhirValue = null;
              selectedRangeAkhir = null;
              selectedRangeAwalValue = null;
              selectedRangeAwal = null;
              selectedPengirimListFilter = null;
              selectedPrajuruListFilter = null;
              selectedKodeSuratFilter = null;
              isFilter = false;
            });
          },
          child: Icon(Icons.add),
          backgroundColor: HexColor("#025393")
        )
      )
    );
  }

  void onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        setState(() {
          editSuratMasukAdmin.idSuratMasuk = selectedIdSuratMasuk;
        });
        Navigator.push(context, CupertinoPageRoute(builder: (context) => editSuratMasukAdmin())).then((value) {
          refreshListSuratMasuk();
          selectedRangeAkhirValue = null;
          selectedRangeAkhir = null;
          selectedRangeAwalValue = null;
          selectedRangeAwal = null;
          selectedPengirimListFilter = null;
          selectedPrajuruListFilter = null;
          selectedKodeSuratFilter = null;
          isFilter = false;
        });
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
                                child: Text("Hapus Surat Masuk", style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: HexColor("#025393")
                                ), textAlign: TextAlign.center),
                                margin: EdgeInsets.only(top: 10)
                            ),
                            Container(
                                child: Text("Apakah Anda yakin ingin menghapus surat ini?", style: TextStyle(
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
                          var body = jsonEncode({
                            "surat_masuk_id" : selectedIdSuratMasuk
                          });
                          http.post(Uri.parse(apiURLDeleteSuratMasuk),
                              headers: {"Content-Type" : "application/json"},
                              body: body
                          ).then((http.Response response) {
                            var responseValue = response.statusCode;
                            if(responseValue == 200) {
                              refreshListSuratMasuk();
                              Fluttertoast.showToast(
                                  msg: "Data surat masuk berhasil dihapus",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM
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
        break;
    }
  }

  void selectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      selectedRangeAwal = DateFormat("dd-MMM-yyyy").format(args.value.startDate).toString();
      selectedRangeAwalValue = DateFormat("yyyy-MM-dd").format(args.value.startDate).toString();
      selectedRangeAkhir = DateFormat("dd-MMM-yyyy").format(args.value.endDate ?? args.value.startDate).toString();
      selectedRangeAkhirValue = DateFormat("yyyy-MM-dd").format(args.value.endDate ?? args.value.startDate).toString();
      controllerFilterTanggalMasuk.text = selectedRangeAkhirValue == null ? "$selectedRangeAwal" : "$selectedRangeAwal - $selectedRangeAkhir";
    });
    showFilterResult();
  }
}