import 'package:admin/config/constants.dart';
import 'package:admin/config/helper.dart';
import 'package:admin/controllers/donation_operations/donation_operations_bloc.dart';
import 'package:admin/controllers/supportive_organizations/supportive_organizations_bloc.dart';
import 'package:admin/models/models.dart';
import 'package:admin/screens/screens.dart';
import 'package:admin/widgets/widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DonationPageFragment extends StatelessWidget {
  const DonationPageFragment({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        const CustomAppBar(
          leading: LeadingIcon(
            isHidden: true,
          ),
        ),
        const SizedBox(height: defaultPadding),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.87,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  tr('dona_camp'),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: primaryColor,
                  ),
                ),
                const SizedBox(height: defaultPadding * 0.75),
                TitleIconButton(
                  title: tr('add_donation_campaign'),
                  icon: Icons.add_rounded,
                  onPressed: () {
                    // NAVIGATE TO ADD DONATION CAMPAIGN
                    Navigator.pushNamed(
                        context, AddDonationCampaignScreen.routeName());
                  },
                ),
                const SizedBox(height: defaultPadding * 0.5),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: TitleIconButton(
                          title: tr('active_don_campaigns'),
                          icon: Icons.online_prediction_rounded,
                          titleStyle: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(color: Colors.black.withOpacity(0.5)),
                          iconSize: 25,
                          onPressed: () async {
                            // GO TO ACTIVE DONATION CAMPAIGNS PAGE
                            Navigator.pushNamed(
                                context, ActiveDonCampsScreen.routeName());
                          },
                        ),
                      ),
                      const SizedBox(width: defaultPadding * 0.5),
                      Expanded(
                        child: TitleIconButton(
                          title: tr('comp_don_campaigns'),
                          icon: Icons.check_rounded,
                          titleStyle: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(color: Colors.black.withOpacity(0.5)),
                          iconSize: 25,
                          onPressed: () async {
                            // GO TO COMPLETED DONATION CAMPAIGNS PAGE
                            Navigator.pushNamed(
                                context, CompletedDonCampsScreen.routeName());
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: defaultPadding * 2),
                const Text(
                  'don_operations',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: primaryColor,
                  ),
                ).tr(),
                const SizedBox(height: defaultPadding * 0.75),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: TitleIconButton(
                          title: tr('add_don_op'),
                          icon: Icons.add_rounded,
                          titleStyle: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(color: Colors.black.withOpacity(0.5)),
                          iconSize: 25,
                          onPressed: () async {
                            // GO TO ADD DONATION OPERATION PAGE
                            Navigator.pushNamed(
                                context, AddDonOpScreen.routeName());
                          },
                        ),
                      ),
                      const SizedBox(width: defaultPadding * 0.5),
                      Expanded(
                        child: TitleIconButton(
                          title: tr('prev_don_op'),
                          icon: Icons.monetization_on_outlined,
                          titleStyle: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(color: Colors.black.withOpacity(0.5)),
                          iconSize: 25,
                          onPressed: () async {
                            // GO TO DONATIONS HISTORY SCREEN
                            Navigator.pushNamed(
                              context,
                              DonationsHistoryScreen.routeName(),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: defaultPadding * 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      tr('contributors'),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: primaryColor,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // GO TO ADD SUPPORTIVE ORGANIZATION PAGE
                        Navigator.pushNamed(
                          context,
                          SupportiveOraganizationsScreen.routeName(),
                        );
                      },
                      style: ButtonStyle(
                        overlayColor: MaterialStateColor.resolveWith(
                          (states) => primaryColor.withOpacity(0.1),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'show_registered_orgs',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: primaryColor),
                          ).tr(),
                          const SizedBox(width: defaultPadding * 0.25),
                          const Icon(
                            Icons.arrow_circle_left_outlined,
                            color: primaryColor,
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: defaultPadding * 0.5),
                _DataCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tr('most_contri_dona'),
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: primaryColor,
                        ),
                      ),
                      BlocBuilder<DonationOperationsBloc,
                          DonationOperationsState>(
                        builder: (context, state) {
                          if (state is DonationOperationsLoading) {
                            return SizedBox(
                              height: MediaQuery.of(context).size.height * 0.25,
                              child: const Center(
                                child: CircularProgressIndicator(
                                  color: primaryColor,
                                ),
                              ),
                            );
                          }
                          if (state is DonationOperationsError) {
                            return SizedBox(
                              height: MediaQuery.of(context).size.height * 0.25,
                              child: _TopContributionsLoadingErrorWidget(
                                onRetryPressed: () {
                                  context
                                      .read<DonationOperationsBloc>()
                                      .add(GetDonationOperations());
                                },
                              ),
                            );
                          }
                          if (state is DonationOperationsLoaded) {
                            // SORT THE LIST OF DONATION OPERATIONS BY AMOUNT
                            List<MapEntry<String, double>>
                                highestPersonsDonations =
                                _getTopPersonsDonations(
                              state.donationOperations
                                  .where((element) =>
                                      element.donatorType == DonorType.person)
                                  .toList(),
                            );

                            if (highestPersonsDonations.isEmpty) {
                              return SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.25,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: defaultPadding * 1.5,
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/images/empty.svg',
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.15,
                                        ),
                                        Text(
                                          tr('no_persons_donations'),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                color: primaryColor,
                                                height: 1.5,
                                              ),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(
                                            height: defaultPadding * 0.5),
                                        TryAgainButton(
                                          titleWidget: Text(
                                            tr('refresh'),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                    color: secondaryColor),
                                          ),
                                          iconSize: 15,
                                          onPressed: () {
                                            context
                                                .read<DonationOperationsBloc>()
                                                .add(GetDonationOperations());
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        'cnotr_name',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                                color: Colors.black
                                                    .withOpacity(0.5)),
                                      ).tr(),
                                      Text(
                                        'con_val',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                                color: Colors.black
                                                    .withOpacity(0.5)),
                                      ).tr(),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: defaultPadding),
                                if (highestPersonsDonations.length >= 3) ...[
                                  for (int index = 0; index < 3; index++) ...[
                                    Ink(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: defaultPadding * 0.5,
                                        horizontal: defaultPadding,
                                      ),
                                      child: InformationRow(
                                        leading:
                                            highestPersonsDonations[index].key,
                                        // TODO: CHANGE IT TO LOCAL CURRENCY
                                        trailing: highestPersonsDonations[index]
                                            .value
                                            .toString(),
                                      ),
                                    ),
                                    const SizedBox(
                                        height: defaultPadding * 0.5),
                                  ],
                                ] else ...[
                                  for (MapEntry<String, double> donatorEntry
                                      in highestPersonsDonations) ...[
                                    Ink(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: defaultPadding * 0.5,
                                        horizontal: defaultPadding,
                                      ),
                                      child: InformationRow(
                                        leading: donatorEntry.key,
                                        // TODO: CHANGE IT TO LOCAL CURRENCY
                                        trailing: donatorEntry.value.toString(),
                                      ),
                                    ),
                                    const SizedBox(
                                        height: defaultPadding * 0.5),
                                  ],
                                ],
                              ],
                            );
                          }

                          return const SizedBox();
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: defaultPadding),
                _DataCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tr('most_org_contri'),
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: primaryColor,
                        ),
                      ),
                      BlocBuilder<SupportiveOrganizationsBloc,
                          SupportiveOrganizationsState>(
                        builder: (context, state) {
                          if (state is SupportiveOrganizationsLoading) {
                            return SizedBox(
                              height: MediaQuery.of(context).size.height * 0.25,
                              child: const Center(
                                child: CircularProgressIndicator(
                                  color: primaryColor,
                                ),
                              ),
                            );
                          }
                          if (state is SupportiveOrganizationsError) {
                            return SizedBox(
                              height: MediaQuery.of(context).size.height * 0.25,
                              child: _TopContributionsLoadingErrorWidget(
                                onRetryPressed: () {
                                  context
                                      .read<SupportiveOrganizationsBloc>()
                                      .add(GetSupportiveOrganizations());
                                },
                              ),
                            );
                          }
                          if (state is SupportiveOrganizationsLoaded) {
                            // SORT LIST OF ORGANIZATIONS BY TOTAL CONTRIBUTIONS
                            List<SupportiveOrganization> sortedOrganizations =
                                _getSortedOrganizationsList(
                                    state.organizations);
                            if (sortedOrganizations.isEmpty) {
                              return SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.25,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: defaultPadding * 1.5,
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/images/empty.svg',
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.15,
                                        ),
                                        Text(
                                          tr('no_organizations_donations'),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                color: primaryColor,
                                                height: 1.5,
                                              ),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(
                                            height: defaultPadding * 0.5),
                                        TryAgainButton(
                                          titleWidget: Text(
                                            tr('refresh'),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                    color: secondaryColor),
                                          ),
                                          iconSize: 15,
                                          onPressed: () {
                                            context
                                                .read<
                                                    SupportiveOrganizationsBloc>()
                                                .add(
                                                    GetSupportiveOrganizations());
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }
                            return Column(
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            'select_org',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                    color: Colors.black
                                                        .withOpacity(0.5)),
                                          ).tr(),
                                          Text(
                                            'con_val',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                    color: Colors.black
                                                        .withOpacity(0.5)),
                                          ).tr(),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: defaultPadding),
                                    if (sortedOrganizations.length >= 3) ...[
                                      for (int index = 0;
                                          index < 3;
                                          index++) ...[
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: defaultPadding * 0.5,
                                            horizontal: defaultPadding,
                                          ),
                                          child: InformationRow(
                                            leading:
                                                Helper.isLocaleArabic(context)
                                                    ? sortedOrganizations[index]
                                                        .nameAr!
                                                    : sortedOrganizations[index]
                                                        .nameEn!,
                                            // TODO: CHANGE IT TO LOCAL CURRENCY
                                            trailing: sortedOrganizations[index]
                                                .totalContributions!
                                                .toString(),
                                          ),
                                        ),
                                        const SizedBox(
                                            height: defaultPadding * 0.5),
                                      ],
                                    ] else ...[
                                      for (SupportiveOrganization org
                                          in sortedOrganizations) ...[
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: defaultPadding * 0.5,
                                            horizontal: defaultPadding,
                                          ),
                                          child: InformationRow(
                                            leading:
                                                Helper.isLocaleArabic(context)
                                                    ? org.nameAr!
                                                    : org.nameEn!,
                                            // TODO: CHANGE IT TO LOCAL CURRENCY

                                            trailing: org.totalContributions
                                                .toString(),
                                          ),
                                        ),
                                        const SizedBox(
                                            height: defaultPadding * 0.5),
                                      ],
                                    ],
                                  ],
                                ),
                              ],
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: defaultPadding),
              ],
            ),
          ),
        )
      ],
    );
  }

  // A FUNCTION TO SORT A LIST OF SUPPORTIVE ORGANIZATIONS OBJECTS BY TOTAL CONTRIBUTIONS
  List<SupportiveOrganization> _getSortedOrganizationsList(
    List<SupportiveOrganization> organizations,
  ) {
    List<SupportiveOrganization> sortedOrganizations = [];

    // COPY THE LIST OF ORGANIZATIONS TO A NEW LIST
    for (var element in organizations) {
      if (element.totalContributions! != 0) sortedOrganizations.add(element);
    }

    // SORT THE LIST BY TOTAL CONTRIBUTIONS
    sortedOrganizations.sort((a, b) => b.totalContributions!.compareTo(
          a.totalContributions!,
        ));

    return sortedOrganizations;
    // return [];
  }

  // A FUNCTION TO SORT DONATION OPERATINONS OF PERSONS BY AMOUNT
  List<MapEntry<String, double>> _getTopPersonsDonations(
      List<DonationOperation> donationOperations) {
    List<DonationOperation> sortedDonationOperations = [];

    // COPY THE LIST
    for (DonationOperation donationOperation in donationOperations) {
      sortedDonationOperations.add(donationOperation);
    }

    // APPLY AGGRIGATION BY DONATOR NAME ON THE LIST
    Map<String, double> topDonators = sortedDonationOperations
        .fold<Map<String, double>>({}, (previousValue, element) {
      if (previousValue.containsKey(element.donorName)) {
        previousValue[element.donorName] =
            (previousValue[element.donorName])! + element.paidAmount!;
      } else {
        previousValue[element.donorName] = element.paidAmount!;
      }
      return previousValue;
    });

    // SORT THE MAP BY VALUE
    List<MapEntry<String, double>> topDonatorsSorted = topDonators.entries
        .toList()
        .where((element) => element.value != 0)
        .toList();
    topDonatorsSorted.sort((a, b) => b.value.compareTo(a.value));

    return topDonatorsSorted;
    // return [];
  }
}

class _TopContributionsLoadingErrorWidget extends StatelessWidget {
  const _TopContributionsLoadingErrorWidget({
    Key? key,
    required this.onRetryPressed,
  }) : super(key: key);
  final VoidCallback onRetryPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: defaultPadding * 2,
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              'assets/images/failure.svg',
              height: MediaQuery.of(context).size.height * 0.15,
            ),
            Text(
              tr('unexpected_error'),
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: primaryColor,
                    height: 1.5,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: defaultPadding * 0.5),
            TryAgainButton(
              titleWidget: Text(
                tr('try_again'),
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: secondaryColor),
              ),
              iconSize: 15,
              onPressed: onRetryPressed,
            ),
          ],
        ),
      ),
    );
  }
}

class _DataCard extends StatelessWidget {
  const _DataCard({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: Material(
        child: InkWell(
          child: Ink(
            padding: const EdgeInsets.symmetric(
              vertical: defaultPadding * 0.5,
              horizontal: defaultPadding,
            ),
            decoration: const BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
