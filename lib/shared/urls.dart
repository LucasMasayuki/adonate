class Urls {
  static String baseUrl = 'http://192.168.15.75:8000/';
  static String baseUrlWithoutBar = '192.168.15.75:8000/';
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

  static List<String> routes = [
    '/login',
    '/campaigns',
    '/campaign-detail',
    '/edit-campaign'
  ];

  static getUrl(key) {
    return baseUrl + url[key];
  }

  static getUri(key, param) {
    return Uri.https(baseUrlWithoutBar, url[key], param);
  }
}
