import 'package:easy_localization/easy_localization.dart';

class Person {
  final int? personId;
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final DateTime? birthDate;
  final int? age;
  final String? nationalNumber;
  final String? stateEn;
  final String? stateAr;
  final String? cityAr;
  final String? cityEn;
  final String? healthStatusAr;
  final String? healthStatusEn;
  final String? healthReportUrl;
  final String? joinDate;
  final String? terminationDate;

  // DERIVED FIELDS
  late String? fullNameEn;
  late String? fullNameAr;
  late PersonStatus? status;

  Person({
    this.personId,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.birthDate,
    this.age,
    this.nationalNumber,
    this.stateEn,
    this.stateAr,
    this.cityAr,
    this.cityEn,
    this.healthStatusAr,
    this.healthStatusEn,
    this.healthReportUrl,
    this.joinDate,
    this.terminationDate,
  }) {
    fullNameEn = '$firstName $lastName';
    fullNameAr = '$lastName $firstName';
    status = terminationDate != null
        ? PersonStatus.registered
        : PersonStatus.terminated;
  }

  // FROM JSON FUNCTION FOR PARSING JSON OBJECT TO PERSON OBJECT
  factory Person.fromJson(Map<String, dynamic> json) => Person(
        personId: json['id'] as int,
        firstName: json['f_name'] as String,
        lastName: json['l_name'] as String,
        phoneNumber: json['phone_num'] as String,
        birthDate: DateTime.parse(json['birth_date'] as String),
        age: json['age'] as int,
        nationalNumber: json['nat_id_num'] as String,
        stateEn: json['state_en'] as String,
        stateAr: json['state_ar'] as String,
        cityAr: json['city_ar'] as String,
        cityEn: json['city_en'] as String,
        healthStatusAr: json['health_status_ar'] as String,
        healthStatusEn: json['health_status_en'] as String,
        healthReportUrl: json['health_report'] as String,
        joinDate: json['start_date'],
        terminationDate: json['end_date'],
      );

  // TO JSON FUNCTION FOR PARSING PERSON OBJECT TO JSON OBJECT
  Map<String, dynamic> toJson() => {
        'f_name': firstName,
        'l_name': lastName,
        'phone_num': phoneNumber,
        'birth_date': DateFormat('yyyy-MM-dd').format(birthDate!),
        'nat_id_num': nationalNumber,
        'state_en': stateEn,
        'state_ar': stateAr,
        'city_ar': cityAr,
        'city_en': cityEn,
        'health_status_ar': healthStatusAr,
        'health_status_en': healthStatusEn,
        'health_report': healthReportUrl,
      };
}

enum PersonStatus {
  registered,
  terminated,
}
