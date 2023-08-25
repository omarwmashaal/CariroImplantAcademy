import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientsMedical/dentalHistroy/domain/repositories/dentalHistoryRepo.dart';
import 'package:dartz/dartz.dart';

import '../entities/dentalHistoryEntity.dart';

class GetDentalHistoryUseCase extends UseCases<DentalHistoryEntity,int>{
  final DentalHistoryRepo dentalHistoryRepo;
  GetDentalHistoryUseCase({required this.dentalHistoryRepo});
  @override
  Future<Either<Failure, DentalHistoryEntity>> call(int id)async {
   return await dentalHistoryRepo.getDentalHistory(id);
  }

}