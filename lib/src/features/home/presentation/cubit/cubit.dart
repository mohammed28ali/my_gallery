import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_gallery/src/features/home/data/datasource/datasource.dart';
import 'package:my_gallery/src/features/home/data/repository/repository.dart';
import 'package:my_gallery/src/features/home/domain/Entity/entity.dart';
import 'package:my_gallery/src/features/home/domain/repository/repository.dart';
import 'package:my_gallery/src/features/home/presentation/cubit/states.dart';

import 'dart:isolate';

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
        await _uploadImage(pickedImage.path);
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
        await _uploadImage(pickedImage.path);
      }
    } catch (e) {
      emit(ImageUploadFailure('Failed to pick image: $e'));
    }
  }

  Future<void> _uploadImage(String imagePath) async {
    final response = ReceivePort();
    await Isolate.spawn(_uploadIsolate, response.sendPort);

    response.listen((message) {
      if (message is String) {
        emit(ImageUploadFailure('Failed to upload image: $message'));
      } else if (message is ImageEntity) {
        emit(ImageUploadSuccess(message.imageUrl));
      }
    });

    response.close();
  }

  static void _uploadIsolate(SendPort sendPort) async {
    final receivePort = ReceivePort();
    sendPort.send(receivePort.sendPort);

    receivePort.listen((message) async {
      if (message is String) {
        sendPort.send(message);
      } else if (message is String) {
        try {
          final result = await ImageRepositoryImpl(ImageDataProvider(Dio()))
              .uploadImage(message);
          result.fold(
            (failure) => sendPort.send(failure.message),
            (imageEntity) => sendPort.send(imageEntity),
          );
        } catch (e) {
          sendPort.send('Failed to upload image: $e');
        }
      }
    });

    receivePort.close();
  }
}
