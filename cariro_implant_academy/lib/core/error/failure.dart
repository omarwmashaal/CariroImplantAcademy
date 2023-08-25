import 'package:equatable/equatable.dart';

import 'exception.dart';

const DATACONVERSION_FAILURE_MESSAGE = "Couldn't convert data";

abstract class Failure extends Equatable {
  String? message;
  
  Failure({this.message});
  static Failure exceptionToFailure(Exception exception) {
    if (exception is HttpInternalServerErrorException)
      return HttpInternalServerErrorFailure(failureMessage: exception.message);
    else if (exception is HttpBadRequestException)
      return HttpBadRequestFailure(failureMessage: exception.message);
    else if (exception is HttpUnauthorizedException)
      return HttpUnauthorizedFailure(failureMessage: exception.message);
    else if (exception is HttpForbiddenException)
      return HttpForbiddenFailure(failureMessage: exception.message);
    else if (exception is HttpNotImplementedException)
      return HttpNotImplementedFailure(failureMessage: exception.message);
    else if (exception is HttpNotFoundException)
      return HttpNotFoundFailure(failureMessage: exception.message);
    else if (exception is NetworkException)
      return NetworkFailure(failureMessage: exception.message);
    else if (exception is LoginException)
      return LoginFailure(failureMessage: exception.message);
    else if (exception is DataConversionException)
      return DataConversionFailure(failureMessage: exception.message);
    else if (exception is InputValidationException)
      return InputValidationFailure(failureMessage: exception.message);
    else if (exception is ServerUnReachableException)
      return ServerUnreachablFailure(failureMessage: exception.message);
    else
      return UnknownFailure();
  }

}

class HttpInternalServerErrorFailure extends Failure {
  String? message;
  HttpInternalServerErrorFailure({String? failureMessage}){
    this.message = "InternalServerError: $failureMessage";
    super.message=this.message;
  }
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class LoginFailure extends Failure {
  String? message;
  LoginFailure({String? failureMessage}){
    this.message = "Login: $failureMessage";
    super.message=this.message;
  }
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class InputValidationFailure extends Failure {
  String? message;
  InputValidationFailure({String? failureMessage}){
    this.message = "InputValidation: $failureMessage";
    super.message=this.message;
  }
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class BadRequestFailure extends Failure {
  String? message;
  BadRequestFailure({String? failureMessage}){
    this.message = "BadRequest: $failureMessage";
    super.message=this.message;
  }
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class NetworkFailure extends Failure {
  String? message;
  NetworkFailure({String? failureMessage}){    
    this.message = "Network: $failureMessage";
    super.message=this.message;
  }
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}



class HttpBadRequestFailure extends Failure {
  String? message;
  HttpBadRequestFailure({String? failureMessage}){
    this.message = "BadRequest: $failureMessage";
    super.message=this.message;
  }
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class HttpUnauthorizedFailure extends Failure {
  String? message;
  HttpUnauthorizedFailure({String? failureMessage}){
    this.message = "Unauthorized: $failureMessage";
    super.message=this.message;
  }
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class HttpForbiddenFailure extends Failure {
  String? message;
  HttpForbiddenFailure({String? failureMessage}){
    this.message = "Forbidden: $failureMessage";
    super.message=this.message;
  }
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class HttpNotFoundFailure extends Failure {
  String? message;
  HttpNotFoundFailure({String? failureMessage}){
    this.message = "NotFound: $failureMessage";
    super.message=this.message;
  }
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class HttpNotImplementedFailure extends Failure {
  String? message;
  HttpNotImplementedFailure({String? failureMessage}){
    this.message = "NotImplemented: $failureMessage";
    super.message=this.message;
  }
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class DataConversionFailure extends Failure {
  String? message;
  DataConversionFailure({String? failureMessage}){
    this.message = "DataConversion: $failureMessage";
    super.message=this.message;
  }
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class UnknownFailure extends Failure {
  String? message;
  UnknownFailure({String? failureMessage}){
    this.message = "Unknown: $failureMessage";
    super.message=this.message;
  }
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
class DataVerificationFailure extends Failure {
  String? message;
  DataVerificationFailure({String? failureMessage}){
    this.message = "DataVerification: $failureMessage";
    super.message=this.message;
  }
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
class UploadImageFailure extends Failure {
  String? message;
  UploadImageFailure({String? failureMessage}){
    this.message = "UploadImage: $failureMessage";
    super.message=this.message;
  }
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
class SelectingImageFailure extends Failure {
  String? message;
  SelectingImageFailure({String? failureMessage}){
    this.message = "SelectingImage: $failureMessage";
    super.message=this.message;
  }
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
class ServerUnreachablFailure extends Failure {
  String? message;
  ServerUnreachablFailure({String? failureMessage}){
    this.message = "Server unreachable: $failureMessage";
    super.message=this.message;
  }
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
