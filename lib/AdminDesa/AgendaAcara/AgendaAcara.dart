import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_calendar/calendar.dart';

class agendaAcaraAdmin extends StatefulWidget {
  const agendaAcaraAdmin({Key key}) : super(key: key);

  @override
  State<agendaAcaraAdmin> createState() => _agendaAcaraAdminState();
}

class _agendaAcaraAdminState extends State<agendaAcaraAdmin> {
  List<Color> warna=<Color>[];
  DateTime sekarang = DateTime.now();
  final CalendarController calendarController = CalendarController();
  bool availableAgendaInternal = false;
  bool availableAgendaUndangan = false;
  bool LoadingAgendaInternal = true;
  bool LoadingAgendaUndangan = true;
  List<Meeting> agendaInternal = [];
  List<Meeting> agendaUndangan = [];

  Future<List<Meeting>> getAgendaUndangan() async {
    var data = await http.get(Uri.parse("http://siradaskripsi.my.id/api/agenda/1465/undangan"));
    var jsonData = json.decode(data.body);
    agendaUndangan = [];
    if(data.statusCode == 200) {
      setState(() {
        availableAgendaUndangan = true;
        LoadingAgendaUndangan = false;
      });
      for(var data in jsonData) {
        Meeting meeting = Meeting(
            eventName: data['perihal'],
            from: DateTime.parse("${data['tanggal_kegiatan_mulai']}T${data['waktu_kegiatan_mulai']}"),
            to: DateTime.parse("${data['tanggal_kegiatan_berakhir']}T${data['waktu_kegiatan_selesai']}"),
            background: HexColor("#025393"),
            allDay: false
        );
        agendaUndangan.add(meeting);
      }
      return agendaUndangan;
    }else{
      setState(() {
        LoadingAgendaUndangan = false;
        availableAgendaUndangan = false;
      });
    }
  }

