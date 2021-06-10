import 'package:http/http.dart' as http;
import 'dart:convert';

class Backend {
  // String url;
  // Backend(this.url);
  String host = '192.168.1.75';

  static Future<http.Response> postUser(String jsonUser) {
    return http.post(
      'http://localhost:8080/users',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonUser,
    );
  }

  static Future<http.Response> authUser(String jsonUser) {
    return http.post(
      'http://localhost:8080/users/auth',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonUser,
    );
  }

  static Future<http.Response> postBand(String jsonBand) {
    return http.post(
      'http://localhost:8080/bands',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        // 'Accept': 'application/json; charset=UTF-8'
      },
      body: jsonBand,
    );
  }

  static Future<http.Response> postPub(String jsonPub) {
    return http.post(
      'http://localhost:8080/pubs',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        // 'Accept': 'application/json; charset=UTF-8'
      },
      body: jsonPub,
    );
  }

  static Future<http.Response> postShow(var jsonShow) {
    return http.post(
      'http://localhost:8080/shows',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        // 'Accept': 'application/json; charset=UTF-8'
      },
      body: jsonShow,
    );
  }

  static Future<http.Response> putShow(String jsonShow, int id) {
    return http.post(
      'http://localhost:8080/shows/$id',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        // 'Accept': 'application/json; charset=UTF-8'
      },
      body: jsonShow,
    );
  }

  static Future<http.Response> getBandsByUser(int userId) {
    var response = http.get(
      'http://localhost:8080/bands/user/$userId',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        // 'Accept': 'application/json; charset=UTF-8'
      },
    );
    // print('getBandsByUser response: $response');
    return response;
  }

  static Future<http.Response> getPubsByUser(int userId) {
    var response = http.get(
      'http://localhost:8080/pubs/user/$userId',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        // 'Accept': 'application/json; charset=UTF-8'
      },
    );
    // print('getBandsByUser response: $response');
    return response;
  }
}
