part of 'supportive_organizations_bloc.dart';

abstract class SupportiveOrganizationsEvent extends Equatable {
  const SupportiveOrganizationsEvent();

  @override
  List<Object> get props => [];
}

class GetSupportiveOrganizations extends SupportiveOrganizationsEvent {}

class AddSupportiveOrganization extends SupportiveOrganizationsEvent {
  final SupportiveOrganization organization;

  const AddSupportiveOrganization(this.organization);

  @override
  List<Object> get props => [organization];
}
