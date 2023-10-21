import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/stock/domain/entities/stockEntity.dart';
import 'package:cariro_implant_academy/features/stock/domain/repositories/stockRepository.dart';
import 'package:dartz/dartz.dart';

import '../entities/stockLogEntity.dart';

class GetStockLogUseCase extends UseCases<List<StockLogEntity>, GetStockLogParams> {
  final StockRepository stockRepository;

  GetStockLogUseCase({required this.stockRepository});

  @override
  Future<Either<Failure, List<StockLogEntity>>> call(params) async {
    return await stockRepository
        .getStockLogs(
          params.search,
          params.from,
          params.to,
          params.categoryId,
          params.operatorId,
          params.status,
        )
        .then((value) => value.fold(
              (l) => Left(l..message = "Get Stock Logs: ${l.message ?? ""}"),
              (r) => Right(r),
            ));
  }
}

class GetStockLogParams {
  final String? search;
  final DateTime? from;
  final DateTime? to;
  final int? categoryId;
  final int? operatorId;
  final String? status;

  const GetStockLogParams({
    this.search,
    this.from,
    this.to,
    this.categoryId,
    this.operatorId,
    this.status,
  });
}
