import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile_carbon/models/models.dart';

class AuthApi {
  static const signInPath = '/auth/login';
  static const signInSocialPath = '/auth/login-social';
  static const registerPath = '/auth/register';
  static const forgetPasswordPath = '/auth/forget-password';
  static const accountDetailPath = '/account/detail';
  static const accountUpdatePath = '/account/update';

  final Dio _dio;

  const AuthApi(this._dio);

  Future<LoginResponse> signIn({
    required String email,
    required String password,
  }) async {
    var formData = FormData.fromMap({
      'email': email,
      'password': password,
    });

    final response = await _dio.post(
      signInPath,
      data: formData,
    );

    return LoginResponse.fromJson(response.data['data']);
  }

  Future<LoginResponse> signInGoogle({
    String? email,
    String? fullName,
    String? idExternal,
    String? token,
  }) async {
    var formData = FormData.fromMap({
      'email': email ?? "",
      'password': '',
      'full_name': fullName ?? "",
      'phone': '',
      'address': '',
      'id_external': idExternal ?? "",
      'type': 'Google',
      'fcm_token': token ?? "",
    });
    print("===> formData: ${formData.fields}");

    final response = await _dio.post(
      signInSocialPath,
      data: formData,
    );

    return LoginResponse.fromJson(response.data['data']);
  }

  Future<String> register({
    required String fullName,
    required String email,
    required String password,
  }) async {
    var formData = FormData.fromMap({
      'email': email,
      'password': password,
      'full_name': fullName,
    });

    final response = await _dio.post(
      registerPath,
      data: formData,
    );

    debugPrint("==> message register: ${response.data['message']}");
    return response.data['message'];
  }

  Future<String> forgetPassword({
    required String email,
  }) async {
    var formData = FormData.fromMap({
      'email': email,
    });

    final response = await _dio.post(
      forgetPasswordPath,
      data: formData,
    );

    debugPrint("==> message forget pass: ${response.data['message']}");
    return response.data['message'];
  }

  Future<AccountDetail> getAccountDetail() async {
    final response = await _dio.get(
      accountDetailPath,
    );

    return AccountDetail.fromJson(response.data['data']);
  }

  Future<void> storeAccountUpdate({
    String? name,
    String? email,
    String? phone,
    String? address,
    String? filePath,
  }) async {
    print("===> filePath is: $filePath");
    var formData = FormData.fromMap({
      'full_name': name,
      'email': email,
      'phone': phone,
      'address': address,
      // 'file': await MultipartFile.fromFile(
      //   filePath ?? "",
      // ),
    });

    if (filePath != null) {
      formData.files.add(
        MapEntry(
          "file",
          await MultipartFile.fromFile(filePath),
        ),
      );
    }

    print("===> formData: ${formData.fields}");

    await _dio.post(
      accountUpdatePath,
      data: formData,
    );
  }
}
