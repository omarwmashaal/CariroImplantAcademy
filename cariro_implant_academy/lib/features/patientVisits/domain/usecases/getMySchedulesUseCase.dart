import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientVisits/domain/entity/visitEntity.dart';
import 'package:cariro_implant_academy/features/patientVisits/domain/repositories/visitsRepo.dart';
import 'package:dartz/dartz.dart';

class GetMySchedulesUseCase extends UseCases<List<VisitEntity>, int> {
  final VisitsRepo visitsRepo;

  GetMySchedulesUseCase({required this.visitsRepo});

  @override
  Future<Either<Failure, List<VisitEntity>>> call(int month) async {
    return await visitsRepo.getMySchedules(month)
      ..fold(
        (l) => Left("Get My Schedules:${l.message}"),
        (r) => Right(r),
      );
  }
}
