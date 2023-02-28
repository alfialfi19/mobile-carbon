import 'package:mobile_carbon/api/api.dart';
import 'package:mobile_carbon/models/donation_detail.dart';

class DonationRepository {
  final DonationApi _donationApi;

  DonationRepository(this._donationApi);

  Future<List<DonationDetail>> getListDonation({
    int? page,
    String? category,
    String? keyword,
    String? type,
  }) async {
    final response = await _donationApi.getListDonation(
      page: page,
      category: category,
      keyword: keyword,
    );

    return response;
  }

  Future<DonationDetail> getDetailDonation({
    int? id,
  }) async {
    final response = await _donationApi.getDetailDonation(
      id: id,
    );

    return response;
  }
}
