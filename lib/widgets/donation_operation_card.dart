import 'package:admin/config/constants.dart';
import 'package:admin/config/helper.dart';
import 'package:admin/controllers/supportive_organizations/supportive_organizations_bloc.dart';
import 'package:admin/models/models.dart';
import 'package:admin/widgets/data_card.dart';
import 'package:admin/widgets/information_row.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';

class DonationCard extends StatelessWidget {
  const DonationCard({
    Key? key,
    required this.donationOperation,
  }) : super(key: key);
  final DonationOperation donationOperation;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: defaultPadding * 0.5),
      child: Column(
        children: [
          DataCard(
            bgColor: primaryColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: InformationRow(
              leading: tr('donation_id'),
              trailing: donationOperation.id!.toString(),
              leadingColor: secondaryColor,
            ),
          ),
          DataCard(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: BlocBuilder<SupportiveOrganizationsBloc,
                          SupportiveOrganizationsState>(
                        builder: (context, state) {
                          if (state is SupportiveOrganizationsLoaded) {
                            return Text(
                              donationOperation.donorName == 'Organization'
                                  ? (Helper.isLocaleArabic(context)
                                      ? state.organizations
                                          .where((element) =>
                                              element.id ==
                                              donationOperation.idSupOrg)
                                          .first
                                          .nameAr
                                      : state.organizations
                                          .where((element) =>
                                              element.id ==
                                              donationOperation.idSupOrg)
                                          .first
                                          .nameEn)!
                                  : donationOperation.donorName,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(color: primaryColor),
                            );
                          }
                          return Text(
                            tr('loading'),
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: primaryColor),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: defaultPadding * 0.5),
                    Container(
                      height: 25,
                      padding: const EdgeInsets.symmetric(
                          horizontal: defaultPadding),
                      decoration: BoxDecoration(
                        color: _getDonatorColor(donationOperation.donatorType!)
                            .withOpacity(0.5)
                            .withAlpha(50),
                        borderRadius: BorderRadius.circular(45),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        _getDonatorTypeName(donationOperation.donatorType!),
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(
                                color: _getDonatorColor(
                                    donationOperation.donatorType!)),
                      ).tr(),
                    )
                  ],
                ),
                const SizedBox(height: defaultPadding * 0.5),
                InformationRow(
                  leading: tr('paid_amount'),
                  trailing: plural(
                    'donations',
                    donationOperation.paidAmount!,
                  ),
                ),
                const SizedBox(height: defaultPadding * 0.5),
                InformationRow(
                  leading: tr('payment_method'),
                  trailing: tr('${donationOperation.paymentMethodKey}'),
                ),
                const SizedBox(height: defaultPadding * 0.5),
                InformationRow(
                  leading: tr('donation_date'),
                  isTrailingReversed: true,
                  trailing: Jiffy(donationOperation.paymentDate!).fromNow(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _getDonatorColor(DonorType type) {
    switch (type) {
      case DonorType.person:
        return Colors.blue.shade900;
      case DonorType.organization:
        return primaryColor;
      default:
        return Colors.black;
    }
  }

  _getDonatorTypeName(DonorType type) {
    switch (type) {
      case DonorType.person:
        return 'person';
      case DonorType.organization:
        return 'organization';
      default:
        return 'person';
    }
  }
}
