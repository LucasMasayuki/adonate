class ErrorMessages {
  static Map<String, dynamic> errorMapped = {
    'email': {
      'Enter a valid email address.': 'Entre com um email válido',
      'This field may not be blank.': 'Este campo não pode ser vazio'
    },
    'passoword': {
      'This field may not be blank.': 'Este campo não pode ser vazio'
    }
  };

  static getError(key, message) {
    return errorMapped[key][message];
  }
}