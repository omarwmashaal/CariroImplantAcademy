import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/visitEntity.dart';
import 'package:cariro_implant_academy/features/patient/domain/repositories/visitsRepo.dart';
import 'package:dartz/dartz.dart';

class GetVisitsUseCase extends UseCases<List<VisitEntity>, int?> {
  final VisitsRepo visitsRepo;

  GetVisitsUseCase({required this.visitsRepo});

  @override
  Future<Either<Failure, List<VisitEntity>>> call(int? patientId) async {
    if (patientId == null)
      return await visitsRepo.getAllVisits().then((value) => value.fold(
            (l) => Left(l..message = "Get All Visits: ${l.message ?? ""}"),
            (r) => Right(r),
          ));
    return await visitsRepo.getPatientVisits(patientId).then((value) => value.fold(
          (l) => Left(l..message = "Get patient Visits: ${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}
