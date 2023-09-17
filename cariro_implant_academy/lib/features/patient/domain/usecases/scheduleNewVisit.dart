import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/visitEntity.dart';
import 'package:cariro_implant_academy/features/patient/domain/repositories/visitsRepo.dart';
import 'package:dartz/dartz.dart';

class ScheduleNewVisitUseCase extends UseCases<NoParams,VisitEntity>{
  final VisitsRepo visitsRepo;
  ScheduleNewVisitUseCase ({required this.visitsRepo});
  @override
  Future<Either<Failure, NoParams>> call(VisitEntity params) async{
    return await visitsRepo.scheduleNewVisit(params)
      ..fold(
            (l) => Left("Schedule New Visit: ${l.message}"),
            (r) => Right(r),
      );
  }

}