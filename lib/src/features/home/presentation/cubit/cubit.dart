import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_gallery/src/features/home/data/datasource/datasource.dart';
import 'package:my_gallery/src/features/home/data/repository/repository.dart';
import 'package:my_gallery/src/features/home/domain/repository/repository.dart';
import 'package:my_gallery/src/features/home/presentation/cubit/states.dart';

class ImageUploadCubit extends Cubit<ImageUploadState> {
  final ImageRepository _repository =
      ImageRepositoryImpl(ImageDataProvider(Dio()));
  final ImagePicker _picker = ImagePicker();

  ImageUploadCubit() : super(ImageUploadInitial());

  Future<void> pickImageFromGallery() async {
    emit(ImageUploadInProgress());
    try {
      final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        _uploadImage(pickedImage.path);
      }
    } catch (e) {
      emit(ImageUploadFailure('Failed to pick image: $e'));
    }
  }

  Future<void> pickImageFromCamera() async {
    emit(ImageUploadInProgress());
    try {
      final pickedImage = await _picker.pickImage(source: ImageSource.camera);
      if (pickedImage != null) {
        _uploadImage(pickedImage.path);
      }
    } catch (e) {
      emit(ImageUploadFailure('Failed to pick image: $e'));
    }
  }

  Future<void> _uploadImage(String imagePath) async {
    try {
      final result = await _repository.uploadImage(imagePath);
      result.fold(
        (failure) => emit(ImageUploadFailure(failure.message)),
        (imageEntity) => emit(ImageUploadSuccess(imageEntity.imageUrl)),
      );
    } catch (e) {
      emit(ImageUploadFailure('Failed to upload image: $e'));
    }
  }
}
