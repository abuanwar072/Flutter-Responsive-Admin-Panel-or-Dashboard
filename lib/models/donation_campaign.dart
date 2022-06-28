class DonationCampaign {
  final int? id;
  final String? titleAr;
  final String? titleEn;
  final double? targetAmount;
  final double? collectedAmount;
  final int? numberOfBeneficiaries;
  final DonationCampaignStatus? status;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? coverImageUrl;
  final int? empID;

  DonationCampaign({
    this.id,
    this.titleAr,
    this.titleEn,
    this.targetAmount,
    this.collectedAmount,
    this.numberOfBeneficiaries,
    this.status,
    this.startDate,
    this.endDate,
    this.coverImageUrl,
    this.empID,
  });

  // FROM JSON FUNCTION WITH NULL CHECK FOR NULLABLE FIELDS
  factory DonationCampaign.fromJson(Map<String, dynamic> json) {
    return DonationCampaign(
      id: json['id'] as int?,
      titleAr: json['titleAr'] as String?,
      titleEn: json['titleEn'] as String?,
      targetAmount: json['targetAmount'] as double?,
      collectedAmount: json['collectedAmount'] as double?,
      numberOfBeneficiaries: json['numberOfBeneficiaries'] as int?,
      status: json['status'] as DonationCampaignStatus?,
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      coverImageUrl: json['coverImageUrl'] as String?,
      empID: json['empID'] as int?,
    );
  }

  // TO JSON FUNCTION WITH NULL CHECK FOR NULLABLE FIELDS
  Map<String, dynamic> toJson() {
    return {
      'id': id == null ? null : id,
      'titleAr': titleAr == null ? null : titleAr,
      'titleEn': titleEn == null ? null : titleEn,
      'targetAmount': targetAmount == null ? null : targetAmount,
      'collectedAmount': collectedAmount == null ? null : collectedAmount,
      'numberOfBeneficiaries':
          numberOfBeneficiaries == null ? null : numberOfBeneficiaries,
      'status': status == null ? null : status,
      'startDate': startDate == null ? null : startDate?.toIso8601String(),
      'endDate': endDate == null ? null : endDate?.toIso8601String(),
      'coverImageUrl': coverImageUrl == null ? null : coverImageUrl,
      'empID': empID == null ? null : empID,
    };
  }
}

enum DonationCampaignStatus {
  active,
  cancelled,
  completed,
}
