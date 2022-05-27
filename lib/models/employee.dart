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
  });
}

final List<Employee> dummyEmployees = [
  Employee(
    empId: 0,
    cityName: 'Mohajirin',
    state: 'Damascus',
    firstName: 'Alaa',
    lastName: 'Zamel',
    phoneNumber: '+963991146587',
    email: 'alaa.zamel80@gmail.com',
    cvImgUrl:
        'https://www.visualcv.com/static/0876ce13a50b8fca3dcecaa2e03f7e5c/08306/swiss-cv-image.png',
    startDate: '2020-12-08 00:00:00',
    isAdmin: true,
  ),
  Employee(
    empId: 1,
    cityName: 'Al Maliki',
    state: 'Damascus',
    firstName: 'Ghemar',
    lastName: 'Kaseeh',
    phoneNumber: '+963941470334',
    email: 'gmar.kaseeh@gmail.com',
    cvImgUrl:
        'https://www.wetalent.nl/wp-content/uploads/2020/06/CV-template-Accountmanager-pagina-1.jpg',
    startDate: '2021-07-02 00:00:00',
    isAdmin: false,
  ),
    Employee(
    empId: 2,
    cityName: 'Mazzah',
    state: 'Damascus',
    firstName: 'Ghemar',
    lastName: 'Kaseeh',
    phoneNumber: '+963941470334',
    email: 'gmar.kaseeh@gmail.com',
    cvImgUrl:
        'https://www.wetalent.nl/wp-content/uploads/2020/06/CV-template-Accountmanager-pagina-1.jpg',
    startDate: '2021-07-02 00:00:00',
    isAdmin: false,
  ),
];
