part of 'article_bloc.dart';

abstract class ArticleState extends BlocState {
  const ArticleState({
    super.statusCode,
    super.message,
    super.errorCode,
  });
}

class ArticleInitial extends ArticleState {}

class ListArticleLoading extends ArticleState {}

class ListArticleLoaded extends ArticleState {
  final List<ArticleDetail> articleList;

  const ListArticleLoaded(this.articleList);
}

class ListArticleEmpty extends ArticleState {}

class ListArticleError extends ArticleState {
  final GenericErrorResponse errorResponse;

  const ListArticleError(this.errorResponse);
}

class DetailArticleLoading extends ArticleState {}

class DetailArticleLoaded extends ArticleState {
  final ArticleDetail article;

  const DetailArticleLoaded(this.article);
}

class DetailArticleError extends ArticleState {
  final GenericErrorResponse errorResponse;

  const DetailArticleError(this.errorResponse);
}

class StoreArticleLoading extends ArticleState {}

class StoreArticleSuccess extends ArticleState {}

class StoreArticleError extends ArticleState {
  final GenericErrorResponse errorResponse;

  const StoreArticleError(this.errorResponse);
}
