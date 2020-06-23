import 'package:flutter/material.dart';

class User {
  int _id;
  String _name;
  String _email;
  String _phone;
  String _password;

  User(
      this._id, this._name, @required this._email, this._phone, this._password);

  void setName(name) {
    this._name = name;
  }

  void setEmail(email) {
    this._email = email;
  }

  void setPhone(phone) {
    this._phone = phone;
  }

  void setPassword(password) {
    this._password = password;
  }

  String getName() {
    return _name;
  }

  String getEmail() {
    return _email;
  }

  String getPhone() {
    return _phone;
  }

  String getPassword() {
    return _password;
  }
}
