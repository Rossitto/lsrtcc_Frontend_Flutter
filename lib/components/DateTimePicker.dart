import 'dart:convert';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:intl/intl.dart';
import 'package:lsrtcc_flutter/components/rounded_button.dart';
import 'package:lsrtcc_flutter/constants.dart';
import 'package:lsrtcc_flutter/model/showSchedule.dart';
import 'package:lsrtcc_flutter/screens/profile_screen.dart';
import 'package:lsrtcc_flutter/services/backend_api.dart';

class DateTimePicker extends StatefulWidget {
  static const String id = 'dateTimePicker_screen';

  @override
  _DateTimePickerState createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  double _height;
  double _width;

  String _setTime, _setDate;

  String _hour, _minute, _time;

  String dateTime;

  DateTime selectedDate = DateTime.now();

  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);

  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  TextEditingController _dateISOController = TextEditingController();
  // TextEditingController _timeISOController = TextEditingController();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      initialDatePickerMode: DatePickerMode.day,
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
      locale: Locale("pt"),
      // builder: (BuildContext context, Widget child) {
      //   return MediaQuery(
      //     data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
      //     child: child,
      //   );
      // },
    );
    if (picked != null)
      setState(() {
        selectedDate = picked; // 2021-05-20 00:00:00.000
        // print('selectedDate sem format: $selectedDate');
        var selectedDateFormatada =
            formatDate(selectedDate, [dd, '/', mm, '/', yyyy]);
        _dateController.text = selectedDateFormatada;
        print('_dateController.text: ${_dateController.text}');

        var selectedDateISO =
            formatDate(selectedDate, [yyyy, '-', mm, '-', dd]);
        _dateISOController.text = selectedDateISO;
        print('_dateISOController.text: ${_dateISOController.text}');
      });
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        helpText: "Hora do evento",
        builder: (BuildContext context, Widget child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child,
          );
        });
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour + ' : ' + _minute;
        _timeController.text = _time;
        _timeController.text = formatDate(
            DateTime(2020, 08, 1, selectedTime.hour, selectedTime.minute),
            [HH, ':', nn]).toString();
        print('_timeController.text: ${_timeController.text}');
      });
  }

  @override
  void initState() {
    var dataFormatada = formatDate(DateTime.now(), [dd, '/', mm, '/', yyyy]);
    // print('dataFormatada = $dataFormatada');
    _dateController.text = dataFormatada;

    var horaFormatada = formatDate(
        DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
        [HH, ':', nn]).toString();
    _timeController.text = horaFormatada;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    dateTime = DateFormat.yMd().format(DateTime.now());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Agendar Evento'),
      ),
      body: Container(
        width: _width,
        height: _height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  'Data do Evento',
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5),
                ),
                InkWell(
                  onTap: () {
                    _selectDate(context);
                  },
                  child: Container(
                    width: _width / 1.7,
                    height: _height / 9,
                    margin: EdgeInsets.only(top: 30),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: Colors.grey[200]),
                    child: TextFormField(
                      style: TextStyle(fontSize: 40),
                      textAlign: TextAlign.center,
                      enabled: false,
                      keyboardType: TextInputType.text,
                      controller: _dateController,
                      onSaved: (String val) {
                        _setDate = val;
                      },
                      decoration: InputDecoration(
                          disabledBorder:
                              UnderlineInputBorder(borderSide: BorderSide.none),
                          // labelText: 'Time',
                          contentPadding: EdgeInsets.only(top: 0.0)),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Text(
                  'Hora do Evento',
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5),
                ),
                InkWell(
                  onTap: () {
                    _selectTime(context);
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 30),
                    width: _width / 1.7,
                    height: _height / 9,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: Colors.grey[200]),
                    child: TextFormField(
                      style: TextStyle(fontSize: 40),
                      textAlign: TextAlign.center,
                      onSaved: (String val) {
                        _setTime = val;
                      },
                      enabled: false,
                      keyboardType: TextInputType.text,
                      controller: _timeController,
                      decoration: InputDecoration(
                          disabledBorder:
                              UnderlineInputBorder(borderSide: BorderSide.none),
                          // labelText: 'Time',
                          contentPadding: EdgeInsets.all(5)),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5.0,
            ),
            RoundedButton(
              color: Colors.blueAccent,
              text: 'SALVAR',
              onPressed: () async {
                print('_dateController.text: ${_dateController.text}');
                print('_timeController.text: ${_timeController.text}');

                var showTimestamp = DateTime.parse(
                    "${_dateISOController.text} ${_timeController.text}");
                print('showTimestamp = $showTimestamp');
                // TODO : pegar o Pub ID certo ao postar ShowSchedule
                // TODO : pegar o Band ID certo ao postar ShowSchedule
                ShowSchedule currentShow = ShowSchedule(
                  pubId: 2,
                  bandId: 2,
                  show_datetime: showTimestamp,
                );

                String jsonShow = jsonEncode(currentShow);
                print('jsonShow = $jsonShow');
                // TODO: se show já existir = PUT em vez de POST e enviar o ID do show na URL.
                var response = await Backend.postShow(jsonShow);
                String responseBody = response.body;
                print('responseBody = $responseBody');
                // var responseTitle = jsonDecode(responseBody)['title'] ?? "";
                var responseTitle = '';
                if (response.statusCode == 201) {
                  print('Evento agendado com sucesso! ' +
                      'Status Code: ${response.statusCode}');
                  //   String userName = jsonDecode(responseBody)['name'] ?? "";
                  //   String userEmail = jsonDecode(responseBody)['email'] ?? "";
                  //   String userPhone = jsonDecode(responseBody)['phone'] ?? "";
                  //   int userId = jsonDecode(responseBody)['id'] ?? "";
                  //   userdata.write('userIsLogged', true);
                  //   userdata.write('userName', userName);
                  //   userdata.write('userEmail', userEmail);
                  //   userdata.write('userPhone', userPhone);
                  //   userdata.write('userId', userId);
                  Navigator.pushNamed(context, ProfileScreen.id);
                } else {
                  print('ERRO! ' + 'Status Code: ${response.statusCode}');
                  print(responseTitle);
                  setState(
                    () {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text('Ops... Algo deu errado. $sadEmoji'),
                          content: Text(
                              '$responseTitle\n\nStatusCode: ${response.statusCode}'),
                          elevation: 24.0,
                        ),
                        barrierDismissible: true,
                      );
                    },
                  );
                }
                ;
              },
            ),
          ],
        ),
      ),
    );
  }
}
