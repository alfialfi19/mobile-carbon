import 'package:dio/dio.dart';
import 'package:mobile_carbon/models/models.dart';

class MasterApi {
  static const masterPath = '/master';
  static const masterArticleCategoryPath = '$masterPath/article-category';
  static const masterEmisiCategoryPath = '$masterPath/emisi-category';
  static const masterEmisiSubCategoryPath = '$masterPath/emisi-sub-category';

  final Dio _dio;

  const MasterApi(this._dio);

  Future<List<EmisiCategory>> getArticleCategory() async {
    List<EmisiCategory> results = [];

    final response = await _dio.get(
      masterArticleCategoryPath,
    );

    if (response.data != null && response.data['data'] != null) {
      List rawData = response.data['data'];

      for (Map data in rawData) {
        results.add(
          EmisiCategory.fromJson(
            Map<String, dynamic>.from(data),
          ),
        );
      }
    }

    return results;
  }

  Future<List<EmisiCategory>> getEmisiCategory() async {
    List<EmisiCategory> results = [];

    final response = await _dio.get(
      masterEmisiCategoryPath,
    );

    if (response.data != null && response.data['data'] != null) {
      List rawData = response.data['data'];

      for (Map data in rawData) {
        results.add(
          EmisiCategory.fromJson(
            Map<String, dynamic>.from(data),
          ),
        );
      }
    }

    return results;
  }

  Future<List<EmisiCategory>> getEmisiSubCategory({
    int? id,
  }) async {
    List<EmisiCategory> results = [];

    final queries = {
      'id': id ?? 0,
    };

    final response = await _dio.get(
      masterEmisiSubCategoryPath,
      queryParameters: queries,
    );

    if (response.data != null && response.data['data'] != null) {
      List rawData = response.data['data'];

      for (Map data in rawData) {
        results.add(
          EmisiCategory.fromJson(
            Map<String, dynamic>.from(data),
          ),
        );
      }
    }

    return results;
  }
}
