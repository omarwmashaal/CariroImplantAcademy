import 'package:cariro_implant_academy/domain/authentication/entities/UserEntity.dart';
import 'package:equatable/equatable.dart';

abstract class Authentication_blocState extends Equatable{
  Authentication_blocState([List props = const<dynamic>[]]);
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
  final UserEntity user;
  LoggedIn({required this.user});

  @override
  // TODO: implement props
  List<Object?> get props => [user];
}