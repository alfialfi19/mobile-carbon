import 'package:mobile_carbon/api/api.dart';

import '../models/models.dart';

class EcoActivityRepository {
  final EcoActivityApi _ecoActivityApi;

  EcoActivityRepository(this._ecoActivityApi);

  Future<List<ArticleDetail>> getListEcoActivity({
    int? page,
    int? category,
    String? keyword,
  }) async {
    final response = await _ecoActivityApi.getListEcoActivity(
      page: page,
      category: category,
      keyword: keyword,
    );

    return response;
  }
}
