import '../../models/models.dart';

class EmisiArgument {
  final String? idCategory;
  final String? idSubCategory;
  final String? val;
  final String? unit;
  final String? source;
  final List<EmisiCategory> selectedCategory;

  EmisiArgument({
    this.idCategory,
    this.idSubCategory,
    this.val,
    this.unit,
    this.source,
    this.selectedCategory = const [],
  });
}
