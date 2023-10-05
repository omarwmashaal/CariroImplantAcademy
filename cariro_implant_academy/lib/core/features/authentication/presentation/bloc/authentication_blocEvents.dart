import 'package:cariro_implant_academy/core/features/authentication/domain/usecases/loginUseCase.dart';
import 'package:cariro_implant_academy/features/user/domain/entities/userEntity.dart';

abstract class Authentication_blocEvent{}
class LogInEvent extends Authentication_blocEvent{
  final LoginParams loginParams;
  LogInEvent(this.loginParams);
}
class LogOutEvent extends Authentication_blocEvent{}

class CheckLogInStatusEvent extends Authentication_blocEvent{}

class RegisterUserEvent extends Authentication_blocEvent{
  final UserEntity user;
  RegisterUserEvent({required this.user});
}