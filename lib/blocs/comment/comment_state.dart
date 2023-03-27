part of 'comment_bloc.dart';

abstract class CommentState extends BlocState {
  const CommentState({
    super.statusCode,
    super.message,
    super.errorCode,
  });
}

class CommentInitial extends CommentState {}

class ListCommentLoading extends CommentState {}

class ListCommentLoadingPaging extends CommentState {}

class ListCommentLoaded extends CommentState {
  final List<Comments> commentList;

  const ListCommentLoaded(this.commentList);
}

class ListCommentEmpty extends CommentState {}

class ListCommentError extends CommentState {
  final GenericErrorResponse errorResponse;

  const ListCommentError(this.errorResponse);
}

class StoreCommentLoading extends CommentState {}

class StoreCommentSuccess extends CommentState {}

class StoreCommentError extends CommentState {
  final GenericErrorResponse errorResponse;

  const StoreCommentError(this.errorResponse);
}
