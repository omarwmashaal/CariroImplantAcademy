import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/postSurgicalTreatmentEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/treatmentPlanEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/repo/postSurgicalTreatmentRepo.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/repo/treatmentPlanRepo.dart';
import 'package:dartz/dartz.dart';

class GetPostSurgicalTreatmentUseCase extends UseCases<PostSurgicalTreatmentEntity, int> {
  final PostSurgicalTreatmentRepo surgicalTreatmentRepo;

  GetPostSurgicalTreatmentUseCase({required this.surgicalTreatmentRepo});

  @override
  Future<Either<Failure, PostSurgicalTreatmentEntity>> call(int id) async {
    return await surgicalTreatmentRepo.getPostSurgicalTreatment(id).then(
          (value) => value.fold(
            (l) => Left(l..message = "Get Post Surgical Treatment: ${l.message ?? ""}"),
            (r) => Right(r),
          ),
        );
  }
}
