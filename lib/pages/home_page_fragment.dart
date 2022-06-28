import 'package:admin/config/constants.dart';
import 'package:admin/reusable_widgets/reusable_widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePageFragment extends StatelessWidget {
  const HomePageFragment({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // AppBar
        CustomAppBar(
          leading: LeadingIcon(
            icon: Icons.logout_rounded,
            onPressed: () {},
          ),
        ),

        SizedBox(height: defaultPadding),

        // All Operation Activated
        _ActiveOperationDetails(),
        SizedBox(height: defaultPadding),

        // Donation Deaails Card
        DonationDetails(),
        SizedBox(height: defaultPadding),

        // Volunteer Details Card
        _VolunteerDetails(
          totalVolunteersNum: 350,
          totalSepcNum: 15,
        ),
        SizedBox(height: defaultPadding),
      ],
    );
  }
}

class _ActiveOperationDetails extends StatelessWidget {
  const _ActiveOperationDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tr('active_operation'),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: defaultPadding),
          Align(
            alignment: AlignmentDirectional.topCenter,
            child: SvgPicture.asset(
              "assets/icons/logo.svg",
              height: defaultPadding * 10,
            ),
          ),
          SizedBox(height: defaultPadding),
          DetailsInfoCard(
            svgSrc: "assets/icons/donation.svg",
            title: tr('donation_op'),
            leading: Text('campaign').plural(30),
          ),
          DetailsInfoCard(
            svgSrc: "assets/icons/ngo-people.svg",
            title: tr('volunteer_op'),
            leading: Text('campaign').plural(9),
          ),
          DetailsInfoCard(
            svgSrc: "assets/icons/sponsorships.svg",
            title: tr('sponsorship_op'),
            leading: Text('sponsorship').plural(12),
          ),
        ],
      ),
    );
  }
}

class _VolunteerDetails extends StatelessWidget {
  const _VolunteerDetails({
    Key? key,
    required this.totalVolunteersNum,
    required this.totalSepcNum,
  }) : super(key: key);

  final int totalVolunteersNum;
  final int totalSepcNum;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tr('volunteer_details'),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: defaultPadding),
          Align(
            alignment: AlignmentDirectional.topCenter,
            child: SvgPicture.asset(
              "assets/images/volunteer.svg",
              height: defaultPadding * 10,
            ),
          ),
          SizedBox(height: defaultPadding),
          DetailsInfoCard(
            title: tr('tot_vol_count'),
            svgSrc: 'assets/icons/menu_profile.svg',
            leading: Text('volunteer_person').plural(totalVolunteersNum),
          ),
          DetailsInfoCard(
            title: tr('tot_vol_spe'),
            svgSrc: 'assets/icons/menu_doc.svg',
            leading: Text('specializations').plural(totalSepcNum),
          ),
        ],
      ),
    );
  }
}
