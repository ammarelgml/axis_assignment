part of 'bloc.dart';

abstract class SaveImageState {}

class SaveImageInitial extends SaveImageState {}

class LoadingSaveImageState extends SaveImageState {}

class SuccessSaveImageState extends SaveImageState {}

class StoragePermissionDenied extends SaveImageState {}

class ErrorSaveImageState extends SaveImageState {
  final String message;

  ErrorSaveImageState({required this.message});
}
