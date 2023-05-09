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

  final bool value;

  const EmisiCategory({
    this.id,
    this.opt,
    this.file,
    this.idCategory,
    this.category,
    this.unit,
    this.value = false,
  });

  Map<String, dynamic> toJson() => _$EmisiCategoryToJson(this);

  factory EmisiCategory.fromJson(Map<String, dynamic> json) =>
      _$EmisiCategoryFromJson(json);

  copyWith({
    String? id,
    String? opt,
    String? file,
    String? idCategory,
    String? category,
    String? unit,
    bool? value,
  }) {
    return EmisiCategory(
      id: id ?? this.id,
      opt: opt ?? this.opt,
      file: file ?? this.file,
      idCategory: idCategory ?? this.idCategory,
      unit: unit ?? this.unit,
      value: value ?? this.value,
    );
  }

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
