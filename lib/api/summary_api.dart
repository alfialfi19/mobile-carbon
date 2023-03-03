import 'package:dio/dio.dart';

import '../models/models.dart';

class SummaryApi {
  static const summaryPath = '/summary';
  static const summaryRankPath = '$summaryPath-rank';

  final Dio _dio;

  SummaryApi(this._dio);

  Future<SummaryRank> getSummaryRank({
    int? page,
    String? type,
  }) async {
    final queries = {
      'page': page ?? 1,
      'type': type ?? 'Artikel',
    };

    final response = await _dio.get(
      summaryRankPath,
      queryParameters: queries,
    );

    return SummaryRank.fromJson(response.data['data']);
  }
}
