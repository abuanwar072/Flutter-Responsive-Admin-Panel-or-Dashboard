import 'dart:convert';
import 'dart:io';

import 'package:admin/config/helper.dart';
import 'package:admin/exceptions/server_exception.dart';
import 'package:admin/models/donation_campaign.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class DonationCampaignsServices {
  // CLASS NAME FOR DEBUGGING PURPOSES IN CAPITAL CASE
  static const String className = 'DonationCampaignsServices';

  // DONATION CAMPAIGNS ENDPOINT BASE URL
  final String baseUrl = 'https://ataa-management-system.herokuapp.com/api';
  final String donationCampaignsEndpoint = '/donation-campaign';

  // GET DONATION CAMPANIGNS
  Future<List<DonationCampaign>?> getDonationCampaigns() async {
    http.Response response;
    try {
      response = await http.get(
        Uri.parse('$baseUrl$donationCampaignsEndpoint'),
        headers: {
          'Accept': 'application/json',
        },
      ).timeout(const Duration(seconds: 10));

      // ! FETCHED SUCCESSFULLY
      if (response.statusCode == 200) {
        Helper.logger.i(
          '$className::getDonationCampaigns: ${response.body}',
        );
        return compute(_parseDonationCampaigns, response.body);

        // ! SERVER ERROR
      } else if (response.statusCode >= 500 && response.statusCode < 600) {
        throw ServerException('Failed to load donation campaigns');

        // ! ERROR CAUSED BY UESR'S REQUEST
      } else {
        throw http.ClientException('Failed to load donation campaigns');
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

  // STORE DONATION CAMPAIGN
  Future<bool?> storeDonationCampaign(
    DonationCampaign donationCampaign,
  ) async {
    http.Response response;
    try {
      Helper.logger.v(donationCampaign.toJson());
      response = await http
          .post(
            Uri.parse('$baseUrl$donationCampaignsEndpoint'),
            headers: {
              'Accept': 'application/json',
              'Content-Type': 'application/json',
            },
            body: json.encode(donationCampaign.toJson()),
          )
          .timeout(const Duration(seconds: 10));

      // ! FETCHED SUCCESSFULLY
      if (response.statusCode == 201) {
        Helper.logger.v('$className::storeDonationCampaign: ${response.body}');
        return true;

        // ! SERVER ERROR
      } else if (response.statusCode >= 500 && response.statusCode < 600) {
        throw ServerException('Failed to store donation campaign');

        // ! ERROR CAUSED BY UESR'S REQUEST
      } else {
        throw http.ClientException('Failed to store donation campaign');
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

  // CANCEL DONATION CAMPAIGN
  Future<bool?> cancelDonationCampaign(
    DonationCampaign donationCampaign,
  ) async {
    http.Response response;
    try {
      response = await http.delete(
        Uri.parse('$baseUrl$donationCampaignsEndpoint/${donationCampaign.id}'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ).timeout(const Duration(seconds: 10));

      // ! FETCHED SUCCESSFULLY
      if (response.statusCode == 200) {
        Helper.logger.i(
          '$className::cancelDonationCampaign: ${response.body}',
        );
        return true;

        // ! SERVER ERROR
      } else if (response.statusCode >= 500 && response.statusCode < 600) {
        Helper.logger.e('$className: ServerException ${response.statusCode}');
        Helper.logger.e('$className: ServerException ${response.body}');
        throw ServerException('Failed to cancel donation campaign');

        // ! ERROR CAUSED BY UESR'S REQUEST
      } else {
        throw http.ClientException('Failed to cancel donation campaign');
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

  // PARSE DONATION CAMPAIGNS
  List<DonationCampaign> _parseDonationCampaigns(responseBody) {
    final parsed = json
        .decode(responseBody)['Donation Campaigns']
        .cast<Map<String, dynamic>>();
    return parsed
        .map<DonationCampaign>((json) => DonationCampaign.fromJson(json))
        .toList();
  }
}
