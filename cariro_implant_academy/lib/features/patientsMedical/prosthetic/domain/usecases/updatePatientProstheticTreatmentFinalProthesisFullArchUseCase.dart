import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/prostheticDiagnosticEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/prostheticStepEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/repositories/prostheticRepository.dart';
import 'package:dartz/dartz.dart';

import '../entities/prostheticFinalEntity.dart';

class UpdatePatientProstheticTreatmentFinalProthesisFullArchUseCase extends UseCases<NoParams, List<ProstheticStepEntity>> {
  final ProstheticRepository prostheticRepository;

  UpdatePatientProstheticTreatmentFinalProthesisFullArchUseCase({required this.prostheticRepository});

  @override
  Future<Either<Failure, NoParams>> call(List<ProstheticStepEntity> data) async {
    data!.removeWhere((element) => element.statusId == null && element.nextVisitId == null);

    return await prostheticRepository.updatePatientProstheticTreatmentFinalProthesisFullArch(data).then((value) => value.fold(
          (l) => Left(l..message = "Update Full Arch: ${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}
