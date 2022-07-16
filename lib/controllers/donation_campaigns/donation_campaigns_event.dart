part of 'donation_campaigns_bloc.dart';

abstract class DonationCampaignsEvent extends Equatable {
  const DonationCampaignsEvent();

  @override
  List<Object> get props => [];
}

// GET EVENET
class GetDonationCampaigns extends DonationCampaignsEvent {}

// STORE EVENT
class StoreDonationCampaign extends DonationCampaignsEvent {
  final DonationCampaign donationCampaign;

  const StoreDonationCampaign(this.donationCampaign);

  @override
  List<Object> get props => [donationCampaign];
}

class CancelDonationCampaign extends DonationCampaignsEvent {
  final DonationCampaign donationCampaign;

  const CancelDonationCampaign(this.donationCampaign);
}
