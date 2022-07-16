import 'package:admin/models/donation_operation.dart';

class SupportiveOrganization {
  final int? id;
  final String? nameAr;
  final String? nameEn;
  final String? phoneNumber;
  final String? email;
  final String? cityAr;
  final String? cityEn;
  final String? stateAr;
  final String? stateEn;
  final double? totalContributions;
  final List<DonationOperation>? donationOperations;

  SupportiveOrganization({
    this.id,
    this.nameAr,
    this.nameEn,
    this.phoneNumber,
    this.email,
    this.cityAr,
    this.cityEn,
    this.stateAr,
    this.stateEn,
    this.donationOperations,
    this.totalContributions,
  });

  // NEED TO BE EDITED TO MATCH THE API
  factory SupportiveOrganization.fromJson(Map<String, dynamic> json) {
    return SupportiveOrganization(
      id: json['id'] as int,
      nameAr: json['name_org'] as String,
      nameEn: json['name_org_en'] as String,
      phoneNumber: json['phone_num'] as String,
      email: json['email'] as String,
      cityAr: json['city'] as String,
      cityEn: json['city_en'] as String,
      stateAr: json['state'] as String,
      stateEn: json['state_en'] as String,
      totalContributions: double.parse(json['total_contributions'].toString()),
      donationOperations: (json['donation_operation'] as List)
          .map((e) => DonationOperation.fromJson(e))
          .toList(),
    );
  }

  // TO JSON FUNCTION
  Map<String, dynamic> toJson() => <String, dynamic>{
        'name_org': nameAr,
        'name_org_en': nameEn,
        'city': cityAr,
        'city_en': cityEn,
        'state': stateAr,
        'state_en': stateEn,
        'phone_num': phoneNumber,
        'email': email,
      };

  @override
  String toString() {
    return 'SupportiveOrganization{id: $id, nameAr: $nameAr, nameEn: $nameEn, phoneNumber: $phoneNumber, email: $email, cityAr: $cityAr, cityEn: $cityEn, stateAr: $stateAr, stateEn: $stateEn, totalContributions: $totalContributions, donationOperations: $donationOperations}';
  }
}

// THIS LIST OF DUMMY SUPPORTIVE ORGANIZATIONS
final List<SupportiveOrganization> orgs = [
  SupportiveOrganization(
    id: 1,
    nameAr: 'منظمة إحسان',
    nameEn: 'Ihsan Organization',
    phoneNumber: '0123456789',
    email: 'ihsan@example.com',
    cityAr: 'المهاجرين',
    cityEn: 'Mouhajerin',
    stateAr: 'دمشق',
    stateEn: 'Damascus',
  ),
  SupportiveOrganization(
    id: 2,
    nameAr: 'منظمة إنماء',
    nameEn: 'Enmaa Organization',
    phoneNumber: '2345847568',
    email: 'enmaa@example.com',
    cityAr: 'مساكن برزة',
    cityEn: 'Masaken Barzah',
    stateAr: 'دمشق',
    stateEn: 'Damascus',
  ),
  SupportiveOrganization(
    id: 3,
    nameAr: 'منظمة بناء',
    nameEn: 'Benaa Organization',
    phoneNumber: '2345847568',
    email: 'benaa@example.com',
    cityAr: 'المزة',
    cityEn: 'Al Mazzeh',
    stateAr: 'دمشق',
    stateEn: 'Damascus',
  ),
  SupportiveOrganization(
    id: 4,
    nameAr: 'منظمة رعاية',
    nameEn: 'Reaya Organization',
    phoneNumber: '2345847568',
    email: 'enmaa@example.com',
    cityAr: 'المالكي',
    cityEn: 'Al Malaki',
    stateAr: 'دمشق',
    stateEn: 'Damascus',
  ),
];
