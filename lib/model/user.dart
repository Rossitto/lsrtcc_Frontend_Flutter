import 'package:flutter/material.dart';

// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

List<User> userFromJson(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  User({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.password,
  });

  int id;
  String name;
  String email;
  String phone;
  String password;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"] == null ? null : json["phone"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone == null ? null : phone,
        "password": password,
      };
}


// class User {
//   final int _id;
//   String _name;
//   String _email;
//   String _phone;
//   String _password;

//   set name(name) => _name;
//   set email(email) => _email;
//   set phone(phone) => _phone;
//   set password(password) => _password;

//   get id => _id;
//   get name => _name;
//   get email => _email;
//   get phone => _phone;
//   get password => _password;

//   User(
//       {id,
//       @required name,
//       @required email,
//       @required phone,
//       @required password})
//       : _id = id,
//         _name = name,
//         _email = email,
//         _phone = phone,
//         _password = password;

//   // User();

// // Sem esses métodos, não é possível transformar um objeto dessa classe em um arquivo JSON! Não chamo eles exatamente, mas sem eles, jsonEncode() não roda: https://www.codegrepper.com/code-examples/dart/Converting+object+to+an+encodable+object+failed%3A+Instance+of+%27DioError%27
//   User.fromJson(Map<String, dynamic> json)
//       : _id = json['id'],
//         _name = json['name'],
//         _email = json['email'],
//         _phone = json['phone'],
//         _password = json['password'];

//   Map<String, dynamic> toJson() => {
//         'id': _id,
//         'name': _name,
//         'email': _email,
//         'phone': _phone,
//         'password': _password
//       };
// }


