class ErrorMessages {
  static Map<String, dynamic> errorMapped = {
    'email': {
      'Enter a valid email address.': 'Entre com um email valido',
      'This field may not be blank.': 'Este campo nao pode ser vazio'
    },
    'passoword': {
      'This field may not be blank.': 'Este campo nao pode ser vazio'
    }
  };

  static getError(key, message) {
    return errorMapped[key][message];
  }
}