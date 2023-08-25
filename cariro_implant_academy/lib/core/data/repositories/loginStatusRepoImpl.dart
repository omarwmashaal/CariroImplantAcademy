import 'package:cariro_implant_academy/core/data/dataSources/loginStatusDataSource.dart';
import 'package:cariro_implant_academy/core/error/exception.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/domain/authentication/entities/UserEntity.dart';

import 'package:dartz/dartz.dart';

import '../../domain/repositories/loginStatusRepo.dart';

class LoginStatusRepoImpl implements CheckLoginStatusRepo {
  LoginStatusDataSource dataSource;

  LoginStatusRepoImpl(this.dataSource);

  @override
  Future<Either<Failure, UserEntity>> checkLoginStatus() async {
    try {
      final result = await dataSource.checkLoginStatus();
      return Right(result);
    } on LoginException {
      return Left(LoginFailure());
    } on HttpInternalServerErrorException {
      return Left(HttpInternalServerErrorFailure());
    }
  }
}
