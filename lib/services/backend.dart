import 'package:http/http.dart' as http;
import 'dart:convert';

class Backend {
  Backend(this.url);

  String url;

  static Future<http.Response> postUser(String jsonUser) {
    return http.post(
      'http://localhost:8080/users',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonUser,
    );
  }

// TODO:  se não usar, excluir esse método abaixo!
  // static Future<bool> validatePostUser(jsonUser) async {
  //   http.Response response = await postUser(jsonUser);

  //   if (response.statusCode == 201) {
  //     return true;
  //   } else {
  //     print(response.statusCode);
  //     return false;
  //   }
  // }

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
