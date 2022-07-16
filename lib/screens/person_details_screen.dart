import 'package:admin/config/constants.dart';
import 'package:admin/config/helper.dart';
import 'package:admin/models/models.dart';
import 'package:admin/screens/screens.dart';
import 'package:admin/widgets/widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class PersonDetailsScreen extends StatelessWidget {
  const PersonDetailsScreen({Key? key}) : super(key: key);

  static String routeName() => '/person_details';

  @override
  Widget build(BuildContext context) {
    final Person person = ModalRoute.of(context)!.settings.arguments as Person;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          tr('person_details'),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        elevation: 0,
        backgroundColor: bgColor,
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
          if (person.terminationDate == null)
            IconButton(
              onPressed: () {
                // todo: go to edit person screen
                Navigator.pushNamed(
                  context,
                  AddEditPersonScreen.routeName(),
                  arguments: {
                    'isInAddMode': false,
                    'person': person,
                  },
                );
              },
              icon: const Icon(
                Icons.edit_note_rounded,
                color: Colors.black,
              ),
              splashRadius: 20,
            ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DataCard(
              child: Column(
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage('assets/images/avatar.jpg'),
                    backgroundColor: Colors.transparent,
                    radius: 50,
                  ),
                  const SizedBox(height: defaultPadding * 0.5),
                  Text(
                    '${person.firstName!} ${person.lastName!}',
                    style: const TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: defaultPadding * 0.5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        tr('personal_id'),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${person.personId!}',
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        tr('medical_status'),
                      ),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          Helper.isLocaleArabic(context)
                              ? person.healthStatusAr!
                              : person.healthStatusEn!,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: defaultPadding),
            DataCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr('personal_information'),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: primaryColor,
                    ),
                  ),
                  const SizedBox(height: defaultPadding),
                  InformationRow(
                    leading: tr('first_name'),
                    trailing: person.firstName!,
                  ),
                  const SizedBox(height: defaultPadding * .75),
                  InformationRow(
                    leading: tr('last_name'),
                    trailing: person.lastName!,
                  ),
                  const SizedBox(height: defaultPadding * .75),
                  InformationRow(
                    leading: tr('phone_number'),
                    trailing: person.phoneNumber!,
                    isTrailingReversed: true,
                  ),
                  const SizedBox(height: defaultPadding * .75),
                  InformationRow(
                    leading: tr('age'),
                    trailing: '${person.age!}',
                  ),
                  const SizedBox(height: defaultPadding * .75),
                  InformationRow(
                    leading: tr('nat_id_num'),
                    trailing: person.nationalNumber!,
                  ),
                  const SizedBox(height: defaultPadding * .75),
                  InformationRow(
                    leading: tr('join_date'),
                    trailing: DateFormat(Helper.isLocaleArabic(context)
                            ? 'yyyy/MM/dd'
                            : 'dd/MM/yyyy')
                        .format(DateTime.parse(person.joinDate!)),
                  ),
                  if (person.terminationDate != null) ...[
                    const SizedBox(height: defaultPadding * .75),
                    InformationRow(
                      leading: tr('termination_date'),
                      trailing: DateFormat(Helper.isLocaleArabic(context)
                              ? 'yyyy/MM/dd'
                              : 'dd/MM/yyyy')
                          .format(DateTime.parse(person.terminationDate!)),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: defaultPadding),
            DataCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr('address'),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: primaryColor,
                    ),
                  ),
                  const SizedBox(height: defaultPadding),
                  InformationRow(
                    leading: tr('state'),
                    trailing: Helper.isLocaleArabic(context)
                        ? person.stateAr!
                        : person.stateEn!,
                  ),
                  const SizedBox(height: defaultPadding),
                  InformationRow(
                    leading: tr('city'),
                    trailing: Helper.isLocaleArabic(context)
                        ? person.cityAr!
                        : person.cityAr!,
                  ),
                ],
              ),
            ),
            const SizedBox(height: defaultPadding),
            DataCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr('official_docs'),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: primaryColor,
                    ),
                  ),
                  const SizedBox(height: defaultPadding),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        tr('health_report'),
                        style: Theme.of(context).textTheme.bodyLarge!,
                      ),
                      TextButton(
                        onPressed: () {
                          // GO TO PDF VIEWER TO SHOW HEALTH REPORT
                          Navigator.pushNamed(
                            context,
                            PDFViewerScreen.routeName(),
                            arguments: person.healthReportUrl,
                          );
                        },
                        style:
                            TextButton.styleFrom(backgroundColor: primaryColor),
                        child: Text(
                          tr('download'),
                          style: const TextStyle(color: secondaryColor),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
