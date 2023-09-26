import 'package:http/http.dart';

Exception getHttpException({required int statusCode, String? message}) {
  switch (statusCode) {
    case 400:
      return HttpBadRequestException(message: message);
    case 401:
      return HttpUnauthorizedException(message: message??"");
    case 403:
      return HttpForbiddenException(message: message??'');
    case 404:
      return HttpNotFoundException(message: message??"");
    case 405:
      return HttpMethodNotAllowedException(message: message??"");
    case 500:
      return HttpInternalServerErrorException(message: message??"");
    case 501:
      return HttpNotImplementedException(message: message??"");
    default:
      return Exception();
  }
}
Exception mapException(dynamic e)
{
  if(e is ClientException)
    return ServerUnReachableException();
  return HttpInternalServerErrorException();

}

class Exceptions implements Exception {
  final String? message;
  Exceptions({this.message});
}

class LoginException implements Exceptions {
  final String? message;

  LoginException({this.message});}

class InputValidationException implements Exceptions {
  final String? message;

  InputValidationException({this.message});
}

class NetworkException implements Exceptions {
  final String? message;

  NetworkException({this.message});}

class HttpBadRequestException implements Exceptions {
  final String? message;

  HttpBadRequestException({this.message});
}

class HttpUnauthorizedException implements Exceptions {
  final String? message;

  HttpUnauthorizedException({this.message});}

class HttpForbiddenException implements Exceptions {
  final String? message;

  HttpForbiddenException({this.message});}

class HttpNotFoundException implements Exceptions {
  final String? message;

  HttpNotFoundException({this.message});}

class HttpNotImplementedException implements Exceptions {
  final String? message;

  HttpNotImplementedException({this.message});}

class HttpInternalServerErrorException implements Exceptions {
  final String? message;

  HttpInternalServerErrorException({this.message});}

class HttpMethodNotAllowedException implements Exceptions {
  final String? message;

  HttpMethodNotAllowedException({this.message});}

class DataConversionException implements Exceptions {
  final String? message;

  DataConversionException({this.message});
}
class ServerUnReachableException implements Exceptions {
  final String? message;

  ServerUnReachableException({this.message});
}
