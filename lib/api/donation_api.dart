import 'package:dio/dio.dart';
import 'package:mobile_carbon/models/models.dart';

class DonationApi {
  static const donationPath = '/donate';
  static const donationListPath = '$donationPath/list';
  static const donationDetailPath = '$donationPath/detail';

  final Dio _dio;

  DonationApi(this._dio);

  Future<List<DonationDetail>> getListDonation({
    int? page,
    String? category,
    String? keyword,
  }) async {
    List<DonationDetail> results = [];

    final queries = {
      'page': page ?? 1,
      'category': category ?? "Terupdate",
      'keyword': keyword ?? "",
    };

    final response = await _dio.get(
      donationListPath,
      queryParameters: queries,
    );

    if (response.data != null && response.data['data'] != null) {
      List rawData = response.data['data'];

      for (Map data in rawData) {
        results.add(
          DonationDetail.fromJson(
            Map<String, dynamic>.from(data),
          ),
        );
      }
    }

    return results;
  }

  Future<DonationDetail> getDetailDonation({
    int? id,
  }) async {
    final queries = {
      'id': id ?? 0,
    };

    final response = await _dio.get(
      donationDetailPath,
      queryParameters: queries,
    );

    return DonationDetail.fromJson(response.data['data']);
  }
}
