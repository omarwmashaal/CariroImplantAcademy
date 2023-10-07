import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/domain/useCases/loadUsersUseCase.dart';
import 'package:dartz/dartz.dart';

import '../../error/failure.dart';

abstract class LoadingRepo{
  Future<Either<Failure,List<BasicNameIdObjectEntity>>> loadUsers({required LoadUsersEnum userType});
  Future<Either<Failure,List<BasicNameIdObjectEntity>>> loadCandidateBatches();
  Future<Either<Failure,List<BasicNameIdObjectEntity>>> loadCandidatesByBatchId({required int id});
  Future<Either<Failure,List<BasicNameIdObjectEntity>>> loadCandidatesBatches();
  Future<Either<Failure,List<BasicNameIdObjectEntity>>> loadWorkPlaces();
}