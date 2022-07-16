import 'package:admin/config/constants.dart';
import 'package:admin/controllers/donation_campaigns/donation_campaigns_bloc.dart';
import 'package:admin/controllers/mixins/dialog_provider.dart';
import 'package:admin/models/donation_campaign.dart';
import 'package:admin/screens/screens.dart';
import 'package:admin/widgets/widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompletedDonCampsScreen extends StatelessWidget with DialogProvider {
  CompletedDonCampsScreen({Key? key}) : super(key: key);

  static String routeName() => '/completed_don_camps_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          tr('completed_camps'),
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
            final completedCampaigns = state.donationCampaigns
                .where((element) =>
                    element.status != DonationCampaignStatus.active)
                .toList();
            if (completedCampaigns.isEmpty) {
              return NoDataWidget(
                onRefreshPressed: () {
                  context
                      .read<DonationCampaignsBloc>()
                      .add(GetDonationCampaigns());
                },
                message: tr('no_comp_or_cancelled_camps'),
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
                itemCount: completedCampaigns.length,
                itemBuilder: (context, index) {
                  return DonationCampaignCard(
                    donationCampaign: completedCampaigns[index],
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        DonationOperationsScreen.routeName(),
                        arguments: completedCampaigns[index],
                      );
                    },
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
