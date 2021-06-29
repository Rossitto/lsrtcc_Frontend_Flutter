import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lsrtcc_flutter/model/band.dart';
import 'package:lsrtcc_flutter/services/backend_api.dart';

class ApiData extends ChangeNotifier {
  // VALORES INICIAIS:
  String _bandName_1 = 'BANDA HardCoded do User';
  String _pubName_1 = 'PUB HardCoded do User';
  final _userdata = GetStorage();

  // MÉTODOS EFETIVAMENTE UTILIZADOS PRA PEGAR E SETAR OS VALORES DAS VARIÁVEIS USADAS PELO APP:
  String get bandName_1 => _bandName_1;

  void apiGetUserBands(int userId) async {
    print('valor inicial _bandName_1 = $_bandName_1');

    print('getUserBands userId = $userId');
    var response = await Backend.getBandsByUser(userId);
    String responseBody = response.body;
    print('apiGetBandsByUser responseBody: $responseBody');

    // && responseBody != '[]'
    if (response.statusCode == 200) {
      // String apiBandName_1 = jsonDecode(responseBody)[0]['name'] ?? "";
      String apiBandName_1 = jsonDecode(responseBody).isEmpty
          ? ''
          : jsonDecode(responseBody)[0]['name'];
      _bandName_1 = apiBandName_1;
      print('apiGetBandsByUser bandName_1: $_bandName_1');
      _userdata.write('bandName_1', _bandName_1);
      notifyListeners();
    }
    _bandName_1 = 'Nenhuma banda';
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
