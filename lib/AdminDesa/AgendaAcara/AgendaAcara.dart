import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:surat/LoginAndRegistration/LoginPage.dart';
import 'package:calendar_view/calendar_view.dart';

class agendaAcaraAdmin extends StatefulWidget {
  static var selectedViewSuratMasuk = "Bulan";
  static var selectedViewSuratKeluar = "Bulan";
  const agendaAcaraAdmin({Key key}) : super(key: key);

  @override
  State<agendaAcaraAdmin> createState() => _agendaAcaraAdminState();
}

class _agendaAcaraAdminState extends State<agendaAcaraAdmin> {
  List view = ['Hari', 'Minggu', 'Bulan'];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              color: HexColor("025393"),
              onPressed: (){
                Navigator.of(context).pop();
              },
            ),
            title: Text("Agenda Acara", style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.bold,
                color: HexColor("025393")
            )),
            bottom: TabBar(
              labelColor: HexColor("025393"),
              unselectedLabelColor: Colors.black,
              tabs: [
                Tab(child: Column(
                  children: <Widget>[
                    Icon(CupertinoIcons.mail, color: HexColor("73A9AD")),
                    Text("Surat Masuk", style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w700
                    ))
                  ],
                )),
                Tab(child: Column(
                  children: <Widget>[
                    Icon(CupertinoIcons.mail, color: HexColor("FBA1A1")),
                    Text("Surat Keluar", style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w700
                    ))
                  ],
                ))
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          Container(
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Text("Tampilan kalendar: ", style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14
                              )),
                            )
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
                                  child: Text("semua tampilan", style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 14
                                  )),
                                ),
                                value: agendaAcaraAdmin.selectedViewSuratMasuk,
                                underline: Container(),
                                items: view.map((e) {
                                  return DropdownMenuItem(
                                    value: e,
                                    child: Text("${e}".toLowerCase(), style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 14
                                    )),
                                  );
                                }).toList(),
                                selectedItemBuilder: (BuildContext context) => view.map((e) => Center(
                                  child: Text("${e}".toLowerCase(), style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 14
                                  )),
                                )).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    agendaAcaraAdmin.selectedViewSuratMasuk = value;
                                  });
                                },
                              ),
                            )
                          )
                        ],
                      ),
                      margin: EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 15),
                    ),
                    Container(
                      child: Expanded(
                        child: agendaSuratMasukAdmin(),
                      ),
                    )
                  ],
                )
              ),
              Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            Container(
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.5,
                                  child: Text("Tampilan kalendar: ", style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 14
                                  )),
                                )
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
                                      child: Text("semua tampilan", style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 14
                                      )),
                                    ),
                                    value: agendaAcaraAdmin.selectedViewSuratKeluar,
                                    underline: Container(),
                                    items: view.map((e) {
                                      return DropdownMenuItem(
                                        value: e,
                                        child: Text("${e}".toLowerCase(), style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 14
                                        )),
                                      );
                                    }).toList(),
                                    selectedItemBuilder: (BuildContext context) => view.map((e) => Center(
                                      child: Text("${e}".toLowerCase(), style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 14
                                      )),
                                    )).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        agendaAcaraAdmin.selectedViewSuratKeluar = value;
                                      });
                                    },
                                  ),
                                )
                            )
                          ],
                        ),
                        margin: EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 15),
                      ),
                      Container(
                        child: Expanded(
                          child: agendaSuratKeluarAdmin(),
                        ),
                      )
                    ],
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class agendaSuratMasukAdmin extends StatefulWidget {
  const agendaSuratMasukAdmin({Key key}) : super(key: key);

  @override
  State<agendaSuratMasukAdmin> createState() => _agendaSuratMasukAdminState();
}

class _agendaSuratMasukAdminState extends State<agendaSuratMasukAdmin> {
  EventController eventControllerSuratMasuk;
  var apiURLGetAgendaSuratMasuk = "https://siradaskripsi.my.id/api/agenda/${loginPage.desaId}/undangan";

