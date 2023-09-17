import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../repositories/addOrRemoveMyPatientsRangeRepo.dart';
import '../repositories/patientInfoRepo.dart';

class AddToMyPatientsUseCase extends UseCases<bool, int> {
  AddOrRemoveMyPatientsRepo addOrRemoveMyPatientsRepo;
  PatientInfoRepo patientInfoRepo;

  AddToMyPatientsUseCase({required this.addOrRemoveMyPatientsRepo, required this.patientInfoRepo});

  @override
  Future<Either<Failure, bool>> call(id) async {
    final patient = await patientInfoRepo.getPatient(id);
    return patient.fold(
      (l) {
        return Left(l);
      },
      (r) async {
        final pref = await SharedPreferences.getInstance();
        
        if (r.doctorId == pref.getInt("userid")) return Left(BadRequestFailure(failureMessage: "Patient is already your patient"));
        return await addOrRemoveMyPatientsRepo.addToMyPatients(id);
      },
    );
  }
}
