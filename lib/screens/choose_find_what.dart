import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lsrtcc_flutter/components/rounded_button.dart';
import 'package:lsrtcc_flutter/constants.dart';
import 'package:lsrtcc_flutter/screens/find_band.dart';
import 'package:lsrtcc_flutter/screens/find_pub.dart';

class ChooseFindWhat extends StatefulWidget {
  static const String id = 'choose_find_what';

  @override
  _ChooseFindWhatState createState() => _ChooseFindWhatState();
}

class _ChooseFindWhatState extends State<ChooseFindWhat>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;
  final userdata = GetStorage();

  @override
  void initState() {
    super.initState();

    userdata.remove('selectedPubJson');
    userdata.remove('selectedBandJson');
    userdata.remove('selectedPubName');
    userdata.remove('selectedBandName');

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
              '  Agendar um Show $fireEmoji',
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
                  height: screenHeight * 0.15,
                ),
                Text(
                  'Que parceiro você precisa encontrar ?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: screenHeight * 0.017,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.05,
                ),
                RoundedButton(
                    color: Colors.blueAccent,
                    text: 'Encontrar um Pub',
                    onPressed: () {
                      Navigator.pushNamed(context, FindPub.id);
                    }),
                RoundedButton(
                    color: Colors.blueAccent,
                    text: 'Encontrar uma Banda',
                    onPressed: () {
                      Navigator.pushNamed(context, FindBand.id);
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
