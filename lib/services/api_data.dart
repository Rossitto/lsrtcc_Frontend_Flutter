import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import 'package:lsrtcc_flutter/model/band.dart';
import 'package:lsrtcc_flutter/services/backend_api.dart';

class ApiData extends ChangeNotifier {
  // VALORES INICIAIS:
  String _bandName_1 = 'BANDA HardCoded do User';
  String _pubName_1 = 'PUB HardCoded do User';
  final _userdata = GetStorage();

  String get bandName_1 => _bandName_1;

  void apiGetUserBands(int userId) async {
    var response = await Backend.getBandsByUser(userId);

    String userBandsResponseBody = response.body;
    print('apiGetBandsByUser responseBody: $userBandsResponseBody');

    // var userBand_1_name = userBands[1].name;
    // var userBand_1_style = userBands[1].style;
    // print('apiGetBandsByUser userBand_1_name: $userBand_1_name');
    // print('apiGetBandsByUser userBand_1_style: $userBand_1_style');

    // && responseBody != '[]'
    if (response.statusCode == 200 && userBandsResponseBody != '[]') {
      // String apiBandName_1 = jsonDecode(responseBody)[0]['name'] ?? "";
      // String apiBandName_1 = jsonDecode(responseBody).isEmpty     ? ''
      //     : jsonDecode(responseBody)[0]['name'];
      // _bandName_1 = apiBandName_1;
      // print('apiGetBandsByUser bandName_1: $_bandName_1');
      // _userdata.write('bandName_1', _bandName_1);

      // var userBands = bandFromJson(userBandsResponseBody);
      // print('apiGetBandsByUser userBands: $userBands');
      _userdata.write('userBandsResponseBody', userBandsResponseBody);

      var userBandsCount = userBandsResponseBody.length;
      // print('apiGetBandsByUser userBandsCount: $userBandsCount');
      _userdata.write('userBandsCount', userBandsCount);

      notifyListeners();
    }

    _bandName_1 = 'Nenhuma banda';

    // _userdata.write('userBands', null);
    _userdata.write('userBandsCount', 0);

    notifyListeners();
  }

  void apiGetUserPubs(int userId) async {
    var response = await Backend.getPubsByUser(userId);
    String responseBody = response.body;
    print('apiGetPubsByUser responseBody: $responseBody');

    // && responseBody != '[]'
    if (response.statusCode == 200 && responseBody != '[]') {
      String apiPubName_1 = jsonDecode(responseBody).isEmpty
          ? ''
          : jsonDecode(responseBody)[0]['name'];
      _pubName_1 = apiPubName_1;
      // String apiPubName_1 = jsonDecode(responseBody)[0]['name'] ?? "";
      print('apiGetPubsByUser pubName_1: $_pubName_1');
      _userdata.write('pubName_1', _pubName_1);
      notifyListeners();
    }
    _pubName_1 = 'Nenhum pub';
    notifyListeners();
  }
}
