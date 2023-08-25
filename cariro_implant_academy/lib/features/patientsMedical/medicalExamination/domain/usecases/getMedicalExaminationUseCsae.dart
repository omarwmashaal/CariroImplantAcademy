import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientsMedical/medicalExamination/domain/repositories/medicalExaminationRepo.dart';
import 'package:dartz/dartz.dart';

import '../entities/medicalExaminationEntity.dart';

class GetMedicalExaminationUseCase extends UseCases<MedicalExaminationEntity,int>{
  final MedicalHistoryRepo medicalExaminationRepo;
  GetMedicalExaminationUseCase({required this.medicalExaminationRepo});
  @override
  Future<Either<Failure, MedicalExaminationEntity>> call(int id)async {
   return await medicalExaminationRepo.getMedicalExamination(id);
  }

}