import 'package:lsrtcc_flutter/constants.dart';
import 'package:flutter/material.dart';
import 'package:lsrtcc_flutter/components/rounded_button.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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
                name = value;
              },
              decoration: kTextFieldDecoration.copyWith(
                hintText: 'Nome completo',
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email = value;
                },
                decoration: kTextFieldDecoration),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              keyboardType: TextInputType.phone,
              onChanged: (value) {
                phone = value;
              },
              decoration: kTextFieldDecoration.copyWith(
                hintText: '(xx) xxxxx-xxxx',
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              keyboardType: TextInputType.visiblePassword,
              onChanged: (value) {
                password = value;
              },
              decoration: kTextFieldDecoration.copyWith(
                hintText: 'Senha',
              ),
            ),
            SizedBox(
              height: 24.0,
            ),
            RoundedButton(
              color: Colors.blueAccent,
              text: 'Cadastrar',
              // TODO: implementar POST method!
              onPressed: () {
                print(
                    "Name: $name. Email: $email. Phone: $phone. Pwd: $password.");
                // TODO: create a user with this information
                // String json = jsonEncode(user);
              },
            ),
          ],
        ),
      ),
    );
  }
}
