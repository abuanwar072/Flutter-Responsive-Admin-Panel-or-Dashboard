import 'dart:convert';
import 'dart:io';

import 'package:admin/config/helper.dart';
import 'package:admin/exceptions/server_exception.dart';
import 'package:admin/models/supportive_organization.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class SupportiveOrganizationsServices {
  // CLASS NAME FOR DEBUGGING PURPOSES IN CAPITAL CASE
  static const String className = 'SupportiveOrganizationsServices';

  // EMPLOYEES ENDPOINT BASE URL
  final String baseUrl = 'https://ataa-management-system.herokuapp.com/api';
  final String organizationsEndpoint = '/organization';

  // GET SUPPORTIVE ORGANIZATIONS
  Future<List<SupportiveOrganization>?> getSupportiveOrganizations() async {
    http.Response response;
    try {
      response = await http.get(
        Uri.parse('$baseUrl$organizationsEndpoint'),
        headers: {
          'Accept': 'application/json',
        },
      ).timeout(const Duration(seconds: 10));

      // ! FETCHED SUCCESSFULLY
      if (response.statusCode == 200) {
        Helper.logger.i(
          '$className::getSupportiveOrganizations: ${response.body}',
        );
        return compute(_parseSupportiveOrganizations, response.body);

        // ! SERVER ERROR
      } else if (response.statusCode >= 500 && response.statusCode < 600) {
        throw ServerException('Failed to load supportive organizations');

        // ! ERROR CAUSED BY USER'S REQUEST
      } else {
        throw http.ClientException('Failed to load supportive organizations');
      }
    } on SocketException {
      if (kDebugMode) Helper.logger.e('$className: SocketException');
      return null;
    } on ServerException {
      if (kDebugMode) Helper.logger.e('$className: ServerException');
      return null;
    } on http.ClientException {
      if (kDebugMode) Helper.logger.e('$className: ClientException');
      return null;
    } on Exception {
      if (kDebugMode) Helper.logger.e('$className: Exception');
      return null;
    }
  }

  // PARSE SUPPORTIVE ORGANIZATIONS
  List<SupportiveOrganization> _parseSupportiveOrganizations(responseBody) {
    final parsed = json
        .decode(responseBody)['Supportive Organizations']
        .cast<Map<String, dynamic>>();
    return parsed
        .map<SupportiveOrganization>(
            (json) => SupportiveOrganization.fromJson(json))
        .toList();
  }

  // ADD A SUPPORTIVE ORGANIZATION
  Future<bool?> addSupportiveOrganization({
    required SupportiveOrganization organization,
  }) async {
    http.Response response;
    try {
      Helper.logger.v(organization.toJson());
      response = await http
          .post(
            Uri.parse('$baseUrl$organizationsEndpoint'),
            headers: {
              'Accept': 'application/json',
              'Content-Type': 'application/json',
            },
            body: json.encode(organization.toJson()),
          )
          .timeout(const Duration(seconds: 10));

      // ! ADDED SUCCESSFULLY
      if (response.statusCode == 201) {
        Helper.logger.i(
          '$className::addSupportiveOrganization: ${response.body}',
        );
        return true;

        // ! SERVER ERROR
      } else if (response.statusCode >= 500 && response.statusCode < 600) {
        Helper.logger.e('$className: ServerException ${response.statusCode}');
        Helper.logger.e('$className: ServerException ${response.body}');
        throw ServerException('Failed to add supportive organization');

        // ! ERROR CAUSED BY USER'S REQUEST
      } else {
        throw http.ClientException('Failed to add supportive organization');
      }
    } on SocketException {
      if (kDebugMode) Helper.logger.e('$className: SocketException');
      return false;
    } on ServerException {
      if (kDebugMode) Helper.logger.e('$className: ServerException');
      return false;
    } on http.ClientException {
      if (kDebugMode) Helper.logger.e('$className: ClientException');
      return false;
    } on Exception {
      if (kDebugMode) Helper.logger.e('$className: Exception');
      return false;
    }
  }
}
