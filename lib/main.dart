import 'package:axis_assignment/data/sources/local/cache/objectbox_handler.dart';
import 'package:axis_assignment/root.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

late ObjectBoxHandler objectBox;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  objectBox = await ObjectBoxHandler.create();

  /// Lock device on portrait mode only
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const Root());
}
