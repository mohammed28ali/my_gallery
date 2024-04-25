import 'package:equatable/equatable.dart';
import 'package:my_gallery/src/features/login/domain/usecases/loginUseCase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;
  final SharedPreferences sharedPreferences;

  LoginCubit({required this.loginUseCase, required this.sharedPreferences})
      : super(LoginInitial());

  Future<void> login(String email, String password) async {
    emit(LoginLoading());
    try {
      final token = await loginUseCase(email, password);
      await sharedPreferences.setString('token', token);
      emit(LoginSuccess());
    } catch (e) {
      emit(LoginFailure(error: e.toString()));
    }
  }
}
