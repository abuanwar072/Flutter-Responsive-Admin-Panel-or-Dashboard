part of 'donation_campaigns_bloc.dart';

abstract class DonationCampaignsState extends Equatable {
  const DonationCampaignsState();

  @override
  List<Object> get props => [];
}

class DonationCampaignsLoading extends DonationCampaignsState {}

class DonationCampaignsLoaded extends DonationCampaignsState {
  final List<DonationCampaign> donationCampaigns;

  const DonationCampaignsLoaded(this.donationCampaigns);

  @override
  List<Object> get props => [donationCampaigns];
}

class DonationCampaignsError extends DonationCampaignsState {
  final String message;
  const DonationCampaignsError(this.message);
}
