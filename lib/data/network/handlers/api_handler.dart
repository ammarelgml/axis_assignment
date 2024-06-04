import "dart:async";
import 'dart:io';

import 'package:axis_assignment/data/network/handlers/api_logger.dart';
import 'package:axis_assignment/utils/constants.dart';
import 'package:axis_assignment/utils/utils.dart';
import 'package:http/http.dart' as http;

class APIHandler {
  String url = Constants.baseUrl;

  setUrl(String uri) {
    url = Constants.baseUrl + uri;
  }

  Future<dynamic> get({Map<String, String>? headers}) async {
    if (await Utils.networkIsConnective()) {
      headers ??= {};
      headers["Accept"] = "application/json";

      APILogger.logApiRequest(type: 'GET', url: url, headers: headers);

      try {
        final res =
            await http.get(Uri.parse(url), headers: headers).timeout(const Duration(seconds: 59), onTimeout: () {
          throw 'Timeout error, try again later!';
        });

        APILogger.logApiResponse(url: url, response: res.body, statusCode: res.statusCode.toString());
        return res;
      } on SocketException {
        throw 'Socket Exception try again later!';
      }
    } else {
      throw 'No Internet connection available!';
    }
  }
}