  Future getAgendaSuratMasuk() async {
    var data = await http.get(Uri.parse(apiURLGetAgendaSuratMasuk));
    var jsonData = json.decode(data.body);
    if(data.statusCode == 200) {
      setState(() {
        for(var data in jsonData) {
          final event = CalendarEventData(
              date: DateTime.parse("${data['tanggal_kegiatan_mulai']}T${data['waktu_kegiatan_mulai']}"),
              startTime: DateTime.parse("${data['tanggal_kegiatan_mulai']}T${data['waktu_kegiatan_mulai']}"),
              endTime: data['waktu_kegiatan_mulai'] == data['waktu_kegiatan_selesai'] ? DateTime.parse("${data['tanggal_kegiatan_berakhir']}T${data['waktu_kegiatan_selesai']}").add(Duration(hours: 1)) : DateTime.parse("${data['tanggal_kegiatan_berakhir']}T${data['waktu_kegiatan_selesai']}"),
              endDate: data['waktu_kegiatan_mulai'] == data['waktu_kegiatan_selesai'] ? DateTime.parse("${data['tanggal_kegiatan_berakhir']}T${data['waktu_kegiatan_selesai']}").add(Duration(hours: 1)) : DateTime.parse("${data['tanggal_kegiatan_berakhir']}T${data['waktu_kegiatan_selesai']}"),
              event: data['perihal'],
            title: "${data['perihal']}",
          );
          eventControllerSuratMasuk.add(event);
        }
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    eventControllerSuratMasuk = EventController();
    getAgendaSuratMasuk();
  }

  @override
  Widget build(BuildContext context) {
    return CalendarControllerProvider(
      controller: eventControllerSuratMasuk,
      child: agendaAcaraAdmin.selectedViewSuratMasuk == "Bulan" ? MonthView(
        minMonth: DateTime(1900),
        maxMonth: DateTime(2100),
        initialMonth: DateTime.now(),
        cellAspectRatio: 1,
        startDay: WeekDays.sunday,
      ) : agendaAcaraAdmin.selectedViewSuratMasuk == "Hari" ? DayView(
        showVerticalLine: true,
        showLiveTimeLineInAllDays: true,
        minDay: DateTime(1900),
        maxDay: DateTime(2100),
        initialDay: DateTime.now(),
        heightPerMinute: 1,
        eventArranger: SideEventArranger(),
      ) : agendaAcaraAdmin.selectedViewSuratMasuk == "Minggu" ? WeekView(
        showLiveTimeLineInAllDays: true,
        width: 400,
        minDay: DateTime(1900),
        maxDay: DateTime(2100),
        initialDay: DateTime.now(),
        heightPerMinute: 1,
        eventArranger: SideEventArranger(),
        startDay: WeekDays.sunday,
      ) : Container(),
    );
  }
}

class agendaSuratKeluarAdmin extends StatefulWidget {
  const agendaSuratKeluarAdmin({Key key}) : super(key: key);

  @override
  State<agendaSuratKeluarAdmin> createState() => _agendaSuratKeluarAdminState();
}

class _agendaSuratKeluarAdminState extends State<agendaSuratKeluarAdmin> {
  EventController eventControllerSuratKeluar;
  var apiURLGetAgendaSuratKeluar = "https://siradaskripsi.my.id/api/agenda/${loginPage.desaId}/internal";

  Future getAgendaSuratKeluar() async {
    var data = await http.get(Uri.parse(apiURLGetAgendaSuratKeluar));
    var jsonData = json.decode(data.body);
    if(data.statusCode == 200) {
      setState(() {
        for(var data in jsonData) {
          final event = CalendarEventData(
            date: DateTime.parse("${data['tanggal_kegiatan_mulai']}T${data['waktu_kegiatan_mulai']}"),
            startTime: DateTime.parse("${data['tanggal_kegiatan_mulai']}T${data['waktu_kegiatan_mulai']}"),
            endTime: data['waktu_kegiatan_mulai'] == data['waktu_kegiatan_selesai'] ? DateTime.parse("${data['tanggal_kegiatan_berakhir']}T${data['waktu_kegiatan_selesai']}").add(Duration(hours: 1)) : DateTime.parse("${data['tanggal_kegiatan_berakhir']}T${data['waktu_kegiatan_selesai']}"),
            endDate: data['waktu_kegiatan_mulai'] == data['waktu_kegiatan_selesai'] ? DateTime.parse("${data['tanggal_kegiatan_berakhir']}T${data['waktu_kegiatan_selesai']}").add(Duration(hours: 1)) : DateTime.parse("${data['tanggal_kegiatan_berakhir']}T${data['waktu_kegiatan_selesai']}"),
            event: data['parindikan'],
            title: data['tim_kegiatan'] == null ? "${data['parindikan']}" : "${data['parindikan']} (${data['tim_kegiatan']})",
          );
          eventControllerSuratKeluar.add(event);
        }
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    eventControllerSuratKeluar = EventController();
    getAgendaSuratKeluar();
  }

  @override
  Widget build(BuildContext context) {
    return CalendarControllerProvider(
      controller: eventControllerSuratKeluar,
      child: agendaAcaraAdmin.selectedViewSuratKeluar == "Bulan" ? MonthView(
        minMonth: DateTime(1900),
        maxMonth: DateTime(2100),
        initialMonth: DateTime.now(),
        cellAspectRatio: 1,
        startDay: WeekDays.sunday,
      ) : agendaAcaraAdmin.selectedViewSuratKeluar == "Hari" ? DayView(
        showVerticalLine: true,
        showLiveTimeLineInAllDays: true,
        minDay: DateTime(1900),
        maxDay: DateTime(2100),
        initialDay: DateTime.now(),
        heightPerMinute: 1,
        eventArranger: SideEventArranger(),
      ) : agendaAcaraAdmin.selectedViewSuratKeluar == "Minggu" ? WeekView(
        showLiveTimeLineInAllDays: true,
        width: 400,
        minDay: DateTime(1900),
        maxDay: DateTime(2100),
        initialDay: DateTime.now(),
        heightPerMinute: 1,
        eventArranger: SideEventArranger(),
        startDay: WeekDays.sunday,
      ) : Container(),
    );
  }
}
