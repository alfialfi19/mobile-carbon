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

  Future<AccountDetail> getAccountDetail() async {
    final response = await _authApi.getAccountDetail();

    return response;
  }
}
