import 'package:cariro_implant_academy/features/stock/domain/entities/stockEntity.dart';
import 'package:cariro_implant_academy/features/stock/domain/entities/stockLogEntity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

abstract class StockRepository {
  Future<Either<Failure, List<StockEntity>>> getStock(String? search);

  Future<Either<Failure, StockEntity>> getStockByName(String search);

  Future<Either<Failure, List<StockLogEntity>>> getStockLogs(String? search, DateTime? from, DateTime? to, int? categoryId, int? operatorId, String? status);
}
