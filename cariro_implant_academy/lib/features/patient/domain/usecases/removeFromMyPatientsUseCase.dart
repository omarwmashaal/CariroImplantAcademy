import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../repositories/addOrRemoveMyPatientsRangeRepo.dart';
import '../repositories/patientInfoRepo.dart';

class RemoveFromMyPatientsUseCase extends UseCases<bool, int> {
  AddOrRemoveMyPatientsRepo addOrRemoveMyPatientsRepo;
  PatientInfoRepo patientInfoRepo;

  RemoveFromMyPatientsUseCase({required this.addOrRemoveMyPatientsRepo, required this.patientInfoRepo});

  @override
  Future<Either<Failure, bool>> call(id) async {
    return await addOrRemoveMyPatientsRepo.removeFromMyPatients(id).then((value) => value.fold(
          (l) => Left(l..message = "Remove from my patients: ${l.message ?? ""}"),
          (r) => Right(r),
        ));

  }
}
