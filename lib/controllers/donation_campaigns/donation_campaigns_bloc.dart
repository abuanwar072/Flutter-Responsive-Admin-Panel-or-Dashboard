import 'package:admin/models/donation_campaign.dart';
import 'package:admin/services/donation_campaigns_services.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'donation_campaigns_event.dart';
part 'donation_campaigns_state.dart';

class DonationCampaignsBloc
    extends Bloc<DonationCampaignsEvent, DonationCampaignsState> {
  // FOR DEBUGGING PURPOSES IN CAPITAL CASE
  final String className = 'DonationCampaignsBloc';

  final DonationCampaignsServices _donationCampaignsServices;

  DonationCampaignsBloc()
      : _donationCampaignsServices = DonationCampaignsServices(),
        super(DonationCampaignsLoading()) {
    on<GetDonationCampaigns>(_onGetDonationCampaigns);
    on<StoreDonationCampaign>(_onStoreDonationCampaign);
    on<CancelDonationCampaign>(_onCancelDonationCampaign);
  }

  Future<void> _onGetDonationCampaigns(
    GetDonationCampaigns event,
    Emitter<DonationCampaignsState> emit,
  ) async {
    emit(DonationCampaignsLoading());
    final List<DonationCampaign>? donationCampaigns =
        await _donationCampaignsServices.getDonationCampaigns();
    if (donationCampaigns != null) {
      emit(DonationCampaignsLoaded(donationCampaigns));
    } else {
      emit(const DonationCampaignsError('Failed to load donation campaigns'));
    }
  }

  Future<void> _onStoreDonationCampaign(
    StoreDonationCampaign event,
    Emitter<DonationCampaignsState> emit,
  ) async {
    emit(DonationCampaignsLoading());
    final bool? success = await _donationCampaignsServices
        .storeDonationCampaign(event.donationCampaign);
    if (success!) {
      final List<DonationCampaign>? donationCampaigns =
          await _donationCampaignsServices.getDonationCampaigns();
      if (donationCampaigns != null) {
        emit(DonationCampaignsLoaded(donationCampaigns));
      } else {
        emit(const DonationCampaignsError('Failed to load donation campaigns'));
      }
    } else {
      emit(const DonationCampaignsError('Failed to store donation campaign'));
    }
  }

  Future<void> _onCancelDonationCampaign(
    CancelDonationCampaign event,
    Emitter<DonationCampaignsState> emit,
  ) async {
    emit(DonationCampaignsLoading());
    final bool? success = await _donationCampaignsServices
        .cancelDonationCampaign(event.donationCampaign);
    if (success!) {
      final List<DonationCampaign>? donationCampaigns =
          await _donationCampaignsServices.getDonationCampaigns();
      if (donationCampaigns != null) {
        emit(DonationCampaignsLoaded(donationCampaigns));
      } else {
        emit(const DonationCampaignsError('Failed to load donation campaigns'));
      }
    } else {
      emit(const DonationCampaignsError('Failed to cancel donation campaign'));
    }
  }
}
