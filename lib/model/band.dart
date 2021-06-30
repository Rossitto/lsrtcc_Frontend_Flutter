import 'package:flutter/material.dart';
import 'package:lsrtcc_flutter/model/user.dart';

import 'dart:convert';

// To parse this JSON data, do
//
//     final band = bandFromJson(jsonString);

List<Band> bandFromJson(String str) =>
    List<Band>.from(json.decode(str).map((x) => Band.fromJson(x)));

String bandToJson(List<Band> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Band {
  Band({
    this.id,
    this.user,
    this.name,
    this.cnpj,
    this.feeBrl,
    this.membersNum,
    this.style,
    this.phone,
    this.email,
  });

  int id;
  List<User> user;
  String name;
  String cnpj;
  double feeBrl;
  int membersNum;
  String style;
  String phone;
  String email;

  factory Band.fromJson(Map<String, dynamic> json) => Band(
        id: json["id"],
        user: List<User>.from(json["user"].map((x) => User.fromJson(x))),
        name: json["name"],
        cnpj: json["cnpj"] == null ? null : json["cnpj"],
        feeBrl: json["fee_brl"],
        membersNum: json["members_num"],
        style: json["style"],
        phone: json["phone"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": List<dynamic>.from(user.map((x) => x.toJson())),
        "name": name,
        "cnpj": cnpj == null ? null : cnpj,
        "fee_brl": feeBrl,
        "members_num": membersNum,
        "style": style,
        "phone": phone,
        "email": email,
      };
}



//   set name(name) => _name;
// set cnpj(cnpj) => _cnpj;
// set feeBrl(feeBrl) => _feeBrl;
// set membersNum(membersNum) => _membersNum;
// set style(style) => _style;
// set phone(phone) => _phone;
// set email(email) => _email;
// set user(user) => _user;

// get id => _id;
// get name => _name;
// get cnpj => _cnpj;
// get feeBrl => _feeBrl;
// get membersNum => _membersNum;
// get style => _style;
// get phone => _phone;
// get email => _email;
// get user => _user;
