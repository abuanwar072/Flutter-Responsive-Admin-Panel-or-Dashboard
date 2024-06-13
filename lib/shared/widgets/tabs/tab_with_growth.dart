import 'package:core_dashboard/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../theme/app_colors.dart';
import '../../constants/defaults.dart';
import '../../constants/ghaps.dart';

class TabWithGrowth extends StatelessWidget {
  const TabWithGrowth({
    super.key,
    required this.title,
    required this.amount,
    required this.growthPercentage,
    this.iconSrc = "assets/icons/shopping_bag_light.svg",
    this.isPositiveGrowth = true,
    this.iconBgColor = AppColors.secondaryBabyBlue,
  });
  final String title, amount, growthPercentage, iconSrc;
  final bool isPositiveGrowth;
  final Color iconBgColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AppDefaults.padding,
          vertical: AppDefaults.padding * 0.75),
      width: double.infinity,
      // height: 100,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!Responsive.isMobile(context))
            CircleAvatar(
              radius: 20,
              backgroundColor: iconBgColor,
              child: SvgPicture.asset(
                iconSrc,
                height: 24,
                width: 24,
                colorFilter: const ColorFilter.mode(
                  AppColors.titleLight,
                  BlendMode.srcIn,
                ),
              ),
            ),
          if (!Responsive.isMobile(context)) gapW16,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                Text(
                  amount,
                  style: Responsive.isDesktop(context)
                      ? Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(fontWeight: FontWeight.bold)
                      : Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                ),
                if (Responsive.isMobile(context))
                  Column(
                    children: [
                      gapH4,
                      Chip(
                        backgroundColor: isPositiveGrowth
                            ? AppColors.success.withOpacity(0.1)
                            : AppColors.error.withOpacity(0.1),
                        side: BorderSide.none,
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppDefaults.padding * 0.25,
                            vertical: AppDefaults.padding * 0.25),
                        label: Text(
                          isPositiveGrowth
                              ? "+$growthPercentage"
                              : "-$growthPercentage",
                          style: TextStyle(
                              color: isPositiveGrowth
                                  ? AppColors.success
                                  : AppColors.error),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          if (!Responsive.isMobile(context))
            Chip(
              backgroundColor: isPositiveGrowth
                  ? AppColors.success.withOpacity(0.1)
                  : AppColors.error.withOpacity(0.1),
              side: BorderSide.none,
              padding: const EdgeInsets.symmetric(
                  horizontal: AppDefaults.padding * 0.25,
                  vertical: AppDefaults.padding * 0.25),
              label: Text(
                isPositiveGrowth ? "+$growthPercentage" : "-$growthPercentage",
                style: TextStyle(
                    color:
                        isPositiveGrowth ? AppColors.success : AppColors.error),
              ),
            ),
        ],
      ),
    );
  }
}
