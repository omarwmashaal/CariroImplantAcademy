import 'package:cariro_implant_academy/core/error/exception.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/domain/authentication/entities/UserEntity.dart';
import 'package:cariro_implant_academy/domain/authentication/repositories/authenticationRepo.dart';
import 'package:cariro_implant_academy/domain/authentication/useCases/loginUseCase.dart';
import 'package:dartz/dartz.dart';

import '../dataSources/aut_ASP_DataSource.dart';

class AuthenticationRepoImpl implements AuthenticationRepo
{
  Auth_ASP_DataSource dataSource;
  AuthenticationRepoImpl(this.dataSource);
  @override
  Future<Either<Failure, UserEntity>> login(LoginParams loginParams) async{
     try {
      final result = await dataSource.login(loginParams);
      return Right(result);
     } on ServerException  {
       return Left(ServerFailure());
     } on LoginException  {
       return Left(LoginFailure());
     }
  }

  @override
  Future<bool> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

}