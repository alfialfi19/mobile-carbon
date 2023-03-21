import 'package:mobile_carbon/api/api.dart';
import 'package:mobile_carbon/commons/commons.dart';
import 'package:mobile_carbon/models/models.dart';

class AuthRepository {
  final AuthApi _authApi;
  final PrefHelper _prefHelper;

  AuthRepository(
    this._authApi,
    this._prefHelper,
  );

  Future<LoginResponse> signIn({
    required String email,
    required String password,
  }) async {
    final response = await _authApi.signIn(
      email: email,
      password: password,
    );

    if (response.token != null) {
      // Set token to prefHelper after get response
      _prefHelper.setAccessToken(response.token!);
    }

    return response;
  }

  Future<LoginResponse> signInGoogle({
    String? email,
    String? fullName,
    String? idExternal,
    String? token,
  }) async {
    final response = await _authApi.signInGoogle(
      email: email,
      fullName: fullName,
      idExternal: idExternal,
      token: token,
    );

    if (response.token != null) {
      // Set token to prefHelper after get response
      _prefHelper.setAccessToken(response.token!);
    }

    return response;
  }

  Future<String> register({
    required String fullName,
    required String email,
    required String password,
  }) async {
    final response = await _authApi.register(
      fullName: fullName,
      email: email,
      password: password,
    );

    return response;
  }

  Future<String> forgetPassword({
    required String email,
  }) async {
    final response = await _authApi.forgetPassword(
      email: email,
    );

    return response;
  }

  Future<AccountDetail> getAccountDetail() async {
    final response = await _authApi.getAccountDetail();

    return response;
  }

  Future<void> storeAccountUpdate({
    String? name,
    String? email,
    String? phone,
    String? address,
  }) async {
    await _authApi.storeAccountUpdate(
      name: name,
      email: email,
      phone: phone,
      address: address,
    );
  }
}
