import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/patientInfoEntity.dart';
import 'package:cariro_implant_academy/features/patient/domain/repositories/patientInfoRepo.dart';
import 'package:dartz/dartz.dart';

class CheckDuplicateIdUseCase extends UseCases<bool,int>{
  PatientInfoRepo repo;
  CheckDuplicateIdUseCase(this.repo);
  @override
  Future<Either<Failure, bool>> call(int id) async{
    return await repo.checkDuplicateId(id);
  }
  
}