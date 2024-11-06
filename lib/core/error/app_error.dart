class AppError extends Error {
  final int? statusCode;
  final String? message;

  AppError({this.statusCode, this.message});
}
