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
    int? me,
  }) async {
    final response = await _articleApi.getListArticle(
      page: page,
      category: category,
      keyword: keyword,
      type: type,
      me: me,
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

  Future<void> storeArticle({
    int? categoryId,
    String? title,
    List<String>? filePath,
    String? desc,
  }) async {
    await _articleApi.storeArticle(
      categoryId: categoryId,
      title: title,
      filePath: filePath,
      desc: desc,
    );
  }
}
