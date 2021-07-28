import 'dart:convert';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:lsrtcc_flutter/components/rounded_button.dart';
import 'package:lsrtcc_flutter/constants.dart';
import 'package:lsrtcc_flutter/model/band.dart';
import 'package:lsrtcc_flutter/model/event.dart';
import 'package:lsrtcc_flutter/model/pub.dart';
import 'package:lsrtcc_flutter/screens/my_events.dart';
import 'package:lsrtcc_flutter/screens/profile_screen.dart';
import 'package:lsrtcc_flutter/services/backend_api.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

class DateTimePicker extends StatefulWidget {
  static const String id = 'dateTimePicker_screen';

  @override
  _DateTimePickerState createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  double _height;
  double _width;
  final userdata = GetStorage();
  var selectedBandName;
  var selectedPubName;
  var selectedBandJson;
  var selectedPubJson;

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

    var selectedDateISO = formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd]);
    _dateISOController.text = selectedDateISO;

    var horaFormatada = formatDate(
        DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
        [HH, ':', nn]).toString();
    _timeController.text = horaFormatada;
    super.initState();

    selectedBandName = userdata.read('selectedBandName') ?? '';
    selectedPubName = userdata.read('selectedPubName') ?? '';
    selectedBandJson = userdata.read('selectedBandJson') ?? '';
    selectedPubJson = userdata.read('selectedPubJson') ?? '';
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    dateTime = DateFormat.yMd().format(DateTime.now());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // title: Text('Agendar Evento', ),
        title: Text(
          'Agendar Evento $fireEmoji',
          style: GoogleFonts.lato(
            textStyle: TextStyle(
              color: Colors.white,
              letterSpacing: .5,
              fontSize: 26,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.normal,
            ),
          ),
        ),
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
                SizedBox(
                  height: _height * 0.1,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Center(
                          child: Text(
                            '$singerEmoji $selectedBandName',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                color: Colors.grey[850],
                                letterSpacing: .5,
                                fontSize: 25,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            '$beerMugEmoji $selectedPubName',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                color: Colors.grey[850],
                                letterSpacing: .5,
                                fontSize: 25,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]),
                SizedBox(
                  height: _height * 0.1,
                ),
                Text(
                  'Data do Evento $calendarEmoji',
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      color: Colors.blue,
                      letterSpacing: .5,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                  // TextStyle(
                  //   fontStyle: FontStyle.italic,
                  //   fontWeight: FontWeight.w600,
                  //   letterSpacing: 0.5,
                  // ),
                ),
                InkWell(
                  onTap: () {
                    _selectDate(context);
                  },
                  child: Container(
                    width: _width / 1.5,
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
                  'Hora do Evento $glowingStarEmoji',
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      color: Colors.blue,
                      letterSpacing: .5,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
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
                print('_dateISOController.text: ${_dateISOController.text}');
                print('_timeController.text: ${_timeController.text}');

                var showTimestamp = DateTime.parse(
                    "${_dateISOController.text} ${_timeController.text}");
                print('showTimestamp = $showTimestamp');
                print('DateTime.now() = ${DateTime.now()}');

                var showTimestampFormatted = formatTimestamp(showTimestamp);
                print('showTimestampFormatted = $showTimestampFormatted');

                print('selectedPubJson: $selectedPubJson');
                print('selectedBandJson: $selectedBandJson');

                Pub currentPub = Pub.fromJson(selectedPubJson);
                print('currentPub: $currentPub');

                Band currentBand = Band.fromJson(selectedBandJson);
                print('currentBand: $currentBand');

                Event currentShow = Event(
                  id: null,
                  pub: currentPub,
                  band: currentBand,
                  showDatetime: showTimestamp, //showTimestampFormatted,
                  confirmed: false,
                  confirmedAt: null,
                  requestedAt: DateTime.now(), // nowFormatted,
                );

                print('currentShow = $currentShow');
                String jsonShow = jsonEncode(currentShow);
                print('jsonShow = $jsonShow');

                // TODO: se show já existir = PUT em vez de POST e enviar o ID do show na URL.

                var response = await Backend.postShow(jsonShow);
                String responseBody = response.body;
                print('responseBody = $responseBody');
                print('responseStatusCode = ${response.statusCode}');

                if (response.statusCode == 201) {
                  print('Evento pré-agendado com sucesso! ' +
                      'Status Code: ${response.statusCode}');
                  // String showId = jsonDecode(responseBody)['id'] ?? "";

                  setState(
                    () {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text('OK! $happyEmoji'),
                          content: Text('Evento pré-agendado com sucesso!'),
                          elevation: 24.0,
                        ),
                        barrierDismissible: true,
                      );
                    },
                  );

                  userdata.writeInMemory('msg_register_event',
                      'Evento Pré-Agendado com Sucesso! $happyEmoji');
                  Navigator.pushNamed(context, MyEvents.id);
                } else {
                  var responseTitle = responseBody.isEmpty
                      ? 'Erro'
                      : jsonDecode(responseBody)['title'];
                  print('ERRO! ' + 'Status Code: ${response.statusCode}');
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
              },
            ),
          ],
        ),
      ),
    );
  }
}
