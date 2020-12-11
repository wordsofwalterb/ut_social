class Validators {
  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );
  static final RegExp _passwordRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  );

  static final RegExp _emailUTRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@utexas.edu',
  );

  static bool isValidEmail(String email) {
    return _emailRegExp.hasMatch(email);
  }

  static bool isValidPassword(String password) {
    return _passwordRegExp.hasMatch(password);
  }

  static bool isValidFirstName(String firstName) {
    if (firstName != null && firstName != '') return true;
    return false;
  }

  static bool isValidLastName(String lastName) {
    if (lastName != null && lastName != '') return true;
    return false;
  }

  static bool isValidUTEmail(String email) {
    return _emailUTRegExp.hasMatch(email);
  }
}
