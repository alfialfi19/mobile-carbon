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

class ListArticleLoadingPaging extends ArticleState {}

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

class UpdateArticleLoading extends ArticleState {}

class UpdateArticleSuccess extends ArticleState {}

class UpdateArticleError extends ArticleState {
  final GenericErrorResponse errorResponse;

  const UpdateArticleError(this.errorResponse);
}

class DeleteArticleLoading extends ArticleState {}

class DeleteArticleSuccess extends ArticleState {}

class DeleteArticleError extends ArticleState {
  final GenericErrorResponse errorResponse;

  const DeleteArticleError(this.errorResponse);
}
