import 'package:objectbox/objectbox.dart';

@Entity()
class PeopleModelBox {
  @Id(assignable: true)
  int id;
  String name;
  String knownForDepartment;
  String profilePath;
  double popularity;

  PeopleModelBox({
    required this.id,
    required this.name,
    required this.knownForDepartment,
    required this.profilePath,
    required this.popularity,
  });
}
