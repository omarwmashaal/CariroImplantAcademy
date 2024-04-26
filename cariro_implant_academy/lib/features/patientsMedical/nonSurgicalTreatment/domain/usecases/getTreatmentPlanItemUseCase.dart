import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientsMedical/nonSurgicalTreatment/domain/entities/nonSurgialTreatmentEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/nonSurgicalTreatment/domain/repositories/nonSurgicalTreatmentRepo.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/treatmenDetailsEntity.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetTreatmentPlanItemUsecase extends UseCases<List<TreatmentDetailsEntity>?,GetTreatmentPlanItemParams > {
  final NonSurgicalTreatmentRepo nonSurgicalTreatmentRepo;

  GetTreatmentPlanItemUsecase({required this.nonSurgicalTreatmentRepo});

  @override
  Future<Either<Failure, List<TreatmentDetailsEntity>>> call(GetTreatmentPlanItemParams params) async {
    final result = await nonSurgicalTreatmentRepo.getPaidPlanItem(patientId: params.patientId, tooth: params.tooth);
    return result.fold(
          (l) => Left(l..message = "Save nonsurgical treatments: ${l.message}"),
          (r) => Right(r),
    );
  }
}

class GetTreatmentPlanItemParams {
  final int patientId;
  final int tooth;

  GetTreatmentPlanItemParams({required this.patientId, required this.tooth});


}
