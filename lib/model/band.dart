import 'package:flutter/material.dart';
import 'package:lsrtcc_flutter/model/user.dart';

class Band {
  final int _id;
  String _name;
  String _cnpj;
  String _feeBrl;
  String _membersNum;
  String _style;
  String _phone;
  String _email;
  List<User> _user;

  set name(name) => _name;
  set cnpj(cnpj) => _cnpj;
  set feeBrl(feeBrl) => _feeBrl;
  set membersNum(membersNum) => _membersNum;
  set style(style) => _style;
  set phone(phone) => _phone;
  set email(email) => _email;
  set user(user) => _user;

  get id => _id;
  get name => _name;
  get cnpj => _cnpj;
  get feeBrl => _feeBrl;
  get membersNum => _membersNum;
  get style => _style;
  get phone => _phone;
  get email => _email;
  get user => _user;

  Band(
      {id,
      @required name,
      @required email,
      @required phone,
      @required user,
      cnpj,
      feeBrl,
      membersNum,
      style})
      : _id = id,
        _name = name,
        _email = email,
        _phone = phone,
        _user = user,
        _cnpj = cnpj,
        _feeBrl = feeBrl,
        _membersNum = membersNum,
        _style = style;

  Band.fromJson(Map<String, dynamic> json)
      : _id = json['id'],
        _name = json['name'],
        _email = json['email'],
        _phone = json['phone'],
        _user = json['user'],
        _cnpj = json['cnpj'],
        _feeBrl = json['fee_brl'],
        _membersNum = json['members_num'],
        _style = json['style'];

  Map<String, dynamic> toJson() => {
        'id': _id,
        'name': _name,
        'email': _email,
        'phone': _phone,
        'user': _user,
        'cnpj': _cnpj,
        'fee_brl': _feeBrl,
        'members_num': _membersNum,
        'style': _style
      };
}
