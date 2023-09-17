import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/patientInfoEntity.dart';
import 'package:cariro_implant_academy/features/patient/domain/repositories/patientInfoRepo.dart';
import 'package:dartz/dartz.dart';

class GetNextAvailableIdUseCase extends UseCases<int,NoParams>{
  PatientInfoRepo repo;
  GetNextAvailableIdUseCase(this.repo);
  @override
  Future<Either<Failure, int>> call(NoParams params) async{
    return await repo.getNextAvailableId();
  }
  
}