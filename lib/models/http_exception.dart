class HttpException implements Exception {
  final String message;

  HttpException(this.message);

  @override
  String toString() {
    return message; // return custom string message
    // return super.toString(); <- new instance dari HttpException
  }
}
