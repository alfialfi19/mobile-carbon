import 'package:dio/dio.dart';

import '../models/models.dart';

class EmisiLogApi {
  static const emisiLogPath = '/emisi-log';
  static const emisiLogListPath = '$emisiLogPath/list';
  static const emisiLogStorePath = '$emisiLogPath/store';

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

  Future<void> storeEmisiLog({
    String? idCategory,
    String? idSubCategory,
    String? val,
    String? unit,
  }) async {
    var formData = FormData.fromMap(
      {
        'id_category': idCategory ?? 0,
        'id_category_sub': idSubCategory ?? 0,
        'val': val ?? "",
        'unit': unit ?? "",
      },
    );

    await _dio.post(
      emisiLogStorePath,
      data: formData,
    );
  }
}
