import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../../constants.dart';

class StorageInfoCard extends StatelessWidget {
  const StorageInfoCard({
    Key? key,
    required this.title,
    required this.svgSrc,
    required this.totalAmountUSD,
    required this.numOfFiles,
  }) : super(key: key);

  final String title, svgSrc;
  final double totalAmountUSD;
  final int numOfFiles;

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
                    "$numOfFiles Donations",
                    style: Theme.of(context).textTheme.caption!.copyWith(color: Colors.white70),
                  ),
                ],
              ),
            ),
          ),
          Text(NumberFormat.simpleCurrency(name: 'USD', decimalDigits: 2).format(totalAmountUSD))
        ],
      ),
    );
  }
}
