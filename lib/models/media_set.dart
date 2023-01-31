import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'media_set.g.dart';

@JsonSerializable()
class MediaSet extends Equatable {
  final Media? media;

  const MediaSet({
    this.media,
  });

  factory MediaSet.fromJson(Map<String, dynamic> json) =>
      _$MediaSetFromJson(json);

  @override
  List<Object?> get props => [
        media,
      ];
}

@JsonSerializable()
class Media extends Equatable {
  final String? id;
  final String? url;
  final String? filetype;
  final String? filename;

  const Media({
    this.id,
    this.url,
    this.filetype,
    this.filename,
  });

  factory Media.fromJson(Map<String, dynamic> json) => _$MediaFromJson(json);

  @override
  List<Object?> get props => [
        id,
        url,
        filetype,
        filename,
      ];
}
