import 'package:admin/config/constants.dart';
import 'package:admin/models/donation_campaign.dart';
import 'package:admin/models/donation_operation.dart';
import 'package:admin/widgets/donation_operation_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DonationOperationsScreen extends StatelessWidget {
  const DonationOperationsScreen({Key? key}) : super(key: key);

  static String routeName() => '/donation_operations_screen';

  @override
  Widget build(BuildContext context) {
    final campaign =
        ModalRoute.of(context)!.settings.arguments as DonationCampaign;
    List<DonationOperation> sortedDonationOperations =
        campaign.donationOperations!.toList()
          ..sort((a, b) => b.paymentDate!.compareTo(a.paymentDate!));
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'camp_don',
          style: Theme.of(context).textTheme.titleMedium,
        ).tr(),
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
      body: campaign.donationOperations!.isEmpty
          ? const _NoOperationsRegistered()
          : ListView.builder(
              padding: const EdgeInsets.all(defaultPadding),
              physics: const BouncingScrollPhysics(),
              itemCount: sortedDonationOperations.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: defaultPadding * 0.5),
                  child: DonationCard(
                    donationOperation: sortedDonationOperations[index],
                  ),
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
            'assets/images/donate.svg',
            width: MediaQuery.of(context).size.width * 0.6,
          ),
          Text(
            tr('no_don_op_for_camp'),
            style: const TextStyle(color: primaryColor),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
