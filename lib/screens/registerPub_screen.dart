import 'dart:convert';
import 'package:lsrtcc_flutter/constants.dart';
import 'package:flutter/material.dart';
import 'package:lsrtcc_flutter/components/rounded_button.dart';
import 'package:lsrtcc_flutter/model/pub.dart';
import 'package:lsrtcc_flutter/services/backend_api.dart';
import 'package:emojis/emojis.dart'; // to use Emoji collection

class RegisterPubScreen extends StatefulWidget {
  static const String id = 'registerPub_screen';

  @override
  _RegisterPubScreenState createState() => _RegisterPubScreenState();
}

class _RegisterPubScreenState extends State<RegisterPubScreen> {
  bool _showPassword = false;
  var sadEmoji = Emojis.cryingFace;

  // tudo String senão não rola fazer o trim().
  String name;
  String email;
  String phone;
  String password;
  String cnpj;
  String address;
  String addressNum;
  String addressCep;
  String city;
  String state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.fromLTRB(24, 80, 24, 24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: 'logo',
                child: Container(
                  height: 150.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                onChanged: (value) {
                  name = value.trim();
                },
                decoration: kTextFieldDecoration.copyWith(
                  labelText: 'Nome do Pub',
                  prefixIcon: Icon(
                    Icons.store_mall_directory,
                    color: Colors.blueGrey,
                  ),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email = value.trim();
                },
                decoration: kTextFieldDecoration.copyWith(
                  labelText: 'Email (não use pessoal)',
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.blueGrey,
                  ),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                keyboardType: TextInputType.phone,
                onChanged: (value) {
                  if (value.isNotEmpty && isNumeric(value)) {
                    phone = value.trim();
                  }
                },
                decoration: kTextFieldDecoration.copyWith(
                  labelText: 'Celular do principal contato',
                  prefixIcon: Icon(
                    Icons.phone,
                    color: Colors.blueGrey,
                  ),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  if (value.isNotEmpty && isNumeric(value)) {
                    cnpj = value.trim();
                  }
                },
                decoration: kTextFieldDecoration.copyWith(
                  labelText: 'CNPJ',
                  prefixIcon: Icon(
                    Icons.business_center,
                    color: Colors.blueGrey,
                  ),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                onChanged: (value) {
                  city = value.trim();
                },
                decoration: kTextFieldDecoration.copyWith(
                  labelText: 'Cidade',
                  prefixIcon: Icon(
                    Icons.location_city,
                    color: Colors.blueGrey,
                  ),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                onChanged: (value) {
                  state = value.trim();
                },
                decoration: kTextFieldDecoration.copyWith(
                  labelText: 'Estado (2 letras)',
                  prefixIcon: Icon(
                    Icons.location_city,
                    color: Colors.blueGrey,
                  ),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  if (value.isNotEmpty && isNumeric(value)) {
                    addressCep = value.trim();
                  }
                },
                decoration: kTextFieldDecoration.copyWith(
                  labelText: 'CEP',
                  prefixIcon: Icon(
                    Icons.markunread_mailbox,
                    color: Colors.blueGrey,
                  ),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                onChanged: (value) {
                  address = value.trim();
                },
                decoration: kTextFieldDecoration.copyWith(
                  labelText: 'Endereço',
                  prefixIcon: Icon(
                    Icons.markunread_mailbox,
                    color: Colors.blueGrey,
                  ),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  if (value.isNotEmpty && isNumeric(value)) {
                    addressNum = value.trim();
                  }
                },
                decoration: kTextFieldDecoration.copyWith(
                  labelText: 'nº',
                  prefixIcon: Icon(
                    Icons.markunread_mailbox,
                    color: Colors.blueGrey,
                  ),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: !this._showPassword,
                keyboardType:
                    TextInputType.visiblePassword, // maybe this is unnecessary
                onChanged: (value) {
                  password = value.trim();
                },
                decoration: kTextFieldDecoration.copyWith(
                    labelText: 'Senha',
                    prefixIcon: Icon(
                      Icons.security,
                      color: Colors.blueGrey,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.remove_red_eye,
                        color: this._showPassword
                            ? Colors.blueAccent
                            : Colors.grey,
                      ),
                      onPressed: () {
                        setState(
                            () => this._showPassword = !this._showPassword);
                      },
                    )),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                color: Colors.blueAccent,
                text: 'Cadastrar Pub',
                onPressed: () async {
                  Pub currentPub = Pub(
                    id: null,
                    name: name,
                    email: email,
                    phone: phone,
                    password: password,
                    cnpj: cnpj,
                    addressCep: addressCep,
                    address: address,
                    addressNum: addressNum,
                    city: city,
                    state: state,
                  );
                  String jsonPub = jsonEncode(currentPub);
                  var response = await Backend.postPub(jsonPub);
                  String responseBody = response.body;
                  var responseTitle = jsonDecode(responseBody)['title'] ?? "";
                  if (response.statusCode == 201) {
                    print('Pub cadastrado! ' +
                        'Status Code: ${response.statusCode}');
                  } else {
                    print('ERRO! ' + 'Status Code: ${response.statusCode}');
                    print(responseTitle);
                    setState(() {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text('Ops... Algo deu errado. $sadEmoji'),
                          content: Text(
                              '$responseTitle\n\nStatusCode: ${response.statusCode}'),
                          elevation: 24.0,
                        ),
                        barrierDismissible: true,
                      );
                    });
                  }
                },
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "voltar",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
