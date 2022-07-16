import 'package:admin/config/constants.dart';
import 'package:admin/config/helper.dart';
import 'package:admin/controllers/mixins/dialog_provider.dart';
import 'package:admin/controllers/supportive_organizations/supportive_organizations_bloc.dart';
import 'package:admin/models/supportive_organization.dart';
import 'package:admin/screens/screens.dart';
import 'package:admin/widgets/widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SupportiveOraganizationsScreen extends StatelessWidget
    with DialogProvider {
  SupportiveOraganizationsScreen({Key? key}) : super(key: key);

  static String routeName() => '/supportive_organizations_screen';

  final ValueNotifier<bool> isLoadingDialogVisible = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          tr('sup_orgs'),
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
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add_circle_outline_rounded,
              color: Colors.black,
            ),
            splashRadius: 20,
            onPressed: () {
              Navigator.pushNamed(
                  context, AddSupportiveOrganizationScreen.routeName());
            },
          ),
        ],
      ),
      body: BlocConsumer<SupportiveOrganizationsBloc,
          SupportiveOrganizationsState>(
        listener: (context, state) {
          Helper.logger.e('SupportiveOrganizationsScreen: $state');

          if (state is SupportiveOrganizationsLoading) {
            showLoadingDialoge(context);
            isLoadingDialogVisible.value = true;
          } else if (state is SupportiveOrganizationsLoaded) {
            if (isLoadingDialogVisible.value) {
              Navigator.pop(context);
              isLoadingDialogVisible.value = false;
            }
          }
        },
        builder: (context, state) {
          if (state is SupportiveOrganizationsError) {
            return UnexpectedErrorWidget(
              onRetryPressed: () {
                context
                    .read<SupportiveOrganizationsBloc>()
                    .add(GetSupportiveOrganizations());
              },
            );
          }
          if (state is SupportiveOrganizationsLoaded) {
            // SORT BY TOTAL CONTRIBUTIONS
            List<SupportiveOrganization> sortedList = state.organizations
                .toList()
              ..sort((a, b) {
                return b.totalContributions!.compareTo(a.totalContributions!);
              });
            if (state.organizations.isEmpty) {
              return NoDataWidget(
                onRefreshPressed: () {
                  context
                      .read<SupportiveOrganizationsBloc>()
                      .add(GetSupportiveOrganizations());
                },
                message: tr('no_sup_orgs'),
              );
            }
            return RefreshIndicator(
              triggerMode: RefreshIndicatorTriggerMode.anywhere,
              color: primaryColor,
              onRefresh: () async {
                context
                    .read<SupportiveOrganizationsBloc>()
                    .add(GetSupportiveOrganizations());
              },
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(defaultPadding),
                itemCount: sortedList.length,
                itemBuilder: (context, index) {
                  return SupportiveOrganizationCard(
                    organization: sortedList[index],
                    onPressed: () {
                      // GO TO DONATION OPERATIONS SCREEN
                      Navigator.pushNamed(
                        context,
                        OrganizationDonationHistoryScreen.routeName(),
                        arguments: sortedList[index],
                      );
                    },
                  );
                },
              ),
            );
          }
          return ValueListenableBuilder<bool>(
            valueListenable: isLoadingDialogVisible,
            builder: (context, value, child) {
              if (!value && state is SupportiveOrganizationsLoading) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircularProgressIndicator(
                        color: primaryColor,
                      ),
                      const SizedBox(height: defaultPadding),
                      Text(
                        tr('loading'),
                        style: const TextStyle(color: primaryColor),
                      ),
                    ],
                  ),
                );
              }

              return Container();
            },
          );
        },
      ),
    );
  }
}
