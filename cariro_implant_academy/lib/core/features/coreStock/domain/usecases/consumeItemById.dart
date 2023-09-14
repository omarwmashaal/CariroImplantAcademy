import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/features/coreStock/domain/repositories/coreStockRepository.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:dartz/dartz.dart';

class ConsumeItemByIdUseCase extends UseCases<NoParams, ConsumeItemByIdParams> {
  final CoreStockRepository coreStockRepository;

  ConsumeItemByIdUseCase({required this.coreStockRepository});

  @override
  Future<Either<Failure, NoParams>> call(params) async {
    return await coreStockRepository.consumeItemById(params.id, params.count).then((value) => value.fold(
          (l) => Left(l..message = "Consume Item: ${l.message ?? ""}"),
          (r) => Right(r),
        ));
  }
}

class ConsumeItemByIdParams {
  final int id;
  final int count;

  ConsumeItemByIdParams({required this.id, required this.count});
}
