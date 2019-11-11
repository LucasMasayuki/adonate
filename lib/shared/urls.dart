class Urls {
  static String baseUrl = 'https://adonate.appspot.com/';
  static Map url = {
    'login': 'login/',
    'register': 'register',
    'logout': 'logout/'
  };

  static getUrl(key) {
    return baseUrl + url[key];
  }
}