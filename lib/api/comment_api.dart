import 'package:dio/dio.dart';
import 'package:mobile_carbon/commons/commons.dart';
import 'package:mobile_carbon/models/models.dart';

class CommentApi {
  static const commentPath = '/comment';
  static const commentListPath = '$commentPath/list';
  static const commentStorePath = '$commentPath/store';
  static const commentUpdatePath = '$commentPath/update';
  static const commentDeletePath = '$commentPath/delete';

  static const commentActivityPath = '/comment-activity';
  static const commentActivityListPath = '$commentActivityPath/list';
  static const commentActivityStorePath = '$commentActivityPath/store';
  static const commentActivityUpdatePath = '$commentActivityPath/update';
  static const commentActivityDeletePath = '$commentActivityPath/delete';

  final Dio _dio;

  const CommentApi(this._dio);

  Future<List<Comments>> getListComment({
    int? page,
    int? id,
    String? source,
  }) async {
    List<Comments> results = [];

    final queries = {
      'page': page ?? 1,
      'id': id ?? 0,
    };

    Response response;

    if (source != null && source == Source.activity.name) {
      response = await _dio.get(
        commentActivityListPath,
        queryParameters: queries,
      );
    } else {
      response = await _dio.get(
        commentListPath,
        queryParameters: queries,
      );
    }

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

  Future<void> deleteComment({
    String? idComment,
    String? source,
  }) async {
    var formData = FormData.fromMap({
      'id': idComment ?? "0",
    });
    print("===> formData: ${formData.fields}");

    if (source != null && source == Source.activity.name) {
      await _dio.post(
        commentActivityDeletePath,
        data: formData,
      );
    } else {
      await _dio.post(
        commentDeletePath,
        data: formData,
      );
    }
  }

  Future<void> storeComment({
    int? idArticle,
    int? idParent,
    String? idComment,
    String? desc,
    String? source,
  }) async {
    var formData = FormData.fromMap({
      'id_article': idArticle ?? "",
      'id_parent': idParent ?? "",
      'id_child': "",
      'desc': desc,
      // 'file': await MultipartFile.fromFile('./text.txt',filename: 'upload.txt')
    });

    Response response;

    if (source != null && source == Source.activity.name) {
      if (idComment != null) {
        final queries = {
          'id': idComment,
        };

        response = await _dio.post(
          commentActivityUpdatePath,
          data: formData,
          queryParameters: queries,
        );
      } else {
        response = await _dio.post(
          commentActivityStorePath,
          data: formData,
        );
      }
    } else {
      if (idComment != null) {
        final queries = {
          'id': idComment,
        };

        response = await _dio.post(
          commentUpdatePath,
          data: formData,
          queryParameters: queries,
        );
      } else {
        response = await _dio.post(
          commentStorePath,
          data: formData,
        );
      }
    }
  }
}
