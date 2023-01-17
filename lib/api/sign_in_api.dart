import 'package:dio/dio.dart';

class SignInApi {
  static const signInPath = '/mobile/sign-in';

  final Dio _dio;

  const SignInApi(this._dio);

  Future<void> signIn() async {}
}
