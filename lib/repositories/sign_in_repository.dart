import 'package:mobile_carbon/api/api.dart';
import 'package:mobile_carbon/commons/commons.dart';

class SignInRepository {
  final SignInApi _signInApi;
  final PrefHelper _prefHelper;

  SignInRepository(
    this._signInApi,
    this._prefHelper,
  );

  Future<void> signIn() async {}
}
