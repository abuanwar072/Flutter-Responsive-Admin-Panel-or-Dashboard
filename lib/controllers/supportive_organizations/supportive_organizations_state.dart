part of 'supportive_organizations_bloc.dart';

abstract class SupportiveOrganizationsState extends Equatable {
  const SupportiveOrganizationsState();

  @override
  List<Object> get props => [];
}

class SupportiveOrganizationsLoading extends SupportiveOrganizationsState {}

class SupportiveOrganizationsLoaded extends SupportiveOrganizationsState {
  final List<SupportiveOrganization> organizations;
  const SupportiveOrganizationsLoaded({required this.organizations});

  @override
  List<Object> get props => [organizations];
}

class SupportiveOrganizationsError extends SupportiveOrganizationsState {
  final String message;
  const SupportiveOrganizationsError({required this.message});

  @override
  List<Object> get props => [message];
}
