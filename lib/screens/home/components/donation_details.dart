import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';
import 'chart.dart';

class DonationDetails extends StatelessWidget {
  const DonationDetails({
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
            tr('donation_details'),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: defaultPadding),
          Chart(),
          _DonationInfoCard(
            svgSrc: "assets/icons/health.svg",
            title: tr('medical'),
            amountOfDonations: 0.2,
            numOfFiles: 1328,
          ),
          _DonationInfoCard(
            svgSrc: "assets/icons/education.svg",
            title: tr('educational'),
            amountOfDonations: 15.3,
            numOfFiles: 1328,
          ),
          _DonationInfoCard(
            svgSrc: "assets/icons/entertainment.svg",
            title: tr('entertainment'),
            amountOfDonations: 5.7,
            numOfFiles: 1328,
          ),
          _DonationInfoCard(
            svgSrc: "assets/icons/other.svg",
            title: tr('other'),
            amountOfDonations: 1.3,
            numOfFiles: 140,
          ),
        ],
      ),
    );
  }
}

class _DonationInfoCard extends StatelessWidget {
  const _DonationInfoCard({
    Key? key,
    required this.title,
    required this.svgSrc,
    required this.amountOfDonations,
    required this.numOfFiles,
  }) : super(key: key);

  final String title, svgSrc;
  final int numOfFiles;
  final double amountOfDonations;

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
            child: SvgPicture.asset(svgSrc),
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
                  Text(
                    'donator'.plural(numOfFiles),
                    style: Theme.of(context)
                        .textTheme
                        .caption!
                        .copyWith(color: Colors.black45),
                  ),
                ],
              ),
            ),
          ),
          Text('amount').plural(amountOfDonations)
        ],
      ),
    );
  }
}
