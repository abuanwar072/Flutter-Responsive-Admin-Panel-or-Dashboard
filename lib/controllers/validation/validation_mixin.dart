mixin ValidationMixin {
  // Validation Regex Patterns
  static RegExp _nameRegex = RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%\s-]');
  static RegExp _emailRegex = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  static RegExp _phoneRegex = RegExp(r'^(?:[+0]9)?[0-9]{10}$');
  static RegExp _dateRegex =
      RegExp(r'(\d{4}-?\d\d-?\d\d(\s|T)\d\d:?\d\d:?\d\d)');

  // validate string is not empty
  bool isFieldEmpty(String fieldValue) => fieldValue.isEmpty;

  bool validateEmailAddress(String email) {
    if (email.isEmpty) {
      return false;
    }
    return _emailRegex.hasMatch(email);
  }

  bool validatePhoneNumber(String phoneNumebr) {
    if (phoneNumebr.isEmpty) {
      return false;
    }
    return _phoneRegex.hasMatch(phoneNumebr);
  }

  bool validateName(String name) {
    if (name.isEmpty) {
      return false;
    }
    return _nameRegex.hasMatch(name);
  }

  bool validateDate(String date) {
    if (date.isEmpty) {
      return false;
    }
    return _dateRegex.hasMatch(date);
  }
}
