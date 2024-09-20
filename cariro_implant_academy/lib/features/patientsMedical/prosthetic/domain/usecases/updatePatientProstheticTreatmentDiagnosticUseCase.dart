import 'package:dartz/dartz.dart';

import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/prostheticDiagnosticEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/prostheticStepEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/repositories/prostheticRepository.dart';

class UpdatePatientProstheticTreatmentDiagnosticUseCase extends UseCases<NoParams, UpdateProsthParams> {
  final ProstheticRepository prostheticRepository;

  UpdatePatientProstheticTreatmentDiagnosticUseCase({required this.prostheticRepository});

  @override
  Future<Either<Failure, NoParams>> call(UpdateProsthParams data) async {
    return await prostheticRepository.updatePatientProstheticTreatmentDiagnostic(data.patientId, data.steps).then((value) => value.fold(
          (l) => Left(l..message = "Update Diagnostic: ${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}

class UpdateProsthParams {
  final int patientId;
  final List<ProstheticStepEntity> steps;
  UpdateProsthParams({
    required this.patientId,
    required this.steps,
  });
}
