import 'dart:convert';
import 'package:emojis/emojis.dart';
import 'package:lsrtcc_flutter/constants.dart';
import 'package:flutter/material.dart';
import 'package:lsrtcc_flutter/components/rounded_button.dart';
import 'package:lsrtcc_flutter/model/user.dart';
import 'package:lsrtcc_flutter/screens/profile_screen.dart';
import 'package:lsrtcc_flutter/services/backend_api.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _showPassword = false;
  var sadEmoji = Emojis.cryingFace;
  String email;
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
                height: 200.0,
                child: Image.asset('images/logo.png'),
              ),
            ),
            SizedBox(
              height: 48.0,
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
                    color: this._showPassword ? Colors.blueAccent : Colors.grey,
                  ),
                  onPressed: () {
                    setState(() => this._showPassword = !this._showPassword);
                  },
                ),
              ),
            ),
            SizedBox(
              height: 24.0,
            ),
            RoundedButton(
              color: Colors.lightBlueAccent,
              onPressed: () async {
                User currentUser = User(
                    id: null,
                    name: null,
                    email: email,
                    phone: null,
                    password: password);
                String jsonUser = jsonEncode(currentUser);
                var response = await Backend.authUser(jsonUser);
                String responseBody = response.body;
                var responseTitle = jsonDecode(responseBody)['title'] ?? "";
                if (response.statusCode == 202) {
                  print('Login efetuado com sucesso! ' +
                      'Status Code: ${response.statusCode}');
                  Navigator.pushNamed(context, ProfileScreen.id);
                } else {
                  print('ERRO! ' + 'Status Code: ${response.statusCode}');
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
              text: 'Log In',
            ),
            SizedBox(
              height: 24.0,
            ),
            FlatButton(
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
    );
  }
}
