part of 'donation_operations_bloc.dart';

abstract class DonationOperationsState extends Equatable {
  const DonationOperationsState();

  @override
  List<Object> get props => [];
}

class DonationOperationsLoading extends DonationOperationsState {}

class DonationOperationsLoaded extends DonationOperationsState {
  final List<DonationOperation> donationOperations;

  const DonationOperationsLoaded(this.donationOperations);

  @override
  List<Object> get props => [donationOperations];
}

class DoantionOperationAdded extends DonationOperationsState {}

class DonationOperationsError extends DonationOperationsState {
  final String message;

  const DonationOperationsError(this.message);

  @override
  List<Object> get props => [message];
}
