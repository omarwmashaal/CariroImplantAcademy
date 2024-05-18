import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/finalProsthesisDeliveryEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/finalProsthesisHealingCollarEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/finalProsthesisImpressionEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/finalProsthesisTryInEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/prostheticDiagnosticEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/prostheticStepEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/repositories/prostheticRepository.dart';
import 'package:dartz/dartz.dart';

import '../entities/prostheticFinalEntity.dart';

class GetPatientProstheticTreatmentFinalProthesisSingleBridgeUseCase extends UseCases<List<ProstheticStepEntity>, int> {
  final ProstheticRepository prostheticRepository;

  GetPatientProstheticTreatmentFinalProthesisSingleBridgeUseCase({required this.prostheticRepository});

  @override
  Future<Either<Failure, List<ProstheticStepEntity>>> call(int id) async {
    return await prostheticRepository.getPatientProstheticTreatmentFinalProthesisSingleBridge(id).then((value) => value.fold(
          (l) => Left(l..message = "Get Single Bridge: ${l.message ?? ""}"),
          (r)=>Right(r),
        ));
  }
}
