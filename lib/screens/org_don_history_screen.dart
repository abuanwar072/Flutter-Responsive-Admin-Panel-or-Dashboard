import 'package:admin/config/constants.dart';
import 'package:admin/config/helper.dart';
import 'package:admin/models/models.dart';
import 'package:admin/widgets/data_card.dart';
import 'package:admin/widgets/information_row.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jiffy/jiffy.dart';

class OrganizationDonationHistoryScreen extends StatelessWidget {
  const OrganizationDonationHistoryScreen({Key? key}) : super(key: key);

  static String routeName() => '/org_don_history';

  @override
  Widget build(BuildContext context) {
    final organization =
        ModalRoute.of(context)!.settings.arguments as SupportiveOrganization;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          (Helper.isLocaleArabic(context)
              ? organization.nameAr
              : organization.nameEn)!,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        elevation: 0,
        backgroundColor: bgColor,

        // Back Button
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          splashRadius: 20,
        ),
      ),
      body: organization.donationOperations!.isEmpty
          ? const _NoOperationsRegistered()
          : ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(defaultPadding),
              itemCount: organization.donationOperations!.length,
              itemBuilder: (context, index) {
                return _OrganizationDonationCard(
                  orgDonationOperation: organization.donationOperations![index],
                );
              },
            ),
    );
  }
}

class _NoOperationsRegistered extends StatelessWidget {
  const _NoOperationsRegistered({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            'assets/images/donation_operation.svg',
            width: MediaQuery.of(context).size.width * 0.6,
          ),
          Text(
            tr('no_donation_operations'),
            style: const TextStyle(color: primaryColor),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _OrganizationDonationCard extends StatelessWidget {
  const _OrganizationDonationCard({
    Key? key,
    required this.orgDonationOperation,
  }) : super(key: key);

  final DonationOperation orgDonationOperation;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: defaultPadding),
      child: Column(
        children: [
          DataCard(
            bgColor: primaryColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: InformationRow(
              leadingColor: secondaryColor,
              leading: tr('donation_id'),
              trailing: orgDonationOperation.id.toString(),
            ),
          ),
          DataCard(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            child: Column(
              children: [
                const SizedBox(height: defaultPadding * 0.5),
                InformationRow(
                  leading: tr('paid_amount'),
                  trailing: plural(
                    'donations',
                    orgDonationOperation.paidAmount!,
                  ),
                ),
                const SizedBox(height: defaultPadding * 0.5),
                InformationRow(
                  leading: tr('payment_method'),
                  trailing: tr('${orgDonationOperation.paymentMethodKey}'),
                ),
                const SizedBox(height: defaultPadding * 0.5),
                InformationRow(
                  leading: tr('donation_date'),
                  isTrailingReversed: true,
                  trailing: Jiffy(orgDonationOperation.paymentDate!).fromNow(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
