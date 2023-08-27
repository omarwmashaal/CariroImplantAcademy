import 'package:cariro_implant_academy/core/error/exception.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/domain/authentication/entities/UserEntity.dart';
import 'package:cariro_implant_academy/domain/authentication/repositories/authenticationRepo.dart';
import 'package:cariro_implant_academy/domain/authentication/useCases/loginUseCase.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/injection_contianer.dart';
import '../dataSources/aut_ASP_DataSource.dart';

class AuthenticationRepoImpl implements AuthenticationRepo
{
  Auth_ASP_DataSource dataSource;
  AuthenticationRepoImpl(this.dataSource);
  @override
  Future<Either<Failure, UserEntity>> login(LoginParams loginParams) async{

    try {
      final result = await dataSource.login(loginParams);
      sl<SharedPreferences>().setString("token", result.token);
      sl<SharedPreferences>().setString("role", result.role);
      sl<SharedPreferences>().setInt("userid", result.idInt);
      sl<SharedPreferences>().setString("userName", result.name);
      return Right(result);
     }
     on Exception catch(e)
    {
     return Left( Failure.exceptionToFailure(e));
    }
     on HttpInternalServerErrorException  {
       return Left(HttpInternalServerErrorFailure());
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