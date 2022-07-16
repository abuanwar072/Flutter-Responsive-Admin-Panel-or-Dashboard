import 'package:admin/models/request.dart';

class SponsorshipRequest extends Request {
  final String sponsorEmail;
  final String sponsorPhone;
  final String sponsorNationalId;
  final String sponsorJob;
  final double annualSalary;
  final String sponsorState;
  final String sponsorCity;
  final String sponsorNationalIDUrl;

  SponsorshipRequest({
    required super.id,
    required super.presenterFullName,
    required this.sponsorEmail,
    required this.sponsorPhone,
    required this.sponsorNationalId,
    required this.sponsorJob,
    required this.annualSalary,
    required this.sponsorState,
    required this.sponsorCity,
    required this.sponsorNationalIDUrl,
  });
}
