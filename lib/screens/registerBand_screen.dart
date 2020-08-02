import 'dart:convert';
import 'package:lsrtcc_flutter/constants.dart';
import 'package:flutter/material.dart';
import 'package:lsrtcc_flutter/components/rounded_button.dart';
import 'package:lsrtcc_flutter/model/band.dart';
import 'package:lsrtcc_flutter/services/backend.dart';
import 'package:emojis/emojis.dart'; // to use Emoji collection

class RegisterBandScreen extends StatefulWidget {
  static const String id = 'registerBand_screen';

  @override
  _RegisterBandScreenState createState() => _RegisterBandScreenState();
}

class _RegisterBandScreenState extends State<RegisterBandScreen> {
  bool _showPassword = false;
  var sadEmoji = Emojis.cryingFace;

  // tudo String senão não rola fazer o trim(). Converter após o trim().
  String name;
  String email;
  String phone;
  String password;
  String cnpj;
  String feeBrl;
  String membersNum;
  String style;

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
                  labelText: 'Nome da banda',
                  prefixIcon: Icon(
                    Icons.library_music,
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
                  labelText: 'Email da banda (não use pessoal)',
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
                  labelText: 'CNPJ (se tiver)',
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
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  if (value.isNotEmpty && isNumeric(value)) {
                    feeBrl = value.trim();
                  }
                  // print(feeBrl.runtimeType);
                },
                decoration: kTextFieldDecoration.copyWith(
                  labelText: 'Cachê R\$',
                  prefixIcon: Icon(
                    Icons.attach_money,
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
                    membersNum = value.trim();
                  }
                },
                decoration: kTextFieldDecoration.copyWith(
                  labelText: 'Número de membros',
                  prefixIcon: Icon(
                    Icons.people,
                    color: Colors.blueGrey,
                  ),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                onChanged: (value) {
                  style = value.trim();
                },
                decoration: kTextFieldDecoration.copyWith(
                  labelText: 'Estilo musical que melhor define',
                  prefixIcon: Icon(
                    Icons.queue_music,
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
                text: 'Cadastrar Banda',
                onPressed: () async {
                  // print(
                  // "Name: $name. Email: $email. Phone: $phone. Pwd: $password. CNPJ: $cnpj. Cachê: $feeBrl. Membros: $membersNum. Estilo: $style.");
                  Band currentBand = Band(
                    id: null,
                    name: name,
                    email: email,
                    phone: phone,
                    password: password,
                    cnpj: cnpj,
                    feeBrl: feeBrl,
                    membersNum: membersNum,
                    style: style,
                  );
                  print(currentBand);
                  String jsonBand = jsonEncode(currentBand);
                  var response = await Backend.postBand(jsonBand);
                  String responseBody = response.body;
                  var responseTitle = jsonDecode(responseBody)['title'];
                  if (response.statusCode == 201) {
                    print('Banda cadastrada! ' +
                        'Status Code: ${response.statusCode}');
                  } else {
                    print('ERRO! ' + 'Status Code: ${response.statusCode}');
                    // print(response.body);
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
            ],
          ),
        ),
      ),
    );
  }
}
