import 'package:flutter/material.dart';
import 'package:lsrtcc_flutter/model/user.dart';

class Pub {
  final int _id;
  String _name;
  String _cnpj;
  String _phone;
  String _email;
  User _user;
  String _address;
  String _addressNum;
  String _addressCep;
  String _city;
  String _state;

  set name(name) => _name;
  set cnpj(cnpj) => _cnpj;
  set phone(phone) => _phone;
  set email(email) => _email;
  set user(user) => _user;
  set address(address) => _address;
  set addressNum(addressNum) => _addressNum;
  set addressCep(addressCep) => _addressCep;
  set city(city) => _city;
  set state(state) => _state;

  get id => _id;
  get name => _name;
  get cnpj => _cnpj;
  get phone => _phone;
  get email => _email;
  get user => _user;
  get address => _address;
  get addressNum => _addressNum;
  get addressCep => _addressCep;
  get city => _city;
  get state => _state;

  Pub(
      {id,
      @required name,
      @required email,
      @required phone,
      @required user,
      @required cnpj,
      address,
      addressNum,
      addressCep,
      city,
      state})
      : _id = id,
        _name = name,
        _email = email,
        _phone = phone,
        _user = user,
        _cnpj = cnpj,
        _address = address,
        _addressNum = addressNum,
        _addressCep = addressCep,
        _city = city,
        _state = state;

  Pub.fromJson(Map<String, dynamic> json)
      : _id = json['id'],
        _name = json['name'],
        _email = json['email'],
        _phone = json['phone'],
        _user = json['user'],
        _cnpj = json['cnpj'],
        _address = json['address'],
        _addressNum = json['address_num'],
        _addressCep = json['address_cep'],
        _city = json['city'],
        _state = json['state'];

  Map<String, dynamic> toJson() => {
        'id': _id,
        'name': _name,
        'email': _email,
        'phone': _phone,
        'user': _user,
        'cnpj': _cnpj,
        'address': _address,
        'address_num': _addressNum,
        'address_cep': _addressCep,
        'city': _city,
        'state': _state
      };
}
