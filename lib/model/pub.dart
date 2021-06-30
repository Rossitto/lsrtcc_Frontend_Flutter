import 'package:flutter/material.dart';
import 'package:lsrtcc_flutter/model/user.dart';

// To parse this JSON data, do
//
//     final pub = pubFromJson(jsonString);

import 'dart:convert';

List<Pub> pubFromJson(String str) =>
    List<Pub>.from(json.decode(str).map((x) => Pub.fromJson(x)));

String pubToJson(List<Pub> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Pub {
  Pub({
    this.id,
    this.user,
    this.name,
    this.cnpj,
    this.address,
    this.addressNum,
    this.addressCep,
    this.city,
    this.state,
    this.phone,
    this.email,
  });

  int id;
  User user;
  String name;
  String cnpj;
  String address;
  int addressNum;
  int addressCep;
  String city;
  String state;
  String phone;
  String email;

  factory Pub.fromJson(Map<String, dynamic> json) => Pub(
        id: json["id"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        name: json["name"],
        cnpj: json["cnpj"],
        address: json["address"],
        addressNum: json["address_num"],
        addressCep: json["address_cep"],
        city: json["city"],
        state: json["state"],
        phone: json["phone"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user == null ? null : user.toJson(),
        "name": name,
        "cnpj": cnpj,
        "address": address,
        "address_num": addressNum,
        "address_cep": addressCep,
        "city": city,
        "state": state,
        "phone": phone,
        "email": email,
      };
}

// class Pub {
//   final int _id;
//   String _name;
//   String _cnpj;
//   String _phone;
//   String _email;
//   User _user;
//   String _address;
//   String _addressNum;
//   String _addressCep;
//   String _city;
//   String _state;

//   set name(name) => _name;
//   set cnpj(cnpj) => _cnpj;
//   set phone(phone) => _phone;
//   set email(email) => _email;
//   set user(user) => _user;
//   set address(address) => _address;
//   set addressNum(addressNum) => _addressNum;
//   set addressCep(addressCep) => _addressCep;
//   set city(city) => _city;
//   set state(state) => _state;

//   get id => _id;
//   get name => _name;
//   get cnpj => _cnpj;
//   get phone => _phone;
//   get email => _email;
//   get user => _user;
//   get address => _address;
//   get addressNum => _addressNum;
//   get addressCep => _addressCep;
//   get city => _city;
//   get state => _state;

//   Pub(
//       {id,
//       @required name,
//       @required email,
//       @required phone,
//       @required user,
//       @required cnpj,
//       address,
//       addressNum,
//       addressCep,
//       city,
//       state})
//       : _id = id,
//         _name = name,
//         _email = email,
//         _phone = phone,
//         _user = user,
//         _cnpj = cnpj,
//         _address = address,
//         _addressNum = addressNum,
//         _addressCep = addressCep,
//         _city = city,
//         _state = state;

//   Pub.fromJson(Map<String, dynamic> json)
//       : _id = json['id'],
//         _name = json['name'],
//         _email = json['email'],
//         _phone = json['phone'],
//         _user = json['user'],
//         _cnpj = json['cnpj'],
//         _address = json['address'],
//         _addressNum = json['address_num'],
//         _addressCep = json['address_cep'],
//         _city = json['city'],
//         _state = json['state'];

//   Map<String, dynamic> toJson() => {
//         'id': _id,
//         'name': _name,
//         'email': _email,
//         'phone': _phone,
//         'user': _user,
//         'cnpj': _cnpj,
//         'address': _address,
//         'address_num': _addressNum,
//         'address_cep': _addressCep,
//         'city': _city,
//         'state': _state
//       };
// }
