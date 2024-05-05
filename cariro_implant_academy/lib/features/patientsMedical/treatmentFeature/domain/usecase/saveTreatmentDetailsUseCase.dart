import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/treatmenDetailsEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/repo/treatmentPlanRepo.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

class SaveTreatmentDetailsUseCase extends UseCases<NoParams, SaveTreatmentDetailsParams> {
  final TreatmentPlanRepo treatmentPlanRepo;

  SaveTreatmentDetailsUseCase({required this.treatmentPlanRepo});

  @override
  Future<Either<Failure, NoParams>> call(SaveTreatmentDetailsParams data) async {
    if (data.data.firstWhereOrNull((element) => element.treatmentItemId == null) != null) {
      return Left(BadRequestFailure(failureMessage: "Error In Treatment Item"));
    }
    return await treatmentPlanRepo.saveTreatmentDetailsData(data.id, data.data).then(
          (value) => value.fold(
            (l) => Left(l..message = "Save Treatment Plan: ${l.message ?? ""}"),
            (r) => Right(r),
          ),
        );
  }
}

class SaveTreatmentDetailsParams {
  final int id;
  final List<TreatmentDetailsEntity> data;

  SaveTreatmentDetailsParams({required this.id, required this.data});
}
