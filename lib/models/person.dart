class Person {
  final int? personId;
  final String? healthStatusEn;
  final String? healthStatusAr;
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final String? state;
  final String? nationalNumber;
  final DateTime? birthDate;
  late int? age;
  final String? healthReportUrl;

  Person({
    this.personId,
    this.healthStatusEn,
    this.healthStatusAr,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.state,
    this.nationalNumber,
    this.birthDate,
    this.healthReportUrl,
  }) {
    this.age = _getAge();
  }

  int _getAge() {
    final int currentYear = DateTime.now().year;
    final int birthYear = this.birthDate!.year;
    return currentYear - birthYear;
  }
}
