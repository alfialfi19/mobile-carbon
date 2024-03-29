part of 'article_bloc.dart';

abstract class ArticleEvent extends Equatable {}

class LoadArticle extends ArticleEvent {
  final int? page;
  final int? category;
  final String? keyword;
  final String? type;
  final int? me;
  final List<ArticleDetail>? currentData;

  LoadArticle({
    this.page,
    this.category,
    this.keyword,
    this.type,
    this.me,
    this.currentData,
  });

  @override
  List<Object?> get props => [
        page,
        category,
        keyword,
        type,
        me,
        currentData,
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

class UpdateArticle extends ArticleEvent {
  final String? articleId;
  final int? categoryId;
  final String? title;
  final List<String>? filePath;
  final String? desc;

  UpdateArticle({
    this.articleId,
    this.categoryId,
    this.title,
    this.filePath,
    this.desc,
  });

  @override
  List<Object?> get props => [
        articleId,
        categoryId,
        title,
        filePath,
        desc,
      ];
}

class DeleteArticle extends ArticleEvent {
  final String? idArticle;

  DeleteArticle({
    this.idArticle,
  });

  @override
  List<Object?> get props => [
        idArticle,
      ];
}
