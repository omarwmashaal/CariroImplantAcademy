import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientsMedical/complications/data/datasources/complicationsDatasource.dart';
import 'package:cariro_implant_academy/features/patientsMedical/complications/domain/entities/complicationsAfterProsthesisEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/complications/domain/entities/complicationsAfterSurgeryEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/complications/domain/repositories/complicationsRepository.dart';
import 'package:cariro_implant_academy/features/patientsMedical/complications/domain/useCases/udpateComplicationsAfterProsthesisUseCase.dart';
import 'package:cariro_implant_academy/features/patientsMedical/complications/domain/useCases/udpateComplicationsAfterSurgeryUseCase.dart';
import 'package:dartz/dartz.dart';

class ComplicationsRepoImpl implements ComplicationsRepo {
  final ComplicationsDatasource complicationsDatasource;
  ComplicationsRepoImpl({required this.complicationsDatasource});
  @override
  Future<Either<Failure, List<ComplicationsAfterProsthesisEntity>>> getComplicationsAfterProsthesis(int id) async {
    try {
      final result = await complicationsDatasource.getComplicationsAfterProsthesis(id);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<ComplicationsAfterSurgeryEntity>>> getComplicationsAfterSurgery(int id) async {
    try {
      final result = await complicationsDatasource.getComplicationsAfterSurgery(id);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> updateComplicationsAfterProsthesis(UpdateProstheticComplicationsParams data) async {
    try {
      final result = await complicationsDatasource.updateComplicationsAfterProsthesis(data);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> updateComplicationsAfterSurgery(UpdateSurgicalComplicationsParams data) async {
    try {
      final result = await complicationsDatasource.updateComplicationsAfterSurgery(data);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<int>>> getSurgeryTeethForComplications(int id) async {
    try {
      final result = await complicationsDatasource.getSurgeryTeethForComplications(id);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }
}
