import 'package:cariro_implant_academy/core/features/authentication/domain/usecases/loginUseCase.dart';
import 'package:cariro_implant_academy/features/user/domain/entities/userEntity.dart';

abstract class Authentication_blocEvent{}
class logInEvent extends Authentication_blocEvent{
  final LoginParams loginParams;
  logInEvent(this.loginParams);
}
class LogOutEvent extends Authentication_blocEvent{}

class checkLogInStatusEvent extends Authentication_blocEvent{}

class registerUserEvent extends Authentication_blocEvent{
  final UserEntity user;
  registerUserEvent({required this.user});
}