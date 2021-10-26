import 'package:flutter/material.dart';
import 'package:lsrtcc_flutter/screens/date_time_picker.dart';
import 'package:lsrtcc_flutter/components/rounded_button.dart';

import '../constants.dart';

class MyEventsEmpty extends StatefulWidget {
  static const String id = 'my_events_empty';

  @override
  _MyEventsEmptyState createState() => _MyEventsEmptyState();
}

class _MyEventsEmptyState extends State<MyEventsEmpty>
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
              'Meus Eventos',
              style: TextStyle(color: Colors.white70),
            ),
            elevation: 5.0,
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
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.067),
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
                  height: screenHeight * 0.05,
                ),
                Text(
                  'Você não tem nenhum Evento ainda... $sadEmoji',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                // RoundedButton(
                //     color: Colors.blueAccent,
                //     text: 'Cadastrar Banda',
                //     onPressed: () {
                //       Navigator.pushNamed(context, RegisterBandScreen.id);
                //     }),
                RoundedButton(
                    color: Colors.blueAccent,
                    text: 'Cadastrar Evento (TEST)',
                    onPressed: () {
                      Navigator.pushNamed(context, DateTimePicker.id);
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
