import 'package:flutter/material.dart';
import 'package:lsrtcc_flutter/screens/calendar_screen.dart';
import 'package:lsrtcc_flutter/screens/profile_screen.dart';
import 'package:lsrtcc_flutter/screens/registerBand_screen.dart';
import 'package:lsrtcc_flutter/screens/registerPub_screen.dart';
import 'login_screen.dart';
import 'registration_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:lsrtcc_flutter/components/rounded_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller);

    controller.forward();

    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // TODO: make this not overflow screen
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Hero(
                    tag: 'logo',
                    child: Container(
                      child: Image.asset('images/logo.png'),
                      height: 100.0,
                    ),
                  ),
                  SizedBox(width: 8.0),
                  TypewriterAnimatedTextKit(
                    text: ['LSR_TCC'],
                    textStyle: TextStyle(
                      fontSize: 35.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 38.0,
            ),
            RoundedButton(
                color: Colors.lightBlueAccent,
                text: 'Log in',
                onPressed: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                }),
            RoundedButton(
                color: Colors.lightBlueAccent,
                text: 'Cadastrar Usuário',
                onPressed: () {
                  Navigator.pushNamed(context, RegistrationScreen.id);
                }),
            RoundedButton(
                color: Colors.lightBlueAccent,
                text: 'Cadastrar Banda',
                onPressed: () {
                  Navigator.pushNamed(context, RegisterBandScreen.id);
                }),
            RoundedButton(
                color: Colors.lightBlueAccent,
                text: 'Cadastrar Pub',
                onPressed: () {
                  Navigator.pushNamed(context, RegisterPubScreen.id);
                }),
            RoundedButton(
              color: Colors.lightBlueAccent,
              text: 'Agenda',
              onPressed: () {
                Navigator.pushNamed(context, CalendarScreen.id);
              },
            ),
            RoundedButton(
              color: Colors.lightBlueAccent,
              text: 'Perfil',
              onPressed: () {
                Navigator.pushNamed(context, ProfileScreen.id);
              },
            ),
            SizedBox(
              height: 48.0,
            ),
          ],
        ),
      ),
    );
  }
}
