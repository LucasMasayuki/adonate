import 'urls.dart';
import 'package:http/http.dart' as http;

class Api {
  static getRequest(keyUrl) async {
    String url = Urls.getUrl(keyUrl);
    var response = await http.get(url);  // sample info available in response
    return response;
  }

  static postRequest(keyUrl, { data = null }) async {
    String url = Urls.getUrl(keyUrl);

    var response = await http.post(url, body: data);
    return response;
  }

  static deleteRequest(keyUrl, json) async {
    String url = Urls.getUrl(keyUrl);
    var response = await http.delete(url);
    return response;
  }

  static putRequest(keyUrl) async {
    String url = Urls.getUrl(keyUrl);
    var response = await http.put(url);
    return response;
  }
}