import 'package:emojis/emojis.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);

const kTextFieldDecoration = InputDecoration(
  labelStyle: TextStyle(color: Colors.grey),
  labelText: 'Email',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

RegExp numeric = RegExp(r'^-?[0-9]+$');

// check if the string contains only numbers
bool isNumeric(String str) {
  return numeric.hasMatch(str);
}

const sadEmoji = Emojis.cryingFace;

const happyEmoji = Emojis.grinningFaceWithBigEyes;

// addStringToSP(String varName, String varValue) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   prefs.setString('$varName', "$varValue");
// }

String nowFormatted = DateFormat("yyyy-MM-ddTHH:mm").format(DateTime.now());

String formatTimestamp(DateTime timestamp) =>
    DateFormat("yyyy-MM-ddTHH:mm").format(timestamp);

final String khost = '192.168.1.75:8080';
// final String host = 'localhost:8080';

