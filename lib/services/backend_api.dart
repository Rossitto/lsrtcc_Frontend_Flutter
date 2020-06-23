import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.url);

  String url;

// TODO: post User method
  Future<bool> postData() async {
    http.Response response = await http.post(url);

// TODO: conferir status de sucesso do post method
// TODO: retorna true e false mesmo???
    if (response.statusCode == 201) {
      return true;
    } else {
      print(response.statusCode);
      return false;
    }
  }

// TODO: get method
  Future getData() async {
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      String data = response.body;

      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}
