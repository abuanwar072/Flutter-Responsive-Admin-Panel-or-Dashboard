import 'package:admin/models/donation_operation.dart';

class DonationCampaign {
  final int? id;
  final String? titleAr;
  final String? titleEn;
  final int? typeOfCampaignId;
  final double? targetAmount;
  final double? collectedAmount;
  final int? numberOfBeneficiaries;
  late DonationCampaignStatus? status;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? coverImageUrl;
  final int? empID;
  final String? statusString;
  final List<DonationOperation>? donationOperations;

  DonationCampaign({
    this.id,
    this.titleAr,
    this.titleEn,
    this.typeOfCampaignId,
    this.targetAmount,
    this.collectedAmount,
    this.numberOfBeneficiaries,
    this.startDate,
    this.endDate,
    this.coverImageUrl,
    this.empID,
    this.statusString,
    this.donationOperations,
  }) {
    status = _getCampaignStatus();
  }

  _getCampaignStatus() {
    if (statusString == 'completed') {
      return DonationCampaignStatus.completed;
    } else if (statusString == 'cancelled') {
      return DonationCampaignStatus.cancelled;
    } else {
      return DonationCampaignStatus.active;
    }
  }

  // FROM JSON FUNCTION WITH NULL CHECK FOR NULLABLE FIELDS
  factory DonationCampaign.fromJson(Map<String, dynamic> json) {
    return DonationCampaign(
      id: json['id'] as int?,
      empID: json['employee_id'] as int?,
      typeOfCampaignId: json['type_of_campaign_id'] as int?,
      titleAr: json['name_donation_camp'] as String?,
      titleEn: json['name_donation_camp_en'] as String?,
      targetAmount: double.parse(json['payment_required']),
      collectedAmount: (json['current_amount'] as int).toDouble(),
      numberOfBeneficiaries: json['num_of_needy_persons'] as int?,
      statusString: json['status'] as String?,
      coverImageUrl: json['image_url'] as String?,
      donationOperations: (json['donation_operation'] as List<dynamic>)
          .map((e) => DonationOperation.fromJson(e))
          .toList(),
      startDate: json['start_date'] == null
          ? null
          : DateTime.parse(json['start_date'] as String),
      endDate: json['end_date'] == null
          ? null
          : DateTime.parse(json['end_date'] as String),
    );
  }

  // TO STRING FUNCTION
  @override
  String toString() {
    return 'DonationCampaign{id: $id, titleAr: $titleAr, titleEn: $titleEn, typeOfCampaignId: $typeOfCampaignId, targetAmount: $targetAmount, collectedAmount: $collectedAmount, numberOfBeneficiaries: $numberOfBeneficiaries, status: $status, startDate: $startDate, endDate: $endDate, coverImageUrl: $coverImageUrl, empID: $empID, statusString: $statusString}';
  }

  // TO JSON FUNCTION WITH NULL CHECK FOR NULLABLE FIELDS
  Map<String, dynamic> toJson() {
    return {
      'employee_id': 1, // TODO: REMOVE THIS LATER
      'type_of_campaign_id': typeOfCampaignId,
      'name_donation_camp': titleAr,
      'name_donation_camp_en': titleEn,
      'payment_required': targetAmount,
      'num_of_needy_persons': numberOfBeneficiaries,
      'image_url': coverImageUrl,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DonationCampaign &&
        other.id == id &&
        other.titleAr == titleAr &&
        other.titleEn == titleEn &&
        other.typeOfCampaignId == typeOfCampaignId &&
        other.targetAmount == targetAmount &&
        other.collectedAmount == collectedAmount &&
        other.numberOfBeneficiaries == numberOfBeneficiaries &&
        other.status == status &&
        other.startDate == startDate &&
        other.endDate == endDate &&
        other.coverImageUrl == coverImageUrl &&
        other.empID == empID &&
        other.statusString == statusString;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        titleAr.hashCode ^
        titleEn.hashCode ^
        typeOfCampaignId.hashCode ^
        targetAmount.hashCode ^
        collectedAmount.hashCode ^
        numberOfBeneficiaries.hashCode ^
        status.hashCode ^
        startDate.hashCode ^
        endDate.hashCode ^
        coverImageUrl.hashCode ^
        empID.hashCode ^
        statusString.hashCode;
  }
}

enum DonationCampaignStatus {
  active,
  cancelled,
  completed,
}
