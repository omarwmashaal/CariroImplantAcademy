import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/useCases/useCases.dart';
import '../entities/dentalExaminationBaseEntity.dart';
import '../entities/dentalExaminationEntity.dart';

abstract class DentalExaminationRepo{
  Future<Either<Failure, DentalExaminationBaseEntity>> getDentalExamination(int id);

  Future<Either<Failure, NoParams>> saveDentalExamination(DentalExaminationBaseEntity dentalExaminationEntity);

}