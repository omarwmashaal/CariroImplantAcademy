import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/repositories/prostheticRepository.dart';
import 'package:dartz/dartz.dart';

import '../entities/finalProsthesisHealingCollarEntity.dart';
import '../entities/prostheticFinalEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/finalProsthesisDeliveryEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/finalProsthesisImpressionEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/finalProsthesisTryInEntity.dart';

class GetPatientProstheticTreatmentFinalProthesisFullArchUseCase extends UseCases<ProstheticTreatmentFinalEntity, int> {
  final ProstheticRepository prostheticRepository;

  GetPatientProstheticTreatmentFinalProthesisFullArchUseCase({required this.prostheticRepository});

  @override
  Future<Either<Failure, ProstheticTreatmentFinalEntity>> call(int id) async {
    return await prostheticRepository.getPatientProstheticTreatmentFinalProthesisFullArch(id).then((value) => value.fold(
          (l) => Left(l..message = "Get Full Arch: ${l.message ?? ""}"),
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
