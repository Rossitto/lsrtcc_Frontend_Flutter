import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:lsrtcc_flutter/constants.dart';
import 'package:lsrtcc_flutter/components/rounded_button.dart';
import 'package:lsrtcc_flutter/services/backend.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CalendarScreen extends StatefulWidget {
  static const String id = 'calendar_screen';

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AGENDA'),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          TableCalendar(
            calendarController: _calendarController,
            initialCalendarFormat: CalendarFormat.month,
            headerStyle: HeaderStyle(
              centerHeaderTitle: true,
              formatButtonShowsNext: false,
            ),
            startingDayOfWeek: StartingDayOfWeek.monday,
            onDaySelected: (date, events) {
              print(date.toLocal().toIso8601String());
            },
            builders: CalendarBuilders(),
          )
        ],
      )),
    );
  }
}
