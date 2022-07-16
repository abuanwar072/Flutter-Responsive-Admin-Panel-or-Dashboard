import 'package:admin/config/constants.dart';
import 'package:admin/config/helper.dart';
import 'package:admin/widgets/data_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:faker_dart/faker_dart.dart';
import 'package:flutter/material.dart';

class SentNotificationsScreen extends StatelessWidget {
  const SentNotificationsScreen({Key? key}) : super(key: key);

  static String routeName() => '/sent_notifications_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          tr('not_hist'),
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
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(defaultPadding),
        itemCount: 15,
        itemBuilder: (context, index) {
          return NotificationCard(
            content: Helper.isLocaleArabic(context)
                ? Helper.arabicPlainText
                : Faker.instance.lorem.text(),
            date: Faker.instance.date.past(
              DateTime.now(),
              rangeInYears: 1,
            ),
          );
        },
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    Key? key,
    required this.content,
    required this.date,
  }) : super(key: key);
  final String content;
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: defaultPadding * 0.5),
      child: DataCard(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              content,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: defaultPadding),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                DateFormat(
                  Helper.isLocaleArabic(context)
                      ? 'EEEE, dd MMMM yyyy'
                      : 'EEEE, MMMM dd, yyyy',
                  context.locale.languageCode,
                  // ? 'HH:mm - yyyy/MM/dd'
                  // : 'yyyy/MM/dd - HH:mm ',
                ).format(date),
                style: const TextStyle(
                  color: primaryColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
