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
              onPressed: (){},
            )
          ],
        ),
        body: SafeArea(
          child: SfCalendar(
            showWeekNumber: true,
            view: CalendarView.week,
            allowedViews: const[
              CalendarView.day,
              CalendarView.week,
              CalendarView.month,
              CalendarView.timelineDay,
              CalendarView.timelineMonth,
              CalendarView.timelineWeek
            ]
          )
        ),
      ),
    );
  }
}

