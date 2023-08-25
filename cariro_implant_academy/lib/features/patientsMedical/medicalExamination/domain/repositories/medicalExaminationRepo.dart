
import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/useCases/useCases.dart';
import '../entities/medicalExaminationEntity.dart';

abstract class MedicalHistoryRepo {
  Future<Either<Failure, MedicalExaminationEntity>> getMedicalExamination(int id);

  Future<Either<Failure, NoParams>> saveMedicalExamination(MedicalExaminationEntity medicalExaminationEntity);

   }
