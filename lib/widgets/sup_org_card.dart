import 'package:admin/config/constants.dart';
import 'package:admin/config/helper.dart';
import 'package:admin/models/supportive_organization.dart';
import 'package:admin/widgets/widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SupportiveOrganizationCard extends StatelessWidget {
  const SupportiveOrganizationCard({
    Key? key,
    required this.organization,
    required this.onPressed,
  }) : super(key: key);

  final SupportiveOrganization organization;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: defaultPadding),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(10),
        child: Ink(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DataCard(
                bgColor: primaryColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: InformationRow(
                  leading: (Helper.isLocaleArabic(context)
                      ? organization.nameAr
                      : organization.nameEn)!,
                  leadingColor: secondaryColor,
                ),
              ),
              DataCard(
                borderRadius: BorderRadius.zero,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tr('address'),
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: primaryColor,
                      ),
                    ),
                    const SizedBox(height: defaultPadding * 0.75),
                    InformationRow(
                      leading: tr('state'),
                      trailing: (Helper.isLocaleArabic(context)
                          ? organization.stateAr
                          : organization.stateEn)!,
                    ),
                    const SizedBox(height: defaultPadding * 0.5),
                    InformationRow(
                      leading: tr('city'),
                      trailing: (Helper.isLocaleArabic(context)
                          ? organization.cityAr
                          : organization.cityEn)!,
                    ),
                    const SizedBox(height: defaultPadding),
                    Text(
                      tr('contact_info'),
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: primaryColor,
                      ),
                    ),
                    const SizedBox(height: defaultPadding * 0.75),
                    InformationRow(
                      leading: tr('phone_number'),
                      trailing: organization.phoneNumber!,
                    ),
                    const SizedBox(height: defaultPadding * 0.5),
                    InformationRow(
                      leading: tr('email'),
                      trailing: organization.email!,
                    ),
                    const SizedBox(height: defaultPadding * 0.5),
                  ],
                ),
              ),
              DataCard(
                bgColor: primaryColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                child: InformationRow(
                  leading: tr('total_contributions'),
                  trailing:
                      plural('donations', organization.totalContributions!),
                  leadingColor: secondaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
