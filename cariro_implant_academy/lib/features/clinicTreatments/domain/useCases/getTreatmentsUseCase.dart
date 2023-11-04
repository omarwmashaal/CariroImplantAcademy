import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/entities/clinicTreatmentEntity.dart';
import 'package:cariro_implant_academy/features/clinicTreatments/domain/repositories/clinicTreatmentRepo.dart';
import 'package:dartz/dartz.dart';

class GetClinicTreatmentsUseCase extends UseCases<ClinicTreatmentEntity, int> {
  final ClinicTreatmentRepo clinicTreatmentRepo;

  GetClinicTreatmentsUseCase({required this.clinicTreatmentRepo});

  @override
  Future<Either<Failure, ClinicTreatmentEntity>> call(int id) async {
    return await clinicTreatmentRepo.getTreatment(id).then((value) => value.fold(
          (l) => Left(l..message = "Get Clinic Treatment: ${l.message}"),
          (r) => Right(r),
        ));
  }
}
