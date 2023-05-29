enum HttpError {
  badRequest,
  notFound,
  serverError,
  unauthorized,
  forbidden,
  invalidData,
}

class HttpInvalidDataException implements Exception {
  String cause;
  HttpInvalidDataException(this.cause);
}

class HttpForbiddenException implements Exception {
  String cause;
  HttpForbiddenException(this.cause);
}

class HttpBadRequestException implements Exception {
  String cause;
  HttpBadRequestException(this.cause);
}

class HttpNotFoundException implements Exception {
  String cause;
  HttpNotFoundException(this.cause);
}

class HttpServerErrorException implements Exception {
  String cause;
  HttpServerErrorException(this.cause);
}

class HttpUnauthorizedException implements Exception {
  String cause;
  HttpUnauthorizedException(this.cause);
}
