class Failure {
  final int code;
  final String message;

  Failure({required this.code, this.message = ''});
}

class FailureConnection {
  final String message;

  FailureConnection(this.message);
}
