import 'package:admin/models/user.dart';

class DonationOperation {
  final int? id;
  final int? idSupOrg;
  final User? user;
  final int? idDonCamp;
  final int? idPaymentMethod;
  final String? donorNameString;
  final double? paidAmount;
  final String? phoneNumber;
  final DateTime? paymentDate;

  // LATER ASSIGNED VALUES
  late DonorType? donatorType;
  late PaymentMethod? paymentMethod;
  late String? paymentMethodKey;
  late String donorName;

  DonationOperation({
    this.id,
    this.idSupOrg,
    this.idDonCamp,
    this.user,
    this.idPaymentMethod,
    this.paidAmount,
    this.donorNameString,
    this.phoneNumber,
    this.paymentDate,
  }) {
    donatorType = _getDonatorType();
    paymentMethod = _getPaymentMethod();
    donorName = _getDonatorName();
    paymentMethodKey = _getPaymentMethodString();
  }

  // FROM JSON FUNCTION WITH NULL CHECK FOR NULLABLE FIELDS
  factory DonationOperation.fromJson(Map<String, dynamic> json) {
    return DonationOperation(
      id: json['id'] as int?,
      idSupOrg: json['supportive_organization_id'] as int?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      idDonCamp: json['donation_campaign_id'] as int?,
      idPaymentMethod: json['payment_method_id'] as int?,
      donorNameString: json['donator_name'] as String?,
      paidAmount: double.parse(json['amount_paid']),
      phoneNumber: json['phone'] as String?,
      paymentDate: json['payment_date'] == null
          ? null
          : DateTime.parse(json['payment_date'] as String),
    );
  }

  // TO JSON FUNCTION
  Map<String, dynamic> toJson() {
    return {
      'supportive_organization_id': idSupOrg,
      'donation_campaign_id': idDonCamp,
      'payment_method_id': 1, // ! BECAUSE WE ACCEPT PAYMENTS AS CACHE
      'amount_paid': paidAmount.toString(),
      'phone': phoneNumber,
      'donator_name': donorNameString,
    };
  }

  // RETURNS DONATOR NAME DEPEDING OF OTHER ATTRIBUTES
  String _getDonatorName() {
    if (donorNameString != null) {
      return donorNameString!;
    } else if (user != null) {
      return user!.fullName;
    }
    // TODO: CHANGE IT LATER TO BE SUPPORTIVE ORGANIZATION NAME
    return "Organization";
  }

  // THIS FUNCTION IS USED TO GET PAYMENT METHOD ENUM FROM AN INT
  PaymentMethod _getPaymentMethod() {
    switch (idPaymentMethod) {
      case 1:
        return PaymentMethod.cash;
      case 2:
        return PaymentMethod.creditCard;
      case 3:
        return PaymentMethod.paypal;
      default:
        return PaymentMethod.other;
    }
  }

  _getPaymentMethodString() {
    switch (idPaymentMethod) {
      case 1:
        return "cache";
      case 2:
        return "credit_card";
      case 3:
        return "paypal";
      default:
        return "other";
    }
  }

  // THIS FUNCTION IS USED TO GET THE DONATOR TYPE ENUM
  DonorType _getDonatorType() {
    if (idSupOrg == null) {
      return DonorType.person;
    } else {
      return DonorType.organization;
    }
  }
}

enum PaymentMethod {
  cash,
  creditCard,
  paypal,
  other,
}

enum DonorType {
  person,
  organization,
}
