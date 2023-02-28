part of 'donation_bloc.dart';

abstract class DonationEvent extends Equatable {}

class LoadDonationList extends DonationEvent {
  final int? page;
  final String? category;
  final String? keyword;

  LoadDonationList(this.page, this.category, this.keyword);

  @override
  List<Object?> get props => [
        page,
        category,
        keyword,
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
