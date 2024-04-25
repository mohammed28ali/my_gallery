import 'package:dartz/dartz.dart';

abstract class GalleryRepository {
  Future<Either<String, List<String>>> getGallery();
}
