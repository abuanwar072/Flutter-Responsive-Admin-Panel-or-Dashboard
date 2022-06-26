import 'package:admin/constants.dart';
import 'package:admin/models/models.dart';
import 'package:admin/reusable_widgets/reusable_widgets.dart';
import 'package:admin/screens/screens.dart';
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
          person.firstName! + ' ' + person.lastName!,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        elevation: 0,
        backgroundColor: bgColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          splashRadius: 20,
        ),
        actions: [
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
            icon: Icon(
              Icons.edit_note_rounded,
              color: Colors.black,
            ),
            splashRadius: 20,
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DataCard(
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(person.healthReportUrl!),
                    backgroundColor: Colors.transparent,
                    radius: 50,
                  ),
                  SizedBox(height: defaultPadding),
                  Text(
                    '${person.firstName!} ${person.lastName!}',
                    style: TextStyle(color: primaryColor),
                  ),
                  SizedBox(height: defaultPadding * 0.5),
                  Text(
                    '${tr('personal_id')} : ${person.personId}',
                  ),
                  SizedBox(height: defaultPadding * 0.25),
                  Text(person.healthStatusAr!), // TODO: CHANGE DUE TO CURRENT LANGUAGE
                ],
              ),
            ),
            SizedBox(height: defaultPadding),
            DataCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr('personal_information'),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: defaultPadding),
                  InformationRow(
                    leading: tr('first_name'),
                    trailing: person.firstName!,
                  ),
                  SizedBox(height: defaultPadding * .75),
                  InformationRow(
                    leading: tr('last_name'),
                    trailing: person.lastName!,
                  ),
                  SizedBox(height: defaultPadding * .75),
                  InformationRow(
                    leading: tr('phone_number'),
                    trailing: person.phoneNumber!,
                  ),
                  SizedBox(height: defaultPadding * .75),
                  InformationRow(
                    leading: tr('age'),
                    trailing: '${person.age!}',
                  ),
                  SizedBox(height: defaultPadding * .75),
                  InformationRow(
                    leading: tr('nat_id_num'),
                    trailing: '${person.nationalNumber!}',
                  ),
                ],
              ),
            ),
            SizedBox(height: defaultPadding),
            DataCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr('address'),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: defaultPadding),
                  InformationRow(
                    leading: tr('state'),
                    trailing: person.state!,
                  ),
                ],
              ),
            ),
            SizedBox(height: defaultPadding),
            DataCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr('official_docs'),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: defaultPadding),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        tr('health_report'),
                        style: Theme.of(context).textTheme.bodyLarge!,
                      ),
                      TextButton(
                        onPressed: () {
                          // todo: implement downloading the health report to user's device
                        },
                        style:
                            TextButton.styleFrom(backgroundColor: primaryColor),
                        child: Text(
                          tr('download'),
                          style: TextStyle(color: secondaryColor),
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
