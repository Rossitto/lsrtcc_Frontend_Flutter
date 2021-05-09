import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:intl/intl.dart';
import 'package:lsrtcc_flutter/components/rounded_button.dart';

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
        selectedDate = picked;
        // print('selectedDate sem format: $selectedDate');
        var selectedDateFormatada =
            formatDate(selectedDate, [dd, '/', mm, '/', yyyy]);
        _dateController.text = selectedDateFormatada;
        print('_dateController.text: ${_dateController.text}');
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
              onPressed: () {
                print('_dateController.text: ${_dateController.text}');
                print('_timeController.text: ${_timeController.text}');
              },
              // onPressed: () async {
              //   Pub currentPub = Pub(
              //     id: null,
              //     name: name,
              //     email: email,
              //     phone: phone,
              //     password: password,
              //     cnpj: cnpj,
              //     addressCep: addressCep,
              //     address: address,
              //     addressNum: addressNum,
              //     city: city,
              //     state: state,
              //   );
              //   String jsonPub = jsonEncode(currentPub);
              //   var response = await Backend.postPub(jsonPub);
              //   String responseBody = response.body;
              //   var responseTitle = jsonDecode(responseBody)['title'] ?? "";
              //   if (response.statusCode == 201) {
              //     print('Pub cadastrado! ' +
              //         'Status Code: ${response.statusCode}');
              //   } else {
              //     print('ERRO! ' + 'Status Code: ${response.statusCode}');
              //     print(responseTitle);
              //     setState(() {
              //       showDialog(
              //         context: context,
              //         builder: (_) => AlertDialog(
              //           title: Text('Ops... Algo deu errado. $sadEmoji'),
              //           content: Text(
              //               '$responseTitle\n\nStatusCode: ${response.statusCode}'),
              //           elevation: 24.0,
              //         ),
              //         barrierDismissible: true,
              //       );
              //     },);
              //   }
              // },
            ),
          ],
        ),
      ),
    );
  }
}
