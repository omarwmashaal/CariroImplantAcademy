import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/features/stock/data/datasource/stockDatasource.dart';
import 'package:cariro_implant_academy/features/stock/domain/entities/stockEntity.dart';
import 'package:cariro_implant_academy/features/stock/domain/entities/stockLogEntity.dart';
import 'package:cariro_implant_academy/features/stock/domain/repositories/stockRepository.dart';
import 'package:dartz/dartz.dart';

class StockRepoImpl implements StockRepository {
  final StockDatasource stockDatasource;

  StockRepoImpl({required this.stockDatasource});

  @override
  Future<Either<Failure, List<StockEntity>>> getStock(String? search) async {
    try {
      final result = await stockDatasource.getStock(search);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<StockLogEntity>>> getStockLogs(String? search)async {
    try {
      final result = await stockDatasource.getStockLogs(search);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.exceptionToFailure(e));
    }
  }
}
