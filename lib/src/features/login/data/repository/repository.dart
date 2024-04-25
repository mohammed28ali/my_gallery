import 'package:my_gallery/src/features/login/data/data_source/datasource.dart';

class AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepository({required this.remoteDataSource});

  Future<String> login(String email, String password) async {
    return await remoteDataSource.login(email, password);
  }
}
