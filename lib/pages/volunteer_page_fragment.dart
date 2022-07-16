import 'package:admin/config/constants.dart';
import 'package:admin/widgets/widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VolunteerPageFragment extends StatelessWidget {
  const VolunteerPageFragment({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.9,
      child: Column(
        children: [
          const CustomAppBar(
            leading: LeadingIcon(
              isHidden: true,
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/images/under_construction.svg',
                  width: MediaQuery.of(context).size.width * 0.6,
                ),
                const SizedBox(
                  height: defaultPadding,
                ),
                const Text('page_under_cons').tr(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
