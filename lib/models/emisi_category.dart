import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'emisi_category.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class EmisiCategory extends Equatable {
  final String? id;
  final String? opt;
  final String? file;
  final String? idCategory;
  final String? category;
  final String? unit;

  const EmisiCategory({
    this.id,
    this.opt,
    this.file,
    this.idCategory,
    this.category,
    this.unit,
  });

  Map<String, dynamic> toJson() => _$EmisiCategoryToJson(this);

  factory EmisiCategory.fromJson(Map<String, dynamic> json) =>
      _$EmisiCategoryFromJson(json);

  @override
  List<Object?> get props => [
        id,
        opt,
        file,
        idCategory,
        category,
        unit,
      ];
}
