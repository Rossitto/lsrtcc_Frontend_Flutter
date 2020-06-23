import 'package:flutter/material.dart';

class User {
  int _id;
  String _name;
  String _email;
  String _phone;
  String _password;

  // User(
  //     {id = this._id,
  //     name = this._name,
  //     @required email = this._email,
  //     phone = this._phone,
  //     password = this._password});

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

  User.fromJson(Map<String, dynamic> json)
      : _name = json['name'],
        _email = json['email'];

  Map<String, dynamic> toJson() => {
        'name': _name,
        'email': _email,
      };
}
