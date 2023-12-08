import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/entities/clinicTreatmentEntity.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/repositories/clinicTreatmentRepo.dart';
import 'package:dartz/dartz.dart';

import '../entities/clinicDoctorPercentageEntity.dart';

class UpdateClinicReceiptUseCase extends UseCases<NoParams, UpdateClinicReceiptParams> {
  final ClinicTreatmentRepo clinicTreatmentRepo;

  UpdateClinicReceiptUseCase({required this.clinicTreatmentRepo});

  @override
  Future<Either<Failure, NoParams>> call(UpdateClinicReceiptParams params) async {
    return await clinicTreatmentRepo.updateClinicReceipt(params.patientId,params.treatmentId).then((value) => value.fold(
          (l) => Left(l..message = "Update Clinic Receipt: ${l.message}"),
          (r) => Right(r),
        ));
  }
}

class UpdateClinicReceiptParams{
  final int patientId;
  final int treatmentId;
  UpdateClinicReceiptParams({required this.patientId,required this.treatmentId});
}
