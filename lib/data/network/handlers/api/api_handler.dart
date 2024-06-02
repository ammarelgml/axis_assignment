import "dart:async";
import "dart:convert";
import 'dart:io';

import 'package:axis_assignment/data/network/handlers/api/api_logger.dart';
import 'package:axis_assignment/data/network/handlers/network_handler.dart';
import 'package:axis_assignment/data/sources/local/local/cache_helper.dart';
import 'package:axis_assignment/data/sources/local/local/cache_keys.dart';
import 'package:axis_assignment/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';

class APIHandler {
  final NetworkHandler _networkInfo = NetworkHandlerImpl(InternetConnectionChecker());

  String url = Constants.baseUrl;

  setUrl(String uri) {
    url = Constants.baseUrl + uri;
  }

  String? getToken() {
    String? token = CacheHelper.get(CacheKeys.kToken);
    return (token != null) ? 'Bearer $token' : null;
  }

  Future<dynamic> get({Map<String, String>? headers}) async {
    if (await _networkInfo.isConnected) {
      headers ??= {};
      headers["Accept"] = "application/json";

      APILogger.logApiRequest(type: 'GET', url: url, headers: headers);

      try {
        final res =
            await http.get(Uri.parse(url), headers: headers).timeout(const Duration(seconds: 50), onTimeout: () {
          throw const SocketException('');
        });

        APILogger.logApiResponse(url: url, response: res.body, statusCode: res.statusCode.toString());
        return res;
      } on SocketException {
        return const SocketException('');
      }
    } else {
      throw NoInternetConnection('');
    }
  }

  Future<dynamic> post(
      {Map<String, dynamic>? body, Map<String, String>? headers}) async {
    if (await _networkInfo.isConnected) {
      headers ??= {};
      headers["Accept"] = "application/json";
      headers["Content-Type"] = "application/json";

      APILogger.logApiRequest(
          type: 'POST', url: url, headers: headers, body: body);
      body ??= {};
      try {
        final res = await http.post(Uri.parse(url), headers: headers, body: json.encode(body)).timeout(
            const Duration(
              seconds: 50,
            ), onTimeout: () {
          throw const SocketException('');
        });

        APILogger.logApiResponse(url: url, response: res.body, statusCode: res.statusCode.toString());
        return res;
      } on SocketException {
        return const SocketException('');
      }
    } else {
      throw NoInternetConnection('');
    }
  }
}
