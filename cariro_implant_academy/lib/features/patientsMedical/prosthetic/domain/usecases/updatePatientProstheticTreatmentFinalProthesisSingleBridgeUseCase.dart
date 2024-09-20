import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/prostheticDiagnosticEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/prostheticStepEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/repositories/prostheticRepository.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/usecases/updatePatientProstheticTreatmentDiagnosticUseCase.dart';
import 'package:dartz/dartz.dart';

import '../entities/prostheticFinalEntity.dart';

class UpdatePatientProstheticTreatmentFinalProthesisSingleBridgeUseCase extends UseCases<NoParams, UpdateProsthParams> {
  final ProstheticRepository prostheticRepository;

  UpdatePatientProstheticTreatmentFinalProthesisSingleBridgeUseCase({required this.prostheticRepository});

  @override
  Future<Either<Failure, NoParams>> call(UpdateProsthParams data) async {
    return await prostheticRepository
        .updatePatientProstheticTreatmentFinalProthesisSingleBridge(data.patientId, data.steps)
        .then((value) => value.fold(
              (l) => Left(l..message = "Update Single Bridge: ${l.message ?? ""}"),
              (r) => Right(r),
            ));
  }
}
