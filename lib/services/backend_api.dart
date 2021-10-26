import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:lsrtcc_flutter/constants.dart';

class Backend {
  // String url;
  // Backend(this.url);
  // String host = '192.168.1.75:8080';

  static Future<http.Response> postUser(String jsonUser) {
    return http.post(
      'http://${khost}/users',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonUser,
    );
  }

  static Future<http.Response> authUser(String jsonUser) {
    return http.post(
      'http://${khost}/users/auth',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonUser,
    );
  }

  static Future<http.Response> postBand(String jsonBand) {
    return http.post(
      'http://${khost}/bands',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        // 'Accept': 'application/json; charset=UTF-8'
      },
      body: jsonBand,
    );
  }

  static Future<http.Response> postPub(String jsonPub) {
    return http.post(
      'http://${khost}/pubs',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        // 'Accept': 'application/json; charset=UTF-8'
      },
      body: jsonPub,
    );
  }

  static Future<http.Response> postShow(var jsonShow) {
    return http.post(
      'http://${khost}/shows',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        // 'Accept': 'application/json; charset=UTF-8'
      },
      body: jsonShow,
    );
  }

  static Future<http.Response> putShow(String jsonShow, int id) {
    return http.post(
      'http://${khost}/shows/$id',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        // 'Accept': 'application/json; charset=UTF-8'
      },
      body: jsonShow,
    );
  }

  static Future<http.Response> deleteShow(int showId) {
    return http
        .delete('http://${khost}/shows/$showId', headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      // 'Accept': 'application/json; charset=UTF-8'
    });
  }

  static Future<http.Response> getBandsByUser(int userId) {
    var response = http.get(
      'http://${khost}/bands/user/$userId',
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
      'http://${khost}/pubs/user/$userId',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        // 'Accept': 'application/json; charset=UTF-8'
      },
    );
    // print('getBandsByUser response: $response');
    return response;
  }

  static Future<http.Response> getEventsByUser(int userId) {
    var response = http.get(
      'http://${khost}/shows/user/$userId',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        // 'Accept': 'application/json; charset=UTF-8'
      },
    );
    // print('getBandsByUser response: $response');
    return response;
  }

  static Future<http.Response> getAllPubs() {
    var response = http.get(
      'http://${khost}/pubs',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        // 'Accept': 'application/json; charset=UTF-8'
      },
    );
    // print('getBandsByUser response: $response');
    return response;
  }

  static Future<http.Response> getAllBands() {
    var response = http.get(
      'http://${khost}/bands',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        // 'Accept': 'application/json; charset=UTF-8'
      },
    );
    // print('getBandsByUser response: $response');
    return response;
  }
}
