import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import 'package:lsrtcc_flutter/model/band.dart';
import 'package:lsrtcc_flutter/model/event.dart';
import 'package:lsrtcc_flutter/model/pub.dart';
import 'package:lsrtcc_flutter/services/backend_api.dart';

class ApiData extends ChangeNotifier {
  // VALORES INICIAIS:
  final _userdata = GetStorage();

  void apiGetUserBands(int userId) async {
    var response = await Backend.getBandsByUser(userId);

    String userBandsResponseBody = response.body;
    // print('apiGetBandsByUser responseBody: $userBandsResponseBody');

    // var userBand_1_name = userBands[1].name;
    // var userBand_1_style = userBands[1].style;
    // print('apiGetBandsByUser userBand_1_name: $userBand_1_name');
    // print('apiGetBandsByUser userBand_1_style: $userBand_1_style');

    // && responseBody != '[]'
    if (response.statusCode == 200 && userBandsResponseBody != '[]') {
      _userdata.write('userBandsResponseBody', userBandsResponseBody);

      var userBands = bandFromJson(userBandsResponseBody);
      var userBandsCount = userBands.length;
      // print('apiGetBandsByUser userBandsCount: $userBandsCount');

      // var UserBandsCountInitial = _userdata.read('userBandsCount');
      // print('UserBandsCountInitial: $UserBandsCountInitial');

      _userdata.write('userBandsCount', userBandsCount);

      notifyListeners();
    } else {
      // _userdata.write('userBands', null);
      _userdata.write('userBandsCount', 0);
    }
    notifyListeners();
  }

  void apiGetUserPubs(int userId) async {
    var response = await Backend.getPubsByUser(userId);

    String userPubsResponseBody = response.body;
    // print('apiGetPubsByUser responseBody: $userPubsResponseBody');

    if (response.statusCode == 200 && userPubsResponseBody != '[]') {
      _userdata.write('userPubsResponseBody', userPubsResponseBody);

      var userPubs = pubFromJson(userPubsResponseBody);
      var userPubsCount = userPubs.length;
      // print('apiGetPubsByUser userPubsCount: $userPubsCount');

      _userdata.write('userPubsCount', userPubsCount);

      notifyListeners();
    } else {
      _userdata.write('userPubsCount', 0);
    }

    notifyListeners();
  }

  void apiGetUserEvents(int userId) async {
    print("userId: $userId");
    var response = await Backend.getEventsByUser(userId);

    String userEventsResponseBody = response.body;
    // print('apiGetEventsByUser responseBody: $userEventsResponseBody');

    if (response.statusCode == 200 && userEventsResponseBody != '[]') {
      _userdata.write('userEventsResponseBody', userEventsResponseBody);

      var userEvents = eventFromJson(userEventsResponseBody);
      var userEventsCount = userEvents.length;
      // print('apiGetEventsByUser userEventsCount: $userEventsCount');

      _userdata.write('userEventsCount', userEventsCount);

      notifyListeners();
    } else {
      _userdata.write('userEventsCount', 0);
    }

    notifyListeners();
  }

  void apiGetAllPubs() async {
    var response = await Backend.getAllPubs();

    String allPubsResponseBody = response.body;

    if (response.statusCode == 200 && allPubsResponseBody != '[]') {
      _userdata.write('allPubsResponseBody', allPubsResponseBody);

      var allPubs = pubFromJson(allPubsResponseBody);
      var allPubsCount = allPubs.length;

      _userdata.write('allPubsCount', allPubsCount);

      notifyListeners();
    } else {
      _userdata.write('allPubsCount', 0);
    }

    notifyListeners();
  }

  void apiGetAllBands() async {
    var response = await Backend.getAllBands();

    String allBandsResponseBody = response.body;

    if (response.statusCode == 200 && allBandsResponseBody != '[]') {
      _userdata.write('allBandsResponseBody', allBandsResponseBody);

      var allBands = bandFromJson(allBandsResponseBody);
      var allBandsCount = allBands.length;

      _userdata.write('allBandsCount', allBandsCount);

      notifyListeners();
    } else {
      _userdata.write('allBandsCount', 0);
    }

    notifyListeners();
  }

  void apiDeleteUserEvent(int showId) async {
    print("showId: $showId");

    var response = await Backend.deleteShow(showId);

    String responseBody = response.body;
    int responseCode = response.statusCode;

    print("responseBody: $responseBody");
    print("responseCode: $responseCode");

    notifyListeners();
  }

  void apiConfirmEvent(int showId) async {
    print("showId: $showId");

    var response = await Backend.deleteShow(showId);

    String responseBody = response.body;
    int responseCode = response.statusCode;

    print("responseBody: $responseBody");
    print("responseCode: $responseCode");

    notifyListeners();
  }
}
