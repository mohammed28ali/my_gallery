import 'package:equatable/equatable.dart';

// Base class for image upload states
abstract class ImageUploadState extends Equatable {
  const ImageUploadState();

  @override
  List<Object> get props => [];
}

// Initial state before any image upload operation
class ImageUploadInitial extends ImageUploadState {}

// State representing that an image upload is in progress
class ImageUploadInProgress extends ImageUploadState {}

// State representing that the image upload was successful
class ImageUploadSuccess extends ImageUploadState {
  final String imageUrl;

  const ImageUploadSuccess(this.imageUrl);

  @override
  List<Object> get props => [imageUrl];
}

// State representing that the image upload failed
class ImageUploadFailure extends ImageUploadState {
  final String error;

  const ImageUploadFailure(this.error);

  @override
  List<Object> get props => [error];
}
