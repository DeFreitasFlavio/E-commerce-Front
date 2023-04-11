class AppException implements Exception {
  AppException({
    required this.code,
    required this.message,
  });
  final int code;
  final String message;

  @override
  String toString() {
    return "EXCEPTION CODE :$code\n$message";
  }
}
