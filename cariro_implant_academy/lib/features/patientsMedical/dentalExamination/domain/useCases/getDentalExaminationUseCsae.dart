import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientsMedical/dentalExamination/domain/entities/dentalExaminationBaseEntity.dart';
import 'package:dartz/dartz.dart';

import '../entities/dentalExaminationEntity.dart';
import '../repositories/dentalExaminationRepo.dart';


class GetDentalExaminationUseCase extends UseCases<DentalExaminationBaseEntity,int>{
  final DentalExaminationRepo dentalExaminationRepo;
  GetDentalExaminationUseCase({required this.dentalExaminationRepo});
  @override
  Future<Either<Failure, DentalExaminationBaseEntity>> call(int id)async {
   return await dentalExaminationRepo.getDentalExamination(id);
  }

}