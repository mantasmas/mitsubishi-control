part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class LoginInitiated extends AuthState {}

class LoginDone extends AuthState {
  final String contextKey;
  final String name;

  LoginDone(this.contextKey, this.name);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is LoginDone && o.contextKey == contextKey && o.name == name;
  }

  @override
  int get hashCode => contextKey.hashCode ^ name.hashCode;
}

class LoginError extends AuthState {}
