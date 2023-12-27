import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/core/constants/enums/enums.dart';
import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/repositories/settingsRepository.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/stock/domain/entities/stockEntity.dart';
import 'package:cariro_implant_academy/features/stock/domain/repositories/stockRepository.dart';
import 'package:dartz/dartz.dart';

class GetStockUseCase extends UseCases<List<StockEntity>, String?> {
  final StockRepository stockRepository;

  GetStockUseCase({
    required this.stockRepository,
  });

  @override
  Future<Either<Failure, List<StockEntity>>> call(params) async {
    return await stockRepository.getStock(params).then((value) => value.fold(
          (l) => Left(l..message = "Get Stock: ${l.message ?? ""}"),
          (r) {

            return Right(r);
          },
        ));
  }
}
