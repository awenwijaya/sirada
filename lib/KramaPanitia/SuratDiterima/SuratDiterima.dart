import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:surat/KramaPanitia/SuratKeluarPanitia/DetailSurat.dart';
import 'package:surat/LoginAndRegistration/LoginPage.dart';
import 'dart:convert';

import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class suratDiterimaPanitia extends StatefulWidget {
  const suratDiterimaPanitia({Key key}) : super(key: key);

  @override
  State<suratDiterimaPanitia> createState() => _suratDiterimaPanitiaState();
}

class _suratDiterimaPanitiaState extends State<suratDiterimaPanitia> {
  var apiURLGetSuratDiterima = "https://siradaskripsi.my.id/api/surat/tetujon/panitia/${loginPage.kramaId}";
  var apiURLGetFilterTimKegiatan = "https://siradaskripsi.my.id/api/surat/tetujon/panitia/filter/${loginPage.kramaId}";
  var apiURLGetFilterResult = "https://siradaskripsi.my.id/api/surat/tetujon/panitia/filter/result";
  List suratDiterima = List();
  bool availableSurat = false;
  bool LoadingSurat = true;
  bool LoadingFilter = true;
  bool isFilter = false;
  final controllerSearch = TextEditingController();
  final DateRangePickerController controllerFilterTanggal = DateRangePickerController();
  List timKegiatanFilter = [];
  var selectedTimKegiatanFilter;

  //filter tanggal keluar
  var selectedFilterTanggal;
  String selectedRangeAwal;
  String selectedRangeAwalValue;
  String selectedRangeAkhir;
  String selectedRangeAkhirValue;
  DateTime rangeAwal;
  DateTime rangeAkhir;

  Future getFilterResult() async {
    setState(() {
      LoadingSurat = true;
      isFilter = true;
    });
    var body = jsonEncode({
      "search_query" : controllerSearch.text == "" ? null : controllerSearch.text,
      "tanggal_awal" : selectedRangeAwalValue == null ? null : selectedRangeAwalValue,
      "tanggal_akhir" : selectedRangeAkhirValue == null ? selectedRangeAwalValue == null ? null : selectedRangeAwalValue : selectedRangeAkhirValue,
      "tim_kegiatan_filter" : selectedTimKegiatanFilter,
      "krama_mipil_id" : loginPage.kramaId
    });
    http.post(Uri.parse(apiURLGetFilterResult),
      headers: {"Content-Type" : "application/json"},
      body: body
    ).then((http.Response response) async {
      if(response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        setState(() {
          suratDiterima = jsonData;
          LoadingSurat = false;
          availableSurat = true;
        });
      }else {
        setState(() {
          LoadingSurat = false;
          availableSurat = false;
        });
      }
    });
  }

  Future getFilterKomponen() async {
    http.get(Uri.parse(apiURLGetFilterTimKegiatan),
        headers: {"Content-Type" : "application/json"}
    ).then((http.Response response) {
      print("get filter komponen status : ${response.statusCode.toString()}");
      if(response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        setState(() {
          timKegiatanFilter = jsonData;
          LoadingFilter = false;
        });
      }
    });
  }

