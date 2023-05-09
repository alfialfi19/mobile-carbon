import 'package:dio/dio.dart';

import '../models/models.dart';

class EmisiLogApi {
  static const emisiLogPath = '/emisi-log';
  static const emisiLogListPath = '$emisiLogPath/list';
  static const emisiLogStorePath = '$emisiLogPath/store';
  static const emisiLogStoreMultiplePath = '$emisiLogPath/store-multiple';

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

  Future<void> storeEmisiLogMultiple({
    List<EmisiCategory>? listEmisi,
    List<String>? listVal,
  }) async {
    var formData = FormData();

    if (listEmisi != null) {
      int i = 0;

      for (var emisi in listEmisi) {
        formData.fields.addAll([
          MapEntry("id_category[$i]", emisi.idCategory ?? "0"),
          MapEntry("id_category_sub[$i]", emisi.id ?? "0"),
          MapEntry("unit[$i]", emisi.unit ?? "0"),
        ]);
        i++;
      }
    }

    if (listVal != null) {
      int j = 0;

      for (String? value in listVal) {
        formData.fields.addAll([
          MapEntry("val[$j]", value ?? "0"),
        ]);
        j++;
      }
    }

    print("===> formData: ${formData.fields}");

    await _dio.post(
      emisiLogStoreMultiplePath,
      data: formData,
    );
  }
}
