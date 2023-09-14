import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/surgicalTreatmentEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/treatmentPlanEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/repo/surgicalTreatmentRepo.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/repo/treatmentPlanRepo.dart';
import 'package:dartz/dartz.dart';

class GetSurgicalTreatmentUseCase extends UseCases<SurgicalTreatmentEntity, int> {
  final SurgicalTreatmentRepo surgicalTreatmentRepo;

  GetSurgicalTreatmentUseCase({required this.surgicalTreatmentRepo});

  @override
  Future<Either<Failure, SurgicalTreatmentEntity>> call(int id) async {
    return await surgicalTreatmentRepo.getSurgicalTreatment(id).then(
          (value) => value.fold(
            (l) => Left(l..message = "Get Surgical Treatment: ${l.message ?? ""}"),
            (r) => Right(r),
          ),
        );
  }
}
