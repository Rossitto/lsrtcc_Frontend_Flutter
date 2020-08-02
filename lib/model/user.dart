import 'package:flutter/material.dart';

class User {
  final int _id;
  String _name;
  String _email;
  String _phone;
  String _password;

  set name(name) => _name;
  set email(email) => _email;
  set phone(phone) => _phone;
  set password(password) => _password;

  get id => _id;
  get name => _name;
  get email => _email;
  get phone => _phone;
  get password => _password;

  User(
      {id,
      @required name,
      @required email,
      @required phone,
      @required password})
      : _id = id,
        _name = name,
        _email = email,
        _phone = phone,
        _password = password;

  // User();

// TODO conferir futuramente se precisa desses 2 métodos sobre json:
  User.fromJson(Map<String, dynamic> json)
      : _id = json['id'],
        _name = json['name'],
        _email = json['email'],
        _phone = json['phone'],
        _password = json['password'];

  Map<String, dynamic> toJson() => {
        'id': _id,
        'name': _name,
        'email': _email,
        'phone': _phone,
        'password': _password
      };
}
