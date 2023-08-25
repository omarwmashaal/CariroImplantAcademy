import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientsMedical/medicalExamination/domain/repositories/medicalExaminationRepo.dart';
import 'package:dartz/dartz.dart';

import '../entities/medicalExaminationEntity.dart';

class SaveMedicalExaminationUseCase extends UseCases<NoParams,MedicalExaminationEntity>{
  final MedicalHistoryRepo medicalExaminationRepo;
  SaveMedicalExaminationUseCase({required this.medicalExaminationRepo});
  @override
  Future<Either<Failure, NoParams>> call(MedicalExaminationEntity medicalExaminationEntity)async {
   return await medicalExaminationRepo.saveMedicalExamination(medicalExaminationEntity);
  }

}