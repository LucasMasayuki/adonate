class Urls {
  static String baseUrl = 'https://adonate.appspot.com/';
  static String baseUrlWithoutBar = 'adonate.appspot.com';
  static Map url = {
    'login': 'login/',
    'register': 'register',
    'logout': 'logout/',
    'auth': 'api/auth',
    'campaigns': 'api/campaigns/',
    'tags': 'api/tags/',
    'get_campaigns_of_adonator': 'api/get_campaigns_adonator',
    'save_campaign': 'api/save_campaign',
    'filter_campaign': 'api/filter_campaign'
  };

  static getUrl(key) {
    return baseUrl + url[key];
  }

  static getUri(key, param) {
    return  Uri.https(baseUrlWithoutBar, url[key], param);
  }
}