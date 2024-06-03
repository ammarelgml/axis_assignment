import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

part 'event.dart';

part 'state.dart';

class SaveImageBloc extends Bloc<SaveImageEvent, SaveImageState> {
  SaveImageBloc() : super(SaveImageInitial()) {
    on<SaveImage>(_onSaveImage);
  }

  late PermissionStatus storageStatus;

  getStoragePermissionStatus() async {
    if (Platform.isAndroid) {
      final plugin = DeviceInfoPlugin();
      final android = await plugin.androidInfo;
      storageStatus = android.version.sdkInt < 33 ? await Permission.storage.request() : PermissionStatus.granted;
    } else if (Platform.isIOS) {
      storageStatus =  await Permission.storage.request();
    }

    if (storageStatus == PermissionStatus.permanentlyDenied) {
      openAppSettings();
    }
  }

  _onSaveImage(SaveImage event, Emitter<SaveImageState> emit) async {
    emit(LoadingSaveImageState());
    await getStoragePermissionStatus();
    try {
      if (storageStatus.isGranted) {
        // Get the image data from the URL
        final response = await http.get(Uri.parse(event.url));
        if (response.statusCode != 200) {
          throw Exception('Failed to download image from ${event.url}');
        } else {
          final imageBytes = response.bodyBytes;
          final result = await ImageGallerySaver.saveImage(imageBytes);
          if (result['isSuccess']) {
            emit(SuccessSaveImageState());
          } else {
            emit(ErrorSaveImageState(message: result['errorMessage']));
          }
        }
      } else {
        emit(StoragePermissionDenied());
      }
    } catch (error) {
      emit(ErrorSaveImageState(message: error.toString()));
    }
    emit(SaveImageInitial());
  }
}
