/*
  REPRESENT A GIFT OBJECT IN THE DATABASE
*/

import 'dart:math';

class GiftCard {
  final int id;
  final String nameAr;
  final String nameEn;
  final String descriptionAr;
  final String descriptionEn;
  final double value;

  GiftCard({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.descriptionAr,
    required this.descriptionEn,
    required this.value,
  });

  static final _random = Random();
  static final List<GiftCard> gifts = [
    GiftCard(
      id: 0,
      nameAr: 'تعليم',
      nameEn: 'Education',
      descriptionAr: 'هدية بمناسبة النجاح في السنة الدراسية',
      descriptionEn: 'A gift for success in the educational year',
      value: double.parse(_random.nextDouble().toStringAsFixed(2)) * 100000,
    ),
    GiftCard(
      id: 1,
      nameAr: 'عيد ميلاد',
      nameEn: 'Birthday',
      descriptionAr: 'هدية بمناسبة موعد عيد ميلادك',
      descriptionEn: 'A gift for your birthday',
      value: double.parse(_random.nextDouble().toStringAsFixed(2)) * 100000,
    ),
    GiftCard(
      id: 2,
      nameAr: 'صحة',
      nameEn: 'Health',
      descriptionAr: 'هدية بمناسبة نجاح العملية مع التمني بدوام الصحة والعافية',
      descriptionEn:
          'A gift on the occasion of the success of the operation, wishing you good health',
      value: double.parse(_random.nextDouble().toStringAsFixed(2)) * 100000,
    ),
  ];
}
