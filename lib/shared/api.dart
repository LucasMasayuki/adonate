import 'package:http/http.dart' as http;

import 'urls.dart';
import 'package:adonate/shared/sharedPreferencesHelper.dart';

class Api {
  static Future<http.Response> getRequest(keyUrl, {params}) async {
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
      Uri.parse(url),
      headers: {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json; charset=utf-8'
      },
    );
    return response;
  }

  static Future<http.Response> postRequest(keyUrl, {data}) async {
    String url = Urls.getUrl(keyUrl);
    String? token = await SharedPreferencesHelper.get('token');
    var response;

    if (token == null) {
      response = await http.post(
        Uri.parse(url),
        body: data,
        headers: {
          'Content-Type': 'application/json',
        },
      );
      print(response);
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

  static Future<http.Response> deleteRequest(keyUrl, {data}) async {
    String url = Urls.getUrl(keyUrl);
    String token = await SharedPreferencesHelper.get('token');

    var response = await http.delete(
      Uri.parse(url),
      headers: {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json'
      },
    );
    return response;
  }

  static Future<http.Response> putRequest(keyUrl, {data}) async {
    String url = Urls.getUrl(keyUrl);
    String token = await SharedPreferencesHelper.get('token');

    var response = await http.put(
      Uri.parse(url),
      body: data,
      headers: {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json'
      },
    );
    return response;
  }
}
