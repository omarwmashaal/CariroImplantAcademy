import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/prostheticEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/repositories/prostheticRepository.dart';
import 'package:dartz/dartz.dart';

class UpdatePatientProstheticTreatmentFinalProthesisSingleBridgeUseCase extends UseCases<NoParams, ProstheticTreatmentEntity> {
  final ProstheticRepository prostheticRepository;

  UpdatePatientProstheticTreatmentFinalProthesisSingleBridgeUseCase({required this.prostheticRepository});

  @override
  Future<Either<Failure, NoParams>> call(ProstheticTreatmentEntity data) async {
    return  await prostheticRepository.updatePatientProstheticTreatmentFinalProthesisSingleBridge(data).then((value) => value.fold(
          (l) => Left(l..message = "Update Single Bridge: ${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}
