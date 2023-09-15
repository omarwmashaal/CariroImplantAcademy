import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/prostheticEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/repositories/prostheticRepository.dart';
import 'package:dartz/dartz.dart';

class UpdatePatientProstheticTreatmentFinalProthesisFullArchUseCase extends UseCases<NoParams, ProstheticTreatmentEntity> {
  final ProstheticRepository prostheticRepository;

  UpdatePatientProstheticTreatmentFinalProthesisFullArchUseCase({required this.prostheticRepository});

  @override
  Future<Either<Failure, NoParams>> call(ProstheticTreatmentEntity data) async {
    return  await prostheticRepository.updatePatientProstheticTreatmentFinalProthesisFullArch(data).then((value) => value.fold(
          (l) => Left(l..message = "Update Full Arch: ${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}
