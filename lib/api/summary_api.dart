import 'package:dio/dio.dart';

import '../models/models.dart';

class SummaryApi {
  static const summaryPath = '/summary';
  static const summaryRankPath = '$summaryPath-rank';
  static const summaryEmisiLog = '$summaryPath-emisi-log';
  static const summaryHistory = '$summaryPath-history';

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

  Future<SummaryEmisiLog> getSummaryEmisiLog() async {
    final response = await _dio.get(
      summaryEmisiLog,
    );

    return SummaryEmisiLog.fromJson(response.data['data']);
  }

  Future<SummaryHistory> getSummaryHistory({int? page, String? type}) async {
    final queries = {
      'page': page ?? 1,
      'type': type ?? 'Emisi',
    };

    final response = await _dio.get(
      summaryHistory,
      queryParameters: queries,
    );

    return SummaryHistory.fromJson(response.data['data']);
  }
}
