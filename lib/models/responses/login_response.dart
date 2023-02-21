import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class LoginResponse extends Equatable {
  final String? token;
  final String? createdAt;
  final String? expiredAt;

  const LoginResponse({
    this.token,
    this.createdAt,
    this.expiredAt,
  });

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  @override
  List<Object?> get props => [
        token,
        createdAt,
        expiredAt,
      ];
}
