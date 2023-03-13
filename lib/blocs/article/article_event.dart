part of 'article_bloc.dart';

abstract class ArticleEvent extends Equatable {}

class LoadArticle extends ArticleEvent {
  final int? page;
  final int? category;
  final String? keyword;
  final String? type;
  final int? me;

  LoadArticle(
    this.page,
    this.category,
    this.keyword,
    this.type,
    this.me,
  );

  @override
  List<Object?> get props => [
        page,
        category,
        keyword,
        type,
        me,
      ];
}

class LoadArticleDetail extends ArticleEvent {
  final int? id;

  LoadArticleDetail(this.id);

  @override
  List<Object?> get props => [
        id,
      ];
}
