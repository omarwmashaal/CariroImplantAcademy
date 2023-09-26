import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:cariro_implant_academy/features/stock/domain/entities/stockEntity.dart';
import 'package:cariro_implant_academy/features/stock/domain/repositories/stockRepository.dart';
import 'package:dartz/dartz.dart';

class GetStockByNameUseCase extends UseCases<StockEntity, String> {
  final StockRepository stockRepository;

  GetStockByNameUseCase({required this.stockRepository});

  @override
  Future<Either<Failure,StockEntity>> call(params) async {
    return await stockRepository.getStockByName(params).then((value) => value.fold(
          (l) => Left(l..message = "Get Stock By Name: ${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}
