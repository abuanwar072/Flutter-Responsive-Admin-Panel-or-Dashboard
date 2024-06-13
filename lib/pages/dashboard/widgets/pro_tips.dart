import 'package:core_dashboard/pages/dashboard/widgets/tips_item.dart';
import 'package:core_dashboard/responsive.dart';
import 'package:core_dashboard/shared/constants/defaults.dart';
import 'package:core_dashboard/shared/constants/ghaps.dart';
import 'package:core_dashboard/shared/widgets/section_title.dart';
import 'package:core_dashboard/theme/app_colors.dart';
import 'package:flutter/material.dart';

final List<TipsItem> proTipsDummyData = [
  const TipsItem(
    title: 'Early access',
    time: '3 mins read',
    iconSrc: 'assets/icons/schedule_light.svg',
  ),
  const TipsItem(
    title: 'Asset use guidelines',
    time: 'Time',
    iconSrc: 'assets/icons/arrow_forward_light.svg',
    backgroundColor: AppColors.highlightLight,
  ),
  const TipsItem(
    title: 'Exclusive downloads',
    time: '2 mins read',
    iconSrc: 'assets/icons/design_light.svg',
  ),
  const TipsItem(
    title: 'Behind the scenes',
    time: '3 mins read',
    iconSrc: 'assets/icons/video_recorder_light.svg',
  ),
  const TipsItem(
    title: 'Asset use guidelines',
    time: '1 mins read',
    iconSrc: 'assets/icons/phone_call_incoming_light.svg',
  ),
  const TipsItem(
    title: 'Life & work updates',
    time: '3 mins read',
    iconSrc: 'assets/icons/multiselect_light.svg',
  ),
];

class ProTips extends StatelessWidget {
  const ProTips({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDefaults.padding),
      decoration: const BoxDecoration(
        color: AppColors.bgSecondayLight,
        borderRadius: BorderRadius.all(
          Radius.circular(AppDefaults.borderRadius),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          gapH8,
          const SectionTitle(
            title: "Pro tips",
            color: AppColors.secondaryMintGreen,
          ),
          gapH20,
          Text(
            'Need some ideas for the next product?',
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyMedium?.color,
            ),
          ),
          gapH20,
          GridView.builder(
            itemCount: proTipsDummyData.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: Responsive.isMobile(context) ? 560 : 410,
              mainAxisExtent: 80,
              crossAxisSpacing: AppDefaults.padding,
              mainAxisSpacing: AppDefaults.padding,
            ),
            itemBuilder: (context, index) => proTipsDummyData[index],
          ),
        ],
      ),
    );
  }
}
