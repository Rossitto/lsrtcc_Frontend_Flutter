import 'dart:convert';
import 'package:lsrtcc_flutter/constants.dart';
import 'package:flutter/material.dart';
import 'package:lsrtcc_flutter/components/rounded_button.dart';
import 'package:lsrtcc_flutter/model/user.dart';
import 'package:lsrtcc_flutter/services/backend.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool _showPassword = false;

  String name;
  String email;
  String phone;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
              tag: 'logo',
              child: Container(
                height: 100.0,
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
                labelText: 'Nome completo',
                prefixIcon: Icon(
                  Icons.person,
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
                phone = value.trim();
              },
              decoration: kTextFieldDecoration.copyWith(
                labelText: 'Celular',
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
              obscureText: !this._showPassword,
              keyboardType: TextInputType.visiblePassword,
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
                      color:
                          this._showPassword ? Colors.blueAccent : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() => this._showPassword = !this._showPassword);
                    },
                  )),
            ),
            SizedBox(
              height: 24.0,
            ),
            RoundedButton(
              color: Colors.blueAccent,
              text: 'Cadastrar',
              onPressed: () {
                print(
                    "Name: $name. Email: $email. Phone: $phone. Pwd: $password.");
                User currentUser = User(
                    id: null,
                    name: name,
                    email: email,
                    phone: phone,
                    password: password);
                print(currentUser.name);
                String jsonUser = jsonEncode(currentUser);
                // var json = currentUser.toJson();
                print(jsonUser);
                Backend.postUser(jsonUser);
              },
            ),
          ],
        ),
      ),
    );
  }
}
