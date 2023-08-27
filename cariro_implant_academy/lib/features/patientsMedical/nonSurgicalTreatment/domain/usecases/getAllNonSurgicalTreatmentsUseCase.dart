import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientsMedical/nonSurgicalTreatment/domain/entities/nonSurgialTreatmentEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/nonSurgicalTreatment/domain/repositories/nonSurgicalTreatmentRepo.dart';
import 'package:dartz/dartz.dart';

class GetAllNonSurgicalTreatmentsUseCase extends UseCases<List<NonSurgicalTreatmentEntity>, int> {
  final NonSurgicalTreatmentRepo nonSurgicalTreatmentRepo;

  GetAllNonSurgicalTreatmentsUseCase({required this.nonSurgicalTreatmentRepo});

  @override
  Future<Either<Failure, List<NonSurgicalTreatmentEntity>>> call(int params) async {
    final result = await nonSurgicalTreatmentRepo.getAllNonSurgicalTreatments(params);
    return result.fold(
          (l) => Left(l..message = "Get all nonsurgical treatments: ${l.message}"),
          (r) => Right(r),
    );
  }
}
