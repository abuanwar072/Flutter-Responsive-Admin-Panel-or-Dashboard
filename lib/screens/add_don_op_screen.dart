import 'dart:ui' as ui;

import 'package:admin/config/constants.dart';
import 'package:admin/config/helper.dart';
import 'package:admin/controllers/donation_campaigns/donation_campaigns_bloc.dart';
import 'package:admin/controllers/donation_operations/donation_operations_bloc.dart';
import 'package:admin/controllers/mixins/dialog_provider.dart';
import 'package:admin/controllers/mixins/filed_provider.dart';
import 'package:admin/controllers/supportive_organizations/supportive_organizations_bloc.dart';
import 'package:admin/controllers/validation/validation_mixin.dart';
import 'package:admin/screens/screens.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../models/models.dart';

class AddDonOpScreen extends StatelessWidget
    with FieldProvider, DialogProvider, ValidationProvider {
  AddDonOpScreen({Key? key}) : super(key: key);

  static String routeName() => '/add_don_op_screen';
  final _formKey = GlobalKey<FormState>();
  final _campaignsDropdownKey = GlobalKey<FormFieldState>();
  final _orgsDropdownKey = GlobalKey<FormFieldState>();

  // Donator type
  final ValueNotifier<bool?> donatorType = ValueNotifier<bool?>(null);
  final ValueNotifier<DonationCampaign?> campToDonate =
      ValueNotifier<DonationCampaign?>(null);

  // Selected Supportive Organization
  final ValueNotifier<SupportiveOrganization?> selectedSupOrg =
      ValueNotifier<SupportiveOrganization?>(null);

  final TextEditingController _paidAmountController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _donatorNameController = TextEditingController();

  // ADD A DONATION OPERATION
  Future<void> addDonationOperation(BuildContext context) async {
    context.read<DonationOperationsBloc>().add(
          AddDonationOperation(
            donationOperation: DonationOperation(
              idSupOrg: selectedSupOrg.value == null
                  ? null
                  : selectedSupOrg.value!.id,
              idDonCamp: campToDonate.value!.id,
              donorNameString: _donatorNameController.text,
              phoneNumber: _phoneNumberController.text,
              paidAmount: double.parse(_paidAmountController.text),
            ),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return showExitPopup(context);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            tr('add_don_op'),
            style: Theme.of(context).textTheme.titleMedium,
          ),
          elevation: 0,
          backgroundColor: bgColor,

          // Back Button
          leading: IconButton(
            onPressed: () async {
              if (await showExitPopup(context)) Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            splashRadius: 20,
          ),
          actions: [
            IconButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Helper.logger.d('PERFORM A DAONATION OPERATION');
                  addDonationOperation(context);
                }
              },
              icon: const Icon(
                Icons.check_circle_outline_rounded,
                color: Colors.black,
              ),
              splashRadius: 20,
            ),
          ],
        ),
        body: BlocListener<DonationOperationsBloc, DonationOperationsState>(
          listener: (context, state) {
            if (state is DonationOperationsLoading) {
              showLoadingDialoge(context);
            } else if (state is DoantionOperationAdded) {
              // GET LATEST VERSION OF DONATION CAMPAIGNS
              context.read<DonationCampaignsBloc>().add(GetDonationCampaigns());

              if (selectedSupOrg.value != null) {
                // GET LATEST VERSION OF ORGANIZATIONS DATA
                context
                    .read<SupportiveOrganizationsBloc>()
                    .add(GetSupportiveOrganizations());
              }

              int count = 0;
              Navigator.of(context).popUntil((_) => count++ >= 2);
            } else {
              Navigator.of(context).pop();
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                children: [
                  _DataCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tr('don_op_details'),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: primaryColor,
                          ),
                        ),
                        const SizedBox(height: defaultPadding),
                        BlocBuilder<DonationCampaignsBloc,
                            DonationCampaignsState>(
                          builder: (context, state) {
                            if (state is DonationCampaignsLoading) {
                              return SizedBox(
                                height: 40,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      tr('loading_campaigns'),
                                      style:
                                          const TextStyle(color: primaryColor),
                                    ),
                                    const SizedBox(width: defaultPadding * 2),
                                    const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                            if (state is DonationCampaignsError) {
                              return Align(
                                alignment: Alignment.center,
                                child: Text(
                                  tr('error_loading_donation_campaigns'),
                                  style:
                                      const TextStyle(color: Colors.redAccent),
                                ),
                              );
                            }
                            if (state is DonationCampaignsLoaded) {
                              return ValueListenableBuilder<DonationCampaign?>(
                                valueListenable: campToDonate,
                                builder: (context, campaign, _) {
                                  return DropdownButtonFormField<
                                      DonationCampaign?>(
                                    key: _campaignsDropdownKey,
                                    value: campaign,
                                    isExpanded: true,
                                    decoration: const InputDecoration(
                                      fillColor: Colors.transparent,
                                      filled: true,
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey,
                                          width: 0.5,
                                        ),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey,
                                          width: 0.5,
                                        ),
                                      ),
                                    ),
                                    validator: (content) {
                                      if (content == null) {
                                        return tr('select_campaign');
                                      }
                                      return null;
                                    },
                                    items: [
                                      DropdownMenuItem(
                                        value: null,
                                        child: Text(
                                          tr('camp_to_donate'),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      for (var camp in state.donationCampaigns
                                          .where((element) =>
                                              element.status ==
                                              DonationCampaignStatus.active)
                                          .toList())
                                        DropdownMenuItem(
                                          value: camp,
                                          child: Text(
                                            Helper.isLocaleArabic(context)
                                                ? camp.titleAr!
                                                : camp.titleEn!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      DropdownMenuItem(
                                        value: DonationCampaign(id: -1),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pop(_campaignsDropdownKey
                                                .currentContext!);
                                            Navigator.pushNamed(
                                              context,
                                              AddDonationCampaignScreen
                                                  .routeName(),
                                            );
                                          },
                                          highlightColor: primaryColor
                                              .withOpacity(0.5)
                                              .withAlpha(50),
                                          splashColor: primaryColor
                                              .withOpacity(0.5)
                                              .withAlpha(50),
                                          child: Ink(
                                            padding: const EdgeInsets.all(
                                                defaultPadding),
                                            width: double.infinity,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  tr('add_donation_campaign'),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(
                                                          color: primaryColor),
                                                  textAlign: TextAlign.center,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                const SizedBox(
                                                    width: defaultPadding),
                                                const Icon(
                                                  Icons.add_rounded,
                                                  color: primaryColor,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                    onChanged: (value) {
                                      if (value != null && value.id == -1) {
                                        // THE BUTTON HAS BEE PRESSED
                                        // SO WE NEED TO ADD A NEW ORGANIZATION
                                        campToDonate.value = null;
                                      } else {
                                        campToDonate.value = value;
                                      }
                                    },
                                  );
                                },
                              );
                            }
                            return const SizedBox();
                          },
                        ),
                        const SizedBox(height: defaultPadding * 0.5),
                        buildTextFormField(
                          context: context,
                          hintText: tr('con_val'),
                          controller: _paidAmountController,
                          keyboardType: TextInputType.number,
                          suffixText: '\$',
                          validator: (content) {
                            if (content == null || content.isEmpty) {
                              return tr('required');
                            }
                            if (!validatePrice(content)) {
                              return tr('invalid_price');
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: defaultPadding * 0.5),
                        buildTextFormField(
                          context: context,
                          hintText: tr('phone_number_optional'),
                          controller: _phoneNumberController,
                          keyboardType: TextInputType.phone,
                          textDirection: ui.TextDirection.ltr,
                          validator: (content) {
                            if (content != null && content.isNotEmpty) {
                              if (!validatePhoneNumber(content)) {
                                return tr('invalid_phone_number');
                              }
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: defaultPadding * 0.5),
                        ValueListenableBuilder<bool?>(
                          valueListenable: donatorType,
                          builder: (context, value, _) {
                            return DropdownButtonFormField<bool?>(
                              value: value,
                              isExpanded: true,
                              decoration: const InputDecoration(
                                fillColor: Colors.transparent,
                                filled: true,
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                    width: 0.5,
                                  ),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                    width: 0.5,
                                  ),
                                ),
                              ),
                              validator: (content) {
                                if (content == null) {
                                  return tr('select_donator_type');
                                }
                                return null;
                              },
                              items: [
                                DropdownMenuItem(
                                  value: null,
                                  child: Text(
                                    tr('donator_type'),
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: false,
                                  child: Text(
                                    tr('organization'),
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: true,
                                  child: Text(
                                    tr('person'),
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                              onChanged: (value) {
                                if (value == null || value == false) {
                                  selectedSupOrg.value = null;
                                }
                                donatorType.value = value;
                              },
                            );
                          },
                        ),
                        // ! IN CASE THE DONATOR IS AN ORGANIZATION,
                        // ! LET HIM SELECT THE ORGANIZATION FROM DDB
                        const SizedBox(height: defaultPadding * 0.5),
                        BlocBuilder<SupportiveOrganizationsBloc,
                            SupportiveOrganizationsState>(
                          builder: (context, state) {
                            if (state is DonationCampaignsLoading) {
                              return SizedBox(
                                height: 40,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      tr('loading_organizations'),
                                      style:
                                          const TextStyle(color: primaryColor),
                                    ),
                                    const SizedBox(width: defaultPadding * 2),
                                    const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                            if (state is DonationCampaignsError) {
                              return Align(
                                alignment: Alignment.center,
                                child: Text(
                                  tr('error_loading_organizations'),
                                  style:
                                      const TextStyle(color: Colors.redAccent),
                                ),
                              );
                            }
                            if (state is SupportiveOrganizationsLoaded) {
                              return ValueListenableBuilder<bool?>(
                                valueListenable: donatorType,
                                builder: (context, value, _) {
                                  if (value == null) {
                                    return Container();
                                  }
                                  if (value == true) {
                                    return buildTextFormField(
                                      context: context,
                                      hintText: tr('donator_name'),
                                      controller: _donatorNameController,
                                      keyboardType: TextInputType.name,
                                      validator: (content) {
                                        if (content == null ||
                                            content.isEmpty) {
                                          return tr('required');
                                        }
                                        return null;
                                      },
                                    );
                                  }
                                  return ValueListenableBuilder<
                                      SupportiveOrganization?>(
                                    valueListenable: selectedSupOrg,
                                    builder: (context, org, _) {
                                      return DropdownButtonFormField<
                                          SupportiveOrganization>(
                                        key: _orgsDropdownKey,
                                        value: org,
                                        isExpanded: true,
                                        decoration: const InputDecoration(
                                          fillColor: Colors.transparent,
                                          filled: true,
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.grey,
                                              width: 0.5,
                                            ),
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.grey,
                                              width: 0.5,
                                            ),
                                          ),
                                        ),
                                        validator: (content) {
                                          if (content == null) {
                                            return tr('select_organization');
                                          }
                                          return null;
                                        },
                                        items: [
                                          DropdownMenuItem(
                                            value: null,
                                            child: Text(
                                              tr('select_org'),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          for (var org in state.organizations)
                                            DropdownMenuItem(
                                              value: org,
                                              child: Text(
                                                Helper.isLocaleArabic(context)
                                                    ? org.nameAr!
                                                    : org.nameEn!,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          DropdownMenuItem(
                                            value:
                                                SupportiveOrganization(id: -1),
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.pop(_orgsDropdownKey
                                                    .currentContext!);
                                                Navigator.pushNamed(
                                                  context,
                                                  AddSupportiveOrganizationScreen
                                                      .routeName(),
                                                );
                                              },
                                              highlightColor: primaryColor
                                                  .withOpacity(0.5)
                                                  .withAlpha(50),
                                              splashColor: primaryColor
                                                  .withOpacity(0.5)
                                                  .withAlpha(50),
                                              child: Ink(
                                                padding: const EdgeInsets.all(
                                                    defaultPadding),
                                                width: double.infinity,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      tr('add_sup_org'),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium!
                                                          .copyWith(
                                                              color:
                                                                  primaryColor),
                                                      textAlign:
                                                          TextAlign.center,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    const SizedBox(
                                                        width: defaultPadding),
                                                    const Icon(
                                                      Icons.add_rounded,
                                                      color: primaryColor,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                        onChanged: (value) {
                                          if (value != null && value.id == -1) {
                                            // THE BUTTON HAS BEE PRESSED
                                            // SO WE NEED TO ADD A NEW ORGANIZATION
                                            selectedSupOrg.value = null;
                                          } else {
                                            selectedSupOrg.value = value;
                                          }
                                        },
                                      );
                                    },
                                  );
                                },
                              );
                            }
                            return const SizedBox();
                          },
                        ),
                        const SizedBox(height: defaultPadding * 0.5),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Center(
                        child: SvgPicture.asset(
                          'assets/icons/logo.svg',
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: defaultPadding * 0.5),
                      Text(
                        tr('charity_name'),
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: primaryColor, height: 1.4),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                ],
              ),
            ),
          ),
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
