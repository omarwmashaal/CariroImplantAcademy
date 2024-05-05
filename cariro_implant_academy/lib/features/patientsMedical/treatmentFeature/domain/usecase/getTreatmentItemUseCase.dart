import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/treatmenDetailsEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/treatmentItemEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/treatmentPlanEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/repo/treatmentPlanRepo.dart';
import 'package:dartz/dartz.dart';

class GetTreatmentItemsUseCase extends UseCases<List<TreatmentItemEntity>, NoParams> {
  final TreatmentPlanRepo treatmentPlanRepo;

  GetTreatmentItemsUseCase({required this.treatmentPlanRepo});

  @override
  Future<Either<Failure, List<TreatmentItemEntity>>> call(NoParams) async {
    return await treatmentPlanRepo.getTreatmentItems().then(
          (value) => value.fold(
            (l) => Left(l..message = "Get Treatment Items: ${l.message ?? ""}"),
            (r) => Right(r),
          ),
        );
  }
}
