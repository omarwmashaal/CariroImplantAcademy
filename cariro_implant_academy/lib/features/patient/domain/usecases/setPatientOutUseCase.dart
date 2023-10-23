import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patient/domain/entities/patientInfoEntity.dart';
import 'package:cariro_implant_academy/features/patient/domain/repositories/patientInfoRepo.dart';
import 'package:dartz/dartz.dart';

class SetPatientOutUseCase extends UseCases<NoParams,SetPatientOutParams>
{
  final PatientInfoRepo patientRepo;
  SetPatientOutUseCase({required this.patientRepo});
  @override
  Future<Either<Failure, NoParams>> call(SetPatientOutParams params) async{
   return await patientRepo.setPatientOut(params.id,params.outReason);
  }

}

class SetPatientOutParams{
  final int id;
  final String outReason;

  const SetPatientOutParams({
    required this.id,
    required this.outReason,
  });
}