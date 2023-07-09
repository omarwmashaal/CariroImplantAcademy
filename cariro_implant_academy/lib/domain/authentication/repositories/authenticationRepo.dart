import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:dartz/dartz.dart';

import '../entities/UserEntity.dart';
import '../useCases/loginUseCase.dart';
abstract class AuthenticationRepo{
 Future<Either<Failure,UserEntity>> login(LoginParams loginParams);
 Future<bool> logout();
}