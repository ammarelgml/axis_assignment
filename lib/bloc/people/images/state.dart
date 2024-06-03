part of 'bloc.dart';

abstract class ImagesState {}

class ImagesInitial extends ImagesState {}

class LoadedImagesState extends ImagesState {
  final List<PersonImage> imagesList;

  LoadedImagesState({required this.imagesList});
}

class LoadingImagesState extends ImagesState {}

class ErrorImagesState extends ImagesState {
  final String message;

  ErrorImagesState({required this.message});
}
