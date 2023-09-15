import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/prostheticEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/repositories/prostheticRepository.dart';
import 'package:dartz/dartz.dart';

class UpdatePatientProstheticTreatmentDiagnosticUseCase extends UseCases<NoParams, ProstheticTreatmentEntity> {
  final ProstheticRepository prostheticRepository;

  UpdatePatientProstheticTreatmentDiagnosticUseCase({required this.prostheticRepository});

  @override
  Future<Either<Failure, NoParams>> call(ProstheticTreatmentEntity data) async {

    data.prostheticDiagnostic_DiagnosticImpression!.removeWhere((element) =>
    element.diagnostic==null &&element.nextStep==null
    );

    data.prostheticDiagnostic_ScanAppliance!.removeWhere((element) =>
    element.diagnostic==null
    );

    data.prostheticDiagnostic_Bite!.removeWhere((element) =>
    element.diagnostic==null &&element.nextStep==null
    );


    if(data.prostheticDiagnostic_DiagnosticImpression![0].diagnostic==null && data.prostheticDiagnostic_DiagnosticImpression![0].nextStep==null)
    {
      data.prostheticDiagnostic_DiagnosticImpression = [];
    }

    return await prostheticRepository.updatePatientProstheticTreatmentDiagnostic(data).then((value) => value.fold(
          (l) => Left(l..message = "Update Diagnostic: ${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}
