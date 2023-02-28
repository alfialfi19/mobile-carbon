part of 'donation_bloc.dart';

abstract class DonationState extends BlocState {
  const DonationState({
    super.statusCode,
    super.message,
    super.errorCode,
  });
}

class DonationInitial extends DonationState {}

class ListDonationLoading extends DonationState {}

class ListDonationLoaded extends DonationState {
  final List<DonationDetail> donationList;

  const ListDonationLoaded(this.donationList);
}

class ListDonationEmpty extends DonationState {}

class ListDonationError extends DonationState {
  final GenericErrorResponse errorResponse;

  const ListDonationError(this.errorResponse);
}

class DetailDonationLoading extends DonationState {}

class DetailDonationLoaded extends DonationState {
  final DonationDetail donationDetail;

  const DetailDonationLoaded(this.donationDetail);
}

class DetailDonationError extends DonationState {
  final GenericErrorResponse errorResponse;

  const DetailDonationError(this.errorResponse);
}
