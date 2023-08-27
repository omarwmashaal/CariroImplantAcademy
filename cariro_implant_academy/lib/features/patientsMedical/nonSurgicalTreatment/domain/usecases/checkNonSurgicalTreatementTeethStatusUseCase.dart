import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientsMedical/nonSurgicalTreatment/domain/entities/nonSurgialTreatmentEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/nonSurgicalTreatment/domain/repositories/nonSurgicalTreatmentRepo.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class CheckNonSurgicalTreatmentTeethStatusUseCase extends UseCases<List<int>, String> {
  final NonSurgicalTreatmentRepo nonSurgicalTreatmentRepo;

  CheckNonSurgicalTreatmentTeethStatusUseCase({required this.nonSurgicalTreatmentRepo});

  @override
  Future<Either<Failure, List<int>>> call(String params) async {
    final result = await nonSurgicalTreatmentRepo.checkNonSurgicalTreatmentTeethStatus(params);
    return result.fold(
      (l) => Left(l..message = "Check non surgical treatment teeth status: ${l.message}"),
      (r) => Right(r),
    );
  }
}
