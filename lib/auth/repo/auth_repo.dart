import 'package:addis_teller_app/auth/auth.dart';
import 'package:meta/meta.dart';

class AuthRepo {
  final AuthDataProvider authDataProvider;
  AuthRepo({@required this.authDataProvider})
      : assert(authDataProvider != null);

  Future<Auth> loginUser(Auth auth) async {
    return authDataProvider.loginUser(auth);
  }

  Future<Auth> registerUser(Auth auth) async {
    return authDataProvider.registerUser(auth);
  }
}
