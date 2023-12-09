import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/visitEntity.dart';
import 'package:cariro_implant_academy/features/patient/domain/repositories/visitsRepo.dart';
import 'package:dartz/dartz.dart';

class UpdateVisitUseCase extends UseCases<NoParams,UpdateVisitParams>{
  final VisitsRepo visitsRepo;
  UpdateVisitUseCase ({required this.visitsRepo});
  @override
  Future<Either<Failure, NoParams>> call(UpdateVisitParams params) async{
    return await visitsRepo.updateVisit(params.visitEntity,params.delete)
      ..fold(
            (l) => Left("Update Visit: ${l.message}"),
            (r) => Right(r),
      );
  }

}
class UpdateVisitParams{
  final VisitEntity visitEntity;
  final bool delete;
  UpdateVisitParams({required this.visitEntity, this.delete = false});
}