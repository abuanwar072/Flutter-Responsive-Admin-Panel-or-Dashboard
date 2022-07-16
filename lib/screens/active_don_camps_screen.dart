import 'package:admin/config/constants.dart';
import 'package:admin/controllers/donation_campaigns/donation_campaigns_bloc.dart';
import 'package:admin/controllers/mixins/dialog_provider.dart';
import 'package:admin/models/donation_campaign.dart';
import 'package:admin/screens/screens.dart';
import 'package:admin/widgets/widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActiveDonCampsScreen extends StatelessWidget with DialogProvider {
  ActiveDonCampsScreen({Key? key}) : super(key: key);

  static String routeName() => '/active_don_camps_screen';

  // SHOW DELETE CONFIRMATION DIALOGUE
  Future<bool> _showDeleteWarningDialogue(context) async {
    return await showDialog(
          // show confirm dialogue
          // the return value will be from "Yes" or "No" options
          context: context,
          builder: (context) => AlertDialog(
            title: const Text(
              'warning',
              style: TextStyle(color: Colors.red),
            ).tr(),
            content: Text(
              'cancel_don_camp_warning',
              style: Theme.of(context).textTheme.bodyMedium,
            ).tr(),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                style: ButtonStyle(
                  overlayColor: MaterialStateColor.resolveWith(
                    (states) => Colors.red.withOpacity(0.1),
                  ),
                ),
                //return false when click on "NO"
                child: Text('no', style: Theme.of(context).textTheme.bodyLarge)
                    .tr(),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                style: ButtonStyle(
                  overlayColor: MaterialStateColor.resolveWith(
                    (states) => primaryColor.withOpacity(0.1),
                  ),
                ),
                //return true when click on "Yes"
                child: Text('yes', style: Theme.of(context).textTheme.bodyLarge)
                    .tr(),
              ),
            ],
          ),
        ) ??
        false; // if showDialogue had returned null, then return false
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          tr('active_camps'),
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
        actions: const [],
      ),
      body: BlocConsumer<DonationCampaignsBloc, DonationCampaignsState>(
        listener: (context, state) {
          if (state is DonationCampaignsLoading) {
            showLoadingDialoge(context);
          } else {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          if (state is DonationCampaignsLoading) {
            return const SizedBox();
          }
          if (state is DonationCampaignsError) {
            return UnexpectedErrorWidget(
              onRetryPressed: () {
                context
                    .read<DonationCampaignsBloc>()
                    .add(GetDonationCampaigns());
              },
            );
          }
          if (state is DonationCampaignsLoaded) {
            final activeDonationCampaigns = state.donationCampaigns
                .where((element) =>
                    element.status == DonationCampaignStatus.active)
                .toList();
            if (activeDonationCampaigns.isEmpty) {
              return NoDataWidget(
                onRefreshPressed: () {
                  context
                      .read<DonationCampaignsBloc>()
                      .add(GetDonationCampaigns());
                },
                message: tr('no_active_camps'),
              );
            }
            return RefreshIndicator(
              triggerMode: RefreshIndicatorTriggerMode.anywhere,
              color: primaryColor,
              onRefresh: () async {
                BlocProvider.of<DonationCampaignsBloc>(context)
                    .add(GetDonationCampaigns());
              },
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(
                  defaultPadding,
                  defaultPadding,
                  defaultPadding,
                  0,
                ),
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: activeDonationCampaigns.length,
                itemBuilder: (context, index) {
                  return DonationCampaignCard(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, DonationOperationsScreen.routeName(),
                          arguments: activeDonationCampaigns[index]);
                    },
                    onLongPress: () async {
                      if (await _showDeleteWarningDialogue(context)) {
                        // IF PRESSED YES, CANCEL THE CAMPAIGN
                        if (kDebugMode) print('cancelled');
                        context
                            .read<DonationCampaignsBloc>()
                            .add(CancelDonationCampaign(
                              activeDonationCampaigns[index],
                            ));
                      } else {
                        // IF PRESSED NO, DO NOTHING
                        if (kDebugMode) print('not cancelled');
                      }
                    },
                    donationCampaign: state.donationCampaigns
                        .where((element) =>
                            element.status == DonationCampaignStatus.active)
                        .toList()[index],
                  );
                },
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
