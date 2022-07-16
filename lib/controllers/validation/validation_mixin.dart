mixin ValidationProvider {
  // Validation Regex Patterns
  static final RegExp _nameRegex = RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%\s-]');
  static final RegExp _emailRegex = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  static final RegExp _phoneRegex =
      RegExp('^[\\+]?[(]?[0-9]{3}[)]?[-\\s\\.]?[0-9]{3}[-\\s\\.]?[0-9]{4,6}\$'
          // r'^(?:[+0]9)?[0-9]{10}$'
          );
  static final RegExp _dateRegex =
      RegExp(r'(\d{4}-?\d\d-?\d\d(\s|T)\d\d:?\d\d:?\d\d)');

  static final RegExp _priceRegex = RegExp(r'^\d+(\.\d{1,2})?$');

  static final RegExp _numberRegex = RegExp(r'^[0-9]*$');

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

  bool validatePrice(String price) {
    if (price.isEmpty) {
      return false;
    }
    return _priceRegex.hasMatch(price);
  }

  bool validateDate(String date) {
    if (date.isEmpty) {
      return false;
    }
    return _dateRegex.hasMatch(date);
  }

  bool validateNationalID(String nationalID) {
    if (nationalID.isEmpty) {
      return false;
    }
    return _numberRegex.hasMatch(nationalID);
  }
}
