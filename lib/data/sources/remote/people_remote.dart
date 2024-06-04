import 'package:axis_assignment/data/network/handlers/api_handler.dart';
import 'package:axis_assignment/utils/constants.dart';

class PeopleRemote {
  final APIHandler _apiHandler = APIHandler();

  /// GET People Paginated
  Future<dynamic> getPeople({int? page = 1}) async {
    _apiHandler.setUrl('/person/popular?api_key=${Constants.apiKey}&page=$page');
    return await _apiHandler.get();
  }

  /// GET People Images
  Future<dynamic> getPersonImages(int personId) async {
    _apiHandler.setUrl('/person/$personId/images?api_key=${Constants.apiKey}');
    return await _apiHandler.get();
  }
}
