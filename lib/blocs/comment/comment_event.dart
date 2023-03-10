part of 'comment_bloc.dart';

abstract class CommentEvent extends Equatable {}

class LoadComment extends CommentEvent {
  final int? page;
  final int? id;
  final String? source;

  LoadComment(
    this.page,
    this.id,
    this.source,
  );

  @override
  List<Object?> get props => [
        page,
        id,
        source,
      ];
}

class StoreComment extends CommentEvent {
  final int? idArticle;
  final int? idParent;
  final String? desc;
  final String? source;

  StoreComment(
    this.idArticle,
    this.idParent,
    this.desc,
    this.source,
  );

  @override
  List<Object?> get props => [
        idArticle,
        idParent,
        desc,
        source,
      ];
}
