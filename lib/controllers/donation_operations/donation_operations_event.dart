part of 'donation_operations_bloc.dart';

abstract class DonationOperationsEvent extends Equatable {
  const DonationOperationsEvent();

  @override
  List<Object> get props => [];
}

// GET DONATION OPERATIONS
class GetDonationOperations extends DonationOperationsEvent {
  @override
  String toString() => 'GetDonationOperations';
}

// ADD A DONATION OPERATION EVENT
class AddDonationOperation extends DonationOperationsEvent {
  final DonationOperation donationOperation;

  const AddDonationOperation({required this.donationOperation});

  @override
  List<Object> get props => [donationOperation];
}
