import 'dart:convert';
import 'dart:io';

import 'package:admin/config/helper.dart';
import 'package:admin/exceptions/server_exception.dart';
import 'package:admin/models/person.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class PersonsServices {
  // CLASS NAME FOR DEBUGGING PURPOSES IN CAPITAL CASE
  static const String className = 'PersonServices';

  // EMPLOYEES ENDPOINT BASE URL
  final String baseUrl = 'https://ataa-management-system.herokuapp.com/api';
  final String personsEndpoint = '/person';

  // GET PERSONS WITH SPECIAL NEEDS FROM API
  Future<List<Person>?> getPersonsWithSpecialNeeds() async {
    http.Response? response;
    try {
      response = await http.get(
        Uri.parse('$baseUrl$personsEndpoint'),
        headers: {
          'Accept': 'application/json',
        },
      ).timeout(const Duration(seconds: 10));

      // ! FETCHED SUCCESSFULLY
      if (response.statusCode == 200) {
        Helper.logger.i(
          '$className::getPersonsWithSpecialNeeds: ${response.body}',
        );
        return compute(_parsePersons, response.body);

        // ! SERVER ERROR
      } else if (response.statusCode >= 500 && response.statusCode < 600) {
        throw ServerException('Failed to load persons with special needs');

        // ! ERROR CAUSED BY UESR'S REQUEST
      } else {
        throw http.ClientException('Failed to load persons with special needs');
      }
    } on SocketException {
      if (kDebugMode) Helper.logger.e('$className: SocketException');
      return null;
    } on ServerException {
      if (kDebugMode) {
        Helper.logger.e('$className: ServerException ${response!.statusCode}');
      }
      return null;
    } on http.ClientException {
      if (kDebugMode) Helper.logger.e('$className: ClientException');
      return null;
    } on Exception {
      if (kDebugMode) Helper.logger.e('$className: Exception');
      return null;
    }
  }

  // STORE PERSON WITH SPECIAL NEEDS ON SERVER
  Future<bool?> storePersonWithSpecialNeeds(Person person) async {
    http.Response? response;
    try {
      Helper.logger.v(person.toJson());
      response = await http
          .post(
            Uri.parse('$baseUrl$personsEndpoint'),
            headers: {
              'Accept': 'application/json',
              'Content-Type': 'application/json',
            },
            body: json.encode(person.toJson()),
          )
          .timeout(const Duration(seconds: 10));

      // ! FETCHED SUCCESSFULLY
      if (response.statusCode == 200) {
        Helper.logger.i(
          '$className::storePersonWithSpecialNeeds: ${response.body}',
        );
        return true;

        // ! SERVER ERROR
      } else if (response.statusCode >= 500 && response.statusCode < 600) {
        throw ServerException('Failed to store person with special needs');

        // ! ERROR CAUSED BY UESR'S REQUEST
      } else {
        throw http.ClientException('Failed to store person with special needs');
      }
    } on SocketException {
      if (kDebugMode) Helper.logger.e('$className: SocketException');
      return false;
    } on ServerException {
      if (kDebugMode) {
        Helper.logger.e('$className: ServerException ${response!.statusCode}');
      }
      return false;
    } on http.ClientException {
      if (kDebugMode) Helper.logger.e('$className: ClientException');
      return false;
    } on Exception {
      if (kDebugMode) Helper.logger.e('$className: Exception');
      return false;
    }
  }

  // UPDATE PERSON WITH SPECIAL NEEDS ON SERVER
  Future<bool?> updatePersonWithSpecialNeeds(Person person) async {
    http.Response? response;
    try {
      Helper.logger.v(person.toJson());
      response = await http
          .put(
            Uri.parse('$baseUrl$personsEndpoint/${person.personId}'),
            headers: {
              'Accept': 'application/json',
              'Content-Type': 'application/json',
            },
            body: json.encode(person.toJson()),
          )
          .timeout(const Duration(seconds: 10));

      // ! FETCHED SUCCESSFULLY
      if (response.statusCode == 200) {
        Helper.logger.i(
          '$className::updatePersonWithSpecialNeeds: ${response.body}',
        );
        return true;

        // ! SERVER ERROR
      } else if (response.statusCode >= 500 && response.statusCode < 600) {
        Helper.logger.e('$className: ServerException ${response.statusCode}');
        Helper.logger.e('$className: ServerException ${response.body}');
        throw ServerException('Failed to update person with special needs');

        // ! ERROR CAUSED BY UESR'S REQUEST
      } else {
        throw http.ClientException(
            'Failed to update person with special needs');
      }
    } on SocketException {
      if (kDebugMode) Helper.logger.e('$className: SocketException');
      return false;
    } on ServerException {
      if (kDebugMode) {
        Helper.logger.e('$className: ServerException ${response!.body}');
      }
      return false;
    } on http.ClientException {
      if (kDebugMode) Helper.logger.e('$className: ClientException');
      return false;
    } on Exception {
      if (kDebugMode) Helper.logger.e('$className: Exception');
      return false;
    }
  }

  // TERMINATE PERSON WITH SPECIAL NEEDS ON SERVER
  Future<bool?> terminatePersonWithSpecialNeeds(Person person) async {
    http.Response? response;
    try {
      response = await http.delete(
        Uri.parse('$baseUrl$personsEndpoint/${person.personId}'),
        headers: {
          'Accept': 'application/json',
        },
      ).timeout(const Duration(seconds: 10));

      // ! FETCHED SUCCESSFULLY
      if (response.statusCode == 200) {
        Helper.logger.i(
          '$className::deletePersonWithSpecialNeeds: ${response.body}',
        );
        return true;

        // ! SERVER ERROR
      } else if (response.statusCode >= 500 && response.statusCode < 600) {
        throw ServerException('Failed to delete person with special needs');

        // ! ERROR CAUSED BY UESR'S REQUEST
      } else {
        throw http.ClientException(
            'Failed to delete person with special needs');
      }
    } on SocketException {
      if (kDebugMode) Helper.logger.e('$className: SocketException');
      return false;
    } on ServerException {
      if (kDebugMode) {
        Helper.logger.e('$className: ServerException ${response!.statusCode}');
      }
      return false;
    } on http.ClientException {
      if (kDebugMode) Helper.logger.e('$className: ClientException');
      return false;
    } on Exception {
      if (kDebugMode) Helper.logger.e('$className: Exception');
      return false;
    }
  }

  // PARSE PERSONS FROM JSON
  List<Person> _parsePersons(responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    Helper.logger.i('$className::_parsePersons: ${parsed.length}');
    Helper.logger.v('$className::_parsePersons: $parsed');
    return parsed.map<Person>((json) => Person.fromJson(json)).toList();
  }
}
