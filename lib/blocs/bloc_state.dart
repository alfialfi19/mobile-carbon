import 'package:equatable/equatable.dart';
import '../commons/constants/error_code.dart';

abstract class BlocState extends Equatable {
  final int? statusCode;
  final String? message;
  final String? errorCode;

  const BlocState({this.statusCode, this.message, this.errorCode});

  @override
  List<Object?> get props => [statusCode, message, errorCode];

  bool get isConnectionError => checkConnectionError(statusCode);
}
