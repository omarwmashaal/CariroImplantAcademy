import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/visitEntity.dart';
import 'package:cariro_implant_academy/features/patient/domain/repositories/visitsRepo.dart';
import 'package:dartz/dartz.dart';

class GetVisitsUseCase extends UseCases<List<VisitEntity>, GetVisitsParams> {
  final VisitsRepo visitsRepo;

  GetVisitsUseCase({required this.visitsRepo});

  @override
  Future<Either<Failure, List<VisitEntity>>> call(GetVisitsParams params) async {
    if (params.patientId == null)
      return await visitsRepo.getAllVisits(params.search).then((value) => value.fold(
            (l) => Left(l..message = "Get All Visits: ${l.message ?? ""}"),
            (r) => Right(r),
          ));
    return await visitsRepo.getPatientVisits(params.patientId!).then((value) => value.fold(
          (l) => Left(l..message = "Get patient Visits: ${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}
class GetVisitsParams{
  final int? patientId;
  final String? search;
  
  GetVisitsParams({this.patientId,this.search});
}
