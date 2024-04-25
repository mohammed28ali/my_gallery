import 'package:my_gallery/src/features/login/data/repository/repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase({required this.repository});

  Future<String> call(String email, String password) async {
    return await repository.login(email, password);
  }
}
