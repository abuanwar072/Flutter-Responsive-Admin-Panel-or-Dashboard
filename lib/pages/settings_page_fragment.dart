import 'package:admin/config/constants.dart';
import 'package:admin/widgets/widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class SettingsPageFragment extends StatelessWidget {
  const SettingsPageFragment({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ADD APP BAR
        const CustomAppBar(
          leading: LeadingIcon(
            isHidden: true,
          ),
        ),
        const SizedBox(height: defaultPadding),
        // ADD LANGUAGE SWITCH DROP DOWN BUTTON
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: defaultPadding,
            horizontal: defaultPadding * 0.5,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DataCard(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'language',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: primaryColor),
                    ).tr(),
                    SizedBox(
                      width: 120,
                      child: DropdownButtonFormField<Locale>(
                        alignment: AlignmentDirectional.center,
                        decoration: const InputDecoration(
                          fillColor: Colors.transparent,
                          filled: true,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                        ),
                        value: context.locale,
                        onChanged: (newLanguage) async {
                          context.setLocale(newLanguage!);
                          await Jiffy.locale(newLanguage.languageCode);
                        },
                        items: [
                          DropdownMenuItem(
                            value: const Locale('en'),
                            child: Text(
                              'english',
                              style: Theme.of(context).textTheme.bodySmall,
                            ).tr(),
                          ),
                          DropdownMenuItem(
                            value: const Locale('ar'),
                            child: Text(
                              'arabic',
                              style: Theme.of(context).textTheme.bodySmall,
                            ).tr(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
