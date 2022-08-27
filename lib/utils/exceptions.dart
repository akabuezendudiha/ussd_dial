abstract class ApiException implements Exception {
  final _message;
  final _prefix;
  String get errorDetail => _message;  
  ApiException([this._message, this._prefix]);

  String toString() {
    return '$_prefix$_message';
  }
}

class UnknownException extends ApiException {
  UnknownException([String message])
    : super(message, 'Unknown exception ');
}

class FetchDataException extends ApiException {
  FetchDataException([String message])
    : super(message, 'Error during communication: ');
}

class UnreachableEndpointException extends ApiException {
  UnreachableEndpointException([String message])
    : super(message, 'Server is Unreachable: ');
}

class BadRequestException extends ApiException {
  BadRequestException([String message])
    : super(message, 'Invalid Request: ');
}

class UnauthorisedException extends ApiException {
  UnauthorisedException([String message])
    : super(message, 'Unauthorised: ');
}

class InvalidInputException extends ApiException {
  InvalidInputException([String message])
    : super(message, 'Invalid input: ');
} 