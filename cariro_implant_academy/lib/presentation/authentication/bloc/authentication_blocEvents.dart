import 'package:cariro_implant_academy/domain/authentication/useCases/loginUseCase.dart';

abstract class Authentication_blocEvent{}
class LogInEvent extends Authentication_blocEvent{
  final LoginParams loginParams;
  LogInEvent(this.loginParams);
}
class LogOutEvent extends Authentication_blocEvent{}

class CheckLogInStatusEvent extends Authentication_blocEvent{}
