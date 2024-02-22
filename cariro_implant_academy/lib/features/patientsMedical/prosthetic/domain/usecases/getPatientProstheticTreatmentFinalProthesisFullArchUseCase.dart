import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/finalProsthesisDeliveryEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/finalProsthesisHealingCollarEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/finalProsthesisImpressionEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/finalProsthesisTryInEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/prostheticDiagnosticEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/repositories/prostheticRepository.dart';
import 'package:dartz/dartz.dart';

import '../entities/prostheticFinalEntity.dart';

class GetPatientProstheticTreatmentFinalProthesisSingleBridgeUseCase extends UseCases<ProstheticTreatmentFinalEntity, int> {
  final ProstheticRepository prostheticRepository;

  GetPatientProstheticTreatmentFinalProthesisSingleBridgeUseCase({required this.prostheticRepository});

  @override
  Future<Either<Failure, ProstheticTreatmentFinalEntity>> call(int id) async {
    return await prostheticRepository.getPatientProstheticTreatmentFinalProthesisSingleBridge(id).then((value) => value.fold(
          (l) => Left(l..message = "Get Single Bridge: ${l.message ?? ""}"),
          (r) {
            if (r.healingCollars?.isEmpty ?? true) {
              r.healingCollars = [];
            }
            if (r.tryIns?.isEmpty ?? true) {
              r.tryIns = [];
            }
            if (r.delivery?.isEmpty ?? true) {
              r.delivery = [];
            }
            if (r.impressions?.isEmpty ?? true) {
              r.impressions = [];
            }
            return Right(r);
          },
        ));
  }
}
