import 'package:admin/config/constants.dart';
import 'package:admin/config/helper.dart';
import 'package:admin/models/gift_card.dart';
import 'package:admin/models/models.dart';
import 'package:admin/screens/screens.dart';
import 'package:admin/widgets/widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotificationsPageFragment extends StatelessWidget {
  const NotificationsPageFragment({
    Key? key,
  }) : super(key: key);

  // SHOW A DIALOGUE WITH A TEXT FORM FIELD TO ENTER NOTIFICATION CONTENT
  Future<bool> _showDialogForNotificationContent(BuildContext context) async {
    final contentArController = TextEditingController();
    final contentEnController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                'send_push_not',
                style: Theme.of(context).textTheme.titleMedium,
              ).tr(),
              content: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      validator: (content) {
                        if (content!.isEmpty) {
                          return tr('enter_not_content');
                        }
                        return null;
                      },
                      controller: contentArController,
                      cursorColor: primaryColor,
                      keyboardType: TextInputType.multiline,
                      maxLength: 100,
                      // 100 CHART IS THE MAX LENGTH OF NOTIFICATION MESSAGE
                      maxLines: null,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.black),
                      decoration: InputDecoration(
                        filled: true,
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(
                                color: Theme.of(context)
                                    .hintColor
                                    .withOpacity(0.5)),
                        hintText: tr('not_content_ar'),
                        fillColor: Colors.transparent,
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: primaryColor,
                          ),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: Theme.of(context).hintColor.withOpacity(0.2),
                          ),
                        ),
                      ),
                    ),
                    TextFormField(
                      validator: (content) {
                        if (content!.isEmpty) {
                          return tr('enter_not_content');
                        }
                        return null;
                      },
                      controller: contentEnController,
                      cursorColor: primaryColor,
                      keyboardType: TextInputType.multiline,
                      maxLength: 100,
                      // 100 CHART IS THE MAX LENGTH OF NOTIFICATION MESSAGE
                      maxLines: null,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.black),
                      decoration: InputDecoration(
                        filled: true,
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(
                                color: Theme.of(context)
                                    .hintColor
                                    .withOpacity(0.5)),
                        hintText: tr('not_content_en'),
                        fillColor: Colors.transparent,
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: primaryColor,
                          ),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: Theme.of(context).hintColor.withOpacity(0.2),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  style: ButtonStyle(
                    overlayColor: MaterialStateColor.resolveWith(
                      (states) => Colors.red.withOpacity(0.1),
                    ),
                  ),
                  //return false when click on "NO"
                  child: Text(
                    'cancel',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ).tr(),
                ),
                TextButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      Navigator.of(context).pop(true);
                    }
                  },
                  style: ButtonStyle(
                    overlayColor: MaterialStateColor.resolveWith(
                      (states) => primaryColor.withOpacity(0.1),
                    ),
                  ),
                  //return true when click on "Yes"
                  child: Text(
                    'send',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ).tr(),
                ),
              ],
            );
          },
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.9,
      child: Column(
        children: [
          const CustomAppBar(
            leading: LeadingIcon(
              isHidden: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: defaultPadding,
              horizontal: defaultPadding * 0.5,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                BigButton(
                  title: tr('send_push_not'),
                  icon: Icons.send,
                  onPressed: () async {
                    // SHOW A DIALOGUE TO ENTER NOTIFICATION CONTENT
                    if (await _showDialogForNotificationContent(context)) {
                      // TODO: SEND A PUSH NOTIFICATION TO THE SERVER
                      if (kDebugMode) {
                        print('NOTIFICATIONS PAGE: SEND A PUSH NOTIFICATION');
                      }
                    }
                  },
                ),
                const SizedBox(height: defaultPadding * 0.75),
                BigButton(
                  title: tr('not_hist'),
                  icon: Icons.circle_notifications_rounded,
                  onPressed: () {
                    // GO TO SENT NOTIFICATIONS SCREEN
                    Navigator.pushNamed(
                      context,
                      SentNotificationsScreen.routeName(),
                    );
                  },
                ),
                const SizedBox(height: defaultPadding),
                const Text(
                  'requests',
                  style: TextStyle(
                    fontSize: 18,
                    color: primaryColor,
                  ),
                ).tr(),
                const SizedBox(height: defaultPadding * 0.5),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.45,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(
                vertical: defaultPadding * 0.5,
                horizontal: defaultPadding * 0.5,
              ),
              itemCount: requests.length,
              itemBuilder: (context, index) {
                return RequestCard(
                  request: requests[index],
                );
              },
            ),
          ),
          Flexible(
            child: Center(
              child: Flexible(
                child: SvgPicture.asset(
                  'assets/icons/logo.svg',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RequestCard extends StatelessWidget {
  const RequestCard({
    Key? key,
    required this.request,
  }) : super(key: key);
  final Request request;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: defaultPadding * 0.5),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.87,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DataCard(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10),
                topLeft: Radius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TODO: ADD REQUEST DETAILS HERE
                  Text(
                    request is VolunteerRequest ? 'vol_req' : 'gift',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: primaryColor),
                  ).tr(),
                  const SizedBox(height: defaultPadding * 2),

                  // ! REQUEST PRESENTER NAME,

                  if (request is VolunteerRequest)
                    InformationRow(
                      leading: tr('volunteer_name'),
                      trailing: request.presenterFullName,
                    ),
                  if (request is GiftRequest)
                    Text(
                      (Helper.isLocaleArabic(context)
                          ? GiftCard.gifts[(request as GiftRequest).giftID]
                              .descriptionAr
                          : GiftCard.gifts[(request as GiftRequest).giftID]
                              .descriptionEn),
                      style: Theme.of(context).textTheme.bodyLarge!,
                    ),
                  const SizedBox(height: defaultPadding),

                  // ! VOLUNTTER AGE,
                  InformationRow(
                    leading: tr(
                      request is VolunteerRequest ? 'age' : 'sender_name',
                    ),
                    trailing: request is VolunteerRequest
                        ? (request as VolunteerRequest).volunteerAge.toString()
                        : request.presenterFullName,
                  ),
                  const SizedBox(height: defaultPadding),

                  // ! PHONE NUMBER,
                  InformationRow(
                    leading: tr(
                      request is VolunteerRequest
                          ? 'phone_number'
                          : 'reciepent_name',
                    ),
                    isTrailingReversed: true,
                    trailing: request is VolunteerRequest
                        ? (request as VolunteerRequest).volunteerPhone
                        : (request as GiftRequest).recipientFullName,
                  ),
                  const SizedBox(height: defaultPadding),

                  // ! EMAIL ADDRESS,
                  InformationRow(
                      leading: tr(
                        request is VolunteerRequest
                            ? 'email'
                            : 'rec_phone_number',
                      ),
                      isTrailingReversed: true,
                      trailing: request is VolunteerRequest
                          ? (request as VolunteerRequest).volunteerEmail
                          : (request as GiftRequest).recipientPhone),

                  SizedBox(
                    height: request is VolunteerRequest
                        ? (defaultPadding * 0.5)
                        : defaultPadding,
                  ),

                  // ! EDUCATIONAL DOCUMENT,
                  InformationRow(
                    leading: tr(
                      request is VolunteerRequest
                          ? 'educational_doc'
                          : 'gift_value',
                    ),
                    trailing: request is GiftRequest
                        ? plural(
                            'donations', (request as GiftRequest).giftValue)
                        : null,
                    trailingWidget: request is VolunteerRequest
                        ? TextButton(
                            onPressed: () {
                              // todo: open a new page to show the universiy degree pdf file (if exists)
                            },
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: defaultPadding),
                              primary: primaryColor,
                            ),
                            child: Text(
                              tr('details'),
                            ),
                          )
                        : null,
                  ),
                  SizedBox(
                    height: request is VolunteerRequest
                        ? (defaultPadding * 0.5)
                        : defaultPadding * 1.2,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: DataCard(
                      onPressed: () {
                        // TODO: SEND REJECT REQUEST TO THE SERVER
                      },
                      bgColor: Colors.grey[350],
                      borderRadius: BorderRadius.only(
                        bottomRight: Helper.isLocaleArabic(context)
                            ? const Radius.circular(10)
                            : Radius.zero,
                        bottomLeft: Helper.isLocaleArabic(context)
                            ? Radius.zero
                            : const Radius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          'reject',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(color: Colors.black),
                        ).tr(),
                      ),
                    ),
                  ),
                  Expanded(
                    child: DataCard(
                      onPressed: () {
                        // TODO :SEND ACCEPT REQUEST TO SERVER
                      },
                      bgColor: primaryColor,
                      // splashColor: primaryColor.withAlpha(),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Helper.isLocaleArabic(context)
                            ? const Radius.circular(10)
                            : Radius.zero,
                        bottomRight: Helper.isLocaleArabic(context)
                            ? Radius.zero
                            : const Radius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          'accept',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(color: Colors.white),
                        ).tr(),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BigButton extends StatelessWidget {
  const BigButton({
    Key? key,
    required this.title,
    required this.icon,
    this.onPressed,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(10),
      child: DataCard(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: defaultPadding * 0.5,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(color: primaryColor),
              ),
              Icon(
                icon,
                color: primaryColor.withOpacity(0.75),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
