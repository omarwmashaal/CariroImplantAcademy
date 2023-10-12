import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/requestChangeEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/repo/surgicalTreatmentRepo.dart';
import 'package:dartz/dartz.dart';

class AcceptChangesUseCase extends UseCases<NoParams, RequestChangeEntity> {
  final SurgicalTreatmentRepo surgicalTreatmentRepo;

  AcceptChangesUseCase({required this.surgicalTreatmentRepo});

  @override
  Future<Either<Failure, NoParams>> call(RequestChangeEntity params) async {
    return await surgicalTreatmentRepo.acceptChanges(params).then((value) => value.fold(
          (l) => Left(l..message = "Accept Changes: ${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}
