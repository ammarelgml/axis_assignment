class Failure {
  final int code;
  final String error;
  final String message;

  String get userMessage => '$error: $message';

  Failure({required this.code, required this.error, this.message = ''});

  factory Failure.fromResponse(Map<String, dynamic> json) {
    final int code = json['statusCode'] ?? -1;
    final String error = json['error'] ?? '';
    final dynamic messageData = json['message'];

    String message = '';

    if (messageData != null) {
      if (messageData is List<dynamic> && messageData.isNotEmpty) {
        message = messageData.first;
      } else if (messageData is String) {
        message = messageData;
      }
    }

    message = message.isEmpty ? error : message;

    return Failure(code: code, error: error, message: message);
  }
}
