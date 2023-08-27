import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientVisits/domain/entity/visitEntity.dart';
import 'package:cariro_implant_academy/features/patientVisits/domain/repositories/visitsRepo.dart';
import 'package:dartz/dartz.dart';

class GetAllSchedulesUseCase extends UseCases<List<VisitEntity>, int> {
  final VisitsRepo visitsRepo;

  GetAllSchedulesUseCase({required this.visitsRepo});

  @override
  Future<Either<Failure, List<VisitEntity>>> call(int month) async {
    return await visitsRepo.getAllSchedules(month)
      ..fold(
        (l) => Left("Get All Schedules:${l.message}"),
        (r) => Right(r),
      );
  }
}
