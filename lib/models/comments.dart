import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'comments.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Comments extends Equatable {
  final String? id;
  final String? idParent;
  final String? idChild;
  final String? article;
  final String? articleName;
  final String? writer;
  final String? writerName;
  final String? receiver;
  final String? receiverName;
  final String? desc;
  final String? file;
  final String? status;
  final String? createdBy;
  final String? createdAt;
  final String? updatedAt;
  final String? processedBy;
  final String? processedAt;
  final List<CommentsItem>? item;

  const Comments({
    this.id,
    this.idParent,
    this.idChild,
    this.article,
    this.articleName,
    this.writer,
    this.writerName,
    this.receiver,
    this.receiverName,
    this.desc,
    this.file,
    this.status,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.processedBy,
    this.processedAt,
    this.item,
  });

  Map<String, dynamic> toJson() => _$CommentsToJson(this);

  factory Comments.fromJson(Map<String, dynamic> json) =>
      _$CommentsFromJson(json);

  @override
  List<Object?> get props => [
        id,
        idParent,
        idChild,
        article,
        articleName,
        writer,
        writerName,
        receiver,
        receiverName,
        desc,
        file,
        status,
        createdBy,
        createdAt,
        updatedAt,
        processedBy,
        processedAt,
        item,
      ];
}

@JsonSerializable(fieldRename: FieldRename.snake)
class CommentsItem extends Equatable {
  final String? id;
  final String? idParent;
  final String? idChild;
  final String? article;
  final String? articleName;
  final String? writer;
  final String? writerName;
  final String? receiver;
  final String? receiverName;
  final String? desc;
  final String? file;
  final String? status;
  final String? createdBy;
  final String? createdAt;
  final String? updatedAt;
  final String? processedBy;
  final String? processedAt;

  const CommentsItem({
    this.id,
    this.idParent,
    this.idChild,
    this.article,
    this.articleName,
    this.writer,
    this.writerName,
    this.receiver,
    this.receiverName,
    this.desc,
    this.file,
    this.status,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.processedBy,
    this.processedAt,
  });

  Map<String, dynamic> toJson() => _$CommentsItemToJson(this);

  factory CommentsItem.fromJson(Map<String, dynamic> json) =>
      _$CommentsItemFromJson(json);

  @override
  List<Object?> get props => [
        id,
        idParent,
        idChild,
        article,
        articleName,
        writer,
        writerName,
        receiver,
        receiverName,
        desc,
        file,
        status,
        createdBy,
        createdAt,
        updatedAt,
        processedBy,
        processedAt,
      ];
}
