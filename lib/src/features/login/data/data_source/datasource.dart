import 'package:dio/dio.dart';

class AuthRemoteDataSource {
  final ApiClient apiClient;

  AuthRemoteDataSource({required this.apiClient});

  Future<String> login(String email, String password) async {
    final response = await apiClient.postLogin(email, password);
    final token = response.data['token'] as String;
    return token;
  }
}

class ApiClient {
  final Dio _dio = Dio();

  Future<Response> postLogin(String email, String password) async {
    try {
      return await _dio.post(
        'https://flutter.prominaagency.com/api/auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
