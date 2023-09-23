import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/stock/domain/entities/stockEntity.dart';
import 'package:cariro_implant_academy/features/stock/domain/repositories/stockRepository.dart';
import 'package:dartz/dartz.dart';

import '../entities/stockLogEntity.dart';

class GetStockLogUseCase extends UseCases<List<StockLogEntity>, String?> {
  final StockRepository stockRepository;

  GetStockLogUseCase({required this.stockRepository});

  @override
  Future<Either<Failure, List<StockLogEntity>>> call(params) async {
    return await stockRepository.getStockLogs(params).then((value) => value.fold(
          (l) => Left(l..message = "Get Stock Logs: ${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}
