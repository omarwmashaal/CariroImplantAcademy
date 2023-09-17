import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/visitEntity.dart';
import 'package:cariro_implant_academy/features/patient/domain/repositories/visitsRepo.dart';
import 'package:dartz/dartz.dart';

class PatientEntersClinicUseCase extends UseCases<NoParams, int> {
  final VisitsRepo visitsRepo;

  PatientEntersClinicUseCase({required this.visitsRepo});

  @override
  Future<Either<Failure, NoParams>> call(int patientId) async {
    return await visitsRepo.patientEntersClinic(patientId).then((value) => value.fold(
          (l) => Left(l..message = "Patient Enters Clinic: ${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}
