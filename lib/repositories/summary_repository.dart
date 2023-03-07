import 'package:mobile_carbon/api/api.dart';

import '../models/models.dart';

class SummaryRepository {
  final SummaryApi _summaryApi;

  SummaryRepository(this._summaryApi);

  Future<SummaryRank> getSummaryRank({
    int? page,
    String? type,
  }) async {
    final response = await _summaryApi.getSummaryRank(
      page: page,
      type: type,
    );

    return response;
  }

  Future<SummaryEmisiLog> getSummaryEmisiLog() async {
    final response = await _summaryApi.getSummaryEmisiLog();

    return response;
  }

  Future<SummaryHistory> getSummaryHistory({
    int? page,
    String? type,
  }) async {
    final response = await _summaryApi.getSummaryHistory(
      page: page,
      type: type,
    );

    return response;
  }
}
