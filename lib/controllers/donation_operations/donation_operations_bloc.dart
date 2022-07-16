import 'package:admin/models/donation_operation.dart';
import 'package:admin/services/donation_operations_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'donation_operations_event.dart';
part 'donation_operations_state.dart';

class DonationOperationsBloc
    extends Bloc<DonationOperationsEvent, DonationOperationsState> {
  final DonationOperationsServices _donationOperationsServices;

  DonationOperationsBloc()
      : _donationOperationsServices = DonationOperationsServices(),
        super(DonationOperationsLoading()) {
    on<GetDonationOperations>(_onGetDonationOperations);
    on<AddDonationOperation>(_onAddDonationOperation);
  }

  Future<void> _onGetDonationOperations(
    GetDonationOperations event,
    Emitter<DonationOperationsState> emit,
  ) async {
    emit(DonationOperationsLoading());
    final List<DonationOperation>? donationOperations =
        await _donationOperationsServices.getDonationOperations();

    if (donationOperations == null) {
      emit(const DonationOperationsError('Failed to load donation operations'));
    } else {
      emit(DonationOperationsLoaded(donationOperations));
    }
  }

  Future<void> _onAddDonationOperation(
    AddDonationOperation event,
    Emitter<DonationOperationsState> emit,
  ) async {
    emit(DonationOperationsLoading());
    final bool? success = await _donationOperationsServices
        .storeDonationOperation(event.donationOperation);
    if (success!) {
      emit(DoantionOperationAdded());
      final List<DonationOperation>? donationOperations =
          await _donationOperationsServices.getDonationOperations();
      if (donationOperations == null) {
        emit(const DonationOperationsError(
            'Failed to load donation operations'));
      } else {
        emit(DonationOperationsLoaded(donationOperations));
      }
    } else {
      emit(const DonationOperationsError('Failed to add donation operation'));
    }
  }
}
