import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientsMedical/dentalExamination/data/datasources/dentalExaminationDataSource.dart';
import 'package:cariro_implant_academy/features/patientsMedical/dentalExamination/domain/entities/dentalExaminationEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/dentalExamination/domain/repositories/dentalExaminationRepo.dart';
import 'package:dartz/dartz.dart';

import '../../domain/entities/dentalExaminationBaseEntity.dart';

class DentalExaminationRepoImpl implements DentalExaminationRepo {
  final DentalExaminationDataSource dentalExaminationDataSource;

  DentalExaminationRepoImpl({required this.dentalExaminationDataSource});

  @override
  Future<Either<Failure, DentalExaminationBaseEntity>> getDentalExamination(int id) async {
    try {
      final result = await dentalExaminationDataSource.getDentalExamination(id);
      result.dentalExaminations = ( result.dentalExaminations??[]).map((e) => e as DentalExaminationEntity).toList();
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> saveDentalExamination(DentalExaminationBaseEntity dentalExaminationEntity) async{
    try {
      final result = await dentalExaminationDataSource.saveDentalExamination(dentalExaminationEntity);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }

  }
}