  Future<List<Meeting>> getAgendaInternal() async {
    var data = await http.get(Uri.parse("http://siradaskripsi.my.id1650114734.pdf/api/agenda/1465/internal"));
    var jsonData = json.decode(data.body);
    agendaInternal = [];
    if(data.statusCode == 200) {
      setState(() {
        LoadingAgendaInternal = false;
        availableAgendaInternal = true;
      });
      for(var data in jsonData) {
        Meeting meeting = Meeting(
            eventName: data['parindikan'],
            from: DateTime.parse("${data['tanggal_kegiatan_mulai']}T${data['waktu_kegiatan_mulai']}"),
            to: DateTime.parse("${data['tanggal_kegiatan_berakhir']}T${data['waktu_kegiatan_selesai']}"),
            background: HexColor("#025393"),
            allDay: false
        );
        agendaInternal.add(meeting);
      }
      return agendaInternal;
    }else {
      setState(() {
        LoadingAgendaInternal = false;
        availableAgendaInternal = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAgendaUndangan();
    getAgendaInternal();
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
          title: Text("Agenda Acara", style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w700,
            color: HexColor("#025393")
          )),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.help_outline_outlined),
              color: HexColor("#025393"),
              onPressed: (){
                showDialog(
                  context: context,
                  barrierDismissible: true,
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
                                'images/kalendar.png',
                                height: 50,
                                width: 50,
                              ),
                            ),
                            Container(
                              child: Text("Tentang Agenda", style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: HexColor("#025393")
                              ), textAlign: TextAlign.center),
                              margin: EdgeInsets.only(top: 10),
                            ),
                            Container(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      "Agenda acara adalah daftar kegiatan yang dilaksanakan pada Desa Adat pada kurun waktu tertentu."
                                          "\nKegiatan pada Desa Adat dapat berasal dari Surat Undangan ataupun dari acara yang dilaksanakan oleh Kantor Desa Adat"
                                          "\nAgenda acara terbagi menjadi 2 yaitu:"
                                          "\n\n1. Agenda Internal: Agenda yang dilaksanakan oleh Kantor Desa Adat dan berasal dari data Surat Keluar"
                                          "\n\n2. Agenda Undangan: Agenda yang dilaksanakan oleh instansi lain dan berasal dari data Surat Masuk", style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 14
                                    ),
                                      textAlign: TextAlign.center,
                                    ),
                                    margin: EdgeInsets.only(top: 10),
                                  )
                                ],
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
                            color: HexColor("#025393")
                          )),
                          onPressed: (){Navigator.of(context).pop();},
                        )
                      ],
                    );
                  }
                );
              },
            )
          ],
        ),
        body: SafeArea(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                DefaultTabController(
                  length: 2,
                  initialIndex: 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        child: TabBar(
                          labelColor: HexColor("#025393"),
                          unselectedLabelColor: Colors.black,
                          tabs: [
                            Tab(
                              child: Column(
                                children: <Widget>[
                                  Icon(CupertinoIcons.calendar),
                                  Text("Internal", style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w700
                                  ))
                                ],
                              ),
                            ),
                            Tab(
                              child: Column(
                                children: <Widget>[
                                  Icon(CupertinoIcons.mail),
                                  Text("Undangan", style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w700
                                  ))
                                ],
                              ),
                            )
                          ],
                        ),
                        margin: EdgeInsets.only(top: 15),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: TabBarView(
                          children: <Widget>[
                            Container(
                              child: LoadingAgendaInternal ? ProfilePageShimmer() : Container(
                                child: availableAgendaInternal ? Container(
                                    padding: EdgeInsets.only(top: 5),
                                    child: SafeArea(
                                      child: Container(
                                          child: SfCalendar(
                                            controller: calendarController,
                                            view: CalendarView.month,
                                            onTap: calendarTapped,
                                            allowedViews: [
                                              CalendarView.day,
                                              CalendarView.week,
                                              CalendarView.month,
                                              CalendarView.timelineDay,
                                              CalendarView.timelineWeek,
                                              CalendarView.timelineMonth
                                            ],
                                            initialDisplayDate: sekarang,
                                            dataSource: MeetingDataSource(agendaInternal),
                                          )
                                      ),
                                    )
                                ) : Container(
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          child: Icon(
                                            CupertinoIcons.calendar,
                                            size: 50,
                                            color: Colors.black26,
                                          ),
                                        ),
                                        Container(
                                          child: Text("Tidak ada Agenda Internal", style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black26
                                          ), textAlign: TextAlign.center),
                                          margin: EdgeInsets.only(top: 10),
                                          padding: EdgeInsets.symmetric(horizontal: 30),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ),
                            Container(
                                child: LoadingAgendaUndangan ? ProfilePageShimmer() : Container(
                                  child: availableAgendaUndangan ? Container(
                                      padding: EdgeInsets.only(top: 5),
                                      child: SafeArea(
                                        child: Container(
                                            child: SfCalendar(
                                              controller: calendarController,
                                              view: CalendarView.month,
                                              onTap: calendarTapped,
                                              allowedViews: [
                                                CalendarView.day,
                                                CalendarView.week,
                                                CalendarView.month,
                                                CalendarView.timelineDay,
                                                CalendarView.timelineWeek,
                                                CalendarView.timelineMonth
                                              ],
                                              initialDisplayDate: sekarang,
                                              dataSource: MeetingDataSource(agendaUndangan),
                                            )
                                        ),
                                      )
                                  ) : Container(
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            child: Icon(
                                              CupertinoIcons.number,
                                              size: 50,
                                              color: Colors.black26,
                                            ),
                                          ),
                                          Container(
                                            child: Text("Tidak ada Agenda Undangan", style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black26
                                            ), textAlign: TextAlign.center),
                                            margin: EdgeInsets.only(top: 10),
                                            padding: EdgeInsets.symmetric(horizontal: 30),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ),
    );
  }

  void calendarTapped(CalendarTapDetails calendarTapDetails) {
    if(calendarController.view == CalendarView.month && calendarTapDetails.targetElement == CalendarElement.calendarCell) {
      calendarController.view = CalendarView.day;
    }else if((calendarController.view == CalendarView.week || calendarController.view == CalendarView.workWeek) && calendarTapDetails.targetElement == CalendarElement.viewHeader) {
      calendarController.view = CalendarView.day;
    }
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments[index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments[index].to;
  }

  @override
  String getSubject(int index) {
    return appointments[index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments[index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments[index].allDay;
  }
}

class Meeting {
  Meeting(
      {this.eventName,
        this.from,
        this.to,
        this.background,
        this.allDay = false});

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool allDay;
}