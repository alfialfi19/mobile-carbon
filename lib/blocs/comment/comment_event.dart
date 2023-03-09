part of 'comment_bloc.dart';

abstract class CommentEvent extends Equatable {}

class LoadComment extends CommentEvent {
  final int? page;
  final int? id;

  LoadComment(this.page, this.id);

  @override
  List<Object?> get props => [
        page,
        id,
      ];
}
