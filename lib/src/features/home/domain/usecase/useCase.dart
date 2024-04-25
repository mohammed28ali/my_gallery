import 'package:dartz/dartz.dart';
import 'package:my_gallery/src/core/api/error.dart';
import 'package:my_gallery/src/features/home/domain/Entity/entity.dart';

abstract class ImageUploadUseCase {
  Future<Either<Failure, ImageEntity>> uploadImage(String imagePath);
}
