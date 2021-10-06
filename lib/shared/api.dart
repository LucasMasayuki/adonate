import 'package:http/http.dart';

import 'urls.dart';
import 'package:http/http.dart' as http;
import 'package:adonate/shared/sharedPreferencesHelper.dart';

class Api {
  static Future<Response> getRequest(keyUrl, {params}) async {
    String url = Urls.getUrl(keyUrl);
    String? token = await SharedPreferencesHelper.get('token');
    var response;

    if (token == null) {
      response = await http.get(
        Uri.http(url, ''),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
        },
      );
      return response;
    }

    if (params != null) {
      response = await http.get(
        Urls.getUri(keyUrl, params),
        headers: {
          'Authorization': 'Token $token',
          'Content-Type': 'application/json; charset=utf-8'
        },
      );
      return response;
    }

    response = await http.get(
      Uri.http(url, ''),
      headers: {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json; charset=utf-8'
      },
    );
    return response;
  }

  static Future<Response> postRequest(keyUrl, {data}) async {
    String url = Urls.getUrl(keyUrl);
    String? token = await SharedPreferencesHelper.get('token');
    var response;

    if (token == null) {
      response = await http.post(
        Uri.http(url, ''),
        body: data,
        headers: {
          'Content-Type': 'application/json',
        },
      );
      return response;
    }

    response = await http.post(
      Uri.http(url, ''),
      body: data,
      headers: {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json'
      },
    );
    return response;
  }

  static Future<Response> deleteRequest(keyUrl, {data}) async {
    String url = Urls.getUrl(keyUrl);
    String token = await SharedPreferencesHelper.get('token');

    var response = await http.delete(
      Uri.http(url, ''),
      headers: {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json'
      },
    );
    return response;
  }

  static Future<Response> putRequest(keyUrl, {data}) async {
    String url = Urls.getUrl(keyUrl);
    String token = await SharedPreferencesHelper.get('token');

    var response = await http.put(
      Uri.http(url, ''),
      body: data,
      headers: {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json'
      },
    );
    return response;
  }
}
