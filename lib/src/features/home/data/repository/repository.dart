import 'package:my_gallery/src/core/api/error.dart';
import 'package:my_gallery/src/features/home/data/datasource/datasource.dart';
import 'package:dartz/dartz.dart';
import 'package:my_gallery/src/features/home/domain/Entity/entity.dart';
import 'package:my_gallery/src/features/home/domain/repository/repository.dart';

class ImageRepositoryImpl implements ImageRepository {
  final ImageDataProvider _dataProvider;

  ImageRepositoryImpl(this._dataProvider);

  @override
  Future<Either<Failure, ImageEntity>> uploadImage(String imagePath) async {
    try {
      final imageUrl = await _dataProvider.uploadImage(imagePath);
      return Right(ImageEntity(imageUrl));
    } catch (e) {
      return Left(Failure('Failed to upload image: $e'));
    }
  }
}
