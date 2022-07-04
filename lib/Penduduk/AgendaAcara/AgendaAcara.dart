import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:surat/LoginAndRegistration/LoginPage.dart';
import 'package:calendar_view/calendar_view.dart';


class agendaAcaraKrama extends StatefulWidget {
  static var selectedView = "Bulan";
  const agendaAcaraKrama({Key key}) : super(key: key);

  @override
  State<agendaAcaraKrama> createState() => _agendaAcaraKramaState();
}

class _agendaAcaraKramaState extends State<agendaAcaraKrama> {
  List view = ['Hari', 'Minggu', 'Bulan'];
  EventController eventController;
  var apiURLGetAgenda = "https://siradaskripsi.my.id/api/agenda/${loginPage.desaId}/krama";

  Future getAgenda() async {
    var data = await http.get(Uri.parse(apiURLGetAgenda));
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
          eventController.add(event);
        }
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    eventController = EventController();
    getAgenda();
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
          title: Text("Agenda Acara", style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.bold,
            color: Colors.white
          )),
        ),
        body: Column(
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
                          value: agendaAcaraKrama.selectedView,
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
                              agendaAcaraKrama.selectedView = value;
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
                child: CalendarControllerProvider(
                  controller: eventController,
                  child: agendaAcaraKrama.selectedView == "Bulan" ? MonthView(
                    minMonth: DateTime(1900),
                    maxMonth: DateTime(2100),
                    initialMonth: DateTime.now(),
                    cellAspectRatio: 1,
                    startDay: WeekDays.sunday,
                  ) : agendaAcaraKrama.selectedView == "Hari" ? DayView(
                    showVerticalLine: true,
                    showLiveTimeLineInAllDays: true,
                    minDay: DateTime(1900),
                    maxDay: DateTime(2100),
                    initialDay: DateTime.now(),
                    heightPerMinute: 1,
                    eventArranger: SideEventArranger(),
                  ) : agendaAcaraKrama.selectedView == "Minggu" ? WeekView(
                    showLiveTimeLineInAllDays: true,
                    width: 400,
                    minDay: DateTime(1900),
                    maxDay: DateTime(2100),
                    initialDay: DateTime.now(),
                    heightPerMinute: 1,
                    eventArranger: SideEventArranger(),
                    startDay: WeekDays.sunday,
                  ) : Container(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}