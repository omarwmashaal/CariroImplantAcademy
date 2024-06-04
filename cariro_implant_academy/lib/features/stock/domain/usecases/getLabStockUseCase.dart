import 'package:dartz/dartz.dart';

import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/repositories/settingsRepository.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/stock/domain/entities/stockEntity.dart';
import 'package:cariro_implant_academy/features/stock/domain/repositories/stockRepository.dart';

class GetLabStockUseCase extends UseCases<List<StockEntity>, GetLabStockParams> {
  final StockRepository stockRepository;

  GetLabStockUseCase({
    required this.stockRepository,
  });

  @override
  Future<Either<Failure, List<StockEntity>>> call(params) async {
    return await stockRepository
        .getLabStock(
          params.search,
          params.parentId,
          params.companyId,
          params.shadeId,
          params.consumed,
        )
        .then((value) => value.fold(
              (l) => Left(l..message = "Get Stock: ${l.message ?? ""}"),
              (r) {
                return Right(r);
              },
            ));
  }
}

class GetLabStockParams {
  final String? search;
  final int? parentId;
  final int? companyId;
  final int? shadeId;
  final bool? consumed;
  GetLabStockParams({
    this.search,
    this.parentId,
    this.companyId,
    this.shadeId,
    this.consumed,
  });
}
