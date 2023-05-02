part of 'eco_activity_bloc.dart';

abstract class EcoActivityEvent extends Equatable {}

class LoadEcoActivity extends EcoActivityEvent {
  final int? page;
  final int? category;
  final String? keyword;
  final List<ArticleDetail>? currentData;
  final String me;

  LoadEcoActivity({
    this.page,
    this.category,
    this.keyword,
    this.currentData,
    this.me = "0",
  });

  @override
  List<Object?> get props => [
        page,
        category,
        keyword,
        currentData,
        me,
      ];
}

class LoadEcoActivityDetail extends EcoActivityEvent {
  final int? id;

  LoadEcoActivityDetail(this.id);

  @override
  List<Object?> get props => [
        id,
      ];
}
