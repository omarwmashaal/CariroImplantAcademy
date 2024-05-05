import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/data/datasources/postSurgicalTreatmentDatasource.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/requestChangeEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/postSurgicalTreatmentEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/repo/postSurgicalTreatmentRepo.dart';
import 'package:dartz/dartz.dart';

class PostSurgicalTreatmentRepoImpl implements PostSurgicalTreatmentRepo {
  final PostSurgicalTreatmentDatasource postSurgicalTreatmentDatasource;
  PostSurgicalTreatmentRepoImpl({required this.postSurgicalTreatmentDatasource});
  @override
  Future<Either<Failure, PostSurgicalTreatmentEntity>> getPostSurgicalTreatment(int id) async {
    try {
      final result = await postSurgicalTreatmentDatasource.getPostSurgicalTreatment(id);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> savePostSurgicalTreatment( PostSurgicalTreatmentEntity data) async {
    try {
      final result = await postSurgicalTreatmentDatasource.savePostSurgicalTreatment( data);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, RequestChangeEntity>> addChangeRequest(RequestChangeEntity request) async {
    try {
      final result = await postSurgicalTreatmentDatasource.addChangeRequest(request);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> acceptChanges(RequestChangeEntity request) async {
    try {
      final result = await postSurgicalTreatmentDatasource.acceptChanges(request);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }
}
