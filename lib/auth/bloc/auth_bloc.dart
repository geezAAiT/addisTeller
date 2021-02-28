import 'package:addis_teller_app/auth/bloc/bloc.dart';
import 'package:addis_teller_app/auth/auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo authRepo;
  AuthBloc({@required this.authRepo})
      : assert(authRepo != null),
        super(FormInitState());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (event is StartEvent) yield FormInitState();
    if (event is LoginButtonPressed) {
      yield LoginLoadingState();
      try {
        final user = await authRepo.loginUser(event.auth);
        print('useris $user');
        if (user.isAdmin) {
          pref.setString("token", user.token);
          pref.setBool("isAdmin", user.isAdmin);
          pref.setString("id", user.id);
          yield AdminLoginSucessState(auth: user);
        } else {
          pref.setString("token", user.token);
          pref.setBool("isAdmin", user.isAdmin);
          pref.setString("id", user.id);
          yield UserLoginSucessState();
        }
      } catch (e) {
        yield LoginErrorState(message: '${e.message}');
      }
    }
    if (event is RegisterButtonPressed) {
      yield RegisterLoadingState();
      try {
        final user = await authRepo.registerUser(event.auth);
        yield UserRegisterSucessState();
      } catch (e) {
        yield LoginErrorState(message: '${e.message}');
      }
    }
  }
}
