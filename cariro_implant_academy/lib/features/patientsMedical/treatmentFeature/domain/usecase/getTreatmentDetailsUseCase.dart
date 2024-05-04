import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/treatmenDetailsEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/treatmentPlanEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/repo/treatmentPlanRepo.dart';
import 'package:dartz/dartz.dart';

class GetTreatmentDetailsUseCase extends UseCases<List<TreatmentDetailsEntity>, int> {
  final TreatmentPlanRepo treatmentPlanRepo;

  GetTreatmentDetailsUseCase({required this.treatmentPlanRepo});

  @override
  Future<Either<Failure, List<TreatmentDetailsEntity>>> call(int id) async {
    return await treatmentPlanRepo.getTreatmentDetails(id).then(
          (value) => value.fold(
            (l) => Left(l..message = "Get Treatment Details: ${l.message ?? ""}"),
            (r) => Right(r),
          ),
        );
  }
}
