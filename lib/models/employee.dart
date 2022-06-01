import 'package:flutter/material.dart';

@immutable
class Employee {
  final int? empId;
  final String? cityName;
  final String? state;
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final String? email;
  final String? cvImgUrl;
  final String? startDate;
  final String? endDate;
  final bool? isAdmin;
  final String? resumeFileName;
  Employee({
    this.empId,
    this.cityName,
    this.state,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.email,
    this.cvImgUrl,
    this.startDate,
    this.endDate,
    this.isAdmin,
    this.resumeFileName,
  });

  @override
  String toString() {
    return 'Employee(empId: $empId, cityName: $cityName, state: $state, firstName: $firstName, lastName: $lastName, phoneNumber: $phoneNumber, email: $email, cvImgUrl: $cvImgUrl, startDate: $startDate, endDate: $endDate, isAdmin: $isAdmin)';
  }
}
