import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/advancedPatientSearchEntity.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/advancedTreatmentSearchEntity.dart';
import 'package:cariro_implant_academy/features/user/domain/repositories/userRepository.dart';
import 'package:dartz/dartz.dart';

import '../repositories/patientInfoRepo.dart';

class AdvancedTreatmentSearchUseCase extends UseCases<List<AdvancedTreatmentSearchEntity>, AdvancedTreatmentSearchEntity> {
  final PatientInfoRepo patientInfoRepo;

  AdvancedTreatmentSearchUseCase({required this.patientInfoRepo});

  @override
  Future<Either<Failure, List<AdvancedTreatmentSearchEntity>>> call(AdvancedTreatmentSearchEntity params) async {
    return await patientInfoRepo.advancedTreatmentSearch(params).then((value) => value.fold(
          (l) => Left(l..message = "Advanced Treatment Search:${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}
