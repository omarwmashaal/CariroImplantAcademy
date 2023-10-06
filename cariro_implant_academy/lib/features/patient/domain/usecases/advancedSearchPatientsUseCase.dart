import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/advancedPatientSearchEntity.dart';
import 'package:cariro_implant_academy/features/patient/domain/repositories/patientInfoRepo.dart';
import 'package:cariro_implant_academy/features/user/domain/repositories/userRepository.dart';
import 'package:dartz/dartz.dart';

class AdvancedSearchPatientsUseCase extends UseCases<List<AdvancedPatientSearchEntity>, AdvancedPatientSearchEntity> {
  final PatientInfoRepo patientInfoRepo;

  AdvancedSearchPatientsUseCase({required this.patientInfoRepo});

  @override
  Future<Either<Failure, List<AdvancedPatientSearchEntity>>> call(AdvancedPatientSearchEntity params) async {
    return await patientInfoRepo.advancedSearchPatients(params).then((value) => value.fold(
          (l) => Left(l..message = "Advanced Search:${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}
