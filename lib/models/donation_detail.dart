import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'donation_detail.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class DonationDetail extends Equatable {
  final String? id;
  final String? slug;
  final String? title;
  final String? location;
  final String? activityAt;
  final String? contact;
  final String? deadlineAt;
  final String? url;
  final String? writer;
  final String? writerName;
  final String? desc;
  final String? totalViews;
  final List? file;
  final String? status;
  final String? createdBy;
  final String? createdAt;
  final String? updatedAt;
  final String? processedBy;
  final String? processedAt;
  final String? writerImg;

  const DonationDetail({
    this.id,
    this.slug,
    this.title,
    this.location,
    this.activityAt,
    this.contact,
    this.deadlineAt,
    this.url,
    this.writer,
    this.writerName,
    this.desc,
    this.totalViews,
    this.file,
    this.status,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.processedBy,
    this.processedAt,
    this.writerImg,
  });

  Map<String, dynamic> toJson() => _$DonationDetailToJson(this);

  factory DonationDetail.fromJson(Map<String, dynamic> json) =>
      _$DonationDetailFromJson(json);

  @override
  List<Object?> get props => [
        id,
        slug,
        title,
        location,
        activityAt,
        contact,
        deadlineAt,
        url,
        writer,
        writerName,
        desc,
        totalViews,
        file,
        status,
        createdBy,
        createdAt,
        updatedAt,
        processedBy,
        processedAt,
        writerImg,
      ];
}
