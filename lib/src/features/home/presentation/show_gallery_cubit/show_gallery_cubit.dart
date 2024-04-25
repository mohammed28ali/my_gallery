import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_gallery/src/features/home/domain/repository/gallery_repository.dart';

class GalleryCubit extends Cubit<List<String>> {
  final GalleryRepository repository;

  GalleryCubit({required this.repository}) : super([]);
  void fetchGallery() async {
    final galleryEither = await repository.getGallery();
    galleryEither.fold(
      (error) {
        print('Error fetching gallery: $error');
        emit([]);
      },
      (images) => emit(images),
    );
  }
}
