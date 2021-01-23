import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mitsubishi_control/models/auth.dart';
import 'package:mitsubishi_control/repository/mel_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final MELRepository _melRepository;

  AuthCubit(this._melRepository) : super(AuthInitial());

  Future<void> login(AuthInfo authInfo) async {
    try {
      emit(LoginInitiated());

      final response = await _melRepository.login(authInfo);

      if (response.isSucessful) {
        emit(LoginDone(response.contextKey, response.name));
      } else {
        emit(LoginError());
      }
    } catch (error) {
      emit(LoginError());
    }
  }
}
