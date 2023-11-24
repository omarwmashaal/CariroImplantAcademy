import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/entities/clinicTreatmentEntity.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/repositories/clinicTreatmentRepo.dart';
import 'package:dartz/dartz.dart';

import '../entities/clinicDoctorPercentageEntity.dart';

class GetDoctorPercentageForPatientUseCase extends UseCases<List<ClinicDoctorPercentageEntity>, int> {
  final ClinicTreatmentRepo clinicTreatmentRepo;

  GetDoctorPercentageForPatientUseCase({required this.clinicTreatmentRepo});

  @override
  Future<Either<Failure, List<ClinicDoctorPercentageEntity>>> call(int id) async {
    return await clinicTreatmentRepo.getDoctorPercentageForPatient(id).then((value) => value.fold(
          (l) => Left(l..message = "Get Doctor Percentage For Patient: ${l.message}"),
          (r) => Right(r),
        ));
  }
}
