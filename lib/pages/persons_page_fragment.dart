import 'package:admin/config/constants.dart';
import 'package:admin/controllers/mixins/dialog_provider.dart';
import 'package:admin/controllers/persons/persons_bloc.dart';
import 'package:admin/models/models.dart';
import 'package:admin/screens/screens.dart';
import 'package:admin/widgets/search_field.dart';
import 'package:admin/widgets/widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:toast/toast.dart';

class PersonsPageFragment extends StatelessWidget with DialogProvider {
  PersonsPageFragment({
    Key? key,
  }) : super(key: key);

  final ValueNotifier<String?> searchQuery = ValueNotifier<String?>(null);

  @override
  Widget build(BuildContext context) {
    // INITIALIZE TOAST
    ToastContext().init(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
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
        const SizedBox(height: defaultPadding),
        SearchField(
          onSearch: (query) {
            searchQuery.value = query;
          },
        ),
        const SizedBox(height: defaultPadding * 0.5),
        RefreshIndicator(
          triggerMode: RefreshIndicatorTriggerMode.anywhere,
          color: primaryColor,
          onRefresh: () async {
            // CLEAR SEARCH QUERY
            searchQuery.value = null;

            // CALL GET EMPLOYEES BLOC EVENT
            BlocProvider.of<PersonsBloc>(context)
                .add(GetPersonsWithSpecialNeeds());
          },
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overscroll) {
              overscroll.disallowIndicator();
              return true;
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                child: BlocConsumer<PersonsBloc, PersonsState>(
                  listener: (context, state) {
                    if (state is PersonsLoading) {
                      showLoadingDialoge(context);
                    } else {
                      Navigator.pop(context);
                    }

                    // TO GET LATEST VERSION OF DATA FROM SERVER
                    // if (state is PersonAdded ||
                    //     state is PersonUpdated ||
                    //     state is PersonTerminated) {
                    //   context.read<PersonsBloc>().add(GetPersonsWithSpecialNeeds());
                    // }
                  },
                  builder: (context, state) {
                    if (state is PersonsLoading) {
                      return const SizedBox();
                    }
                    if (state is PersonsError) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: Center(
                          child: UnexpectedErrorWidget(
                            onRetryPressed: () {
                              context
                                  .read<PersonsBloc>()
                                  .add(GetPersonsWithSpecialNeeds());
                            },
                          ),
                        ),
                      );
                    }
                    if (state is PersonsLoaded) {
                      if (state.persons.isEmpty) {
                        return NoDataWidget(
                          onRefreshPressed: () {
                            context
                                .read<PersonsBloc>()
                                .add(GetPersonsWithSpecialNeeds());
                          },
                          message: tr('no_persons'),
                        );
                      }
                      return ValueListenableBuilder<String?>(
                        valueListenable: searchQuery,
                        builder: (context, query, _) {
                          // Filter persons by query
                          final filteredPersons = query == null
                              ? state.persons
                              : state.persons
                                  .where((person) =>
                                      person.firstName!
                                          .toLowerCase()
                                          .contains(query) ||
                                      person.lastName!
                                          .toLowerCase()
                                          .contains(query) ||
                                      person.nationalNumber!.contains(query) ||
                                      person.age!.toString().contains(query) ||
                                      person.healthStatusAr!.contains(query) ||
                                      person.healthStatusEn!.contains(query) ||
                                      person.stateAr!.contains(query) ||
                                      person.stateEn!.contains(query) ||
                                      person.cityAr!.contains(query) ||
                                      person.cityEn!.contains(query))
                                  .toList();
                          return _buildPersonsList(context, filteredPersons);
                        },
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _buildPersonsList(BuildContext context, List<Person> persons) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.765,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: StaggeredGrid.count(
          crossAxisSpacing: 8,
          crossAxisCount: 2,
          children: [
            // SHOW THE NUMBER OF REGISTERED PERSONS IN THE SYSTEM
            StaggeredGridTile.count(
              crossAxisCellCount: 2,
              mainAxisCellCount: 0.25,
              child: _DataCard(
                child: _InfoRow(
                  leading: tr('persons_count_title'),
                  trailing: plural(
                      'persons_count',
                      persons
                          .where((element) => element.terminationDate == null)
                          .length),
                  leadingColor: primaryColor,
                ),
              ),
            ),

            // SHOW THE CARDs FOR EACH PERSON IN THE SYSTEM
            const StaggeredGridTile.count(
              crossAxisCellCount: 2,
              mainAxisCellCount: 0.05,
              child: SizedBox(),
            ),
            for (int index = 0; index < persons.length; index++)
              StaggeredGridTile.count(
                crossAxisCellCount: 1,
                mainAxisCellCount: 1,
                child: PersonCard(
                  onLongPress: () async {
                    final isTerminated =
                        await showDeleteWarningDialogue(context);
                    if (isTerminated) {
                      context.read<PersonsBloc>().add(
                          TerminatePersonWithSpecialNeeds(
                              person: persons[index]));
                    }
                  },
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      PersonDetailsScreen.routeName(),
                      arguments: persons[index],
                    );
                  },
                  person: persons[index],
                ),
              ),
          ],
        ),
      ),
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
              child: Stack(
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage('assets/images/avatar.jpg'),
                    backgroundColor: Colors.transparent,
                    radius: 40,
                  ),
                  if (person.terminationDate == null)
                    const Positioned(
                      bottom: 0,
                      right: 0,
                      child: Icon(
                        Icons.verified_user_rounded,
                        color: primaryColor,
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: defaultPadding * 0.5),
            Text(
              '${person.firstName} ${person.lastName}',
              style: const TextStyle(color: primaryColor),
            ),
            Text(
              '${tr('personal_id')} ${person.personId}',
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
