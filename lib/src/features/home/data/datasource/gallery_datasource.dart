import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:my_gallery/src/features/home/domain/repository/gallery_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GalleryRepositoryImpl implements GalleryRepository {
  final String baseUrl = 'https://flutter.prominaagency.com/api/my-gallery';
  final Dio _dio = Dio();

  @override
  Future<Either<String, List<String>>> getGallery() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      if (token == null) {
        throw Exception('No user found.');
      }

      _dio.options.headers['Authorization'] = 'Bearer $token';

      final response = await _dio.get(baseUrl);

      log('Response body: ${response.data}');

      if (response.statusCode == 200) {
        final data = response.data;
        final List<String> images = List<String>.from(data['data']['images']);
        return Right(images);
      } else {
        return const Left('Failed to fetch gallery');
      }
    } catch (e) {
      return Left('Failed to fetch gallery: $e');
    }
  }
}
