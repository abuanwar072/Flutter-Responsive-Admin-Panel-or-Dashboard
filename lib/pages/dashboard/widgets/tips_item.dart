import 'package:core_dashboard/shared/constants/defaults.dart';
import 'package:core_dashboard/shared/constants/ghaps.dart';
import 'package:core_dashboard/shared/widgets/avatar/customer_rounded_avatar.dart';
import 'package:core_dashboard/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TipsItem extends StatelessWidget {
  const TipsItem({
    super.key,
    this.height = 64,
    this.width = 64,
    this.backgroundColor,
    required this.title,
    required this.time,
    required this.iconSrc,
    this.tagStatus = 'New',
    this.tagColor = AppColors.secondaryLavender,
  });

  final double height, width;
  final Color? backgroundColor, tagColor;
  final String title, time, iconSrc;
  final String tagStatus;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              fixedSize: Size(height, width),
              shape: const CircleBorder(),
              backgroundColor: backgroundColor,
            ),
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
          gapW8,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Theme.of(context).textTheme.titleLarge!.color,
                  fontWeight: FontWeight.w600,
                ),
              ),
              gapH8,
              Row(
                children: [
                  Chip(
                    backgroundColor: tagColor,
                    side: BorderSide.none,
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppDefaults.padding * 0.25,
                        vertical: AppDefaults.padding * 0.125),
                    label: Text(
                      tagStatus,
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).textTheme.titleSmall?.color),
                    ),
                  ),
                  gapW4,
                  Container(
                    padding: const EdgeInsets.all(AppDefaults.padding * 0.125),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        AppDefaults.borderRadius * 0.5,
                      ),
                      border: Border.all(
                        color: AppColors.highlightLight,
                      ),
                    ),
                    child: Row(
                      children: [
                        const CustomerRoundedAvatar(
                          height: 20,
                          width: 20,
                          radius: AppDefaults.borderRadius * 0.25,
                          imageSrc:
                              'https://t4.ftcdn.net/jpg/03/83/25/83/360_F_383258331_D8imaEMl8Q3lf7EKU2Pi78Cn0R7KkW9o.jpg',
                        ),
                        gapW8,
                        Text(time),
                        gapW8,
                      ],
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
