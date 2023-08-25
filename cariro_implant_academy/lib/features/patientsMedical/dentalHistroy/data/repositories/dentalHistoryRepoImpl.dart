import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/patientsMedical/dentalHistroy/data/datasources/dentalHistoryDatasource.dart';
import 'package:cariro_implant_academy/features/patientsMedical/dentalHistroy/data/models/dentalHistoryModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/dentalHistroy/domain/entities/dentalHistoryEntity.dart';
import 'package:cariro_implant_academy/features/patientsMedical/dentalHistroy/domain/repositories/dentalHistoryRepo.dart';
import 'package:dartz/dartz.dart';

class DentalHistoryRepoImpl implements DentalHistoryRepo{
  final DentalHistoryDataSource dentalHistoryDataSource;
  DentalHistoryRepoImpl({required this.dentalHistoryDataSource});

  @override
  Future<Either<Failure, DentalHistoryModel>> getDentalHistory(int id) async{
    try{
      final result = await  dentalHistoryDataSource.getDentalHistory(id);
      return Right(result);
    }
    on Exception catch(e)
    {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> saveDentalHistory(DentalHistoryEntity dentalHistoryEntity) async{
    try{
      final result = await  dentalHistoryDataSource.saveDentalHistory(dentalHistoryEntity);
      return Right(result);
    }
    on Exception catch(e)
    {
      return Left(Failure.exceptionToFailure(e));
    }
  }

}