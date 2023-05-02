import 'package:mobile_carbon/api/api.dart';

import '../models/models.dart';

class EcoActivityRepository {
  final EcoActivityApi _ecoActivityApi;

  EcoActivityRepository(this._ecoActivityApi);

  Future<List<ArticleDetail>> getListEcoActivity({
    int? page,
    int? category,
    String? keyword,
    required String me,
  }) async {
    final response = await _ecoActivityApi.getListEcoActivity(
      page: page,
      category: category,
      keyword: keyword,
      me: me,
    );

    return response;
  }

  Future<ArticleDetail> getDetailEcoActivity({
    int? id,
  }) async {
    final response = await _ecoActivityApi.getDetailEcoActivity(
      id: id,
    );

    return response;
  }
}
