import 'package:admin/constants.dart';
import 'package:admin/models/models.dart';
import 'package:admin/reusable_widgets/reusable_widgets.dart';
import 'package:admin/reusable_widgets/search_field.dart';
import 'package:admin/screens/screens.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:faker/faker.dart' as faker;
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class PersonsPageFragment extends StatelessWidget {
  const PersonsPageFragment({
    Key? key,
  }) : super(key: key);
  final personsCount = 2358;

  Future<bool> _showDeleteWarningDialogue(context) async {
    return await showDialog(
          // show confirm dialogue
          // the return value will be from "Yes" or "No" options
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              'warning',
              style: TextStyle(color: Colors.red),
            ).tr(),
            content: Text(
              'delete_person_warning',
              style: Theme.of(context).textTheme.bodyMedium,
            ).tr(),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                //return false when click on "NO"
                child: Text('no', style: Theme.of(context).textTheme.bodyLarge)
                    .tr(),
                style: ButtonStyle(
                  overlayColor: MaterialStateColor.resolveWith(
                    (states) => Colors.red.withOpacity(0.1),
                  ),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                //return true when click on "Yes"
                child: Text('yes', style: Theme.of(context).textTheme.bodyLarge)
                    .tr(),
                style: ButtonStyle(
                  overlayColor: MaterialStateColor.resolveWith(
                    (states) => primaryColor.withOpacity(0.1),
                  ),
                ),
              ),
            ],
          ),
        ) ??
        false; // if showDialogue had returned null, then return false
  }

  @override
  Widget build(BuildContext context) {
    final faker.Faker _faker = faker.Faker();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        CustomAppBar(
          leading: LeadingIcon(
            onPressed: () {
              // Add new person with special needs
              Navigator.pushNamed(
                context,
                AddEditPersonScreen.routeName(),
                arguments: {'isInAddMode': true},
              );
            },
            icon: Icons.add_rounded,
          ),
        ),
        SizedBox(height: defaultPadding),
        SearchField(),
        SizedBox(height: defaultPadding * 0.5),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.765,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: StaggeredGrid.count(
              crossAxisSpacing: 8,
              crossAxisCount: 2,
              children: [
                StaggeredGridTile.count(
                  crossAxisCellCount: 2,
                  mainAxisCellCount: 0.25,
                  child: _DataCard(
                    child: _InfoRow(
                      leading: tr('persons_count_title'),
                      trailing: plural('persons_count', personsCount),
                      leadingColor: primaryColor,
                    ),
                  ),
                ),
                StaggeredGridTile.count(
                  crossAxisCellCount: 2,
                  mainAxisCellCount: 0.05,
                  child: SizedBox(),
                ),
                for (int i = 0; i < 70; i++)
                  StaggeredGridTile.count(
                    crossAxisCellCount: 1,
                    mainAxisCellCount: 1,
                    child: PersonCard(
                      onLongPress: () async {
                        final deleteConfirmed =
                            await _showDeleteWarningDialogue(context);
                        if (deleteConfirmed) {
                          // todo: delete confirmed, so delete the person data
                        }
                      },
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          PersonDetailsScreen.routeName(),
                          arguments: Person(
                            personId: i,
                            healthStatusAr: _faker.randomGenerator.string(10),
                            healthStatusEn: _faker.randomGenerator.string(10),
                            firstName: _faker.person.firstName(),
                            lastName: _faker.person.lastName(),
                            phoneNumber: _faker.phoneNumber.us(),
                            state: _faker.address.state(),
                            nationalNumber:
                                _faker.randomGenerator.numberOfLength(12),
                            birthDate: _faker.date
                                .dateTime(minYear: 1990, maxYear: 2015),
                            healthReportUrl: _faker.image.image(),
                          ),
                        );
                      },
                      person: Person(
                        personId: i,
                        healthStatusAr: _faker.randomGenerator.string(10),
                        healthStatusEn: _faker.randomGenerator.string(10),
                        firstName: _faker.person.firstName(),
                        lastName: _faker.person.lastName(),
                        phoneNumber: _faker.phoneNumber.us(),
                        state: _faker.address.state(),
                        nationalNumber:
                            _faker.randomGenerator.numberOfLength(12),
                        birthDate:
                            _faker.date.dateTime(minYear: 1990, maxYear: 2015),
                        healthReportUrl: _faker.image.image(),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class PersonCard extends StatelessWidget {
  const PersonCard({
    Key? key,
    required this.person,
    required this.onPressed,
    this.onLongPress,
  }) : super(key: key);

  final Person person;
  final VoidCallback onPressed;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: defaultPadding * 0.5),
      child: _DataCard(
        onLongPress: onLongPress,
        onPressed: onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/avatar.jpg'),
                backgroundColor: Colors.transparent,
                radius: 40,
              ),
            ),
            SizedBox(height: defaultPadding * 0.5),
            Text(
              '${person.firstName} ${person.lastName}',
              style: TextStyle(color: primaryColor),
            ),
            Text(
              '${tr('personal_id')} : ${person.personId}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              '${tr('age')} : ${person.age}',
              style: Theme.of(context).textTheme.bodySmall,
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

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    Key? key,
    required this.leading,
    required this.trailing,
    this.leadingColor,
  }) : super(key: key);

  final String leading;
  final String trailing;
  final Color? leadingColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          leading,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: leadingColor),
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          trailing,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: (leadingColor ?? Colors.grey).withOpacity(0.9)),
        ),
      ],
    );
  }
}
