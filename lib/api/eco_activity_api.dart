import 'package:dio/dio.dart';
import 'package:mobile_carbon/models/models.dart';

class EcoActivityApi {
  static const ecoActivityPath = '/activity';
  static const ecoActivityListPath = '$ecoActivityPath/list';
  static const ecoActivityDetailPath = '$ecoActivityPath/detail';

  final Dio _dio;

  EcoActivityApi(this._dio);

  Future<List<ArticleDetail>> getListEcoActivity({
    int? page,
    int? category,
    String? keyword,
  }) async {
    List<ArticleDetail> results = [];

    final queries = {
      'page': page ?? 1,
      'category': category ?? "",
      'keyword': keyword ?? "",
    };

    final response = await _dio.get(
      ecoActivityListPath,
      queryParameters: queries,
    );

    if (response.data != null && response.data['data'] != null) {
      List rawData = response.data['data'];

      for (Map data in rawData) {
        results.add(
          ArticleDetail.fromJson(
            Map<String, dynamic>.from(data),
          ),
        );
      }
    }

    return results;
  }

  Future<ArticleDetail> getDetailEcoActivity({
    int? id,
  }) async {
    final queries = {
      'id': id ?? 0,
    };

    final response = await _dio.get(
      ecoActivityDetailPath,
      queryParameters: queries,
    );

    return ArticleDetail.fromJson(response.data['data']);
  }
}
