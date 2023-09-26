import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/complainEntity.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/patientInfoEntity.dart';
import 'package:cariro_implant_academy/features/patient/domain/repositories/complainsRepository.dart';
import 'package:cariro_implant_academy/features/patient/domain/repositories/patientInfoRepo.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../repositories/addOrRemoveMyPatientsRangeRepo.dart';

class UpdatePatientDataUseCase extends UseCases<PatientInfoEntity, PatientInfoEntity> {
 final PatientInfoRepo patientInfoRepo;

  UpdatePatientDataUseCase({required this.patientInfoRepo});

  @override
  Future<Either<Failure, PatientInfoEntity>> call(params) async {
    return patientInfoRepo.updatePatientData(params).then((value) => value.fold(
          (l) => Left(l..message = "Update Patient Data: ${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}
