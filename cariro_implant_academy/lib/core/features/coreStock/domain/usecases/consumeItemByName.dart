import 'package:cariro_implant_academy/core/error/failure.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:dartz/dartz.dart';

import '../repositories/coreStockRepository.dart';

class ConsumeItemByNameUseCase extends UseCases<NoParams, ConsumeItemByNameParams> {
  final CoreStockRepository coreStockRepository;

  ConsumeItemByNameUseCase({required this.coreStockRepository});
  @override
  Future<Either<Failure, NoParams>> call(params) async {
    return await coreStockRepository.consumeItemByName(params.name, params.count).then((value) => value.fold(
          (l) => Left(l..message = "Consume Item ${params.name}: ${l.message ?? ""}"),
          (r) => Right(r),
    ));
  }
}

class ConsumeItemByNameParams {
  final String name;
  final int count;

  ConsumeItemByNameParams({required this.name, required this.count});
}
