import 'package:mobile_carbon/api/api.dart';
import 'package:mobile_carbon/models/models.dart';

class ArticleRepository {
  final ArticleApi _articleApi;

  ArticleRepository(this._articleApi);

  Future<List<ArticleDetail>> getListArticle({
    int? page,
    int? category,
    String? keyword,
    String? type,
  }) async {
    final response = await _articleApi.getListArticle(
      page: page,
      category: category,
      keyword: keyword,
      type: type,
    );

    return response;
  }

  Future<ArticleDetail> getDetailArticle({
    int? id,
  }) async {
    final response = await _articleApi.getDetailArticle(
      id: id,
    );

    return response;
  }
}
