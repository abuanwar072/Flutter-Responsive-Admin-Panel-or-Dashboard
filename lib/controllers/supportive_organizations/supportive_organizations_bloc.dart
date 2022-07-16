import 'package:admin/models/models.dart';
import 'package:admin/services/supportive_organizations_services.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'supportive_organizations_event.dart';
part 'supportive_organizations_state.dart';

class SupportiveOrganizationsBloc
    extends Bloc<SupportiveOrganizationsEvent, SupportiveOrganizationsState> {
  final SupportiveOrganizationsServices _supportiveOrganizationsServices;
  SupportiveOrganizationsBloc()
      : _supportiveOrganizationsServices = SupportiveOrganizationsServices(),
        super(SupportiveOrganizationsLoading()) {
    on<GetSupportiveOrganizations>(_onGetSupportiveOrganizations);
    on<AddSupportiveOrganization>(_onAddSupportiveOrganization);
  }

  Future<void> _onGetSupportiveOrganizations(
    GetSupportiveOrganizations event,
    Emitter<SupportiveOrganizationsState> emit,
  ) async {
    emit(SupportiveOrganizationsLoading());
    List<SupportiveOrganization>? organizations =
        await _supportiveOrganizationsServices.getSupportiveOrganizations();

    if (organizations != null) {
      emit(SupportiveOrganizationsLoaded(organizations: organizations));
    } else {
      emit(const SupportiveOrganizationsError(
          message: 'Failed to load supportive organizations'));
    }
  }

  Future<void> _onAddSupportiveOrganization(
    AddSupportiveOrganization event,
    Emitter<SupportiveOrganizationsState> emit,
  ) async {
    emit(SupportiveOrganizationsLoading());
    bool? success = await _supportiveOrganizationsServices
        .addSupportiveOrganization(organization: event.organization);
    if (success!) {
      List<SupportiveOrganization>? organizations =
          await _supportiveOrganizationsServices.getSupportiveOrganizations();
      if (organizations != null) {
        emit(SupportiveOrganizationsLoaded(organizations: organizations));
      } else {
        emit(const SupportiveOrganizationsError(
            message: 'Failed to load supportive organizations'));
      }
    } else {
      emit(const SupportiveOrganizationsError(
          message: 'Failed to add supportive organization'));
    }
  }
}
