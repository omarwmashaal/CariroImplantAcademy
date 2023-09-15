import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/entities/prostheticEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/repositories/prostheticRepository.dart';
import 'package:dartz/dartz.dart';

class GetPatientProstheticTreatmentFinalProthesisFullArchUseCase extends UseCases<ProstheticTreatmentEntity, int> {
  final ProstheticRepository prostheticRepository;

  GetPatientProstheticTreatmentFinalProthesisFullArchUseCase({required this.prostheticRepository});

  @override
  Future<Either<Failure, ProstheticTreatmentEntity>> call(int id) async {
    return  await  prostheticRepository.getPatientProstheticTreatmentFinalProthesisFullArch(id).then((value) => value.fold(
          (l) => Left(l..message = "Get Full Arch: ${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}
