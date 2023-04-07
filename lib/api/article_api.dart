import 'package:dio/dio.dart';
import 'package:mobile_carbon/models/models.dart';

class ArticleApi {
  static const articlePath = '/article';
  static const articleListPath = '$articlePath/list';
  static const articleDetailPath = '$articlePath/detail';
  static const articleStorePath = '$articlePath/store';
  static const articleUpdatePath = '$articlePath/update';
  static const articleDeletePath = '$articlePath/delete';

  final Dio _dio;

  const ArticleApi(this._dio);

  Future<List<ArticleDetail>> getListArticle({
    int? page,
    int? category,
    String? keyword,
    String? type,
    int? me,
  }) async {
    List<ArticleDetail> results = [];

    final queries = {
      'page': page ?? 1,
      'category': category ?? "",
      'keyword': keyword ?? "",
      'type': type ?? "",
      'me': me ?? "",
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

  Future<void> storeArticle({
    int? categoryId,
    String? title,
    List<String>? filePath,
    String? desc,
  }) async {
    var formData = FormData.fromMap({
      'category': categoryId,
      'title': title,
      'desc': desc,
    });

    if (filePath != null) {
      int i = 1;
      for (var file in filePath) {
        formData.files.addAll([
          MapEntry("file_$i", await MultipartFile.fromFile(file)),
        ]);
        i++;
      }
    }

    await _dio.post(
      articleStorePath,
      data: formData,
    );
  }

  Future<void> updateArticle({
    String? articleId,
    int? categoryId,
    String? title,
    List<String>? filePath,
    String? desc,
  }) async {
    var formData = FormData.fromMap({
      'category': categoryId,
      'title': title,
      'desc': desc,
    });

    if (filePath != null) {
      int i = 1;
      for (var file in filePath) {
        formData.files.addAll([
          MapEntry("file_$i", await MultipartFile.fromFile(file)),
        ]);
        i++;
      }
    }

    final queries = {
      'id': articleId,
    };

    await _dio.post(
      articleUpdatePath,
      data: formData,
      queryParameters: queries,
    );
  }

  Future<void> deleteArticle({
    String? idArticle,
  }) async {
    var formData = FormData.fromMap({
      'id': idArticle ?? "0",
    });

    await _dio.post(
      articleDeletePath,
      data: formData,
    );
  }
}
