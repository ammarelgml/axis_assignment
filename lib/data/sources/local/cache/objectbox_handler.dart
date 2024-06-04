import 'package:axis_assignment/objectbox.g.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class ObjectBoxHandler {
  /// The Store of this app.
  late final Store store;

  ObjectBoxHandler._create(this.store);

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<ObjectBoxHandler> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    // Future<Store> openStore() {...} is defined in the generated objectbox.g.dart
    final store = openStore(directory: join(docsDir.path, "obx-example"));
    return ObjectBoxHandler._create(store);
  }
}
