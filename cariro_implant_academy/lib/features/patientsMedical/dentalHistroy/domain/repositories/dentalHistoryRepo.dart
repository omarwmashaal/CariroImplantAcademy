import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientsMedical/dentalHistroy/domain/entities/dentalHistoryEntity.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';

abstract class DentalHistoryRepo {

  Future<Either<Failure, DentalHistoryEntity>> getDentalHistory(int id);

  Future<Either<Failure, NoParams>> saveDentalHistory(DentalHistoryEntity dentalHistoryEntity);
 }
