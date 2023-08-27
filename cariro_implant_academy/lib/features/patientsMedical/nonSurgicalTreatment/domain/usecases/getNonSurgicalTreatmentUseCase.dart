import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientsMedical/nonSurgicalTreatment/domain/entities/nonSurgialTreatmentEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/nonSurgicalTreatment/domain/repositories/nonSurgicalTreatmentRepo.dart';
import 'package:dartz/dartz.dart';

class GetNonSurgicalTreatmentUseCase extends UseCases<NonSurgicalTreatmentEntity, int> {
  final NonSurgicalTreatmentRepo nonSurgicalTreatmentRepo;

  GetNonSurgicalTreatmentUseCase({required this.nonSurgicalTreatmentRepo});

  @override
  Future<Either<Failure, NonSurgicalTreatmentEntity>> call(int params) async {
    final result = await nonSurgicalTreatmentRepo.getNonSurgicalTreatment(params);
    return result.fold(
          (l) => Left(l..message = "Get nonsurgical treatment: ${l.message}"),
          (r) => Right(r),
    );
  }
}
