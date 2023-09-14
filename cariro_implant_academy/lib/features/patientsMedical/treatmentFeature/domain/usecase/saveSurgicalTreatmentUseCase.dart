import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/surgicalTreatmentEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/teethTreatmentPlan.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/treatmentPlanEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/repo/surgicalTreatmentRepo.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/repo/treatmentPlanRepo.dart';
import 'package:dartz/dartz.dart';

class SaveSurgicalTreatmentUseCase extends UseCases<NoParams, SaveSurgicalTreatmentParams> {
  final SurgicalTreatmentRepo surgicalTreatmentRepo;

  SaveSurgicalTreatmentUseCase({required this.surgicalTreatmentRepo});

  @override
  Future<Either<Failure, NoParams>> call(SaveSurgicalTreatmentParams data) async {
    return await surgicalTreatmentRepo.saveSurgicalTreatment(data.id, data.data).then(
          (value) => value.fold(
            (l) => Left(l..message = "Save Treatment Plan: ${l.message ?? ""}"),
            (r) => Right(r),
          ),
        );
  }
}

class SaveSurgicalTreatmentParams {
  final int id;
  final SurgicalTreatmentEntity data;

  SaveSurgicalTreatmentParams({required this.id, required this.data});
}
