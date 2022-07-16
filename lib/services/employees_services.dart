// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:admin/config/helper.dart';
import 'package:admin/exceptions/server_exception.dart';
import 'package:admin/models/employee.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class EmployeesServices {
  // CLASS NAME FOR DEBUGGING PURPOSES IN CAPITAL CASE
  static const String className = 'EmployeesServices';

  // EMPLOYEES ENDPOINT BASE URL
  final String baseUrl = 'https://ataa-management-system.herokuapp.com/api';
  final String employeesEndpoint = '/emp';

  // GET EMPLOYEES
  Future<List<Employee>?> getEmployees() async {
    http.Response response;
    try {
      response = await http.get(
        Uri.parse('$baseUrl$employeesEndpoint'),
        headers: {
          'Accept': 'application/json',
        },
      ).timeout(const Duration(seconds: 10));

      // ! FETCHED SUCCESSFULLY
      if (response.statusCode == 200) {
        Helper.logger.i(
          '$className::getEmployees: ${response.body}',
        );
        return compute(_parseEmployees, response.body);

        // ! SERVER ERROR
      } else if (response.statusCode >= 500 && response.statusCode < 600) {
        throw ServerException('Failed to load employees');

        // ! ERROR CAUSED BY UESR'S REQUEST
      } else {
        throw ClientException('Failed to load employees');
      }
    } on SocketException {
      if (kDebugMode) Helper.logger.e('$className: SocketException');
      return null;
    } on ServerException {
      if (kDebugMode) Helper.logger.e('$className: ServerException');
      return null;
    } on ClientException {
      if (kDebugMode) Helper.logger.e('$className: ClientException');
      return null;
    } on Exception {
      if (kDebugMode) Helper.logger.e('$className: Exception');
      return null;
    }
  }

  // STORE EMPLOYEE
  Future<bool?> storeEmployee(Employee employee) async {
    http.Response response;
    try {
      Helper.logger.v(employeeToJson(employee));
      response = await http.post(
        Uri.parse('$baseUrl$employeesEndpoint'),
        body: json.encode(employeeToJson(employee)),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      // ! STORED SUCCESSFULLY
      if (response.statusCode == 201) {
        return true;

        // ! SERVER ERROR
      } else if (response.statusCode >= 500 && response.statusCode < 600) {
        throw ServerException('Failed to store employee');

        // ! ERROR CAUSED BY USER'S REQUEST
      } else {
        throw ClientException('Failed to store employee');
      }
    } on SocketException {
      Helper.logger.e('$className: SocketException');
      return false;
    } on ServerException {
      Helper.logger.e('$className: ServerException');
      return false;
    } on ClientException {
      Helper.logger.e('$className: ClientException');
      return null;
    } on Exception {
      Helper.logger.e('$className: Exception');
      return false;
    }
  }

  // UPDATE EMPLOYEE
  Future<bool> updateEmployee(Employee employee) async {
    http.Response response;
    try {
      Helper.logger.v(employeeToJson(employee));
      response = await http.put(
        Uri.parse('$baseUrl$employeesEndpoint/${employee.empId}'),
        body: json.encode(employeeToJson(employee)),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      // ! UPDATED SUCCESSFULLY
      if (response.statusCode == 200) {
        Helper.logger.d('$className: ${response.body}');
        return true;

        // ! SERVER ERROR
      } else if (response.statusCode >= 500 && response.statusCode < 600) {
        throw ServerException('Failed to update employee');

        // ! ERROR CAUSED BY USER'S REQUEST
      } else {
        throw ClientException('Failed to update employee');
      }
    } on SocketException {
      Helper.logger.e('$className: SocketException');
      return false;
    } on ServerException {
      Helper.logger.e('$className: ServerException');
      return false;
    } on ClientException {
      Helper.logger.e('$className: ClientException');
      return false;
    }
  }

  // DELETE EMPLOYEE
  Future<bool> deleteEmployee(Employee employee) async {
    http.Response response;
    try {
      response = await http.delete(
        Uri.parse('$baseUrl$employeesEndpoint/${employee.empId}'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      // ! DELETED SUCCESSFULLY
      if (response.statusCode == 200) {
        return true;

        // ! SERVER ERROR
      } else if (response.statusCode >= 500 && response.statusCode < 600) {
        Helper.logger.e('$className: ServerException ${response.statusCode}');
        Helper.logger.e('$className: ServerException ${response.body}');
        throw ServerException('Failed to delete employee');

        // ! ERROR CAUSED BY USER'S REQUEST
      } else {
        throw ClientException('Failed to delete employee');
      }
    } on SocketException {
      Helper.logger.e('$className: SocketException');
      return false;
    } on ServerException {
      Helper.logger.e('$className: ServerException');
      return false;
    } on ClientException {
      Helper.logger.e('$className: ClientException');
      return false;
    }
  }

  //? PARSE EMPLOYEES
  FutureOr<List<Employee>> _parseEmployees(message) {
    return json
        .decode(message)
        .map<Employee>((json) => Employee.fromJson(json))
        .toList();
  }
}
