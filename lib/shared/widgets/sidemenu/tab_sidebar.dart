import 'package:core_dashboard/shared/constants/config.dart';
import 'package:core_dashboard/shared/constants/defaults.dart';
import 'package:core_dashboard/shared/constants/ghaps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'icon_tile.dart';
import 'theme_icon_tile.dart';

class TabSidebar extends StatelessWidget {
  const TabSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 96,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppDefaults.padding,
                vertical: AppDefaults.padding * 1.5),
            child: SvgPicture.asset(AppConfig.logo),
          ),
          gapH16,
          Expanded(
            child: SizedBox(
              width: 48,
              child: ListView(
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconTile(
                    isActive: true,
                    activeIconSrc: "assets/icons/home_filled.svg",
                    inactiveIconSrc: "assets/icons/home_light.svg",
                    onPressed: () {},
                  ),
                  gapH4,
                  IconTile(
                    isActive: false,
                    activeIconSrc: "assets/icons/diamond_filled.svg",
                    inactiveIconSrc: "assets/icons/diamond_light.svg",
                    onPressed: () {},
                  ),
                  gapH4,
                  IconTile(
                    isActive: false,
                    activeIconSrc: "assets/icons/profile_circled_filled.svg",
                    inactiveIconSrc: "assets/icons/profile_circled_light.svg",
                    onPressed: () {},
                  ),
                  gapH4,
                  IconTile(
                    isActive: false,
                    activeIconSrc: "assets/icons/store_light.svg",
                    inactiveIconSrc: "assets/icons/store_filled.svg",
                    onPressed: () {},
                  ),
                  gapH4,
                  IconTile(
                    isActive: false,
                    activeIconSrc: "assets/icons/pie_chart_filled.svg",
                    inactiveIconSrc: "assets/icons/pie_chart_light.svg",
                    onPressed: () {},
                  ),
                  gapH4,
                  IconTile(
                    isActive: false,
                    activeIconSrc: "assets/icons/promotion_filled.svg",
                    inactiveIconSrc: "assets/icons/promotion_light.svg",
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              IconTile(
                isActive: false,
                activeIconSrc: "assets/icons/arrow_forward_light.svg",
                onPressed: () {},
              ),
              const SizedBox(
                width: 48,
                child: Divider(thickness: 2),
              ),
              gapH4,
              IconTile(
                isActive: false,
                activeIconSrc: "assets/icons/help_light.svg",
                onPressed: () {},
              ),
              gapH4,
              ThemeIconTile(
                isDark: false,
                onPressed: () {},
              ),
              gapH16,
            ],
          )
        ],
      ),
    );
  }
}
