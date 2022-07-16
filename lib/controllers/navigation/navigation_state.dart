part of 'navigation_bloc.dart';

@immutable
abstract class NavigationState extends Equatable {
  final String pageTitle;

  const NavigationState({required this.pageTitle});
  @override
  List<Object?> get props => [pageTitle];
}

class HomePageInitialized extends NavigationState {
  const HomePageInitialized({required super.pageTitle});
}

class EmployeesPageInitialized extends NavigationState {
  const EmployeesPageInitialized({required super.pageTitle});
}

class PersonsWithSpecialNeedsPageInitialized extends NavigationState {
  const PersonsWithSpecialNeedsPageInitialized({required super.pageTitle});
}

class DonationsPageInitialized extends NavigationState {
  const DonationsPageInitialized({required super.pageTitle});
}

class VolunteerPageInitialized extends NavigationState {
  const VolunteerPageInitialized({required super.pageTitle});
}

class SponsorshipsPageInitialized extends NavigationState {
  const SponsorshipsPageInitialized({required super.pageTitle});
}

class NotificationsPageInitialized extends NavigationState {
  const NotificationsPageInitialized({required super.pageTitle});
}

class SettingsPageInitialized extends NavigationState {
  const SettingsPageInitialized({required super.pageTitle});
}
