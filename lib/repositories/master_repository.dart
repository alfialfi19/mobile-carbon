import 'package:mobile_carbon/api/api.dart';
import 'package:mobile_carbon/models/models.dart';

class MasterRepository {
  final MasterApi _masterApi;

  MasterRepository(this._masterApi);

  Future<List<EmisiCategory>> getArticleCategory() async {
    final response = await _masterApi.getArticleCategory();

    return response;
  }

  Future<List<EmisiCategory>> getEmisiCategory() async {
    final response = await _masterApi.getEmisiCategory();

    return response;
  }

  Future<List<EmisiCategory>> getEmisiSubCategory({
    int? id,
  }) async {
    final response = await _masterApi.getEmisiSubCategory(
      id: id,
    );

    return response;
  }
}
