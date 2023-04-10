import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notification_detail.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class NotificationDetail extends Equatable {
  final String? id;
  final String? type;
  final String? idArticle;
  final String? idParent;
  final String? idChild;
  final String? idReceiver;
  final String? title;
  final String? desc;
  final String? file;
  final String? status;
  final String? createdBy;
  final String? createdAt;
  final String? updatedAt;

  const NotificationDetail({
    this.id,
    this.type,
    this.idArticle,
    this.idParent,
    this.idChild,
    this.idReceiver,
    this.title,
    this.desc,
    this.file,
    this.status,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toJson() => _$NotificationDetailToJson(this);

  factory NotificationDetail.fromJson(Map<String, dynamic> json) =>
      _$NotificationDetailFromJson(json);

  @override
  List<Object?> get props => [
        id,
        type,
        idArticle,
        idParent,
        idChild,
        idReceiver,
        title,
        desc,
        file,
        status,
        createdBy,
        createdAt,
        updatedAt,
      ];
}
