import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/entities/clinicTreatmentEntity.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/repositories/clinicTreatmentRepo.dart';
import 'package:dartz/dartz.dart';

class UpdateClinicTreatmentsUseCase extends UseCases<NoParams, UpdateClinicTreatmentsParams> {
  final ClinicTreatmentRepo clinicTreatmentRepo;

  UpdateClinicTreatmentsUseCase({required this.clinicTreatmentRepo});

  @override
  Future<Either<Failure, NoParams>> call(UpdateClinicTreatmentsParams params) async {
    return await clinicTreatmentRepo.updateTreatment(params.id,params.data).then((value) => value.fold(
          (l) => Left(l..message = "Update Clinic Treatment: ${l.message}"),
          (r) => Right(r),
        ));
  }
}
class UpdateClinicTreatmentsParams{
  final int id;
  final ClinicTreatmentEntity data;

  const UpdateClinicTreatmentsParams({
    required this.id,
    required this.data,
  });
}
