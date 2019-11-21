class Urls {
  static String baseUrl = 'https://adonate.appspot.com/';
  static Map url = {
    'login': 'login/',
    'register': 'register',
    'logout': 'logout/',
    'auth': 'api/auth',
    'campaigns': 'api/campaigns/',
    'tags': 'api/tags/',
    'get_campaigns_of_adonator': 'api/get_campaigns_adonator',
  };

  static getUrl(key) {
    return baseUrl + url[key];
  }
}