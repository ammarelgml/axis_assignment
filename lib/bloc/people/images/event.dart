part of 'bloc.dart';

abstract class ImagesEvent {}

class GetPersonImages extends ImagesEvent {
  final int personId;

  GetPersonImages(this.personId);
}
