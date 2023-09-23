import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/visitEntity.dart';
import 'package:cariro_implant_academy/features/user/data/datasource/userDatasource.dart';
import 'package:cariro_implant_academy/features/user/domain/entities/userEntity.dart';
import 'package:cariro_implant_academy/features/user/domain/repositories/userRepository.dart';
import 'package:dartz/dartz.dart';

class UsersRepositoryImpl extends UsersRepository {
  final UserDatasource userDatasource;

  UsersRepositoryImpl({required this.userDatasource});

  @override
  Future<Either<Failure, UserEntity>> getUserData({required int id}) async {
    try {
      final result = await userDatasource.getUserData(id: id);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<UserEntity>>> searchUsersByRole({required String role, String? search, int? batch}) async {
    try {
      final result = await userDatasource.searchUsersByRole(
        role: role,
        batch: batch,
        search: search,
      );
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> updateUserInfo(int id, UserEntity userData) async {
    try {
      final result = await userDatasource.updateUserInfo(
        id,
        userData,
      );
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> resetPassword({required String newPassword1, required String newPassword2, required String oldPassword}) async {
    try {
      final result = await userDatasource.resetPassword(
        newPassword1: newPassword1,
        newPassword2: newPassword2,
        oldPassword: oldPassword,
      );
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<VisitEntity>>> getSessionsDurations(DateTime? from, DateTime? to, int id) async {
    try {
      final result = await userDatasource.getSessionsDurations(from, to, id);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }
}
