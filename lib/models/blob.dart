import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'blob.g.dart';

@JsonSerializable()
class Blob extends Equatable {
  final String? id;
  final String? url;
  final String? fileName;
  final String? filePath;
  final String? fileType;
  final String? createdAt;
  final String? updatedAt;

  const Blob({
    this.id,
    this.url,
    this.fileName,
    this.filePath,
    this.fileType,
    this.createdAt,
    this.updatedAt,
  });

  factory Blob.fromJson(Map<String, dynamic> json) => _$BlobFromJson(json);

  @override
  List<Object?> get props => [
        id,
        url,
        fileName,
        filePath,
        fileType,
        createdAt,
        updatedAt,
      ];
}
