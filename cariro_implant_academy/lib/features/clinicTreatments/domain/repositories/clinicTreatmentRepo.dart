import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/entities/clinicTreatmentEntity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/useCases/useCases.dart';

abstract class ClinicTreatmentRepo{
  Future<Either<Failure,ClinicTreatmentEntity>> getTreatment(int id);
  Future<Either<Failure,NoParams>> updateTreatment(int id, ClinicTreatmentEntity model);

}