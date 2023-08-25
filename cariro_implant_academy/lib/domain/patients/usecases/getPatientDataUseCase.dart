import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/domain/patients/entities/patientInfoEntity.dart';
import 'package:cariro_implant_academy/domain/patients/repositories/patientInfoRepo.dart';
import 'package:dartz/dartz.dart';

class GetPatientDataUseCase extends UseCases<PatientInfoEntity,int>
{
  final PatientInfoRepo patientRepo;
  GetPatientDataUseCase({required this.patientRepo});
  @override
  Future<Either<Failure, PatientInfoEntity>> call(int id) async{
   return await patientRepo.getPatient(id);
  }

}