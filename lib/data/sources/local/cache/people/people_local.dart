import 'package:axis_assignment/data/models/person.dart';
import 'package:axis_assignment/data/sources/local/cache/people/people_entity.dart';
import 'package:axis_assignment/main.dart';
import 'package:axis_assignment/objectbox.g.dart';

class PeopleLocal {
  late Box<PeopleModelBox> _peopleLocalBox;

  PeopleLocal() {
    openPeopleBox();
  }

  openPeopleBox() {
    _peopleLocalBox = objectBox.store.box<PeopleModelBox>();
  }

  List<People> getPeopleFromLocal() {
    final peopleModels = _peopleLocalBox.getAll();
    return peopleModels.map((peopleModelBox) {
      return People(
        id: peopleModelBox.id,
        name: peopleModelBox.name,
        knownForDepartment: peopleModelBox.knownForDepartment,
        profilePath: peopleModelBox.profilePath,
        popularity: peopleModelBox.popularity,
      );
    }).toList();
  }

  Future<void> savePeopleToLocal(List<People> items, bool refreshData) async {
    if (refreshData) {
      _peopleLocalBox.removeAll();
    }

    final peopleModelBoxes = items.map((item) {
      return PeopleModelBox(
        id: item.id,
        name: item.name,
        knownForDepartment: item.knownForDepartment,
        profilePath: item.profilePath,
        popularity: item.popularity,
      );
    }).toList();
    _peopleLocalBox.putMany(peopleModelBoxes);
  }

  void clearBox() {
    _peopleLocalBox.removeAll();
  }
}
