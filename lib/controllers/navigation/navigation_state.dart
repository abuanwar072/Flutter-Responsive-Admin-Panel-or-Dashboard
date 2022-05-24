part of 'navigation_bloc.dart';

@immutable
abstract class NavigationState extends Equatable {
  final String pageTitle;

  NavigationState({required this.pageTitle});
  @override
  List<Object?> get props => [pageTitle];
}

class HomePageInitialized extends NavigationState {
  HomePageInitialized({required super.pageTitle});
}

class EmployeesPageInitialized extends NavigationState {
  EmployeesPageInitialized({required super.pageTitle});
}

class PersonsWithSpecialNeedsPageInitialized extends NavigationState {
  PersonsWithSpecialNeedsPageInitialized({required super.pageTitle});
}

class DonationsPageInitialized extends NavigationState {
  DonationsPageInitialized({required super.pageTitle});
}

class VolunteerPageInitialized extends NavigationState {
  VolunteerPageInitialized({required super.pageTitle});
}

class SponsorshipsPageInitialized extends NavigationState {
  SponsorshipsPageInitialized({required super.pageTitle});
}

class NotificationsPageInitialized extends NavigationState {
  NotificationsPageInitialized({required super.pageTitle});
}

class SettingsPageInitialized extends NavigationState {
  SettingsPageInitialized({required super.pageTitle});
}
