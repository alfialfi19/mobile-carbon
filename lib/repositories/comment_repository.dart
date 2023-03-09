import 'package:mobile_carbon/api/api.dart';
import 'package:mobile_carbon/models/models.dart';

class CommentRepository {
  final CommentApi _commentApi;

  CommentRepository(this._commentApi);

  Future<List<Comments>> getListComment({
    int? page,
    int? id,
  }) async {
    final response = await _commentApi.getListComment(
      page: page,
      id: id,
    );

    return response;
  }
}
