part of 'donation_bloc.dart';

abstract class DonationEvent extends Equatable {}

class LoadDonationList extends DonationEvent {
  final int? page;
  final String? category;
  final String? keyword;
  final List<DonationDetail>? currentData;

  LoadDonationList({
    this.page,
    this.category,
    this.keyword,
    this.currentData,
  });

  @override
  List<Object?> get props => [
        page,
        category,
        keyword,
        currentData,
      ];
}

class LoadDonationDetail extends DonationEvent {
  final int? id;

  LoadDonationDetail(this.id);

  @override
  List<Object?> get props => [
        id,
      ];
}
