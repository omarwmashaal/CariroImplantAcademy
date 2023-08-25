import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientsMedical/dentalHistroy/domain/repositories/dentalHistoryRepo.dart';
import 'package:dartz/dartz.dart';

import '../entities/dentalHistoryEntity.dart';

class SaveDentalHistoryUseCase extends UseCases<NoParams,DentalHistoryEntity>{
  final DentalHistoryRepo dentalHistoryRepo;
  SaveDentalHistoryUseCase({required this.dentalHistoryRepo});
  @override
  Future<Either<Failure, NoParams>> call(DentalHistoryEntity dentalHistoryEntity)async {
   return await dentalHistoryRepo.saveDentalHistory(dentalHistoryEntity);
  }

}