import 'package:cariro_implant_academy/core/data/dataSources/loadingDatasource.dart';
import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/domain/repositories/loadingRepo.dart';
import 'package:cariro_implant_academy/core/domain/useCases/loadUsersUseCase.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:dartz/dartz.dart';

class LoadingRepoImpl implements LoadingRepo {
  final LoadingDatasource loadingDatasource;

  LoadingRepoImpl({required this.loadingDatasource});

  @override
  Future<Either<Failure, List<BasicNameIdObjectEntity>>> loadUsers({required LoadUsersEnum userType}) async {
    try {
      final result = await loadingDatasource.loadUsers(userType: userType);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<BasicNameIdObjectEntity>>> loadCandidateBatches() async {
    try {
      final result = await loadingDatasource.loadCandidateBatches();
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<BasicNameIdObjectEntity>>> loadCandidatesByBatchId({required int id}) async {
    try {
      final result = await loadingDatasource.loadCandidatesByBatchId(id);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<BasicNameIdObjectEntity>>> loadCandidatesBatches() async {
    try {
      final result = await loadingDatasource.loadCandidatesBatches();
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<BasicNameIdObjectEntity>>> loadWorkPlaces() async {
    try {
      final result = await loadingDatasource.loadWorkPlaces();
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }
}
