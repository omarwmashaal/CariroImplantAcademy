import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:dartz/dartz.dart';

import '../entities/authenticationUserEntity.dart';
import '../useCases/loginUseCase.dart';
abstract class AuthenticationRepo{
 Future<Either<Failure,AuthenticationUserEntity>> login(LoginParams loginParams);
 Future<bool> logout();
}