import 'dart:convert';
import 'dart:io';

import 'package:admin/config/helper.dart';
import 'package:admin/exceptions/server_exception.dart';
import 'package:admin/models/donation_operation.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class DonationOperationsServices {
  // CLASS NAME FOR DEBUGGING PURPOSES
  static const String className = "DonationOperationsServices";

  // EMPLOYEES ENDPOINT BASE URL
  final String baseUrl = 'https://ataa-management-system.herokuapp.com/api';
  final String donationOperationsEndpoint = '/donation-operation';

  // GET DONATION OPERATIONS
  Future<List<DonationOperation>?> getDonationOperations() async {
    http.Response response;
    try {
      response = await http.get(
        Uri.parse('$baseUrl$donationOperationsEndpoint'),
        headers: {
          'Accept': 'application/json',
        },
      ).timeout(const Duration(seconds: 10));

      // ! FETCHED SUCCESSFULLY
      if (response.statusCode == 200) {
        Helper.logger.i(
          '$className::getDonationOperations: ${response.body}',
        );
        return compute(_parseDonationOperations, response.body);

        // ! SERVER ERROR
      } else if (response.statusCode >= 500 && response.statusCode < 600) {
        throw ServerException('Failed to load donation operations');

        // ! ERROR CAUSED BY USER'S REQUEST
      } else {
        throw http.ClientException('Failed to load donation operations');
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

  // PARSE DONATION OPERATIONS
  List<DonationOperation> _parseDonationOperations(responseBody) {
    final parsed = json
        .decode(responseBody)['ALL Donation Operation']
        .cast<Map<String, dynamic>>();
    Helper.logger.d('$className::_parseDonationOperations: $parsed');
    return parsed
        .map<DonationOperation>((json) => DonationOperation.fromJson(json))
        .toList();
  }

  // STORE DONATION OPERATION
  Future<bool?> storeDonationOperation(
    DonationOperation donationOperation,
  ) async {
    http.Response response;
    try {
      Helper.logger.v(donationOperation.toJson());
      response = await http
          .post(
            Uri.parse('$baseUrl$donationOperationsEndpoint'),
            headers: {
              'Accept': 'application/json',
              'Content-Type': 'application/json',
            },
            body: json.encode(donationOperation.toJson()),
          )
          .timeout(const Duration(seconds: 10));

      // ! FETCHED SUCCESSFULLY
      if (response.statusCode == 201) {
        Helper.logger.d('$className::storeDonationOperation: ${response.body}');
        return true;

        // ! SERVER ERROR
      } else if (response.statusCode >= 500 && response.statusCode < 600) {
        throw ServerException('Failed to store donation operation');

        // ! ERROR CAUSED BY USER'S REQUEST
      } else {
        throw http.ClientException('Failed to store donation operation');
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