  Future refreshListSuratDiterima() async {
    Uri uri = Uri.parse(apiURLGetSuratDiterima);
    final response = await http.get(uri);
    if(response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        suratDiterima = jsonData;
        LoadingSurat = false;
        availableSurat = true;
      });
    }else {
      setState(() {
        LoadingSurat = false;
        availableSurat = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    refreshListSuratDiterima();
    getFilterKomponen();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: HexColor("025393"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: (){
              Navigator.of(context).pop();
            },
          ),
          title: Text("Surat Diterima", style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w700,
            color: Colors.white
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
                        borderSide: BorderSide(color: HexColor("025393"))
                    ),
                    hintText: "Cari surat...",
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: (){
                        if(controllerSearch.text != '') {
                          setState(() {
                            isFilter = true;
                          });
                          getFilterResult();
                        }
                      },
                    )
                ),
                style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14
                ),
              ),
              margin: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
            ),
            Container(
              child: LoadingFilter ? ListTileShimmer() : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
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
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(width: 1, color: Colors.black38)
                        ),
                        child: Center(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Text(selectedFilterTanggal == null ? "Semua Tanggal Keluar" : selectedFilterTanggal, style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14,
                                color: selectedFilterTanggal == null ? Colors.black54 : Colors.black
                            ), maxLines: 1, softWrap: false, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center),
                          ),
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 5),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(width: 1, color: Colors.black38)
                      ),
                      child: DropdownButton(
                        isExpanded: true,
                        hint: Center(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Text("Semua Tim Kegiatan", style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14
                            ), maxLines: 1, softWrap: false, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center),
                          ),
                        ),
                        value: selectedTimKegiatanFilter,
                        underline: Container(),
                        items: timKegiatanFilter.map((e) {
                          return DropdownMenuItem(
                            value: e['tim_kegiatan'],
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Text(e['tim_kegiatan'], style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14
                              ), maxLines: 1, overflow: TextOverflow.ellipsis, softWrap: false),
                            ),
                          );
                        }).toList(),
                        selectedItemBuilder: (BuildContext context) => timKegiatanFilter.map((e) => Center(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Text(e['tim_kegiatan'], style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14
                            )),
                          ),
                        )).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedTimKegiatanFilter = value;
                          });
                          getFilterResult();
                        },
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 5),
                    ),
                  )
                ],
              ),
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  if(isFilter == true) Container(
                    child: FlatButton(
                      onPressed: (){
                        setState(() {
                          isFilter = false;
                          LoadingSurat = true;
                          selectedRangeAwalValue = null;
                          selectedRangeAwal = null;
                          selectedRangeAkhir = null;
                          selectedRangeAkhirValue = null;
                          selectedTimKegiatanFilter = null;
                          controllerSearch.text = "";
                          selectedFilterTanggal = null;
                        });
                        refreshListSuratDiterima();
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
              child: LoadingSurat ? ListTileShimmer() : availableSurat ? Expanded(
                flex: 1,
                child: RefreshIndicator(
                  onRefresh: isFilter ? getFilterResult : refreshListSuratDiterima,
                  child: ListView.builder(
                    itemCount: suratDiterima.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: (){
                          setState(() {
                            detailSuratKeluarPanitia.suratKeluarId = suratDiterima[index]['surat_keluar_id'];
                            detailSuratKeluarPanitia.isTetujon = true;
                          });
                          Navigator.push(context, CupertinoPageRoute(builder: (context) => detailSuratKeluarPanitia()));
                        },
                        child: Container(
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
                                        child: Text(suratDiterima[index]['parindikan'].toString(), style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: HexColor("025393")
                                        ), maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Text(suratDiterima[index]['nomor_surat'].toString(), style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 14
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
              ) : Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          child: Icon(
                              CupertinoIcons.mail_solid,
                              size: 50,
                              color: Colors.black26
                          )
                      ),
                      Container(
                          child: Text("Tidak ada Data Surat", style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black26
                          ), textAlign: TextAlign.center),
                          margin: EdgeInsets.only(top: 10),
                          padding: EdgeInsets.symmetric(horizontal: 30)
                      ),
                    ],
                  )
              ),
            )
          ],
        ),
      ),
    );
  }

  void selectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      selectedRangeAwal = DateFormat("dd-MMM-yyyy").format(args.value.startDate).toString();
      selectedRangeAwalValue = DateFormat("yyyy-MM-dd").format(args.value.startDate).toString();
      selectedRangeAkhir = DateFormat("dd-MMM-yyyy").format(args.value.endDate ?? args.value.startDate).toString();
      selectedRangeAkhirValue = DateFormat("yyyy-MM-dd").format(args.value.endDate ?? args.value.startDate).toString();
      selectedFilterTanggal = selectedRangeAkhirValue == null ? "$selectedRangeAwal" : "$selectedRangeAwal - $selectedRangeAkhir";
    });
    getFilterResult();
  }

}
