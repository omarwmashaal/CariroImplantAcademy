import 'package:cariro_implant_academy/core/error/exception.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/features/authentication/domain/entities/authenticationUserEntity.dart';
import 'package:cariro_implant_academy/core/features/authentication/domain/repositories/authenticationRepo.dart';
import 'package:cariro_implant_academy/core/features/authentication/domain/usecases/loginUseCase.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/user/domain/entities/userEntity.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../injection_contianer.dart';
import '../datasources/aut_ASP_DataSource.dart';

class AuthenticationRepoImpl implements AuthenticationRepo
{
  Auth_ASP_DataSource dataSource;
  AuthenticationRepoImpl(this.dataSource);
  @override
  Future<Either<Failure, AuthenticationUserEntity>> login(LoginParams loginParams) async{

    try {
      final result = await dataSource.login(loginParams);
      sl<SharedPreferences>().setString("token", result.token);
      sl<SharedPreferences>().setString("role", result.role);
      sl<SharedPreferences>().setInt("userid", result.idInt);
      sl<SharedPreferences>().setString("userName", result.name);
      if(result.profileId!=null)
      sl<SharedPreferences>().setInt("profileImageId", result.profileId!);
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

  @override
  Future<Either<Failure, NoParams>> registerUser(UserEntity user) async {
    try {
      final result = await dataSource.registerUser(user);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>>  resetPasswordForUser(int id)  async {
    try {
      final result = await dataSource.resetPasswordForUser(id);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

}