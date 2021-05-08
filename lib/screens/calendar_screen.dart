import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:lsrtcc_flutter/constants.dart';
import 'package:lsrtcc_flutter/components/rounded_button.dart';
import 'package:lsrtcc_flutter/model/showSchedule.dart';
import 'package:lsrtcc_flutter/services/backend_api.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:date_time_format/date_time_format.dart';

class CalendarScreen extends StatefulWidget {
  static const String id = 'calendar_screen';

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  Map<DateTime, List<dynamic>> _events;
  CalendarController _calendarController;
  TextEditingController _eventController;
  List<dynamic> _selectedEvents;
  TimeOfDay time;
  var selectedDate;

  @override
  void initState() {
    super.initState();
    time = TimeOfDay.now();
    _calendarController = CalendarController();
    _eventController = TextEditingController();
    _events = {};
    _selectedEvents = [];
    // initPrefs();
  }

  // initPrefs() async {
  //   prefs = await SharedPreferences.getInstance();
  //   setState(
  //     () {
  //       _events = Map<DateTime, List<dynamic>>.from(
  //         decodeMap(
  //           json.decode(prefs.getString("events") ?? "{}"),
  //         ),
  //       );
  //     },
  //   );
  // }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  Map<String, dynamic> encodeMap(Map<DateTime, dynamic> map) {
    Map<String, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[key.toString()] = map[key];
    });
    return newMap;
  }

  Map<DateTime, dynamic> decodeMap(Map<String, dynamic> map) {
    Map<DateTime, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[DateTime.parse(key)] = map[key];
    });
    return newMap;
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
              events: _events,
              calendarController: _calendarController,
              initialCalendarFormat: CalendarFormat.month,
              headerStyle: HeaderStyle(
                centerHeaderTitle: true,
                formatButtonShowsNext: false,
              ),
              startingDayOfWeek: StartingDayOfWeek.monday,
              // ? comentei isso abaixo após trocar o Locale, antes estava usando Intl
              // onDaySelected: (date, events) {
              //   selectedDate = DateFormat.yMd("pt_BR").format(date.toLocal());
              //   print(selectedDate);
              //   setState(() {
              //     _selectedEvents = events;
              //   });
              // },
              builders: CalendarBuilders(),
            ),
            ..._selectedEvents.map(
              (event) => ListTile(
                title: Text(event),
                // TODO: implementar mostrar hora do evento
                // trailing: TimeOfDay.fromDateTime(event.dateTime),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),

          // TODO: Fazer isso funcionar! usar apenas um campo DateTime ou 2 campos com Date e com Time???
          onPressed: () async {
            await _pickTime();
            print('time = $time');
            DateTime now = DateTime.now();
            var timeDateTime =
                DateTime(now.year, now.month, now.day, time.hour, time.minute);
            var timeFormated = DateTimeFormat.format(timeDateTime,
                format: DateTimeFormats.iso8601);

            // prefs.setString("events", json.encode(encodeMap(_events)));

            print('timeFormated = $timeFormated');
            ShowSchedule showSchedule = ShowSchedule(
                pubId: 3, bandId: 3, date: selectedDate, time: timeFormated);
            // await postShowToAPI(showSchedule);

            // showDialog(
            //   context: context,
            //   builder: (context) => AlertDialog(
            //     content: TextField(
            //       controller: _eventController,
            //     ),
            //     actions: <Widget>[
            //       TextButton(
            //         child: Text("Salvar"),
            //         onPressed: () async {
            //           if (_eventController.text.isEmpty) return;

            //           // setState(() {
            //           //   if (_events[_calendarController.selectedDay] != null) {
            //           //     _events[_calendarController.selectedDay]
            //           //         .add(_eventController.text);
            //           //   } else {
            //           //     _events[_calendarController.selectedDay] = [
            //           //       _eventController.text
            //           //     ];
            //           //   }
            //           //   prefs.setString(
            //           //       "events", json.encode(encodeMap(_events)));
            //           //   _eventController.clear();
            //           //   Navigator.pop(context);
            //           // });
            //         },
            //       )
            //     ],
            //   ),
            // );
          }),
    );
  }

  // ListTile showTime = ListTile(
  //     title: Text("Time: ${time.hour}:${time.minute}"),
  //     trailing: Icon(Icons.keyboard_arrow_down),
  //     onTap: null);

  _pickTime() async {
    TimeOfDay t = await showTimePicker(
        context: context,
        initialTime: time,
        helpText: "Hora do evento",
        builder: (BuildContext context, Widget child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child,
          );
        });

    if (t != null) {
      setState(() {
        time = t;
      });
    }
  }

  postShowToAPI(ShowSchedule showSchedule) async {
    print(showSchedule);
    String jsonShow = showSchedule.toJson();
    // String jsonShow = jsonEncode(showSchedule);
    var response = await Backend.postShow(jsonShow);
    String responseBody = response.body;
    var responseTitle = jsonDecode(responseBody)['title'] ?? "";
    if (response.statusCode == 201) {
      print('Show agendado! ' + 'Status Code: ${response.statusCode}');
    } else {
      print('ERRO! ' + 'Status Code: ${response.statusCode}');
      // print(response.body);
      print(responseTitle);
      setState(() {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('Ops... Algo deu errado. $sadEmoji'),
            content:
                Text('$responseTitle\n\nStatusCode: ${response.statusCode}'),
            elevation: 24.0,
          ),
          barrierDismissible: true,
        );
      });
    }
  }
}



// _showAddDialog() async {
//   await showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//             backgroundColor: Colors.white70,
//             title: Text("Add Events"),
//             content: TextField(
//               controller: _eventController,
//             ),
//             actions: <Widget>[
//               FlatButton(
//                 child: Text(
//                   "Save",
//                   style:
//                       TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
//                 ),
//                 onPressed: () {
//                   if (_eventController.text.isEmpty) return;
//                   setState(() {
//                     if (_events[_controller.selectedDay] != null) {
//                       _events[_controller.selectedDay]
//                           .add(_eventController.text);
//                     } else {
//                       _events[_controller.selectedDay] = [
//                         _eventController.text
//                       ];
//                     }
//                     _eventController.clear();
//                     Navigator.pop(context);
//                   });
//                 },
//               )
//             ],
//           ));
// }
