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

class UserBandsPubs extends StatefulWidget {
  static const String id = 'user_bands_pubs';

  @override
  _UserBandsPubsState createState() => _UserBandsPubsState();
}

class _UserBandsPubsState extends State<UserBandsPubs>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  final titles = ["List 1", "List 2", "List 3"];
  final subtitles = [
    "Here is list 1 subtitle",
    "Here is list 2 subtitle",
    "Here is list 3 subtitle"
  ];
  final icons = [Icons.ac_unit, Icons.access_alarm, Icons.access_time];

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
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Minhas Bandas/Pubs',
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
      ),
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Container(
          padding: EdgeInsets.only(top: 20),
          child: ListView.builder(
              itemCount: titles.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    onTap: () {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text(titles[index] + ' pressed!'),
                      ));
                    },
                    title: Text(titles[index]),
                    subtitle: Text(subtitles[index]),
                    leading: CircleAvatar(
                      child: Image.asset('images/logo.png'),
                      //     Hero(
                      //   tag: 'logo',
                      //   child: Container(
                      //     child: Image.asset('images/logo.png'),
                      //     height: 100.0,
                      //   ),
                      // ),
                    ),
                    trailing: Icon(
                      icons[index],
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
