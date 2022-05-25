import 'package:admin/constants.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/home/components/donation_details.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
              // if (Responsive.isMobile(context))
              _ActiveOperationDetails(),
              SizedBox(height: defaultPadding),
              DonationDetails(),
              SizedBox(height: defaultPadding),
              _VolunteerDetails(
                totalVolunteersNum: 350,
                totalSepcNum: 15,
              ),
            ],
          ),
        ),
        // if (!Responsive.isMobile(context)) SizedBox(width: defaultPadding),
        // // On Mobile means if the screen is less than 850 we dont want to show it
        // if (!Responsive.isMobile(context))
        //   Expanded(
        //     flex: 2,
        //     child: DonationDetails(),
        //   ),
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
          _DetailsInfoCard(
            svgSrc: "assets/icons/donation.svg",
            title: tr('donation_op'),
            leading: Text('campaign').plural(30),
          ),
          _DetailsInfoCard(
            svgSrc: "assets/icons/ngo-people.svg",
            title: tr('volunteer_op'),
            leading: Text('campaign').plural(9),
          ),
          _DetailsInfoCard(
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
              "assets/icons/ngo-people.svg",
              height: defaultPadding * 7,
            ),
          ),
          SizedBox(height: defaultPadding),
          _DetailsInfoCard(
            title: tr('tot_vol_count'),
            svgSrc: 'assets/icons/menu_profile.svg',
            leading: Text('volunteer_person').plural(totalVolunteersNum),
          ),
          _DetailsInfoCard(
            title: tr('tot_vol_spe'),
            svgSrc: 'assets/icons/menu_doc.svg',
            leading: Text('specializations').plural(totalSepcNum),
          ),
        ],
      ),
    );
  }
}

class _DetailsInfoCard extends StatelessWidget {
  const _DetailsInfoCard({
    Key? key,
    this.subtitle,
    required this.title,
    required this.svgSrc,
    required this.leading,
  }) : super(key: key);

  final String title, svgSrc;
  final num? subtitle;
  final Widget leading;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: defaultPadding),
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: primaryColor.withOpacity(0.15)),
        borderRadius: const BorderRadius.all(
          Radius.circular(defaultPadding),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            height: 20,
            width: 20,
            child: SvgPicture.asset(
              svgSrc,
              color: primaryColor,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (subtitle != null)
                    Text(
                      'donator'.plural(subtitle!),
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(color: Colors.black45),
                    ),
                ],
              ),
            ),
          ),
          leading,
        ],
      ),
    );
  }
}
