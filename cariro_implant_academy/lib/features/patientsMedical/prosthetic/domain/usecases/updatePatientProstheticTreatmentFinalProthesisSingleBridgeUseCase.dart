import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/prostheticDiagnosticEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/repositories/prostheticRepository.dart';
import 'package:dartz/dartz.dart';

import '../entities/prostheticFinalEntity.dart';

class UpdatePatientProstheticTreatmentFinalProthesisSingleBridgeUseCase extends UseCases<NoParams, ProstheticTreatmentFinalEntity> {
  final ProstheticRepository prostheticRepository;

  UpdatePatientProstheticTreatmentFinalProthesisSingleBridgeUseCase({required this.prostheticRepository});

  @override
  Future<Either<Failure, NoParams>> call(ProstheticTreatmentFinalEntity data) async {
    data.impressions?.removeWhere((element) => element.isNull());
    data.healingCollars?.removeWhere((element) => element.isNull());
    data.tryIns?.removeWhere((element) => element.isNull());
    data.delivery?.removeWhere((element) => element.isNull());
    return await prostheticRepository.updatePatientProstheticTreatmentFinalProthesisSingleBridge(data).then((value) => value.fold(
          (l) => Left(l..message = "Update Single Bridge: ${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}
