import 'package:dio/dio.dart';
import 'package:mobile_carbon/models/models.dart';

class AuthApi {
  static const signInPath = '/auth/login';
  static const accountDetailPath = '/account/detail';

  final Dio _dio;

  const AuthApi(this._dio);

  Future<LoginResponse> signIn({
    required String email,
    required String password,
  }) async {
    var formData = FormData.fromMap({
      'email': email,
      'password': password,
      // 'file': await MultipartFile.fromFile(
      //   './text.txt',
      //   filename: 'upload.txt',
      // )
    });

    final response = await _dio.post(
      signInPath,
      data: formData,
    );

    return LoginResponse.fromJson(response.data['data']);
  }

  Future<AccountDetail> getAccountDetail() async {
    final response = await _dio.get(
      accountDetailPath,
    );

    return AccountDetail.fromJson(response.data['data']);
  }
}
