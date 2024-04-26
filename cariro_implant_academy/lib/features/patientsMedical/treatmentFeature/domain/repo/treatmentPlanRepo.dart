import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/treatmenDetailsEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/treatmentPlanEntity.dart';
import 'package:dartz/dartz.dart';

abstract class TreatmentPlanRepo {
  Future<Either<Failure, TreatmentPlanEntity>> getTreatmentPlanData(int id);
  Future<Either<Failure, List<TreatmentDetailsEntity>>> getTreatmentDetails(int id);
  Future<Either<Failure, NoParams>> saveTreatmentDetailsData(
    int id,
    List<TreatmentDetailsEntity> data, {
    bool clearnceUpper = false,
    bool clearanceLower = false,
  });
  Future<Either<Failure, NoParams>> consumeImplant(int id);
}
