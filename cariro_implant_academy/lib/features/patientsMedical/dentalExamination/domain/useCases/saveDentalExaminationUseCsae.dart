import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientsMedical/dentalExamination/domain/repositories/dentalExaminationRepo.dart';
import 'package:dartz/dartz.dart';

import '../entities/dentalExaminationBaseEntity.dart';
import '../entities/dentalExaminationEntity.dart';


class SaveDentalExaminationUseCase extends UseCases<NoParams,DentalExaminationBaseEntity>{
  final DentalExaminationRepo dentalExaminationRepo;
  SaveDentalExaminationUseCase({required this.dentalExaminationRepo});
  @override
  Future<Either<Failure, NoParams>> call(DentalExaminationBaseEntity dentalExaminationEntity)async {
   return await dentalExaminationRepo.saveDentalExamination(dentalExaminationEntity);
  }

}