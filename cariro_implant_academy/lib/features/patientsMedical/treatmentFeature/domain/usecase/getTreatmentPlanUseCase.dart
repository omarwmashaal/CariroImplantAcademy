import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/treatmentPlanEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/repo/treatmentPlanRepo.dart';
import 'package:dartz/dartz.dart';

class GetTreatmentPlanUseCase extends UseCases<TreatmentPlanEntity, int> {
  final TreatmentPlanRepo treatmentPlanRepo;

  GetTreatmentPlanUseCase({required this.treatmentPlanRepo});

  @override
  Future<Either<Failure, TreatmentPlanEntity>> call(int id) async {
    return await treatmentPlanRepo.getTreatmentPlanData(id).then(
          (value) => value.fold(
            (l) => Left(l..message = "Get Treatment Plan: ${l.message ?? ""}"),
            (r) => Right(r),
          ),
        );
  }
}
