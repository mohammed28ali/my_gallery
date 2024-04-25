import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImageDataProvider {
  final Dio _dio;

  ImageDataProvider(this._dio);

  Future<String> uploadImage(String imagePath) async {
    try {
      if (imagePath.isEmpty) {
        throw Exception('Image path is empty.');
      }

      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      if (token == null) {
        throw Exception('No user found.');
      }

      FormData formData = FormData.fromMap({
        "img": await MultipartFile.fromFile(imagePath, filename: "image.jpg")
      });

      final response = await _dio.post(
        'https://flutter.prominaagency.com/api/upload',
        data: formData,
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      if (response.data['status'] == 'success') {
        return '';
      } else {
        throw Exception('Image upload failed: ${response.data['message']}');
      }
    } catch (e) {
      log('Error uploading image: $e');
      rethrow;
    }
  }

  Future<List<String>> fetchGalleryImages() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      if (token == null) {
        throw Exception('No user found.');
      }
      log('Token: $token');

      final response = await _dio.get(
        'https://flutter.prominaagency.com/api/my-gallery',
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      if (response.data['status'] == 'success') {
        final List<String> images =
            List<String>.from(response.data['data']['images']);
        return images;
      } else {
        throw Exception(
            'Failed to fetch gallery images: ${response.data['message']}');
      }
    } catch (e) {
      log('Error fetching gallery images: $e');
      rethrow;
    }
  }
}
