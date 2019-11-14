class Urls {
  static String baseUrl = 'https://adonate.appspot.com/';
  static Map url = {
    'login': 'login/',
    'register': 'register',
    'logout': 'logout/',
    'campaigns': 'api/campaigns/',
    'auth': 'api/auth/'
  };

  static getUrl(key) {
    return baseUrl + url[key];
  }
}