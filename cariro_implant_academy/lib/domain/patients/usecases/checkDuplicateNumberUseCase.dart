import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/domain/patients/entities/patientInfoEntity.dart';
import 'package:cariro_implant_academy/domain/patients/repositories/patientInfoRepo.dart';
import 'package:dartz/dartz.dart';

import '../../../core/domain/repositories/inputValidationRepo.dart';

class CheckDuplicateNumberUseCase extends UseCases<String?, String> {
  PatientInfoRepo patientRepo;
  InputValidationRepo inputValidationRepo;

  CheckDuplicateNumberUseCase({required this.patientRepo, required this.inputValidationRepo});

  @override
  Future<Either<Failure, String?>> call(String number) async {
    final validate = inputValidationRepo.validateStringToInt(number);
    return validate.fold(
      (l) {
        return Left(l);
      },
      (r) async{
        return await patientRepo.compareDuplicateNumber(number);
      },
    );
  }
}
