import 'package:equatable/equatable.dart';

abstract class ImageUploadState extends Equatable {
  const ImageUploadState();
}

class ImageUploadInProgress extends ImageUploadState {
  const ImageUploadInProgress();
  
  @override
  List<Object> get props => [];
}

class ImageUploadSuccess extends ImageUploadState {
  final String imageUrl;

  const ImageUploadSuccess(this.imageUrl);

  @override
  List<Object> get props => [imageUrl];
}

class ImageUploadFailure extends ImageUploadState {
  final String error;

  const ImageUploadFailure(this.error);

  @override
  List<Object> get props => [error];
}
