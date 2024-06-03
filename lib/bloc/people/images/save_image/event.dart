part of 'bloc.dart';

abstract class SaveImageEvent {}

class SaveImage extends SaveImageEvent {
  final String url;

  SaveImage(this.url);
}
