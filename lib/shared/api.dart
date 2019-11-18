import 'urls.dart';
import 'package:http/http.dart' as http;
import 'package:adonate/shared/sharedPreferencesHelper.dart';

class Api {
  static getRequest(keyUrl, { params }) async {
    String url = Urls.getUrl(keyUrl);
    String token = await SharedPreferencesHelper.get('token');
    var response;

    if (token == null) {
      if (params != null) {
        url = '$url $params';
      }

      response = await http.get(url);
      return response;
    }

    response = await http.get(url, headers: { 'Authorization': 'Token $token' },);  // sample info available in response
    return response;
  }

  static postRequest(keyUrl, { data }) async {
    String url = Urls.getUrl(keyUrl);
    String token = await SharedPreferencesHelper.get('token');
    var response;

    if (token == null) {
      response = await http.post(url, body: data);
      return response;
    }

    response = await http.post(url, body: data, headers: { 'Authorization': 'Token $token' },);
    return response;
  }

  static deleteRequest(keyUrl, json) async {
    String url = Urls.getUrl(keyUrl);
    String token = await SharedPreferencesHelper.get('token');

    var response = await http.delete(url, headers: { 'Authorization': 'Token $token' },);
    return response;
  }

  static putRequest(keyUrl) async {
    String url = Urls.getUrl(keyUrl);
    String token = await SharedPreferencesHelper.get('token');

    var response = await http.put(url, headers: { 'Authorization': 'Token $token' },);
    return response;
  }
}