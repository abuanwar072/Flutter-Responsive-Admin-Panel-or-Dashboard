import 'package:admin/models/request.dart';

class GiftRequest extends Request {
  final String recipientFullName;
  final String recipientPhone;
  final double giftValue;
  final int giftID;

  GiftRequest({
    required super.id,
    required super.presenterFullName,
    required this.recipientFullName,
    required this.recipientPhone,
    required this.giftValue,
    required this.giftID,
  });
}
