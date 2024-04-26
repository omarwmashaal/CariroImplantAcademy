import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/repo/treatmentPlanRepo.dart';
import 'package:dartz/dartz.dart';

class ConsumeScrewsUseCase extends UseCases<NoParams, int> {
  final TreatmentPlanRepo treatmentPlanRepo;

  ConsumeScrewsUseCase({required this.treatmentPlanRepo});

  @override
  Future<Either<Failure, NoParams>> call(int id) async {
    return await treatmentPlanRepo.consumeImplant(id).then(
          (value) => value.fold(
            (l) => Left(l..message = "Consume Implant: ${l.message ?? ""}"),
            (r) => Right(r),
          ),
        );
  }
}


