import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/user/domain/entities/userEntity.dart';
import 'package:dartz/dartz.dart';

import '../entities/authenticationUserEntity.dart';
import '../usecases/loginUseCase.dart';
abstract class AuthenticationRepo{
 Future<Either<Failure,AuthenticationUserEntity>> login(LoginParams loginParams);
 Future<Either<Failure,UserEntity>> registerUser(UserEntity user);
 Future<bool> logout();
 Future<Either<Failure,NoParams>> resetPasswordForUser(int id);
}