import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:lsrtcc_flutter/constants.dart';
import 'package:flutter/material.dart';
import 'package:lsrtcc_flutter/components/rounded_button.dart';
import 'package:lsrtcc_flutter/model/band.dart';
import 'package:lsrtcc_flutter/screens/all_registrations_screen.dart';
import 'package:lsrtcc_flutter/screens/welcome_screen.dart';
import 'package:lsrtcc_flutter/services/backend_api.dart';
import 'package:provider/provider.dart';
import 'package:lsrtcc_flutter/services/api_data.dart';

class AnythingListView extends StatelessWidget {
  AnythingListView(
      {@required this.titles,
      this.subtitles,
      this.icons,
      @required this.onTapTile});

  final List titles;
  final List subtitles;
  final List icons;
  final Function onTapTile;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: ListView.builder(
        itemCount: titles.length,
        itemBuilder: (context, index) {
          return Card(
              child: ListTile(
                  onTap: onTapTile,
                  // () {
                  //   Scaffold.of(context).showSnackBar(SnackBar(
                  //     content: Text(titles[index] + ' pressed!'),
                  //   ));
                  // },
                  title: Text(titles[index]),
                  subtitle: Text(subtitles[index]),
                  leading: CircleAvatar(
                    child: Image.asset('images/logo.png'),
                  ),
                  trailing: Icon(icons[index])));
        },
      ),
    );
  }
}
