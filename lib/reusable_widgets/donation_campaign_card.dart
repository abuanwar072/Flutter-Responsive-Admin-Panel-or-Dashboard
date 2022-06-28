import 'package:admin/config/constants.dart';
import 'package:admin/models/models.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class DonationCampaignCard extends StatelessWidget {
  const DonationCampaignCard({
    Key? key,
    required this.donationCampaign,
  }) : super(key: key);
  final DonationCampaign donationCampaign;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
      margin: EdgeInsets.only(bottom: defaultPadding * .75),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 1),
            blurRadius: 3,
            spreadRadius: 1,
            color: Colors.black12,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            child: CachedNetworkImage(
              imageUrl: donationCampaign.coverImageUrl!,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * (0.4 * 0.6),
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(defaultPadding * 0.75),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      context.locale == Locale('ar')
                          ? donationCampaign.titleAr!
                          : donationCampaign.titleEn!,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: primaryColor),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: 25,
                      decoration: BoxDecoration(
                        color: (donationCampaign.status ==
                                    DonationCampaignStatus.active
                                ? primaryColor
                                : donationCampaign.status ==
                                        DonationCampaignStatus.completed
                                    ? Colors.blue.shade800
                                    : Colors.red.shade800)
                            .withOpacity(0.5)
                            .withAlpha(50),
                        borderRadius: BorderRadius.circular(45),
                      ),
                      padding: EdgeInsets.only(top: 4),
                      alignment: Alignment.center,
                      child: Text(
                        donationCampaign.status == DonationCampaignStatus.active
                            ? tr('active')
                            : donationCampaign.status ==
                                    DonationCampaignStatus.completed
                                ? tr('completed')
                                : tr('cancelled'),
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(
                                color: donationCampaign.status ==
                                        DonationCampaignStatus.active
                                    ? primaryColor
                                    : donationCampaign.status ==
                                            DonationCampaignStatus.completed
                                        ? Colors.blue.shade900
                                        : Colors.red.shade900),
                      ),
                    )
                  ],
                ),
                SizedBox(height: defaultPadding * 0.5),
                _InfoRow(
                  trailing: plural('donations', donationCampaign.targetAmount!),
                  leading: tr('target_don_amount'),
                ),
                SizedBox(height: defaultPadding * 0.25),
                _InfoRow(
                  trailing:
                      plural('donations', donationCampaign.collectedAmount!),
                  leading: tr('collected_don'),
                ),
                SizedBox(height: defaultPadding * 0.25),
                _InfoRow(
                  trailing: donationCampaign.numberOfBeneficiaries.toString(),
                  leading: tr('num_of_ben'),
                ),
                SizedBox(height: defaultPadding * 0.25),
                _InfoRow(
                  trailing: DateFormat(
                    context.locale == Locale('ar')
                        ? 'HH:mm - yyyy/MM/dd'
                        : 'yyyy/MM/dd - HH:mm ',
                  ).format(donationCampaign.startDate!),
                  leading: tr('don_camp_start_date'),
                ),
                SizedBox(height: defaultPadding * 0.25),
                _InfoRow(
                  trailing: DateFormat(
                    context.locale == Locale('ar')
                        ? 'HH:mm - yyyy/MM/dd'
                        : 'yyyy/MM/dd - HH:mm ',
                  ).format(donationCampaign.endDate!),
                  leading: tr('don_camp_end_date'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    Key? key,
    required this.leading,
    required this.trailing,
    this.leadingColor,
  }) : super(key: key);

  final String leading;
  final String trailing;
  final Color? leadingColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          leading,
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: leadingColor),
        ),
        Text(
          trailing,
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: (leadingColor ?? Colors.grey).withOpacity(0.9)),
        ),
      ],
    );
  }
}