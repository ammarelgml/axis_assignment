import 'package:flutter/material.dart';

class APILogger {
  static void logApiRequest({
    required String type,
    required String url,
    Map? headers = const {},
    Map? body = const {},
  }) {
    debugPrint(
      '///** Start Request Logger'
      '\nFire request to: $url'
      '\nAPICall: $type '
      '\nHeaders: $headers'
      '\nBody: $body'
      '\nFinish Request Logger **///',
    );
  }

  static void logApiResponse({
    required String url,
    required String statusCode,
    dynamic response,
  }) {
    debugPrint(
      '///** Start Response Logger'
      '\nResult of request: $url'
      '\nstatusCode: $statusCode '
      '\nresponse: $response '
      '\nFinish Response Logger **///',
    );
  }
}
