import 'package:admin/models/request.dart';

class VolunteerRequest extends Request {
  final String volunteerPhone;
  final String volunteerEmail;
  final String volunteerCampaign;
  final DateTime volunteerBirthDate;
  final int volunteerExpYears;
  final String volunteerUniversityDegreeUrl;

  // ATTRIBUTES TO BE CALCULATED LATER
  late int volunteerAge;

  VolunteerRequest({
    required super.id,
    required super.presenterFullName,
    required this.volunteerPhone,
    required this.volunteerEmail,
    required this.volunteerCampaign,
    required this.volunteerBirthDate,
    required this.volunteerExpYears,
    required this.volunteerUniversityDegreeUrl,
  }) {
    volunteerAge =
        (DateTime.now().difference(volunteerBirthDate).inDays ~/ 365);
  }
}
