class ApiException implements Exception {
  final dynamic _message;

  final int? statusCode;

  ApiException([this._message, this.statusCode]);

  @override
  String toString() {
    return "${_message ?? ''}";
  }
}

class DefaultException extends ApiException {
  DefaultException([message]) : super("Something went wrong");
}

class NoInternetException extends ApiException {
  NoInternetException([String? message])
      : super(message ?? "Please connect to internet");
}

class FetchDataException extends ApiException {
  FetchDataException([String? message])
      : super(message ?? "Something went wrong");
}

class BadRequestException extends ApiException {
  BadRequestException([message]) : super(message ?? "Something went wrong");
}

class UnAuthorizedException extends ApiException {
  UnAuthorizedException([message])
      : super(
          message ?? "",
        );
}

class AuthenticationException extends ApiException {
  AuthenticationException({String? message})
      : super(
          message ?? "UnAuthorized.You have no access !",
        );
}

class NotFoundException extends ApiException {
  NotFoundException([message]) : super(message ?? "Something went wrong");
}

class TimeoutException extends ApiException {
  TimeoutException([message]) : super(message ?? "Something went wrong");
}

class InvalidInputException extends ApiException {
  InvalidInputException([String? super.message]);
}

class ConflictException extends ApiException {
  ConflictException({required String? message})
      : super(message ?? "Something went wrong");
}

class UnprocessableEntityException extends ApiException {
  UnprocessableEntityException({required String? message})
      : super(message ?? "Something went wrong");
}

class ClientErrorException extends ApiException {
  ClientErrorException([String? message])
      : super(message ?? "Something went wrong");
}

class ServiceUnavailableException extends ApiException {
  ServiceUnavailableException([String? message])
      : super(message ?? "Service Unavailable");
}

class UnProcessableException extends ApiException {
  UnProcessableException([String? message]) : super("Something went wrong");
}

class RequestCanceledException extends ApiException {
  RequestCanceledException([String? message]) : super("Request was cancelled");
}
