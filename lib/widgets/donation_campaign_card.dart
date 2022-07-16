import 'package:admin/config/constants.dart';
import 'package:admin/config/helper.dart';
import 'package:admin/models/models.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DonationCampaignCard extends StatelessWidget {
  const DonationCampaignCard({
    Key? key,
    required this.donationCampaign,
    this.onLongPress,
    required this.onPressed,
  }) : super(key: key);
  final DonationCampaign donationCampaign;
  final VoidCallback? onLongPress;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: defaultPadding * 0.75),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onLongPress: onLongPress,
        onTap: onPressed,
        child: Ink(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
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
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                child: CachedNetworkImage(
                  errorWidget: (context, url, error) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            'assets/images/image_place_holder.svg',
                            height: MediaQuery.of(context).size.height *
                                (0.4 * 0.3),
                          ),
                          Text(
                            tr('failed_to_load_image'),
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: primaryColor.withOpacity(0.6)),
                          ),
                        ],
                      ),
                    );
                  },
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
                        Flexible(
                          child: Row(
                            children: [
                              Text(
                                context.locale == const Locale('ar')
                                    ? donationCampaign.titleAr!
                                    : donationCampaign.titleEn!,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                        color: donationCampaign.status ==
                                                DonationCampaignStatus.completed
                                            ? Colors.blue.shade800
                                            : donationCampaign.status ==
                                                    DonationCampaignStatus
                                                        .cancelled
                                                ? Colors.red.shade800
                                                : primaryColor),
                              ),
                              if (donationCampaign.status ==
                                  DonationCampaignStatus.cancelled) ...[
                                const SizedBox(width: defaultPadding * 0.5),
                                Icon(
                                  Icons.gpp_bad_outlined,
                                  color: Colors.red.shade800,
                                  size: 18,
                                ),
                              ] else if (donationCampaign.status ==
                                  DonationCampaignStatus.completed) ...[
                                const SizedBox(width: defaultPadding * 0.5),
                                Icon(
                                  Icons.verified_user_outlined,
                                  color: Colors.blue.shade800,
                                  size: 18,
                                ),
                              ]
                            ],
                          ),
                        ),
                        const SizedBox(width: defaultPadding * 0.5),
                        Container(
                          height: 25,
                          padding: const EdgeInsets.symmetric(
                            horizontal: defaultPadding,
                          ),
                          decoration: BoxDecoration(
                            color: _getTypeColor(Helper.typesOfCampaigns
                                    .where((element) =>
                                        element.typeId ==
                                        donationCampaign.typeOfCampaignId!)
                                    .first
                                    .typeId)
                                .withOpacity(0.5)
                                .withAlpha(50),
                            borderRadius: BorderRadius.circular(45),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            Helper.isLocaleArabic(context)
                                ? Helper.typesOfCampaigns
                                    .where((element) =>
                                        element.typeId ==
                                        donationCampaign.typeOfCampaignId!)
                                    .first
                                    .typeNameAr
                                : Helper.typesOfCampaigns
                                    .where((element) =>
                                        element.typeId ==
                                        donationCampaign.typeOfCampaignId!)
                                    .first
                                    .typeNameEn,
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                  color: _getTypeColor(Helper.typesOfCampaigns
                                      .where((element) =>
                                          element.typeId ==
                                          donationCampaign.typeOfCampaignId!)
                                      .first
                                      .typeId),
                                ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: defaultPadding * 0.5),
                    _InfoRow(
                      trailing:
                          plural('donations', donationCampaign.targetAmount!),
                      leading: tr('target_don_amount'),
                    ),
                    const SizedBox(height: defaultPadding * 0.25),
                    _InfoRow(
                      trailing: plural(
                          'donations', donationCampaign.collectedAmount!),
                      leading: tr('collected_don'),
                    ),
                    const SizedBox(height: defaultPadding * 0.25),
                    _InfoRow(
                      trailing:
                          donationCampaign.numberOfBeneficiaries.toString(),
                      leading: tr('num_of_ben'),
                    ),
                    const SizedBox(height: defaultPadding * 0.25),
                    _InfoRow(
                      trailing: DateFormat(
                        Helper.isLocaleArabic(context)
                            ? 'HH:mm - yyyy/MM/dd'
                            : 'yyyy/MM/dd - HH:mm ',
                      ).format(donationCampaign.startDate!),
                      leading: tr('don_camp_start_date'),
                    ),
                    const SizedBox(height: defaultPadding * 0.25),
                    if (donationCampaign.endDate != null)
                      _InfoRow(
                        trailing: DateFormat(
                          Helper.isLocaleArabic(context)
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
        ),
      ),
    );
  }

  // HELPER METHOD TO GET COLOR OF TYPE ACCORDING TO TYPE ID
  _getTypeColor(int typeId) {
    switch (typeId) {
      case 1:
        return Colors.red.shade800;
      case 2:
        return Colors.blue.shade800;
      case 3:
        return Colors.yellow.shade900;
      case 4:
        return Colors.green.shade800;
      default:
        return Colors.black;
    }
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
