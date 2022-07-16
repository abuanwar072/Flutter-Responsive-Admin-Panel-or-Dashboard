import 'package:admin/config/constants.dart';
import 'package:admin/controllers/menu_controller/menu_controller.dart';
import 'package:admin/controllers/navigation/navigation_bloc.dart';
import 'package:admin/pages/pages.dart';
import 'package:admin/widgets/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  static String routeName() => '/main_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MenuController>().scaffoldKey,
      drawer: const SideMenu(),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          primary: false,
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              BlocConsumer<NavigationBloc, NavigationState>(
                listener: (context, state) {
                  context.read<MenuController>().closeMenu();
                },
                builder: (context, state) {
                  // Home Page is selected
                  if (state is HomePageInitialized) {
                    return const HomePageFragment();
                  }

                  // Employees page selected
                  if (state is EmployeesPageInitialized) {
                    return EmployeesPageFragment();
                  }

                  // Persons with special needs selected
                  if (state is PersonsWithSpecialNeedsPageInitialized) {
                    return PersonsPageFragment();
                  }

                  // Donations page selected
                  if (state is DonationsPageInitialized) {
                    return const DonationPageFragment();
                  }
                  // Volunteers page selected
                  if (state is VolunteerPageInitialized) {
                    return const VolunteerPageFragment();
                  }

                  // Sponsorships page selected
                  if (state is SponsorshipsPageInitialized) {
                    return const SponsorshipsPageFragment();
                  }

                  // Notifications page selected
                  if (state is NotificationsPageInitialized) {
                    return const NotificationsPageFragment();
                  }

                  // Persons with special needs selected
                  if (state is SettingsPageInitialized) {
                    return const SettingsPageFragment();
                  }
                  return const HomePageFragment();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
