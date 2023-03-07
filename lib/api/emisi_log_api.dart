import 'package:dio/dio.dart';

import '../models/models.dart';

class EmisiLogApi {
  static const emisiLogPath = '/emisi-log';
  static const emisiLogListPath = '$emisiLogPath/list';

  final Dio _dio;

  EmisiLogApi(this._dio);

  Future<List<EmisiLog>> getEmisiLog({int? page}) async {
    List<EmisiLog> results = [];

    final queries = {
      'page': page ?? 1,
    };

    final response = await _dio.get(
      emisiLogListPath,
      queryParameters: queries,
    );

    if (response.data != null && response.data['data'] != null) {
      List rawData = response.data['data'];

      for (Map data in rawData) {
        results.add(
          EmisiLog.fromJson(
            Map<String, dynamic>.from(data),
          ),
        );
      }
    }

    return results;
  }
}
