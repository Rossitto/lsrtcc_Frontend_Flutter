import 'package:flutter/material.dart';
import 'package:lsrtcc_flutter/components/DateTimePicker.dart';
import 'package:lsrtcc_flutter/screens/calendar_screen.dart';
import 'package:lsrtcc_flutter/screens/profile_screen.dart';
import 'package:lsrtcc_flutter/screens/registerBand_screen.dart';
import 'package:lsrtcc_flutter/screens/registerPub_screen.dart';
import 'login_screen.dart';
import 'registration_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:lsrtcc_flutter/components/rounded_button.dart';

class AllRegistrationsScreen extends StatefulWidget {
  static const String id = 'all_registrations_screen';

  @override
  _AllRegistrationsScreenState createState() => _AllRegistrationsScreenState();
}

class _AllRegistrationsScreenState extends State<AllRegistrationsScreen>
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
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Cadastro',
              style: TextStyle(color: Colors.white70),
            ),
            elevation: 0,
            backgroundColor: Colors.blueAccent[700],
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            // actions: <Widget>[
            //   PopupMenuButton(
            //     itemBuilder: (BuildContext bc) => [
            //       PopupMenuItem(child: Text("Sair"), value: WelcomeScreen.id),
            //       PopupMenuItem(
            //           child: Text("Cadastrar Pub/Banda"),
            //           value: AllRegistrationsScreen.id),
            //     ],
            //     onSelected: (route) {
            //       print(route);
            //       Navigator.pushNamed(context, route);
            //     },
            //     child: Icon(
            //       Icons.more_vert,
            //       color: Colors.white,
            //     ),
            //   ),
            // ],
          ),
          backgroundColor: animation.value,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
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
                      Text(
                        'Show Biz',
                        style: TextStyle(
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
                    color: Colors.blueAccent,
                    text: 'Cadastrar Banda',
                    onPressed: () {
                      Navigator.pushNamed(context, RegisterBandScreen.id);
                    }),
                RoundedButton(
                    color: Colors.blueAccent,
                    text: 'Cadastrar Pub',
                    onPressed: () {
                      Navigator.pushNamed(context, RegisterPubScreen.id);
                    }),
                SizedBox(
                  height: 48.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
