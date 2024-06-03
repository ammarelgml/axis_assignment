import 'package:axis_assignment/data/models/person_image.dart';
import 'package:axis_assignment/data/repositories/people_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'event.dart';

part 'state.dart';

class ImagesBloc extends Bloc<ImagesEvent, ImagesState> {
  ImagesBloc(this._peopleRepository) : super(ImagesInitial()) {
    on<GetPersonImages>(_onGetPersonImages);
  }

  final PeopleRepository _peopleRepository;

  _onGetPersonImages(GetPersonImages event, Emitter<ImagesState> emit) async {
    emit(LoadingImagesState());
    (await _peopleRepository.getPersonImages(event.personId)).fold(
      (error) {
        emit(ErrorImagesState(message: error.message.toString()));
      },
      (images) {
        emit(LoadedImagesState(imagesList: images));
      },
    );
  }
}
