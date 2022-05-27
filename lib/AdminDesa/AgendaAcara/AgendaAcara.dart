import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  List<String> agenda = ["agenda internal", "surat undangan"];
  final CalendarController calendarController = CalendarController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeEventColor();
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
              icon: Icon(Icons.settings),
              color: HexColor("#025393"),
              onPressed: (){
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              child: Text("Pengaturan Tampilan", style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: HexColor("#025393")
                              ), textAlign: TextAlign.center),
                              margin: EdgeInsets.only(top: 10),
                              alignment: Alignment.center,
                            ),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: Text("Simpan", style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w700,
                            color: HexColor("#025393")
                          )),
                          onPressed: (){},
                        ),
                        TextButton(
                          child: Text("Batal", style: TextStyle(
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
        body: FutureBuilder(
          future: getAgendaAcara(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if(snapshot.data != null) {
              return SafeArea(
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
                    dataSource: MeetingDataSource(snapshot.data),
                  )
                ),
              );
            }else{
              return Container(
                child: Center(
                  child: Text("Tidak ada Data")
                )
              );
            }
          },
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

  void initializeEventColor() {
    warna.add(const Color(0xFF0F8644));
    warna.add(const Color(0xFF8B1FA9));
    warna.add(const Color(0xFFD20100));
    warna.add(const Color(0xFFFC571D));
    warna.add(const Color(0xFF36B37B));
    warna.add(const Color(0xFF01A1EF));
    warna.add(const Color(0xFF3D4FB5));
    warna.add(const Color(0xFFE47C73));
    warna.add(const Color(0xFF636363));
    warna.add(const Color(0xFF0A8043));
  }

  Future<List<Meeting>> getAgendaAcara() async {
    var data = await http.get(Uri.parse("http://192.168.18.10:8000/api/agenda/1465/internal"));
    var jsonData = json.decode(data.body);
    final List<Meeting> agendaAcaraData = [];
    final Random random = new Random();
    for(var data in jsonData) {
      Meeting meeting = Meeting(
        eventName: data['perihal'],
        from: DateTime.parse("${data['tanggal_kegiatan_mulai']}T${data['waktu_kegiatan_mulai']}"),
        to: DateTime.parse("${data['tanggal_kegiatan_berakhir']}T${data['waktu_kegiatan_selesai']}"),
        background: warna[random.nextInt(9)],
        allDay: false
      );
      agendaAcaraData.add(meeting);
    }
    return agendaAcaraData;
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