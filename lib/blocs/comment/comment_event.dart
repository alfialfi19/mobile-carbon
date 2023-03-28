part of 'comment_bloc.dart';

abstract class CommentEvent extends Equatable {}

class LoadComment extends CommentEvent {
  final int? page;
  final int? id;
  final String? source;
  final List<Comments>? currentData;

  LoadComment({
    this.page,
    this.id,
    this.source,
    this.currentData,
  });

  @override
  List<Object?> get props => [
        page,
        id,
        source,
        currentData,
      ];
}

class StoreComment extends CommentEvent {
  final int? idArticle;
  final int? idParent;
  final String? idComment;
  final String? desc;
  final String? source;

  StoreComment({
    this.idArticle,
    this.idParent,
    this.idComment,
    this.desc,
    this.source,
  });

  @override
  List<Object?> get props => [
        idArticle,
        idParent,
        idComment,
        desc,
        source,
      ];
}
