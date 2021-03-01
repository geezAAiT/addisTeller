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

  Future<void> updateSelf(Auth auth) async {
    return authDataProvider.updateSelf(auth);
  }

  Future<void> updateUser(Auth auth) async {
    return authDataProvider.updateUser(auth);
  }

  Future<List<Auth>> getUsers() async {
    return authDataProvider.getUsers();
  }
}
