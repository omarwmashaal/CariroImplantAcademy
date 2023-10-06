import 'package:cariro_implant_academy/core/features/authentication/domain/entities/authenticationUserEntity.dart';
import 'package:equatable/equatable.dart';

abstract class Authentication_blocState extends Equatable{
  Authentication_blocState([List props = const<dynamic>[]]);
}
class AuthInitState extends Authentication_blocState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class LoggedOutState extends Authentication_blocState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class ErrorState extends Authentication_blocState{
  final String message;
  ErrorState({required this.message});

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
class LoggingInState extends Authentication_blocState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class LoggedIn extends Authentication_blocState{
  final AuthenticationUserEntity user;
  LoggedIn({required this.user});

  @override
  // TODO: implement props
  List<Object?> get props => [user];
}

class RegisteringUserState extends Authentication_blocState{
  @override
  List<Object?> get props => [];
}
class RegisteredUserSuccessfullyState extends Authentication_blocState{
  @override
  List<Object?> get props => [];
}
class RegisteringUserErrorState extends Authentication_blocState{
  final String message;
  RegisteringUserErrorState({required this.message});
  @override
  List<Object?> get props => [message];
}