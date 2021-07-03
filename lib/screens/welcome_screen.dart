import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lsrtcc_flutter/screens/calendar_screen.dart';
import 'package:lsrtcc_flutter/screens/profile_screen.dart';
import 'package:lsrtcc_flutter/screens/registerBand_screen.dart';
import 'package:lsrtcc_flutter/screens/registerPub_screen.dart';
import 'login_screen.dart';
import 'registration_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:lsrtcc_flutter/components/rounded_button.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;
  final userdata = GetStorage();

  @override
  void initState() {
    super.initState();

    userdata.erase();

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
          backgroundColor: animation.value,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.067),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  flex: 2,
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
                        text: ['show biz'],
                        textStyle: TextStyle(
                          fontSize: 35.0,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 30.0,
                      ),
                      RoundedButton(
                          color: Colors.lightBlueAccent,
                          text: 'Entrar',
                          onPressed: () {
                            Navigator.pushNamed(context, LoginScreen.id);
                          }),
                      SizedBox(
                        height: 10.0,
                      ),
                      RoundedButton(
                          color: Colors.blueGrey[400],
                          text: 'Cadastrar',
                          onPressed: () {
                            Navigator.pushNamed(context, RegistrationScreen.id);
                          }),
                      SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
