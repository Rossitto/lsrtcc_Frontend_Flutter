import 'dart:convert';
import 'package:emojis/emojis.dart';
import 'package:get/get_connect/http/src/certificates/certificates.dart';
import 'package:get_storage/get_storage.dart';
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

  final userdata = GetStorage();

  @override
  void initState() {
    var msg_login = userdata.read('msg_login');
    if (msg_login != null) {
      Future(
        () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(msg_login),
              duration: Duration(seconds: 2),
            ),
          );
        },
      );
    }
    userdata.remove('msg_login');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: screenHeight,
          maxWidth: screenWidth,
        ),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: ListView(
              shrinkWrap: true,
              reverse: true,
              padding: EdgeInsets.symmetric(horizontal: 24.0),
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
                        color: this._showPassword
                            ? Colors.blueAccent
                            : Colors.grey,
                      ),
                      onPressed: () {
                        setState(
                            () => this._showPassword = !this._showPassword);
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 24.0,
                ),
                RoundedButton(
                  text: 'Log In',
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
                      String userName = jsonDecode(responseBody)['name'] ?? "";
                      String userEmail =
                          jsonDecode(responseBody)['email'] ?? "";
                      String userPhone =
                          jsonDecode(responseBody)['phone'] ?? "";
                      int userId = jsonDecode(responseBody)['id'] ?? "";
                      userdata.write('userIsLogged', true);
                      userdata.write('userName', userName);
                      userdata.write('userEmail', userEmail);
                      userdata.write('userPhone', userPhone);
                      userdata.write('userId', userId);

                      Map<String, dynamic> userMap = jsonDecode(responseBody);
                      User currentUser = User.fromJson(userMap);
                      userdata.write('currentUser', currentUser);

                      Navigator.pushNamed(context, ProfileScreen.id);
                      // SharedPreferences prefs =
                      //     await SharedPreferences.getInstance();
                      // prefs.setString('userLoggedInResponseBody', responseBody);
                      // prefs.setString('userLoggedInName', userName);
                      // prefs.setString('userLoggedInEmail', userEmail);
                      // prefs.setString('userLoggedInPhone', userPhone);
                      // prefs.setInt('userLoggedInId', userId);

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
                ),
                SizedBox(
                  height: 24.0,
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
              ].reversed.toList(),
            ),
          ),
        ),
      ),
    );
  }
}
