import 'package:dio/dio.dart';
import 'package:mobile_carbon/models/models.dart';

class CommentApi {
  static const commentPath = '/comment';
  static const commentListPath = '$commentPath/list';

  final Dio _dio;

  const CommentApi(this._dio);

  Future<List<Comments>> getListComment({
    int? page,
    int? id,
  }) async {
    List<Comments> results = [];

    final queries = {
      'page': page ?? 1,
      'id': id ?? 0,
    };

    final response = await _dio.get(
      commentListPath,
      queryParameters: queries,
    );

    if (response.data != null && response.data['data'] != null) {
      List rawData = response.data['data'];

      for (Map data in rawData) {
        results.add(
          Comments.fromJson(
            Map<String, dynamic>.from(data),
          ),
        );
      }
    }

    return results;
  }
}
