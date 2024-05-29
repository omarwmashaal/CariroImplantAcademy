import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/biteEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/diagnosticImpressionEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/prostheticDiagnosticEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/prostheticStepEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/scanApplianceEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/repositories/prostheticRepository.dart';
import 'package:dartz/dartz.dart';

class GetPatientProstheticTreatmentDiagnosticUseCase extends UseCases<List<ProstheticStepEntity>, int> {
  final ProstheticRepository prostheticRepository;

  GetPatientProstheticTreatmentDiagnosticUseCase({required this.prostheticRepository});

  @override
  Future<Either<Failure, List<ProstheticStepEntity>>> call(int id) async {
    return await prostheticRepository.getPatientProstheticTreatmentDiagnostic(id).then((value) => value.fold(
          (l) => Left(l..message = "Get Diagnostics: ${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}
