import 'package:dio/dio.dart';

import '../commons/commons.dart';
import 'api.dart';

class BaseDioClient {
  final Flavor flavor;
  final Dio _dio;
  final PrefHelper? prefHelper;

  Dio get dio => _dio;

  BaseDioClient({
    required this.flavor,
    this.prefHelper,
  }) : _dio = Dio() {
    // if (flavor == Flavor.staging) {
    //   _dio.options.baseUrl = baseUrlDev;
    // } else {
    //   _dio.options.baseUrl = baseUrlProd;
    // }
    _dio.options.baseUrl = baseUrlProd;

    // if (flavor == Flavor.prod) {
    //   _dio.interceptors.add(_interceptor);
    // } else {
    //   _dio.interceptors
    //     ..add(_interceptor)
    //     ..add(LogInterceptor(requestBody: true, responseBody: true));
    // }
    _dio.interceptors
      ..add(_interceptor)
      ..add(LogInterceptor(requestBody: true, responseBody: true));
  }

  Map<String, dynamic> _header(String token) {
    return {'Authorization': token};
  }

  Interceptor get _interceptor => QueuedInterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await prefHelper?.getAccessToken();
          if (token != null) {
            options.headers.addAll(_header(token));
          }

          return handler.next(options);
        },
        onError: (dioError, handler) async {
          return handler.next(dioError);
        },
      );
}
