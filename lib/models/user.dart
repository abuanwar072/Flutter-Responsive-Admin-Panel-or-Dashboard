class User {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String authTypeString;

  // LATER ASSIGNED VALUE
  late String fullName;
  late AuthType authType;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.authTypeString,
  }) {
    fullName = '$firstName $lastName';
    authType = _getAuthType();
  }

  _getAuthType() {
    switch (authTypeString) {
      case 'email':
        return AuthType.email;
      case 'google':
        return AuthType.google;
      case 'facebook':
        return AuthType.facebook;
      default:
        return AuthType.email;
    }
  }

  // FROM JSON FUNCTION WITH NULL CHECK FOR NULLABLE FIELDS
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      email: json['email'] as String,
      authTypeString: json['auth_type'] as String,
    );
  }

  // TO STRING
  @override
  String toString() {
    return 'User{id: $id, firstName: $firstName, lastName: $lastName, email: $email, authTypeString: $authTypeString, fullName: $fullName, authType: $authType}';
  }
}

enum AuthType {
  email,
  google,
  facebook,
}
