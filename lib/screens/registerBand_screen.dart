import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:lsrtcc_flutter/constants.dart';
import 'package:flutter/material.dart';
import 'package:lsrtcc_flutter/components/rounded_button.dart';
import 'package:lsrtcc_flutter/model/band.dart';
import 'package:lsrtcc_flutter/model/user.dart';
import 'package:lsrtcc_flutter/screens/profile_screen.dart';
import 'package:lsrtcc_flutter/services/backend_api.dart';

class RegisterBandScreen extends StatefulWidget {
  static const String id = 'registerBand_screen';

  @override
  _RegisterBandScreenState createState() => _RegisterBandScreenState();
}

class _RegisterBandScreenState extends State<RegisterBandScreen> {
  bool _showPassword = false;

  // tudo String senão não rola fazer o trim(). Converter após o trim().
  String name;
  String email;
  String phone;
  String cnpj;
  String feeBrl;
  String membersNum;
  String style;

  final userdata = GetStorage();

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> userMap = userdata.read('currentUser');
    User currentUser = User.fromJson(userMap);
    print(currentUser);

    // String currentUserString = userdata.read('currentUser');
    // Map<String, dynamic> userMap = jsonDecode(currentUserString);
    // User currentUser = User.fromJson(userMap);

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
                  labelText: 'Estilo musical',
                  prefixIcon: Icon(
                    Icons.queue_music,
                    color: Colors.blueGrey,
                  ),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              // TextField(
              //   obscureText: !this._showPassword,
              //   keyboardType:
              //       TextInputType.visiblePassword, // maybe this is unnecessary
              //   onChanged: (value) {
              //     password = value.trim();
              //   },
              //   decoration: kTextFieldDecoration.copyWith(
              //       labelText: 'Senha',
              //       prefixIcon: Icon(
              //         Icons.security,
              //         color: Colors.blueGrey,
              //       ),
              //       suffixIcon: IconButton(
              //         icon: Icon(
              //           Icons.remove_red_eye,
              //           color: this._showPassword
              //               ? Colors.blueAccent
              //               : Colors.grey,
              //         ),
              //         onPressed: () {
              //           setState(
              //               () => this._showPassword = !this._showPassword);
              //         },
              //       )),
              // ),
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
                    // password: password,
                    cnpj: cnpj,
                    feeBrl: feeBrl,
                    membersNum: membersNum,
                    style: style,
                    user: [currentUser],
                  );
                  print(currentBand);
                  String jsonBand = jsonEncode(currentBand);

                  // ? TESTANDO...
                  print(jsonBand);

                  var response = await Backend.postBand(jsonBand);
                  String responseBody = response.body;
                  var responseTitle = jsonDecode(responseBody)['title'] ?? "";
                  if (response.statusCode == 201) {
                    print('Banda cadastrada! ' +
                        'Status Code: ${response.statusCode}');

                    userdata.writeInMemory('msg_register_band',
                        'Banda Cadastrada com Sucesso! $happyEmoji');
                    Navigator.pushNamed(context, ProfileScreen.id);
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
