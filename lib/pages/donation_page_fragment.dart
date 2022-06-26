import 'package:admin/constants.dart';
import 'package:admin/controllers/navigation/navigation_bloc.dart';
import 'package:admin/reusable_widgets/reusable_widgets.dart';
import 'package:admin/screens/screens.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

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
        CustomAppBar(
          leading: LeadingIcon(
            bgColor: bgColor,
          ),
        ),
        SizedBox(height: defaultPadding),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.77,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  tr('dona_camp'),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: defaultPadding),
                _DataCard(
                  onPressed: () {
                    // NAVIGATE TO ADD DONATION CAMPAIGN
                    Navigator.pushNamed(
                        context, AddDonationCampaignScreen.routeName());
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.15,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add_rounded,
                          size: 40,
                          color: Colors.black.withOpacity(0.5),
                        ),
                        SizedBox(height: defaultPadding * 0.5),
                        Text(
                          'add_donation_campaign',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: Colors.black.withOpacity(0.5)),
                        ).tr()
                      ],
                    ),
                  ),
                ),
                SizedBox(height: defaultPadding * 0.5),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: _DataCard(
                          onPressed: () async {
                            // GO TO ACTIVE DONATION CAMPAIGNS PAGE
                            await context.setLocale(Locale('ar'));
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.online_prediction_rounded,
                                size: 25,
                                color: Colors.black.withOpacity(0.5),
                              ),
                              SizedBox(height: defaultPadding * 0.5),
                              Text(
                                'active_don_campaigns',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                        color: Colors.black.withOpacity(0.5)),
                                textAlign: TextAlign.center,
                              ).tr(),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: defaultPadding * 0.5),
                      Expanded(
                        child: _DataCard(
                          onPressed: () async {
                            // GO TO COMPLETED DONATION CAMPAIGNS PAGE
                            // TODO: REMOVE THIS
                            await context.setLocale(Locale('en'));
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.check_rounded,
                                size: 25,
                                color: Colors.black.withOpacity(0.5),
                              ),
                              SizedBox(height: defaultPadding * 0.5),
                              Text(
                                'comp_don_campaigns',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                        color: Colors.black.withOpacity(0.5)),
                                textAlign: TextAlign.center,
                              ).tr(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: defaultPadding),
                Text(
                  tr('contributors'),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: defaultPadding),
                _DataCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: defaultPadding * 0.5),
                      Text(
                        tr('most_contri_dona'),
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: defaultPadding),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'cnotr_name',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      color: Colors.black.withOpacity(0.5)),
                            ).tr(),
                            Text(
                              'con_val',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      color: Colors.black.withOpacity(0.5)),
                            ).tr(),
                          ],
                        ),
                      ),
                      SizedBox(height: defaultPadding),
                      ClipRRect(
                        // borderRadius:
                        //     const BorderRadius.all(Radius.circular(10)),
                        child: Ink(
                          padding: const EdgeInsets.symmetric(
                            vertical: defaultPadding * 0.5,
                            horizontal: defaultPadding,
                          ),
                          decoration: BoxDecoration(
                            color: secondaryColor,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 1,
                                offset: Offset(0, 1),
                              ),
                            ],
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4)),
                          ),
                          child: InformationRow(
                            leading: 'علاء الدين زامل',
                            trailing: '25 ليرة',
                          ),
                        ),
                      ),
                      SizedBox(height: defaultPadding * 0.5),
                      ClipRRect(
                        // borderRadius:
                        //     const BorderRadius.all(Radius.circular(10)),
                        child: Ink(
                          padding: const EdgeInsets.symmetric(
                            vertical: defaultPadding * 0.5,
                            horizontal: defaultPadding,
                          ),
                          decoration: BoxDecoration(
                            color: secondaryColor,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 1,
                                offset: Offset(0, 1),
                              ),
                            ],
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4)),
                          ),
                          child: InformationRow(
                            leading: 'أحمد الحمصي',
                            trailing: '20 ليرة',
                          ),
                        ),
                      ),
                      SizedBox(height: defaultPadding * 0.5),
                      ClipRRect(
                        // borderRadius:
                        //     const BorderRadius.all(Radius.circular(10)),
                        child: Ink(
                          padding: const EdgeInsets.symmetric(
                            vertical: defaultPadding * 0.5,
                            horizontal: defaultPadding,
                          ),
                          decoration: BoxDecoration(
                            color: secondaryColor,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 1,
                                offset: Offset(0, 1),
                              ),
                            ],
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4)),
                          ),
                          child: InformationRow(
                            leading: 'محمد فارس الدباس',
                            trailing: '15 ليرة',
                          ),
                        ),
                      ),
                      SizedBox(height: defaultPadding * 0.5),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class _DataCard extends StatelessWidget {
  const _DataCard({
    Key? key,
    required this.child,
    this.onPressed,
    this.onLongPress,
  }) : super(key: key);

  final Widget child;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: Material(
        child: InkWell(
          onLongPress: onLongPress,
          onTap: onPressed,
          child: Ink(
            padding: const EdgeInsets.symmetric(
              vertical: defaultPadding * 0.5,
              horizontal: defaultPadding,
            ),
            decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
