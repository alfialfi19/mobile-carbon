import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'account_detail.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AccountDetail extends Equatable {
  final String? jwtToken;
  final String? fcmToken;
  final String? fullName;
  final String? email;
  final String? phone;
  final String? address;
  final String? level;
  @JsonKey(name: 'total_point_1')
  final String? totalPoint1;
  @JsonKey(name: 'total_point_2')
  final String? totalPoint2;
  @JsonKey(name: 'total_point_3')
  final String? totalPoint3;
  final String? status;
  final String? file;
  final String? role;
  final String? roleNama;
  final LevelDetail? levelDetail;

  const AccountDetail({
    this.jwtToken,
    this.fcmToken,
    this.fullName,
    this.email,
    this.phone,
    this.address,
    this.level,
    this.totalPoint1,
    this.totalPoint2,
    this.totalPoint3,
    this.status,
    this.file,
    this.role,
    this.roleNama,
    this.levelDetail,
  });

  Map<String, dynamic> toJson() => _$AccountDetailToJson(this);

  factory AccountDetail.fromJson(Map<String, dynamic> json) =>
      _$AccountDetailFromJson(json);

  @override
  List<Object?> get props => [
        jwtToken,
        fcmToken,
        fullName,
        email,
        phone,
        address,
        level,
        totalPoint1,
        totalPoint2,
        totalPoint3,
        status,
        file,
        role,
        roleNama,
        levelDetail,
      ];
}

@JsonSerializable(fieldRename: FieldRename.snake)
class LevelDetail extends Equatable {
  final String? level;
  final String? participant;
  final List<Participant> participantList;
  final String? nowAt;
  final String? deadlineAt;
  final int? deadlineDay;

  const LevelDetail({
    this.level,
    this.participant,
    this.participantList = const [],
    this.nowAt,
    this.deadlineAt,
    this.deadlineDay,
  });

  Map<String, dynamic> toJson() => _$LevelDetailToJson(this);

  factory LevelDetail.fromJson(Map<String, dynamic> json) =>
      _$LevelDetailFromJson(json);

  @override
  List<Object?> get props =>
      [level, participant, participantList, nowAt, deadlineAt, deadlineDay];
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Participant extends Equatable {
  final String? fullName;
  final String? file;

  const Participant({
    this.fullName,
    this.file,
  });

  factory Participant.fromJson(Map<String, dynamic> json) =>
      _$ParticipantFromJson(json);

  @override
  List<Object?> get props => [
        fullName,
        file,
      ];
}
