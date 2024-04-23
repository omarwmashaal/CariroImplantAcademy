import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/teethTreatmentPlan.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/treatmentPlanEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/repo/treatmentPlanRepo.dart';
import 'package:dartz/dartz.dart';

class SaveTreatmentPlanUseCase extends UseCases<NoParams, SaveTreatmentPlanParams> {
  final TreatmentPlanRepo treatmentPlanRepo;

  SaveTreatmentPlanUseCase({required this.treatmentPlanRepo});

  @override
  Future<Either<Failure, NoParams>> call(SaveTreatmentPlanParams data) async {
    data.data.removeWhere((element) => element.isNull());
    return await treatmentPlanRepo.saveTreatmentPlanData(data.id, data.data,clearanceLower: data.clearanceLower,clearnceUpper: data.clearanceUpper).then(
          (value) => value.fold(
            (l) => Left(l..message = "Save Treatment Plan: ${l.message ?? ""}"),
            (r) => Right(r),
          ),
        );
  }
}

class SaveTreatmentPlanParams {
  final int id;
  final List<TeethTreatmentPlanEntity> data;
  final bool clearanceUpper;
  final bool clearanceLower;

  SaveTreatmentPlanParams({required this.id, required this.data, this.clearanceUpper = false,this.clearanceLower = false});
}
