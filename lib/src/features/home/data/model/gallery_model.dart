import 'package:equatable/equatable.dart';


class GalleryState extends Equatable {
  final List<String> images;

  GalleryState({required this.images});

  @override
  List<Object?> get props => [images];
}
