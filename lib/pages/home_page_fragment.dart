import 'package:admin/constants.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/home/components/donation_details.dart';
import 'package:flutter/material.dart';

class HomePageFragment extends StatelessWidget {
  const HomePageFragment({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 5,
          child: Column(
            children: [
              // MyFiles(),
              // SizedBox(height: defaultPadding),
              // RecentFiles(),
              if (Responsive.isMobile(context))
                SizedBox(height: defaultPadding),
              if (Responsive.isMobile(context)) DonationDetails(),
            ],
          ),
        ),
        if (!Responsive.isMobile(context)) SizedBox(width: defaultPadding),
        // On Mobile means if the screen is less than 850 we dont want to show it
        if (!Responsive.isMobile(context))
          Expanded(
            flex: 2,
            child: DonationDetails(),
          ),
      ],
    );
  }
}
