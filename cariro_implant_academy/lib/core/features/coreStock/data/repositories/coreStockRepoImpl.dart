import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/features/coreStock/data/datasources/coreStockDatasource.dart';
import 'package:cariro_implant_academy/core/features/coreStock/domain/repositories/coreStockRepository.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:dartz/dartz.dart';

class CoreStockRepoImpl implements CoreStockRepository{
  final CoreStockDatasource coreStockDatasource;
  CoreStockRepoImpl({required this.coreStockDatasource});
  @override
  Future<Either<Failure, NoParams>> consumeItemById(int id, int count)async{
    try{
      final result = await  coreStockDatasource.consumeItemById(id,count);
      return Right(result);
    }
    on Exception catch(e)
    {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, NoParams>> consumeItemByName(String name, int count)async{
    try{
      final result = await  coreStockDatasource.consumeItemByName(name,count);
      return Right(result);
    }
    on Exception catch(e)
    {
      return Left(Failure.exceptionToFailure(e));
    }
  }

}