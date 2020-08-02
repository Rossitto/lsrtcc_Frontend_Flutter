import 'package:flutter/material.dart';

class Band {
  final int _id;
  String _name;
  String _cnpj;
  double _feeBrl;
  int _membersNum;
  String _style;
  String _phone;
  String _email;
  String _password;

  set name(name) => _name;
  set cnpj(cnpj) => _cnpj;
  set feeBrl(feeBrl) => _feeBrl;
  set membersNum(membersNum) => _membersNum;
  set style(style) => _style;
  set phone(phone) => _phone;
  set email(email) => _email;
  set password(password) => _password;

  get id => _id;
  get name => _name;
  get cnpj => _cnpj;
  get feeBrl => _feeBrl;
  get membersNum => _membersNum;
  get style => _style;
  get phone => _phone;
  get email => _email;
  get password => _password;

  Band(
      {id,
      @required name,
      @required email,
      @required phone,
      @required password,
      cnpj,
      feeBrl,
      membersNum,
      style})
      : _id = id,
        _name = name,
        _email = email,
        _phone = phone,
        _password = password,
        _cnpj = cnpj,
        _feeBrl = feeBrl,
        _membersNum = membersNum,
        _style = style;
}
