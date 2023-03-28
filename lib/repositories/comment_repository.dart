import 'package:mobile_carbon/api/api.dart';
import 'package:mobile_carbon/models/models.dart';

class CommentRepository {
  final CommentApi _commentApi;

  CommentRepository(this._commentApi);

  Future<List<Comments>> getListComment({
    int? page,
    int? id,
    String? source,
  }) async {
    final response = await _commentApi.getListComment(
      page: page,
      id: id,
      source: source,
    );

    return response;
  }

  Future<void> storeComment({
    int? idArticle,
    int? idParent,
    String? idComment,
    String? desc,
    String? source,
  }) async {
    final response = await _commentApi.storeComment(
      idArticle: idArticle,
      idParent: idParent,
      idComment: idComment,
      desc: desc,
      source: source,
    );
  }
}
