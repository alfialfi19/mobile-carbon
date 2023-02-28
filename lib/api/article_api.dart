import 'package:dio/dio.dart';
import 'package:mobile_carbon/models/models.dart';

class ArticleApi {
  static const articlePath = '/article';
  static const articleListPath = '$articlePath/list';
  static const articleDetailPath = '$articlePath/detail';

  final Dio _dio;

  const ArticleApi(this._dio);

  Future<List<ArticleDetail>> getListArticle({
    int? page,
    int? category,
    String? keyword,
    String? type,
  }) async {
    List<ArticleDetail> results = [];

    final queries = {
      'page': page ?? 1,
      'category': category ?? 1,
      'keyword': keyword ?? "",
      'type': type ?? ""
    };

    final response = await _dio.get(
      articleListPath,
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

  Future<ArticleDetail> getDetailArticle({
    int? id,
  }) async {
    final queries = {
      'id': id ?? 0,
    };

    final response = await _dio.get(
      articleDetailPath,
      queryParameters: queries,
    );

    return ArticleDetail.fromJson(response.data['data']);
  }
}
