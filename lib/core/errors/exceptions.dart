class ServerException implements Exception {
  String? exceptionMessage;
  String? errorCode;
  Map<String, dynamic>? data;

  ServerException({this.exceptionMessage, this.data, this.errorCode});
  @override
  String toString() {
    Object? message = exceptionMessage;
    if (message == null) return "Exception";
    return "$message";
  }
}

class ClientException implements Exception {}
