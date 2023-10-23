import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/patientInfoEntity.dart';
import 'package:cariro_implant_academy/features/patient/domain/repositories/patientInfoRepo.dart';
import 'package:dartz/dartz.dart';

class SetPatientOutUseCase extends UseCases<NoParams,int>
{
  final PatientInfoRepo patientRepo;
  SetPatientOutUseCase({required this.patientRepo});
  @override
  Future<Either<Failure, NoParams>> call(int id) async{
   return await patientRepo.setPatientOut(id);
  }

}