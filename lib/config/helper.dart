import 'dart:math';

import 'package:admin/models/type_of_campaign.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class Helper {
  // LOGGER INSTANCE TO MAKE A LOG MESSAGES
  static final Logger logger = Logger();

  static final Random _random = Random();

  static const String arabicPlainText =
      'ضرب مكّن مشارف وبحلول بل, معقل أثره، الأسيوي وصل عن, جعل في وبدون بوابة ضمنها. ٣٠ غير لكون جسيمة فرنسية.';

  // get a random image url
  static String randomPictureUrl(int width, int height) {
    final randomInt = _random.nextInt(1000);
    return 'https://picsum.photos/$width/$height?random=$randomInt';
  }

  static bool isLocaleArabic(BuildContext context) {
    return context.locale == const Locale('ar');
  }

  static final typesOfCampaigns = <TypeOfCampaign>[
    const TypeOfCampaign(typeId: 1, typeNameAr: 'صحة', typeNameEn: 'Health'),
    const TypeOfCampaign(
        typeId: 2, typeNameAr: 'تعليم', typeNameEn: 'Education'),
    const TypeOfCampaign(
        typeId: 3, typeNameAr: 'ترفيه', typeNameEn: 'Entertainment'),
    const TypeOfCampaign(typeId: 4, typeNameAr: 'أخرى', typeNameEn: 'Other'),
  ];
}
