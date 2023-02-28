part of 'article_bloc.dart';

abstract class ArticleEvent extends Equatable {}

class LoadArticle extends ArticleEvent {
  final int? page;
  final int? category;
  final String? keyword;
  final String? type;

  LoadArticle(this.page, this.category, this.keyword, this.type);

  @override
  List<Object?> get props => [
        page,
        category,
        keyword,
        type,
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
