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

class StoreArticle extends ArticleEvent {
  final int? categoryId;
  final String? title;
  final List<String>? filePath;
  final String? desc;

  StoreArticle({
    this.categoryId,
    this.title,
    this.filePath,
    this.desc,
  });

  @override
  List<Object?> get props => [
        categoryId,
        title,
        filePath,
        desc,
      ];
}
