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
      yield LoadingState();
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
          yield UserLoginSucessState(auth: user);
        }
      } catch (e) {
        yield AuthFailureState(message: '${e.message}');
      }
    }
    if (event is RegisterButtonPressed) {
      yield LoadingState();
      try {
        await authRepo.registerUser(event.auth);
        final users = await authRepo.getUsers();
        yield UsersLoadSucessState(users);
        yield UserRegisterSucessState();
      } catch (e) {
        yield AuthFailureState(message: '${e.message}');
      }
    }
    if (event is UsersLoad) {
      yield LoadingState();
      try {
        final users = await authRepo.getUsers();
        // print('user 1 : $users[0]');
        print("on the user load bloc $users");
        yield UsersLoadSucessState(users);
      } catch (e) {
        yield AuthFailureState(message: '${e.message}');
      }
    }
    if (event is UserUpdate) {
      yield LoadingState();
      try {
        await authRepo.updateUser(event.auth);
        final users = await authRepo.getUsers();
        yield UsersLoadSucessState(users);
      } catch (e) {
        yield AuthFailureState(message: '${e.message}');
      }
    }
    if (event is UserSelfUpdate) {
      yield LoadingState();
      try {
        await authRepo.updateSelf(event.auth);
      } catch (e) {
        yield AuthFailureState(message: '${e.message}');
      }
    }

    if (event is UserDelete) {
      yield LoadingState();
      try {
        await authRepo.deleteUser(event.auth.id);
        final users = await authRepo.getUsers();
        yield UsersLoadSucessState(users);
      } catch (e) {
        yield AuthFailureState(message: '${e.message}');
      }
    }

    if (event is LoggedInUser) {
      try {
        final user = await authRepo.getUserByID(event.id);
        print("loggedin state: $user");
        yield LoggedInUserSuccessState(user: user);
      } catch (e) {
        yield AuthFailureState(message: '${e.message}');
      }
    }
  }
}
